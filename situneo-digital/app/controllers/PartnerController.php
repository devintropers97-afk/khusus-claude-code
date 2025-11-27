<?php
/**
 * PartnerController
 * Controller untuk mengelola Partner operations
 *
 * Handles:
 * - Partner dashboard
 * - Registration & approval
 * - Performance tracking
 * - Commission management
 * - Withdrawal requests
 */

class PartnerController {
    private $partnerModel;
    private $commission;
    private $validator;

    public function __construct() {
        $this->partnerModel = new Partner();
        $this->commission = new Commission();
        $this->validator = new Validator();
    }

    /**
     * Partner dashboard
     *
     * @return void
     */
    public function dashboard() {
        // Require login as partner
        Session::requireLogin();
        Session::requireRole(4); // Partner role

        $partnerId = Session::getUserId();

        // Get dashboard stats
        $stats = $this->partnerModel->getDashboardStats($partnerId);

        // Load dashboard view
        require_once APP_PATH . '/views/partner/dashboard.php';
    }

    /**
     * Process partner registration
     *
     * @return void
     */
    public function register() {
        // Validate CSRF
        if (!CSRF::validate()) {
            return;
        }

        // Sanitize input
        $data = Validator::sanitizeArray($_POST);

        // Validate
        $rules = [
            'first_name' => 'required|min:2|max:100',
            'last_name' => 'required|min:2|max:100',
            'email' => 'required|email|unique:users,email',
            'phone' => 'required|phone',
            'password' => 'required|min:8',
            'password_confirmation' => 'required|confirmed',
            'company_name' => 'max:255',
            'address' => 'required',
            'city' => 'required',
            'province' => 'required'
        ];

        if (!$this->validator->validate($data, $rules)) {
            Session::flash('error', $this->validator->firstError());
            Session::setOldInput($_POST);
            redirect(url('partner/register.php'));
            return;
        }

        // Register partner
        $partnerId = $this->partnerModel->register($data);

        if (!$partnerId) {
            Session::flash('error', 'Terjadi kesalahan saat mendaftar. Silakan coba lagi.');
            Session::setOldInput($_POST);
            redirect(url('partner/register.php'));
            return;
        }

        // Success
        Session::flash('success', 'Pendaftaran partner berhasil! Akun Anda menunggu persetujuan dari Admin. Cek email untuk informasi lebih lanjut.');
        redirect(url('login.php'));
    }

    /**
     * Show partner performance
     *
     * @return void
     */
    public function performance() {
        Session::requireLogin();
        Session::requireRole(4);

        $partnerId = Session::getUserId();
        $year = $_GET['year'] ?? date('Y');
        $month = $_GET['month'] ?? date('n');

        // Get monthly performance
        $performance = $this->partnerModel->getMonthlyPerformance($partnerId, $year, $month);

        // Get ARPU data
        $arpuData = $this->commission->calculateARPU($partnerId, $year, $month);

        // Check tier upgrade
        $tierCheck = $this->commission->checkAndUpdatePartnerTier($partnerId, $year, $month);

        // Load view
        require_once APP_PATH . '/views/partner/performance.php';
    }

    /**
     * Show commissions
     *
     * @return void
     */
    public function commissions() {
        Session::requireLogin();
        Session::requireRole(4);

        $partnerId = Session::getUserId();
        $page = $_GET['page'] ?? 1;

        // Get commissions with pagination
        $this->db = Database::getInstance();
        $offset = ($page - 1) * 20;

        $this->db->query("
            SELECT *
            FROM partner_commissions
            WHERE partner_id = :partner_id
            ORDER BY created_at DESC
            LIMIT 20 OFFSET :offset
        ");

        $this->db->bind(':partner_id', $partnerId);
        $this->db->bind(':offset', $offset, PDO::PARAM_INT);

        $commissions = $this->db->resultSet();

        // Get pending total
        $pendingTotal = $this->commission->getPartnerPendingCommissions($partnerId);

        // Load view
        require_once APP_PATH . '/views/partner/commissions.php';
    }

    /**
     * Request withdrawal
     *
     * @return void
     */
    public function requestWithdrawal() {
        Session::requireLogin();
        Session::requireRole(4);

        if (!CSRF::validate()) {
            return;
        }

        $partnerId = Session::getUserId();
        $amount = $_POST['amount'] ?? 0;
        $bankAccountId = $_POST['bank_account_id'] ?? null;

        // Validate
        if (empty($amount) || $amount <= 0) {
            Session::flash('error', 'Jumlah penarikan tidak valid.');
            redirect(url('partner/withdrawals.php'));
            return;
        }

        // Process withdrawal request
        $withdrawalId = $this->partnerModel->requestWithdrawal($partnerId, $amount, $bankAccountId);

        if ($withdrawalId) {
            Session::flash('success', 'Permintaan penarikan berhasil diajukan. Menunggu persetujuan.');
        } else {
            Session::flash('error', 'Terjadi kesalahan. Periksa saldo Anda.');
        }

        redirect(url('partner/withdrawals.php'));
    }

    /**
     * Show partner clients
     *
     * @return void
     */
    public function clients() {
        Session::requireLogin();
        Session::requireRole(4);

        $partnerId = Session::getUserId();

        // Get clients
        $this->db = Database::getInstance();
        $this->db->query("
            SELECT
                pc.*,
                u.first_name, u.last_name, u.email, u.phone
            FROM partner_clients pc
            JOIN users u ON pc.client_id = u.id
            WHERE pc.partner_id = :partner_id
            ORDER BY pc.acquisition_date DESC
        ");

        $this->db->bind(':partner_id', $partnerId);
        $clients = $this->db->resultSet();

        // Load view
        require_once APP_PATH . '/views/partner/clients.php';
    }

    /**
     * Commission calculator (tool for partners)
     *
     * @return void
     */
    public function calculator() {
        Session::requireLogin();
        Session::requireRole(4);

        $partnerId = Session::getUserId();
        $partner = $this->partnerModel->findById($partnerId);

        $result = null;

        if ($_SERVER['REQUEST_METHOD'] === 'POST' && CSRF::validate()) {
            $orderAmount = $_POST['order_amount'] ?? 0;

            if ($orderAmount > 0) {
                // Calculate commission for different tiers
                $result = [
                    'order_amount' => $orderAmount,
                    'current_tier' => $partner['tier'],
                    'current_rate' => $partner['commission_rate'],
                    'current_commission' => ($orderAmount * $partner['commission_rate']) / 100,
                    'tiers' => []
                ];

                // Show all tier calculations
                $tiers = [
                    'tier1' => Commission::PARTNER_TIER1,
                    'tier2' => Commission::PARTNER_TIER2,
                    'tier3' => Commission::PARTNER_TIER3,
                    'tier4' => Commission::PARTNER_TIER4
                ];

                foreach ($tiers as $tier => $rate) {
                    $result['tiers'][$tier] = [
                        'rate' => $rate,
                        'commission' => ($orderAmount * $rate) / 100
                    ];
                }
            }
        }

        // Load view
        require_once APP_PATH . '/views/partner/calculator.php';
    }
}
