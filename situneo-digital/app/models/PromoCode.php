<?php
/**
 * PromoCode Model
 * Model untuk mengelola promotional codes dan discounts
 *
 * Menyediakan promo code validation dan usage tracking
 */

class PromoCode {
    private $db;

    public function __construct() {
        $this->db = Database::getInstance();
    }

    /**
     * Create new promo code
     *
     * @param array $data
     * @return int|false Promo ID
     */
    public function create($data) {
        try {
            $this->db->query("
                INSERT INTO promo_codes
                (code, description, discount_type, discount_value, max_discount, min_purchase,
                 usage_limit, usage_per_client, valid_from, valid_until, is_active)
                VALUES
                (:code, :description, :discount_type, :discount_value, :max_discount, :min_purchase,
                 :usage_limit, :usage_per_client, :valid_from, :valid_until, :is_active)
            ");

            $this->db->bind(':code', strtoupper($data['code']));
            $this->db->bind(':description', $data['description'] ?? null);
            $this->db->bind(':discount_type', $data['discount_type']);
            $this->db->bind(':discount_value', $data['discount_value']);
            $this->db->bind(':max_discount', $data['max_discount'] ?? 0);
            $this->db->bind(':min_purchase', $data['min_purchase'] ?? 0);
            $this->db->bind(':usage_limit', $data['usage_limit'] ?? null);
            $this->db->bind(':usage_per_client', $data['usage_per_client'] ?? 1);
            $this->db->bind(':valid_from', $data['valid_from'] ?? date('Y-m-d'));
            $this->db->bind(':valid_until', $data['valid_until'] ?? null);
            $this->db->bind(':is_active', $data['is_active'] ?? true);

            $this->db->execute();
            return $this->db->lastInsertId();

        } catch (Exception $e) {
            logError('Promo code creation failed: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Find promo code by ID
     *
     * @param int $id
     * @return array|false
     */
    public function findById($id) {
        $this->db->query("SELECT * FROM promo_codes WHERE id = :id");
        $this->db->bind(':id', $id);
        return $this->db->single();
    }

    /**
     * Find promo code by code string
     *
     * @param string $code
     * @return array|false
     */
    public function findByCode($code) {
        $this->db->query("SELECT * FROM promo_codes WHERE code = :code");
        $this->db->bind(':code', strtoupper($code));
        return $this->db->single();
    }

    /**
     * Validate promo code
     *
     * @param string $code
     * @param int|null $clientId
     * @return array|false Promo details if valid, false otherwise
     */
    public function validateCode($code, $clientId = null) {
        $promo = $this->findByCode($code);

        if (!$promo) {
            return false;
        }

        // Check if active
        if (!$promo['is_active']) {
            return false;
        }

        // Check valid dates
        $now = date('Y-m-d');

        if ($promo['valid_from'] && $promo['valid_from'] > $now) {
            return false; // Not yet valid
        }

        if ($promo['valid_until'] && $promo['valid_until'] < $now) {
            return false; // Expired
        }

        // Check total usage limit
        if ($promo['usage_limit'] && $promo['used_count'] >= $promo['usage_limit']) {
            return false; // Usage limit reached
        }

        // Check per-client usage limit
        if ($clientId && $promo['usage_per_client']) {
            $clientUsage = $this->getClientUsageCount($promo['id'], $clientId);

            if ($clientUsage >= $promo['usage_per_client']) {
                return false; // Client usage limit reached
            }
        }

        return $promo;
    }

    /**
     * Get client usage count for promo code
     *
     * @param int $promoId
     * @param int $clientId
     * @return int
     */
    private function getClientUsageCount($promoId, $clientId) {
        $this->db->query("
            SELECT COUNT(*) as count
            FROM promo_code_usage
            WHERE promo_code_id = :promo_id AND client_id = :client_id
        ");

        $this->db->bind(':promo_id', $promoId);
        $this->db->bind(':client_id', $clientId);

        $result = $this->db->single();
        return $result['count'] ?? 0;
    }

    /**
     * Record promo code usage
     *
     * @param int $promoId
     * @param int $clientId
     * @param int $orderId
     * @param float $discountAmount
     * @return bool
     */
    public function recordUsage($promoId, $clientId, $orderId, $discountAmount) {
        try {
            $this->db->beginTransaction();

            // Insert usage record
            $this->db->query("
                INSERT INTO promo_code_usage
                (promo_code_id, client_id, order_id, discount_amount)
                VALUES
                (:promo_code_id, :client_id, :order_id, :discount_amount)
            ");

            $this->db->bind(':promo_code_id', $promoId);
            $this->db->bind(':client_id', $clientId);
            $this->db->bind(':order_id', $orderId);
            $this->db->bind(':discount_amount', $discountAmount);
            $this->db->execute();

            // Increment used count
            $this->db->query("
                UPDATE promo_codes
                SET used_count = used_count + 1
                WHERE id = :id
            ");
            $this->db->bind(':id', $promoId);
            $this->db->execute();

            $this->db->commit();

            Session::logActivity($clientId, 'promo_code_used', 'Promo code applied to order', [
                'promo_id' => $promoId,
                'order_id' => $orderId,
                'discount_amount' => $discountAmount
            ]);

            return true;

        } catch (Exception $e) {
            $this->db->rollback();
            logError('Failed to record promo usage: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Get all promo codes
     *
     * @param int $page
     * @param int $perPage
     * @param array $filters
     * @return array
     */
    public function getAll($page = 1, $perPage = 20, $filters = []) {
        $offset = ($page - 1) * $perPage;

        $where = ['1=1'];
        $params = [];

        if (isset($filters['is_active'])) {
            $where[] = 'is_active = :is_active';
            $params[':is_active'] = $filters['is_active'];
        }

        if (!empty($filters['discount_type'])) {
            $where[] = 'discount_type = :discount_type';
            $params[':discount_type'] = $filters['discount_type'];
        }

        if (!empty($filters['search'])) {
            $where[] = '(code LIKE :search OR description LIKE :search)';
            $params[':search'] = '%' . $filters['search'] . '%';
        }

        $whereStr = implode(' AND ', $where);

        // Get total count
        $this->db->query("SELECT COUNT(*) as total FROM promo_codes WHERE $whereStr");
        foreach ($params as $param => $value) {
            $this->db->bind($param, $value);
        }
        $totalResult = $this->db->single();
        $total = $totalResult['total'];

        // Get promo codes
        $this->db->query("
            SELECT * FROM promo_codes
            WHERE $whereStr
            ORDER BY created_at DESC
            LIMIT :limit OFFSET :offset
        ");

        foreach ($params as $param => $value) {
            $this->db->bind($param, $value);
        }
        $this->db->bind(':limit', $perPage, PDO::PARAM_INT);
        $this->db->bind(':offset', $offset, PDO::PARAM_INT);

        $promoCodes = $this->db->resultSet();

        return [
            'promo_codes' => $promoCodes,
            'total' => $total,
            'page' => $page,
            'per_page' => $perPage,
            'total_pages' => ceil($total / $perPage)
        ];
    }

    /**
     * Get active promo codes
     *
     * @return array
     */
    public function getActive() {
        $this->db->query("
            SELECT * FROM promo_codes
            WHERE is_active = TRUE
                AND (valid_from IS NULL OR valid_from <= CURDATE())
                AND (valid_until IS NULL OR valid_until >= CURDATE())
                AND (usage_limit IS NULL OR used_count < usage_limit)
            ORDER BY created_at DESC
        ");

        return $this->db->resultSet();
    }

    /**
     * Update promo code
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
                'code', 'description', 'discount_type', 'discount_value',
                'max_discount', 'min_purchase', 'usage_limit', 'usage_per_client',
                'valid_from', 'valid_until', 'is_active'
            ];

            foreach ($allowedFields as $field) {
                if (isset($data[$field])) {
                    $fields[] = "$field = :$field";
                    $params[":$field"] = ($field === 'code') ? strtoupper($data[$field]) : $data[$field];
                }
            }

            if (empty($fields)) {
                return false;
            }

            $this->db->query("
                UPDATE promo_codes
                SET " . implode(', ', $fields) . ", updated_at = NOW()
                WHERE id = :id
            ");

            foreach ($params as $param => $value) {
                $this->db->bind($param, $value);
            }

            return $this->db->execute();

        } catch (Exception $e) {
            logError('Promo code update failed: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Deactivate promo code
     *
     * @param int $id
     * @return bool
     */
    public function deactivate($id) {
        try {
            $this->db->query("UPDATE promo_codes SET is_active = FALSE WHERE id = :id");
            $this->db->bind(':id', $id);
            return $this->db->execute();

        } catch (Exception $e) {
            logError('Promo deactivation failed: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Get promo code usage history
     *
     * @param int $promoId
     * @param int $page
     * @param int $perPage
     * @return array
     */
    public function getUsageHistory($promoId, $page = 1, $perPage = 20) {
        $offset = ($page - 1) * $perPage;

        // Get total count
        $this->db->query("SELECT COUNT(*) as total FROM promo_code_usage WHERE promo_code_id = :promo_id");
        $this->db->bind(':promo_id', $promoId);
        $totalResult = $this->db->single();
        $total = $totalResult['total'];

        // Get usage records
        $this->db->query("
            SELECT
                pcu.*,
                u.first_name, u.last_name, u.email,
                cp.company_name, cp.client_code,
                o.order_number
            FROM promo_code_usage pcu
            JOIN users u ON pcu.client_id = u.id
            LEFT JOIN client_profiles cp ON u.id = cp.user_id
            LEFT JOIN orders o ON pcu.order_id = o.id
            WHERE pcu.promo_code_id = :promo_id
            ORDER BY pcu.used_at DESC
            LIMIT :limit OFFSET :offset
        ");

        $this->db->bind(':promo_id', $promoId);
        $this->db->bind(':limit', $perPage, PDO::PARAM_INT);
        $this->db->bind(':offset', $offset, PDO::PARAM_INT);

        $usage = $this->db->resultSet();

        return [
            'usage' => $usage,
            'total' => $total,
            'page' => $page,
            'per_page' => $perPage,
            'total_pages' => ceil($total / $perPage)
        ];
    }

    /**
     * Get promo code statistics
     *
     * @return array
     */
    public function getStatistics() {
        // Total promo codes
        $this->db->query("SELECT COUNT(*) as total FROM promo_codes");
        $total = $this->db->single()['total'];

        // Active promo codes
        $this->db->query("SELECT COUNT(*) as count FROM promo_codes WHERE is_active = TRUE");
        $active = $this->db->single()['count'];

        // Total usage
        $this->db->query("SELECT COUNT(*) as count FROM promo_code_usage");
        $totalUsage = $this->db->single()['count'];

        // Total discount given
        $this->db->query("SELECT COALESCE(SUM(discount_amount), 0) as total FROM promo_code_usage");
        $totalDiscount = $this->db->single()['total'];

        // Most used promo codes
        $this->db->query("
            SELECT
                pc.code,
                pc.description,
                pc.discount_type,
                pc.discount_value,
                COUNT(pcu.id) as usage_count,
                COALESCE(SUM(pcu.discount_amount), 0) as total_discount
            FROM promo_codes pc
            LEFT JOIN promo_code_usage pcu ON pc.id = pcu.promo_code_id
            GROUP BY pc.id
            ORDER BY usage_count DESC
            LIMIT 10
        ");
        $mostUsed = $this->db->resultSet();

        return [
            'total' => $total,
            'active' => $active,
            'total_usage' => $totalUsage,
            'total_discount' => $totalDiscount,
            'most_used' => $mostUsed
        ];
    }

    /**
     * Calculate discount amount
     *
     * @param array $promo Promo code data
     * @param float $subtotal Cart subtotal
     * @param float $setupFees Cart setup fees
     * @return float Discount amount
     */
    public function calculateDiscount($promo, $subtotal, $setupFees = 0) {
        $discount = 0;

        switch ($promo['discount_type']) {
            case 'percentage':
                $discount = $subtotal * ($promo['discount_value'] / 100);
                if ($promo['max_discount'] > 0 && $discount > $promo['max_discount']) {
                    $discount = $promo['max_discount'];
                }
                break;

            case 'fixed_amount':
                $discount = $promo['discount_value'];
                break;

            case 'free_shipping':
                $discount = $setupFees;
                break;
        }

        // Ensure discount doesn't exceed subtotal
        if ($discount > $subtotal) {
            $discount = $subtotal;
        }

        return $discount;
    }

    /**
     * Generate random promo code
     *
     * @param int $length
     * @return string
     */
    public function generateRandomCode($length = 8) {
        $characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        $code = '';

        do {
            $code = '';
            for ($i = 0; $i < $length; $i++) {
                $code .= $characters[rand(0, strlen($characters) - 1)];
            }

            // Check if code already exists
            $existing = $this->findByCode($code);

        } while ($existing);

        return $code;
    }
}
