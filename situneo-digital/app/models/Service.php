<?php
/**
 * Service Model
 * Model untuk mengelola services/products
 *
 * Menyediakan catalog management dan pricing
 */

class Service {
    private $db;

    public function __construct() {
        $this->db = Database::getInstance();
    }

    /**
     * Get all active services dengan category
     *
     * @param array $filters
     * @return array
     */
    public function getAll($filters = []) {
        $where = ['s.is_active = TRUE'];
        $params = [];

        if (!empty($filters['category_id'])) {
            $where[] = 's.category_id = :category_id';
            $params[':category_id'] = $filters['category_id'];
        }

        if (!empty($filters['service_type'])) {
            $where[] = 's.service_type = :service_type';
            $params[':service_type'] = $filters['service_type'];
        }

        if (!empty($filters['search'])) {
            $where[] = '(s.name LIKE :search OR s.description LIKE :search)';
            $params[':search'] = '%' . $filters['search'] . '%';
        }

        if (isset($filters['is_featured'])) {
            $where[] = 's.is_featured = :is_featured';
            $params[':is_featured'] = $filters['is_featured'];
        }

        $whereStr = implode(' AND ', $where);

        $this->db->query("
            SELECT
                s.*,
                sc.name as category_name,
                sc.slug as category_slug
            FROM services s
            LEFT JOIN service_categories sc ON s.category_id = sc.id
            WHERE $whereStr
            ORDER BY s.sort_order ASC, s.created_at DESC
        ");

        foreach ($params as $param => $value) {
            $this->db->bind($param, $value);
        }

        return $this->db->resultSet();
    }

    /**
     * Get service by ID
     *
     * @param int $id
     * @return array|false
     */
    public function findById($id) {
        $this->db->query("
            SELECT
                s.*,
                sc.name as category_name,
                sc.slug as category_slug
            FROM services s
            LEFT JOIN service_categories sc ON s.category_id = sc.id
            WHERE s.id = :id
        ");

        $this->db->bind(':id', $id);
        return $this->db->single();
    }

    /**
     * Get service by slug
     *
     * @param string $slug
     * @return array|false
     */
    public function findBySlug($slug) {
        $this->db->query("
            SELECT
                s.*,
                sc.name as category_name,
                sc.slug as category_slug
            FROM services s
            LEFT JOIN service_categories sc ON s.category_id = sc.id
            WHERE s.slug = :slug AND s.is_active = TRUE
        ");

        $this->db->bind(':slug', $slug);
        return $this->db->single();
    }

    /**
     * Get all service categories
     *
     * @return array
     */
    public function getCategories() {
        $this->db->query("
            SELECT * FROM service_categories
            WHERE is_active = TRUE
            ORDER BY sort_order ASC, name ASC
        ");

        return $this->db->resultSet();
    }

    /**
     * Get featured services
     *
     * @param int $limit
     * @return array
     */
    public function getFeatured($limit = 6) {
        $this->db->query("
            SELECT
                s.*,
                sc.name as category_name
            FROM services s
            LEFT JOIN service_categories sc ON s.category_id = sc.id
            WHERE s.is_active = TRUE AND s.is_featured = TRUE
            ORDER BY s.sort_order ASC
            LIMIT :limit
        ");

        $this->db->bind(':limit', $limit, PDO::PARAM_INT);
        return $this->db->resultSet();
    }

    /**
     * Create new service
     *
     * @param array $data
     * @return int|false Service ID
     */
    public function create($data) {
        try {
            // Generate service code
            $serviceCode = $this->generateServiceCode($data['service_type']);

            // Generate slug from name
            $slug = $this->generateSlug($data['name']);

            $this->db->query("
                INSERT INTO services
                (category_id, service_code, name, slug, short_description, description, features,
                 service_type, base_price, monthly_price, setup_fee, currency, is_active, is_featured,
                 sort_order, min_contract_months, tags)
                VALUES
                (:category_id, :service_code, :name, :slug, :short_description, :description, :features,
                 :service_type, :base_price, :monthly_price, :setup_fee, :currency, :is_active, :is_featured,
                 :sort_order, :min_contract_months, :tags)
            ");

            $this->db->bind(':category_id', $data['category_id'] ?? null);
            $this->db->bind(':service_code', $serviceCode);
            $this->db->bind(':name', $data['name']);
            $this->db->bind(':slug', $slug);
            $this->db->bind(':short_description', $data['short_description'] ?? null);
            $this->db->bind(':description', $data['description'] ?? null);
            $this->db->bind(':features', !empty($data['features']) ? json_encode($data['features']) : null);
            $this->db->bind(':service_type', $data['service_type']);
            $this->db->bind(':base_price', $data['base_price'] ?? null);
            $this->db->bind(':monthly_price', $data['monthly_price'] ?? null);
            $this->db->bind(':setup_fee', $data['setup_fee'] ?? 0);
            $this->db->bind(':currency', $data['currency'] ?? 'IDR');
            $this->db->bind(':is_active', $data['is_active'] ?? true);
            $this->db->bind(':is_featured', $data['is_featured'] ?? false);
            $this->db->bind(':sort_order', $data['sort_order'] ?? 0);
            $this->db->bind(':min_contract_months', $data['min_contract_months'] ?? 1);
            $this->db->bind(':tags', !empty($data['tags']) ? json_encode($data['tags']) : null);

            $this->db->execute();
            return $this->db->lastInsertId();

        } catch (Exception $e) {
            logError('Service creation failed: ' . $e->getMessage(), $data);
            return false;
        }
    }

    /**
     * Update service
     *
     * @param int $id
     * @param array $data
     * @return bool
     */
    public function update($id, $data) {
        try {
            $fields = [];
            $params = [':id' => $id];

            $allowedFields = [
                'category_id', 'name', 'short_description', 'description', 'features',
                'service_type', 'base_price', 'monthly_price', 'setup_fee', 'currency',
                'is_active', 'is_featured', 'sort_order', 'min_contract_months', 'tags'
            ];

            foreach ($allowedFields as $field) {
                if (isset($data[$field])) {
                    $fields[] = "$field = :$field";

                    // Handle JSON fields
                    if (in_array($field, ['features', 'tags']) && is_array($data[$field])) {
                        $params[":$field"] = json_encode($data[$field]);
                    } else {
                        $params[":$field"] = $data[$field];
                    }
                }
            }

            // Update slug if name changed
            if (isset($data['name'])) {
                $fields[] = "slug = :slug";
                $params[':slug'] = $this->generateSlug($data['name']);
            }

            if (empty($fields)) {
                return false;
            }

            $this->db->query("
                UPDATE services
                SET " . implode(', ', $fields) . ", updated_at = NOW()
                WHERE id = :id
            ");

            foreach ($params as $param => $value) {
                $this->db->bind($param, $value);
            }

            return $this->db->execute();

        } catch (Exception $e) {
            logError('Service update failed: ' . $e->getMessage(), ['id' => $id]);
            return false;
        }
    }

    /**
     * Delete service (soft delete via is_active)
     *
     * @param int $id
     * @return bool
     */
    public function delete($id) {
        try {
            $this->db->query("UPDATE services SET is_active = FALSE WHERE id = :id");
            $this->db->bind(':id', $id);
            return $this->db->execute();
        } catch (Exception $e) {
            logError('Service deletion failed: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Calculate service price
     *
     * @param int $serviceId
     * @param string $type 'beli' or 'sewa'
     * @param int $months For sewa
     * @return array Price breakdown
     */
    public function calculatePrice($serviceId, $type, $months = 1) {
        $service = $this->findById($serviceId);

        if (!$service) {
            return false;
        }

        $breakdown = [
            'service_id' => $serviceId,
            'service_name' => $service['name'],
            'type' => $type,
            'months' => $months
        ];

        if ($type === 'beli') {
            $breakdown['base_price'] = $service['base_price'];
            $breakdown['setup_fee'] = $service['setup_fee'];
            $breakdown['subtotal'] = $service['base_price'];
            $breakdown['total'] = $service['base_price'] + $service['setup_fee'];
        } else { // sewa
            $minMonths = max($months, $service['min_contract_months']);
            $breakdown['monthly_price'] = $service['monthly_price'];
            $breakdown['months'] = $minMonths;
            $breakdown['setup_fee'] = $service['setup_fee'];
            $breakdown['subtotal'] = $service['monthly_price'] * $minMonths;
            $breakdown['total'] = ($service['monthly_price'] * $minMonths) + $service['setup_fee'];
        }

        return $breakdown;
    }

    /**
     * Generate service code
     *
     * @param string $type
     * @return string
     */
    private function generateServiceCode($type) {
        $prefix = strtoupper(substr($type, 0, 3)) . '-';

        $this->db->query("SELECT COUNT(*) as count FROM services WHERE service_code LIKE :prefix");
        $this->db->bind(':prefix', $prefix . '%');
        $result = $this->db->single();

        $sequence = str_pad($result['count'] + 1, 5, '0', STR_PAD_LEFT);
        return $prefix . $sequence;
    }

    /**
     * Generate slug from name
     *
     * @param string $name
     * @return string
     */
    private function generateSlug($name) {
        $slug = strtolower(trim($name));
        $slug = preg_replace('/[^a-z0-9-]/', '-', $slug);
        $slug = preg_replace('/-+/', '-', $slug);
        $slug = trim($slug, '-');

        // Check if slug exists
        $this->db->query("SELECT COUNT(*) as count FROM services WHERE slug = :slug");
        $this->db->bind(':slug', $slug);
        $result = $this->db->single();

        if ($result['count'] > 0) {
            $slug .= '-' . time();
        }

        return $slug;
    }

    /**
     * Get service statistics
     *
     * @return array
     */
    public function getStatistics() {
        // Total services
        $this->db->query("SELECT COUNT(*) as total FROM services WHERE is_active = TRUE");
        $total = $this->db->single()['total'];

        // By type
        $this->db->query("SELECT service_type, COUNT(*) as count
                         FROM services WHERE is_active = TRUE
                         GROUP BY service_type");
        $byType = $this->db->resultSet();

        // Featured count
        $this->db->query("SELECT COUNT(*) as count FROM services
                         WHERE is_active = TRUE AND is_featured = TRUE");
        $featuredCount = $this->db->single()['count'];

        return [
            'total' => $total,
            'by_type' => $byType,
            'featured_count' => $featuredCount
        ];
    }

    /**
     * Count total services with filters
     *
     * @param array $filters
     * @return int
     */
    public function count($filters = []) {
        $where = ['is_active = TRUE'];
        $params = [];

        if (!empty($filters['category_id'])) {
            $where[] = 'category_id = :category_id';
            $params[':category_id'] = $filters['category_id'];
        }

        if (!empty($filters['category_slug'])) {
            $where[] = 'category_id = (SELECT id FROM service_categories WHERE slug = :category_slug)';
            $params[':category_slug'] = $filters['category_slug'];
        }

        if (!empty($filters['service_type'])) {
            $where[] = 'service_type = :service_type';
            $params[':service_type'] = $filters['service_type'];
        }

        if (!empty($filters['search'])) {
            $where[] = '(name LIKE :search OR description LIKE :search)';
            $params[':search'] = '%' . $filters['search'] . '%';
        }

        if (isset($filters['is_featured'])) {
            $where[] = 'is_featured = :is_featured';
            $params[':is_featured'] = $filters['is_featured'];
        }

        $whereStr = implode(' AND ', $where);

        $this->db->query("SELECT COUNT(*) as total FROM services WHERE $whereStr");

        foreach ($params as $param => $value) {
            $this->db->bind($param, $value);
        }

        $result = $this->db->single();
        return $result['total'] ?? 0;
    }

    /**
     * Increment service views
     *
     * @param int $serviceId
     * @return bool
     */
    public function incrementViews($serviceId) {
        try {
            $this->db->query("UPDATE services SET views = views + 1 WHERE id = :id");
            $this->db->bind(':id', $serviceId);
            return $this->db->execute();
        } catch (Exception $e) {
            logError('Failed to increment views: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Get related services by category
     *
     * @param int $serviceId Current service ID to exclude
     * @param int $categoryId Category ID
     * @param int $limit Number of related services
     * @return array
     */
    public function getRelated($serviceId, $categoryId, $limit = 4) {
        $this->db->query("
            SELECT
                s.*,
                sc.name as category_name
            FROM services s
            LEFT JOIN service_categories sc ON s.category_id = sc.id
            WHERE s.is_active = TRUE
                AND s.category_id = :category_id
                AND s.id != :service_id
            ORDER BY s.views DESC, s.created_at DESC
            LIMIT :limit
        ");

        $this->db->bind(':category_id', $categoryId);
        $this->db->bind(':service_id', $serviceId);
        $this->db->bind(':limit', $limit, PDO::PARAM_INT);

        return $this->db->resultSet();
    }

    /**
     * Get category by slug
     *
     * @param string $slug
     * @return array|false
     */
    public function getCategoryBySlug($slug) {
        $this->db->query("SELECT * FROM service_categories WHERE slug = :slug AND is_active = TRUE");
        $this->db->bind(':slug', $slug);
        return $this->db->single();
    }

    /**
     * Get service count per category
     *
     * @return array
     */
    public function getCategoriesWithCount() {
        $this->db->query("
            SELECT
                sc.*,
                COUNT(s.id) as service_count
            FROM service_categories sc
            LEFT JOIN services s ON sc.id = s.category_id AND s.is_active = TRUE
            WHERE sc.is_active = TRUE
            GROUP BY sc.id
            ORDER BY sc.sort_order ASC, sc.name ASC
        ");

        return $this->db->resultSet();
    }
}
