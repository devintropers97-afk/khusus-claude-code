<?php
/**
 * PromoCode Controller
 * Mengelola promotional codes (Admin only)
 */

class PromoCodeController extends Controller {
    private $promoModel;

    public function __construct() {
        parent::__construct();

        // Check if user is logged in
        if (!Session::isLoggedIn()) {
            redirect('/auth/login');
        }

        // Check admin/manager authorization
        $roleId = Session::get('role_id');
        if (!in_array($roleId, [1, 2])) {
            Session::setFlash('error', 'Unauthorized access');
            redirect('/dashboard');
        }

        $this->promoModel = new PromoCode();
    }

    /**
     * List all promo codes
     */
    public function index() {
        $page = $_GET['page'] ?? 1;
        $perPage = 20;

        $filters = [
            'is_active' => isset($_GET['is_active']) ? (bool)$_GET['is_active'] : null,
            'discount_type' => $_GET['discount_type'] ?? '',
            'search' => $_GET['search'] ?? ''
        ];

        $result = $this->promoModel->getAll($page, $perPage, $filters);

        $data = [
            'title' => 'Promo Codes',
            'promo_codes' => $result['promo_codes'],
            'pagination' => [
                'current_page' => $result['page'],
                'total_pages' => $result['total_pages'],
                'total' => $result['total'],
                'per_page' => $result['per_page']
            ],
            'filters' => $filters
        ];

        $this->view('admin/promo-codes', $data);
    }

    /**
     * Show create promo code form
     */
    public function create() {
        $data = [
            'title' => 'Create Promo Code'
        ];

        $this->view('admin/promo-code-create', $data);
    }

