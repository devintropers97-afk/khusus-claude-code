<?php
/**
 * Partner Model
 * Model untuk mengelola Partner/Reseller data dan operasi
 *
 * Partner Features:
 * - Multi-tier commission (30-55%)
 * - Client management
 * - Sales tracking
 * - Training modules
 * - Support tickets
 * - Withdrawal management
 */

class Partner {
    private $db;
    private $commission;

    public function __construct() {
        $this->db = Database::getInstance();
        $this->commission = new Commission();
    }

    /**
     * Register new partner (application)
     *
     * @param array $data Partner application data
     * @return int|false Partner ID if successful
     */
    public function register($data) {
        try {
            $this->db->beginTransaction();

            // 1. Create user account
            $userModel = new User();
            $userData = [
                'email' => $data['email'],
                'password' => $data['password'],
                'first_name' => $data['first_name'],
                'last_name' => $data['last_name'],
                'phone' => $data['phone'] ?? null,
                'role_id' => 4, // Partner role
                'status' => 'inactive' // Inactive until approved
            ];

            $userId = $userModel->create($userData);

            if (!$userId) {
                throw new Exception('Failed to create user account');
            }

            // 2. Generate unique partner code
            $partnerCode = $this->generatePartnerCode();

            // 3. Create partner profile
            $this->db->query("
                INSERT INTO partner_profiles
                (user_id, partner_code, company_name, company_type, tier, commission_rate, status)
                VALUES
                (:user_id, :partner_code, :company_name, :company_type, 'tier1', :commission_rate, 'pending')
            ");

            $this->db->bind(':user_id', $userId);
            $this->db->bind(':partner_code', $partnerCode);
            $this->db->bind(':company_name', $data['company_name'] ?? null);
            $this->db->bind(':company_type', $data['company_type'] ?? 'individual');
            $this->db->bind(':commission_rate', Commission::PARTNER_TIER1);
            $this->db->execute();

            // 4. Create user profile
            $this->db->query("
                INSERT INTO user_profiles (user_id, address, city, province, postal_code)
                VALUES (:user_id, :address, :city, :province, :postal_code)
            ");

            $this->db->bind(':user_id', $userId);
            $this->db->bind(':address', $data['address'] ?? null);
            $this->db->bind(':city', $data['city'] ?? null);
            $this->db->bind(':province', $data['province'] ?? null);
            $this->db->bind(':postal_code', $data['postal_code'] ?? null);
            $this->db->execute();

            // 5. Create partner settings with defaults
            $this->db->query("
                INSERT INTO partner_settings (partner_id)
                VALUES (:partner_id)
            ");

            $this->db->bind(':partner_id', $userId);
            $this->db->execute();

            $this->db->commit();

            // Log activity
            Session::logActivity($userId, 'partner_registration', 'Partner application submitted', [
                'partner_code' => $partnerCode
            ]);

            // Send notification to admin for approval
            $this->notifyAdminNewPartnerApplication($userId, $partnerCode);

            return $userId;

        } catch (Exception $e) {
            $this->db->rollback();
            logError('Partner registration failed: ' . $e->getMessage(), $data);
            return false;
        }
    }

    /**
     * Approve partner application
     *
     * @param int $partnerId
     * @param int $approvedBy Admin/Manager user ID
     * @param int $spvId Optional SPV assignment
     * @param int $managerId Optional Manager assignment
     * @return bool
     */
    public function approve($partnerId, $approvedBy, $spvId = null, $managerId = null) {
        try {
            $this->db->beginTransaction();

            // Update partner status
            $this->db->query("
                UPDATE partner_profiles
                SET status = 'active',
                    approved_at = NOW(),
                    approved_by = :approved_by,
                    spv_id = :spv_id,
                    manager_id = :manager_id
                WHERE user_id = :partner_id
            ");

            $this->db->bind(':approved_by', $approvedBy);
            $this->db->bind(':spv_id', $spvId);
            $this->db->bind(':manager_id', $managerId);
            $this->db->bind(':partner_id', $partnerId);
            $this->db->execute();

            // Activate user account
            $this->db->query("
                UPDATE users
                SET status = 'active'
                WHERE id = :id
            ");

            $this->db->bind(':id', $partnerId);
            $this->db->execute();

            // Assign to SPV if specified
            if ($spvId) {
                $this->assignToSPV($partnerId, $spvId);
            }

            $this->db->commit();

            // Log activity
            Session::logActivity($partnerId, 'partner_approved', 'Partner application approved', [
                'approved_by' => $approvedBy,
                'spv_id' => $spvId,
                'manager_id' => $managerId
            ]);

            // Send approval email to partner
            $partner = $this->findById($partnerId);
            $this->sendApprovalEmail($partner);

            return true;

        } catch (Exception $e) {
            $this->db->rollback();
            logError('Partner approval failed: ' . $e->getMessage(), [
                'partner_id' => $partnerId
            ]);
            return false;
        }
    }

    /**
     * Find partner by ID
     *
     * @param int $partnerId
     * @return array|false
     */
    public function findById($partnerId) {
        $this->db->query("
            SELECT
                u.*,
                pp.*,
                up.address, up.city, up.province,
                spv.first_name as spv_first_name,
                spv.last_name as spv_last_name,
                mgr.first_name as manager_first_name,
                mgr.last_name as manager_last_name
            FROM users u
            JOIN partner_profiles pp ON u.id = pp.user_id
            LEFT JOIN user_profiles up ON u.id = up.user_id
            LEFT JOIN users spv ON pp.spv_id = spv.id
            LEFT JOIN users mgr ON pp.manager_id = mgr.id
            WHERE u.id = :id
                AND u.role_id = 4
                AND u.deleted_at IS NULL
        ");

        $this->db->bind(':id', $partnerId);
        return $this->db->single();
    }

    /**
     * Get all partners with filters
     *
     * @param array $filters
     * @param int $page
     * @param int $perPage
     * @return array
     */
    public function getAll($filters = [], $page = 1, $perPage = 20) {
        $offset = ($page - 1) * $perPage;

        $where = ['u.role_id = 4', 'u.deleted_at IS NULL'];
        $params = [];

        if (!empty($filters['status'])) {
            $where[] = 'pp.status = :status';
            $params[':status'] = $filters['status'];
        }

        if (!empty($filters['tier'])) {
            $where[] = 'pp.tier = :tier';
            $params[':tier'] = $filters['tier'];
        }

        if (!empty($filters['spv_id'])) {
            $where[] = 'pp.spv_id = :spv_id';
            $params[':spv_id'] = $filters['spv_id'];
        }

        if (!empty($filters['search'])) {
            $where[] = "(u.email LIKE :search OR u.first_name LIKE :search OR u.last_name LIKE :search OR pp.partner_code LIKE :search)";
            $params[':search'] = '%' . $filters['search'] . '%';
        }

        $whereStr = implode(' AND ', $where);

        // Get total count
        $this->db->query("SELECT COUNT(*) as total FROM users u JOIN partner_profiles pp ON u.id = pp.user_id WHERE $whereStr");
        foreach ($params as $param => $value) {
            $this->db->bind($param, $value);
        }
        $totalResult = $this->db->single();
        $total = $totalResult['total'];

        // Get partners
        $this->db->query("
            SELECT
                u.id, u.email, u.first_name, u.last_name, u.status as user_status,
                pp.partner_code, pp.company_name, pp.tier, pp.commission_rate, pp.status,
                pp.created_at
            FROM users u
            JOIN partner_profiles pp ON u.id = pp.user_id
            WHERE $whereStr
            ORDER BY pp.created_at DESC
            LIMIT :limit OFFSET :offset
        ");

        foreach ($params as $param => $value) {
            $this->db->bind($param, $value);
        }
        $this->db->bind(':limit', $perPage, PDO::PARAM_INT);
        $this->db->bind(':offset', $offset, PDO::PARAM_INT);

        $partners = $this->db->resultSet();

        return [
            'partners' => $partners,
            'total' => $total,
            'page' => $page,
            'per_page' => $perPage,
            'total_pages' => ceil($total / $perPage)
        ];
    }

    /**
     * Assign partner to SPV
     *
     * @param int $partnerId
     * @param int $spvId
     * @return bool
     */
    public function assignToSPV($partnerId, $spvId) {
        try {
            $this->db->query("
                INSERT INTO spv_partner_assignments (spv_id, partner_id)
                VALUES (:spv_id, :partner_id)
                ON DUPLICATE KEY UPDATE status = 'active'
            ");

            $this->db->bind(':spv_id', $spvId);
            $this->db->bind(':partner_id', $partnerId);

            return $this->db->execute();
        } catch (Exception $e) {
            logError('Failed to assign partner to SPV: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Add client to partner
     *
     * @param int $partnerId
     * @param int $clientId
     * @return bool
     */
    public function addClient($partnerId, $clientId) {
        try {
            $this->db->query("
                INSERT INTO partner_clients (partner_id, client_id, status)
                VALUES (:partner_id, :client_id, 'active')
            ");

            $this->db->bind(':partner_id', $partnerId);
            $this->db->bind(':client_id', $clientId);

            return $this->db->execute();
        } catch (Exception $e) {
            logError('Failed to add client to partner: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Get partner performance for specific month
     *
     * @param int $partnerId
     * @param int $year
     * @param int $month
     * @return array
     */
    public function getMonthlyPerformance($partnerId, $year, $month) {
        // Check if performance record exists
        $this->db->query("
            SELECT * FROM partner_performance
            WHERE partner_id = :partner_id
                AND year = :year
                AND month = :month
        ");

        $this->db->bind(':partner_id', $partnerId);
        $this->db->bind(':year', $year);
        $this->db->bind(':month', $month);

        $existing = $this->db->single();

        if ($existing) {
            return $existing;
        }

        // Calculate and create performance record
        return $this->calculateMonthlyPerformance($partnerId, $year, $month);
    }

    /**
     * Calculate monthly performance
     *
     * @param int $partnerId
     * @param int $year
     * @param int $month
     * @return array
     */
    private function calculateMonthlyPerformance($partnerId, $year, $month) {
        // Get stats from orders
        $this->db->query("
            SELECT
                COALESCE(SUM(total_amount), 0) as total_sales,
                COUNT(*) as total_orders,
                COUNT(DISTINCT client_id) as unique_clients
            FROM orders
            WHERE partner_id = :partner_id
                AND YEAR(created_at) = :year
                AND MONTH(created_at) = :month
                AND status = 'completed'
        ");

        $this->db->bind(':partner_id', $partnerId);
        $this->db->bind(':year', $year);
        $this->db->bind(':month', $month);

        $stats = $this->db->single();

        // Get active clients
        $this->db->query("
            SELECT COUNT(*) as active_clients
            FROM partner_clients
            WHERE partner_id = :partner_id
                AND status = 'active'
        ");

        $this->db->bind(':partner_id', $partnerId);
        $clientStats = $this->db->single();

        // Get total commission
        $totalCommission = $this->commission->getPartnerPaidCommissions($partnerId, $year, $month);

        // Determine tier achieved
        $tierAchieved = $this->commission->determineTierFromSales($stats['total_sales']);

        // Save performance
        $this->db->query("
            INSERT INTO partner_performance
            (partner_id, year, month, total_sales, total_orders, new_clients, active_clients, total_commission, tier_achieved)
            VALUES
            (:partner_id, :year, :month, :total_sales, :total_orders, :new_clients, :active_clients, :total_commission, :tier_achieved)
        ");

        $this->db->bind(':partner_id', $partnerId);
        $this->db->bind(':year', $year);
        $this->db->bind(':month', $month);
        $this->db->bind(':total_sales', $stats['total_sales']);
        $this->db->bind(':total_orders', $stats['total_orders']);
        $this->db->bind(':new_clients', $stats['unique_clients']);
        $this->db->bind(':active_clients', $clientStats['active_clients']);
        $this->db->bind(':total_commission', $totalCommission);
        $this->db->bind(':tier_achieved', $tierAchieved);

        $this->db->execute();

        return [
            'partner_id' => $partnerId,
            'year' => $year,
            'month' => $month,
            'total_sales' => $stats['total_sales'],
            'total_orders' => $stats['total_orders'],
            'new_clients' => $stats['unique_clients'],
            'active_clients' => $clientStats['active_clients'],
            'total_commission' => $totalCommission,
            'tier_achieved' => $tierAchieved
        ];
    }

    /**
     * Request withdrawal
     *
     * @param int $partnerId
     * @param float $amount
     * @param int $bankAccountId
     * @return int|false Withdrawal ID
     */
    public function requestWithdrawal($partnerId, $amount, $bankAccountId) {
        try {
            // Check available balance
            $pendingCommissions = $this->commission->getPartnerPendingCommissions($partnerId);

            if ($amount > $pendingCommissions) {
                throw new Exception('Insufficient balance');
            }

            // Create withdrawal request
            $this->db->query("
                INSERT INTO partner_withdrawals
                (partner_id, amount, bank_account_id, status)
                VALUES
                (:partner_id, :amount, :bank_account_id, 'pending')
            ");

            $this->db->bind(':partner_id', $partnerId);
            $this->db->bind(':amount', $amount);
            $this->db->bind(':bank_account_id', $bankAccountId);

            $this->db->execute();
            $withdrawalId = $this->db->lastInsertId();

            // Log activity
            Session::logActivity($partnerId, 'withdrawal_requested', 'Withdrawal requested: ' . rupiah($amount));

            return $withdrawalId;

        } catch (Exception $e) {
            logError('Withdrawal request failed: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Get partner dashboard stats
     *
     * @param int $partnerId
     * @return array
     */
    public function getDashboardStats($partnerId) {
        $currentYear = date('Y');
        $currentMonth = date('n');

        // Current month performance
        $monthlyPerf = $this->getMonthlyPerformance($partnerId, $currentYear, $currentMonth);

        // Total clients
        $this->db->query("
            SELECT COUNT(*) as total
            FROM partner_clients
            WHERE partner_id = :partner_id AND status = 'active'
        ");
        $this->db->bind(':partner_id', $partnerId);
        $clientsResult = $this->db->single();

        // Pending commissions
        $pendingCommissions = $this->commission->getPartnerPendingCommissions($partnerId);

        // ARPU
        $arpuData = $this->commission->calculateARPU($partnerId, $currentYear, $currentMonth);

        // Partner info
        $partner = $this->findById($partnerId);

        return [
            'partner' => $partner,
            'monthly_performance' => $monthlyPerf,
            'total_clients' => $clientsResult['total'],
            'pending_commissions' => $pendingCommissions,
            'arpu' => $arpuData,
            'tier' => $partner['tier'],
            'commission_rate' => $partner['commission_rate']
        ];
    }

    /**
     * Generate unique partner code
     *
     * @return string
     */
    private function generatePartnerCode() {
        do {
            // Format: PNR-YYYYMMDD-XXXX
            $code = 'PNR-' . date('Ymd') . '-' . strtoupper(substr(bin2hex(random_bytes(2)), 0, 4));

            // Check uniqueness
            $this->db->query("SELECT COUNT(*) as count FROM partner_profiles WHERE partner_code = :code");
            $this->db->bind(':code', $code);
            $result = $this->db->single();

        } while ($result['count'] > 0);

        return $code;
    }

    /**
     * Notify admin about new partner application
     *
     * @param int $partnerId
     * @param string $partnerCode
     * @return void
     */
    private function notifyAdminNewPartnerApplication($partnerId, $partnerCode) {
        // Create notification for admin/manager
        $this->db->query("
            INSERT INTO user_notifications (user_id, type, title, message)
            SELECT id, 'partner_application', 'New Partner Application',
                   CONCAT('New partner application: ', :partner_code)
            FROM users
            WHERE role_id IN (1, 2)
                AND status = 'active'
        ");

        $this->db->bind(':partner_code', $partnerCode);
        $this->db->execute();
    }

    /**
     * Send approval email to partner
     *
     * @param array $partner
     * @return void
     */
    private function sendApprovalEmail($partner) {
        $mailer = new Mailer();

        $subject = "Partner Application Approved - " . APP_NAME;
        $body = "
        <h2>Congratulations!</h2>
        <p>Your partner application has been approved.</p>
        <p><strong>Partner Code:</strong> {$partner['partner_code']}</p>
        <p><strong>Commission Tier:</strong> Tier 1 (30%)</p>
        <p>You can now login to your partner dashboard and start managing clients.</p>
        ";

        $mailer->send($partner['email'], $subject, $body);
    }
}
