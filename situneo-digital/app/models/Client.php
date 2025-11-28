<?php
/**
 * Client Model
 * Model untuk mengelola data client
 *
 * Menyediakan CRUD operations untuk client management
 */

class Client {
    private $db;

    public function __construct() {
        $this->db = Database::getInstance();
    }

    /**
     * Create new client profile
     *
     * @param array $data Client data
     * @return int|false Client user_id jika berhasil
     */
    public function create($data) {
        try {
            $this->db->beginTransaction();

            // 1. Create user account with role_id = 5 (client)
            $userData = [
                'role_id' => 5,
                'email' => $data['email'],
                'password' => password_hash($data['password'], PASSWORD_BCRYPT, ['cost' => BCRYPT_COST]),
                'first_name' => $data['first_name'],
                'last_name' => $data['last_name'],
                'phone' => $data['phone'] ?? null,
                'status' => 'active'
            ];

            $this->db->query("INSERT INTO users (role_id, email, password, first_name, last_name, phone, status)
                             VALUES (:role_id, :email, :password, :first_name, :last_name, :phone, :status)");

            foreach ($userData as $key => $value) {
                $this->db->bind(":$key", $value);
            }

            $this->db->execute();
            $userId = $this->db->lastInsertId();

            // 2. Generate unique client code (CLT-YYYYMMDD-XXXX)
            $clientCode = $this->generateClientCode();

            // 3. Create client profile
            $this->db->query("INSERT INTO client_profiles
                (user_id, client_code, company_name, industry, partner_id, acquisition_date, acquisition_source, status)
                VALUES (:user_id, :client_code, :company_name, :industry, :partner_id, CURDATE(), :acquisition_source, 'active')");

            $this->db->bind(':user_id', $userId);
            $this->db->bind(':client_code', $clientCode);
            $this->db->bind(':company_name', $data['company_name'] ?? null);
            $this->db->bind(':industry', $data['industry'] ?? null);
            $this->db->bind(':partner_id', $data['partner_id'] ?? null);
            $this->db->bind(':acquisition_source', $data['acquisition_source'] ?? 'direct');
            $this->db->execute();

            // 4. Create user profile
            $this->db->query("INSERT INTO user_profiles (user_id, address, city, province)
                             VALUES (:user_id, :address, :city, :province)");
            $this->db->bind(':user_id', $userId);
            $this->db->bind(':address', $data['address'] ?? null);
            $this->db->bind(':city', $data['city'] ?? null);
            $this->db->bind(':province', $data['province'] ?? null);
            $this->db->execute();

            // 5. Create client preferences
            $this->db->query("INSERT INTO client_preferences (client_id) VALUES (:client_id)");
            $this->db->bind(':client_id', $userId);
            $this->db->execute();

            // 6. If assigned to partner, update partner_clients table
            if (!empty($data['partner_id'])) {
                $this->assignToPartner($userId, $data['partner_id']);
            }

            $this->db->commit();

            // Log activity
            Session::logActivity($userId, 'client_registered', 'New client registered', [
                'client_code' => $clientCode
            ]);

            return $userId;

        } catch (Exception $e) {
            $this->db->rollback();
            logError('Client creation failed: ' . $e->getMessage(), $data);
            return false;
        }
    }

    /**
     * Find client by user ID
     *
     * @param int $userId
     * @return array|false
     */
    public function findById($userId) {
        $this->db->query("
            SELECT
                cp.*,
                u.email, u.first_name, u.last_name, u.phone, u.status as user_status,
                u.email_verified_at, u.last_login_at,
                up.address, up.city, up.province,
                p.first_name as partner_first_name, p.last_name as partner_last_name
            FROM client_profiles cp
            JOIN users u ON cp.user_id = u.id
            LEFT JOIN user_profiles up ON u.id = up.user_id
            LEFT JOIN users p ON cp.partner_id = p.id
            WHERE cp.user_id = :user_id
                AND u.deleted_at IS NULL
        ");

        $this->db->bind(':user_id', $userId);
        return $this->db->single();
    }

    /**
     * Alias for findById - Find client by user ID
     *
     * @param int $userId
     * @return array|false
     */
    public function findByUserId($userId) {
        return $this->findById($userId);
    }

    /**
     * Find client by client code
     *
     * @param string $clientCode
     * @return array|false
     */
    public function findByCode($clientCode) {
        $this->db->query("
            SELECT
                cp.*,
                u.email, u.first_name, u.last_name, u.phone
            FROM client_profiles cp
            JOIN users u ON cp.user_id = u.id
            WHERE cp.client_code = :client_code
                AND u.deleted_at IS NULL
        ");

        $this->db->bind(':client_code', $clientCode);
        return $this->db->single();
    }

    /**
     * Get all clients with pagination
     *
     * @param int $page
     * @param int $perPage
     * @param array $filters
     * @return array
     */
    public function getAll($page = 1, $perPage = 20, $filters = []) {
        $offset = ($page - 1) * $perPage;

        // Build WHERE clause
        $where = ['u.deleted_at IS NULL'];
        $params = [];

        if (!empty($filters['partner_id'])) {
            $where[] = 'cp.partner_id = :partner_id';
            $params[':partner_id'] = $filters['partner_id'];
        }

        if (!empty($filters['status'])) {
            $where[] = 'cp.status = :status';
            $params[':status'] = $filters['status'];
        }

        if (!empty($filters['search'])) {
            $where[] = "(u.email LIKE :search OR u.first_name LIKE :search OR u.last_name LIKE :search OR cp.client_code LIKE :search)";
            $params[':search'] = '%' . $filters['search'] . '%';
        }

        $whereStr = implode(' AND ', $where);

        // Get total count
        $this->db->query("SELECT COUNT(*) as total FROM client_profiles cp JOIN users u ON cp.user_id = u.id WHERE $whereStr");
        foreach ($params as $param => $value) {
            $this->db->bind($param, $value);
        }
        $totalResult = $this->db->single();
        $total = $totalResult['total'];

        // Get clients
        $this->db->query("
            SELECT
                cp.*,
                u.email, u.first_name, u.last_name, u.phone, u.status as user_status,
                u.last_login_at,
                p.first_name as partner_first_name, p.last_name as partner_last_name
            FROM client_profiles cp
            JOIN users u ON cp.user_id = u.id
            LEFT JOIN users p ON cp.partner_id = p.id
            WHERE $whereStr
            ORDER BY cp.created_at DESC
            LIMIT :limit OFFSET :offset
        ");

        foreach ($params as $param => $value) {
            $this->db->bind($param, $value);
        }
        $this->db->bind(':limit', $perPage, PDO::PARAM_INT);
        $this->db->bind(':offset', $offset, PDO::PARAM_INT);

        $clients = $this->db->resultSet();

        return [
            'clients' => $clients,
            'total' => $total,
            'page' => $page,
            'per_page' => $perPage,
            'total_pages' => ceil($total / $perPage)
        ];
    }

    /**
     * Update client profile
     *
     * @param int $userId
     * @param array $data
     * @return bool
     */
    public function update($userId, $data) {
        try {
            $this->db->beginTransaction();

            // Update user data if provided
            if (isset($data['first_name']) || isset($data['last_name']) || isset($data['phone'])) {
                $userFields = [];
                $userParams = [':user_id' => $userId];

                if (isset($data['first_name'])) {
                    $userFields[] = 'first_name = :first_name';
                    $userParams[':first_name'] = $data['first_name'];
                }

                if (isset($data['last_name'])) {
                    $userFields[] = 'last_name = :last_name';
                    $userParams[':last_name'] = $data['last_name'];
                }

                if (isset($data['phone'])) {
                    $userFields[] = 'phone = :phone';
                    $userParams[':phone'] = $data['phone'];
                }

                if (!empty($userFields)) {
                    $this->db->query("UPDATE users SET " . implode(', ', $userFields) . ", updated_at = NOW() WHERE id = :user_id");
                    foreach ($userParams as $param => $value) {
                        $this->db->bind($param, $value);
                    }
                    $this->db->execute();
                }
            }

            // Update client profile
            $profileFields = [];
            $profileParams = [':user_id' => $userId];

            $allowedFields = ['company_name', 'industry', 'company_size', 'tax_id', 'billing_address', 'shipping_address',
                             'preferred_payment_method', 'credit_limit', 'status', 'vip_status', 'notes'];

            foreach ($allowedFields as $field) {
                if (isset($data[$field])) {
                    $profileFields[] = "$field = :$field";
                    $profileParams[":$field"] = $data[$field];
                }
            }

            if (!empty($profileFields)) {
                $this->db->query("UPDATE client_profiles SET " . implode(', ', $profileFields) . ", updated_at = NOW() WHERE user_id = :user_id");
                foreach ($profileParams as $param => $value) {
                    $this->db->bind($param, $value);
                }
                $this->db->execute();
            }

            $this->db->commit();

            // Log activity
            Session::logActivity($userId, 'client_updated', 'Client profile updated');

            return true;

        } catch (Exception $e) {
            $this->db->rollback();
            logError('Client update failed: ' . $e->getMessage(), ['user_id' => $userId]);
            return false;
        }
    }

    /**
     * Get client dashboard statistics
     *
     * @param int $userId
     * @return array
     */
    public function getDashboardStats($userId) {
        $client = $this->findById($userId);

        if (!$client) {
            return false;
        }

        // Get total orders
        $this->db->query("SELECT COUNT(*) as count, COALESCE(SUM(total_amount), 0) as total
                         FROM orders WHERE client_id = :client_id");
        $this->db->bind(':client_id', $userId);
        $orders = $this->db->single();

        // Get active subscriptions
        $this->db->query("SELECT COUNT(*) as count FROM client_subscriptions
                         WHERE client_id = :client_id AND status = 'active'");
        $this->db->bind(':client_id', $userId);
        $subscriptions = $this->db->single();

        // Get open tickets
        $this->db->query("SELECT COUNT(*) as count FROM client_support_tickets
                         WHERE client_id = :client_id AND status IN ('open', 'in_progress')");
        $this->db->bind(':client_id', $userId);
        $tickets = $this->db->single();

        // Get unpaid invoices
        $this->db->query("SELECT COUNT(*) as count, COALESCE(SUM(total_amount - paid_amount), 0) as total
                         FROM client_invoices
                         WHERE client_id = :client_id AND status IN ('sent', 'partial', 'overdue')");
        $this->db->bind(':client_id', $userId);
        $unpaidInvoices = $this->db->single();

        return [
            'client' => $client,
            'total_orders' => $orders['count'],
            'total_spent' => $orders['total'],
            'active_subscriptions' => $subscriptions['count'],
            'open_tickets' => $tickets['count'],
            'unpaid_invoices_count' => $unpaidInvoices['count'],
            'unpaid_invoices_total' => $unpaidInvoices['total']
        ];
    }

    /**
     * Assign client to partner
     *
     * @param int $clientId
     * @param int $partnerId
     * @return bool
     */
    private function assignToPartner($clientId, $partnerId) {
        try {
            // Check if partner_clients table exists (from BATCH 2)
            $this->db->query("INSERT INTO partner_clients
                (partner_id, client_id, acquisition_date, status)
                VALUES (:partner_id, :client_id, CURDATE(), 'active')");

            $this->db->bind(':partner_id', $partnerId);
            $this->db->bind(':client_id', $clientId);

            return $this->db->execute();
        } catch (Exception $e) {
            logError('Failed to assign client to partner: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Generate unique client code
     *
     * @return string CLT-YYYYMMDD-XXXX
     */
    private function generateClientCode() {
        $date = date('Ymd');
        $prefix = "CLT-$date-";

        // Get count of clients created today
        $this->db->query("SELECT COUNT(*) as count FROM client_profiles
                         WHERE client_code LIKE :prefix");
        $this->db->bind(':prefix', $prefix . '%');
        $result = $this->db->single();

        $sequence = str_pad($result['count'] + 1, 4, '0', STR_PAD_LEFT);

        return $prefix . $sequence;
    }

    /**
     * Update client status
     *
     * @param int $userId
     * @param string $status
     * @return bool
     */
    public function updateStatus($userId, $status) {
        $allowedStatuses = ['active', 'inactive', 'suspended', 'blacklist'];

        if (!in_array($status, $allowedStatuses)) {
            return false;
        }

        try {
            $this->db->query("UPDATE client_profiles SET status = :status, updated_at = NOW() WHERE user_id = :user_id");
            $this->db->bind(':status', $status);
            $this->db->bind(':user_id', $userId);

            $success = $this->db->execute();

            if ($success) {
                Session::logActivity($userId, 'client_status_changed', "Status changed to $status");
            }

            return $success;

        } catch (Exception $e) {
            logError('Status update failed: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Add loyalty points
     *
     * @param int $userId
     * @param int $points
     * @param string $reason
     * @return bool
     */
    public function addLoyaltyPoints($userId, $points, $reason = '') {
        try {
            $this->db->beginTransaction();

            // Update client loyalty points
            $this->db->query("UPDATE client_profiles
                             SET loyalty_points = loyalty_points + :points
                             WHERE user_id = :user_id");
            $this->db->bind(':points', $points);
            $this->db->bind(':user_id', $userId);
            $this->db->execute();

            // Record transaction
            $this->db->query("INSERT INTO client_loyalty_transactions
                (client_id, transaction_type, points, reason)
                VALUES (:client_id, 'earned', :points, :reason)");
            $this->db->bind(':client_id', $userId);
            $this->db->bind(':points', $points);
            $this->db->bind(':reason', $reason);
            $this->db->execute();

            $this->db->commit();
            return true;

        } catch (Exception $e) {
            $this->db->rollback();
            logError('Failed to add loyalty points: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Get client statistics
     *
     * @return array
     */
    public function getStatistics() {
        // Total clients
        $this->db->query("SELECT COUNT(*) as total FROM client_profiles");
        $total = $this->db->single()['total'];

        // By status
        $this->db->query("SELECT status, COUNT(*) as count FROM client_profiles GROUP BY status");
        $byStatus = $this->db->resultSet();

        // New clients this month
        $this->db->query("SELECT COUNT(*) as count FROM client_profiles
                         WHERE YEAR(created_at) = YEAR(CURDATE()) AND MONTH(created_at) = MONTH(CURDATE())");
        $newThisMonth = $this->db->single()['count'];

        // VIP clients
        $this->db->query("SELECT COUNT(*) as count FROM client_profiles WHERE vip_status = TRUE");
        $vipCount = $this->db->single()['count'];

        return [
            'total' => $total,
            'by_status' => $byStatus,
            'new_this_month' => $newThisMonth,
            'vip_count' => $vipCount
        ];
    }
}