    /**
     * Store new promo code
     */
    public function store() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            redirect('/admin/promo-codes');
        }

        // Validate CSRF token
        if (!validateCSRFToken($_POST['csrf_token'] ?? '')) {
            Session::setFlash('error', 'Invalid request');
            redirect('/admin/promo-codes/create');
        }

        // Validate required fields
        $code = trim(strtoupper($_POST['code'] ?? ''));
        $discountType = $_POST['discount_type'] ?? '';
        $discountValue = floatval($_POST['discount_value'] ?? 0);

        if (empty($code)) {
            Session::setFlash('error', 'Promo code is required');
            redirect('/admin/promo-codes/create');
        }

        if (!in_array($discountType, ['percentage', 'fixed_amount', 'free_shipping'])) {
            Session::setFlash('error', 'Invalid discount type');
            redirect('/admin/promo-codes/create');
        }

        if ($discountValue <= 0) {
            Session::setFlash('error', 'Discount value must be greater than 0');
            redirect('/admin/promo-codes/create');
        }

        // Check if code already exists
        $existing = $this->promoModel->findByCode($code);
        if ($existing) {
            Session::setFlash('error', 'Promo code already exists');
            redirect('/admin/promo-codes/create');
        }

        // Create promo code
        $promoData = [
            'code' => $code,
            'description' => trim($_POST['description'] ?? ''),
            'discount_type' => $discountType,
            'discount_value' => $discountValue,
            'max_discount' => floatval($_POST['max_discount'] ?? 0),
            'min_purchase' => floatval($_POST['min_purchase'] ?? 0),
            'usage_limit' => !empty($_POST['usage_limit']) ? intval($_POST['usage_limit']) : null,
            'usage_per_client' => intval($_POST['usage_per_client'] ?? 1),
            'valid_from' => $_POST['valid_from'] ?? date('Y-m-d'),
            'valid_until' => !empty($_POST['valid_until']) ? $_POST['valid_until'] : null,
            'is_active' => isset($_POST['is_active']) ? true : false
        ];

        $promoId = $this->promoModel->create($promoData);

        if ($promoId) {
            Session::setFlash('success', 'Promo code created successfully');
            redirect('/admin/promo-codes');
        } else {
            Session::setFlash('error', 'Failed to create promo code');
            redirect('/admin/promo-codes/create');
        }
    }

    /**
     * Show edit promo code form
     *
     * @param int $id
     */
    public function edit($id) {
        $promo = $this->promoModel->findById($id);

        if (!$promo) {
            Session::setFlash('error', 'Promo code not found');
            redirect('/admin/promo-codes');
        }

        $data = [
            'title' => 'Edit Promo Code',
            'promo' => $promo
        ];

        $this->view('admin/promo-code-edit', $data);
    }

    /**
     * Update promo code
     */
    public function update() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            redirect('/admin/promo-codes');
        }

        // Validate CSRF token
        if (!validateCSRFToken($_POST['csrf_token'] ?? '')) {
            Session::setFlash('error', 'Invalid request');
            redirect('/admin/promo-codes');
        }

        $id = intval($_POST['promo_id'] ?? 0);

        // Validate required fields
        $code = trim(strtoupper($_POST['code'] ?? ''));
        $discountType = $_POST['discount_type'] ?? '';
        $discountValue = floatval($_POST['discount_value'] ?? 0);

        if (empty($code)) {
            Session::setFlash('error', 'Promo code is required');
            redirect('/admin/promo-codes/edit/' . $id);
        }

        if (!in_array($discountType, ['percentage', 'fixed_amount', 'free_shipping'])) {
            Session::setFlash('error', 'Invalid discount type');
            redirect('/admin/promo-codes/edit/' . $id);
        }

        if ($discountValue <= 0) {
            Session::setFlash('error', 'Discount value must be greater than 0');
            redirect('/admin/promo-codes/edit/' . $id);
        }

        // Check if code exists for another promo
        $existing = $this->promoModel->findByCode($code);
        if ($existing && $existing['id'] != $id) {
            Session::setFlash('error', 'Promo code already exists');
            redirect('/admin/promo-codes/edit/' . $id);
        }

        // Update promo code
        $promoData = [
            'code' => $code,
            'description' => trim($_POST['description'] ?? ''),
            'discount_type' => $discountType,
            'discount_value' => $discountValue,
            'max_discount' => floatval($_POST['max_discount'] ?? 0),
            'min_purchase' => floatval($_POST['min_purchase'] ?? 0),
            'usage_limit' => !empty($_POST['usage_limit']) ? intval($_POST['usage_limit']) : null,
            'usage_per_client' => intval($_POST['usage_per_client'] ?? 1),
            'valid_from' => $_POST['valid_from'] ?? date('Y-m-d'),
            'valid_until' => !empty($_POST['valid_until']) ? $_POST['valid_until'] : null,
            'is_active' => isset($_POST['is_active']) ? true : false
        ];

        $success = $this->promoModel->update($id, $promoData);

        if ($success) {
            Session::setFlash('success', 'Promo code updated successfully');
            redirect('/admin/promo-codes');
        } else {
            Session::setFlash('error', 'Failed to update promo code');
            redirect('/admin/promo-codes/edit/' . $id);
        }
    }

    /**
     * Deactivate promo code
     */
    public function deactivate() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            redirect('/admin/promo-codes');
        }

        // Validate CSRF token
        if (!validateCSRFToken($_POST['csrf_token'] ?? '')) {
            Session::setFlash('error', 'Invalid request');
            redirect('/admin/promo-codes');
        }

        $id = intval($_POST['promo_id'] ?? 0);

        $success = $this->promoModel->deactivate($id);

        if ($success) {
            Session::setFlash('success', 'Promo code deactivated');
        } else {
            Session::setFlash('error', 'Failed to deactivate promo code');
        }

        redirect('/admin/promo-codes');
    }

    /**
     * View promo code usage history
     *
     * @param int $id
     */
    public function usage($id) {
        $promo = $this->promoModel->findById($id);

        if (!$promo) {
            Session::setFlash('error', 'Promo code not found');
            redirect('/admin/promo-codes');
        }

        $page = $_GET['page'] ?? 1;
        $perPage = 20;

        $result = $this->promoModel->getUsageHistory($id, $page, $perPage);

        $data = [
            'title' => 'Promo Code Usage - ' . $promo['code'],
            'promo' => $promo,
            'usage' => $result['usage'],
            'pagination' => [
                'current_page' => $result['page'],
                'total_pages' => $result['total_pages'],
                'total' => $result['total'],
                'per_page' => $result['per_page']
            ]
        ];

        $this->view('admin/promo-code-usage', $data);
    }

    /**
     * Generate random promo code
     */
    public function generateCode() {
        header('Content-Type: application/json');

        $length = intval($_GET['length'] ?? 8);
        $code = $this->promoModel->generateRandomCode($length);

        echo json_encode(['success' => true, 'code' => $code]);
        exit;
    }

    /**
     * Promo code statistics
     */
    public function statistics() {
        $stats = $this->promoModel->getStatistics();

        $data = [
            'title' => 'Promo Code Statistics',
            'stats' => $stats
        ];

        $this->view('admin/promo-code-stats', $data);
    }
}
