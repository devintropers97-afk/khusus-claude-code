<?php
/**
 * Payment Controller
 * Mengelola payment management untuk clients dan admin
 *
 * Handles payment viewing, verification, and refund processing
 */

class PaymentController extends Controller {
    private $paymentModel;
    private $invoiceModel;
    private $orderModel;

    public function __construct() {
        parent::__construct();

        // Check if user is logged in
        if (!Session::isLoggedIn()) {
            redirect('/auth/login');
        }

        $this->paymentModel = new Payment();
        $this->invoiceModel = new Invoice();
        $this->orderModel = new Order();
    }

    /**
     * List all payments for current client
     */
    public function index() {
        $userId = Session::get('user_id');
        $roleId = Session::get('role_id');

        // Get pagination and filters
        $page = $_GET['page'] ?? 1;
        $perPage = 20;
        $filters = [
            'status' => $_GET['status'] ?? '',
            'payment_method' => $_GET['payment_method'] ?? '',
            'search' => $_GET['search'] ?? ''
        ];

        // Admin/Manager can see all payments
        if (in_array($roleId, [1, 2])) {
            $result = $this->paymentModel->getAll($page, $perPage, $filters);
        } else {
            // Client can only see their own payments
            $result = $this->paymentModel->getByClient($userId, $page, $perPage, $filters);
        }

        $data = [
            'title' => 'My Payments',
            'payments' => $result['payments'],
            'pagination' => [
                'current_page' => $result['page'],
                'total_pages' => $result['total_pages'],
                'total' => $result['total'],
                'per_page' => $result['per_page']
            ],
            'filters' => $filters
        ];

        $this->view('client/payments', $data);
    }

    /**
     * View payment detail
     *
     * @param int $id Payment ID
     */
    public function view($id) {
        $payment = $this->paymentModel->findById($id);

        if (!$payment) {
            Session::setFlash('error', 'Payment not found');
            redirect('/client/payments');
        }

        // Check authorization
        $userId = Session::get('user_id');
        $roleId = Session::get('role_id');

        if ($roleId == 5 && $payment['client_id'] != $userId) {
            Session::setFlash('error', 'Unauthorized access');
            redirect('/client/payments');
        }

        $data = [
            'title' => 'Payment ' . $payment['payment_reference'],
            'payment' => $payment
        ];

        $this->view('client/payment-detail', $data);
    }

    /**
     * Admin: List pending payments for verification
     */
    public function pending() {
        // Check admin/manager authorization
        $roleId = Session::get('role_id');
        if (!in_array($roleId, [1, 2])) {
            Session::setFlash('error', 'Unauthorized access');
            redirect('/dashboard');
        }

        $page = $_GET['page'] ?? 1;
        $perPage = 20;

        $result = $this->paymentModel->getPendingPayments($page, $perPage);

        $data = [
            'title' => 'Pending Payments',
            'payments' => $result['payments'],
            'pagination' => [
                'current_page' => $result['page'],
                'total_pages' => $result['total_pages'],
                'total' => $result['total'],
                'per_page' => $result['per_page']
            ]
        ];

        $this->view('admin/payments-pending', $data);
    }

    /**
     * Admin: Verify payment
     */
    public function verify() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            redirect('/admin/payments/pending');
        }

        // Check admin/manager authorization
        $roleId = Session::get('role_id');
        if (!in_array($roleId, [1, 2])) {
            Session::setFlash('error', 'Unauthorized access');
            redirect('/dashboard');
        }

        // Validate CSRF token
        if (!validateCSRFToken($_POST['csrf_token'] ?? '')) {
            Session::setFlash('error', 'Invalid request');
            redirect('/admin/payments/pending');
        }

        $paymentId = $_POST['payment_id'] ?? 0;
        $userId = Session::get('user_id');

        $data = [
            'transaction_id' => $_POST['transaction_id'] ?? null,
            'notes' => $_POST['notes'] ?? null
        ];

        $success = $this->paymentModel->verify($paymentId, $userId, $data);

        if ($success) {
            Session::setFlash('success', 'Payment verified successfully');
        } else {
            Session::setFlash('error', 'Failed to verify payment');
        }

        redirect('/admin/payments/pending');
    }

    /**
     * Admin: Reject payment
     */
    public function reject() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            redirect('/admin/payments/pending');
        }

        // Check admin/manager authorization
        $roleId = Session::get('role_id');
        if (!in_array($roleId, [1, 2])) {
            Session::setFlash('error', 'Unauthorized access');
            redirect('/dashboard');
        }

        // Validate CSRF token
        if (!validateCSRFToken($_POST['csrf_token'] ?? '')) {
            Session::setFlash('error', 'Invalid request');
            redirect('/admin/payments/pending');
        }

        $paymentId = $_POST['payment_id'] ?? 0;
        $reason = $_POST['reason'] ?? '';
        $userId = Session::get('user_id');

        if (empty($reason)) {
            Session::setFlash('error', 'Rejection reason is required');
            redirect('/admin/payments/pending');
        }

        $success = $this->paymentModel->reject($paymentId, $userId, $reason);

        if ($success) {
            Session::setFlash('success', 'Payment rejected');
        } else {
            Session::setFlash('error', 'Failed to reject payment');
        }

        redirect('/admin/payments/pending');
    }

    /**
     * Admin: Show refund form
     *
     * @param int $id Payment ID
     */
    public function refund($id) {
        // Check admin/manager authorization
        $roleId = Session::get('role_id');
        if (!in_array($roleId, [1, 2])) {
            Session::setFlash('error', 'Unauthorized access');
            redirect('/dashboard');
        }

        $payment = $this->paymentModel->findById($id);

        if (!$payment) {
            Session::setFlash('error', 'Payment not found');
            redirect('/admin/payments');
        }

        if ($payment['status'] !== 'verified') {
            Session::setFlash('error', 'Only verified payments can be refunded');
            redirect('/admin/payments/view/' . $id);
        }

        $data = [
            'title' => 'Refund Payment',
            'payment' => $payment
        ];

        $this->view('admin/payment-refund', $data);
    }

    /**
     * Admin: Process refund
     */
    public function processRefund() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            redirect('/admin/payments');
        }

        // Check admin/manager authorization
        $roleId = Session::get('role_id');
        if (!in_array($roleId, [1, 2])) {
            Session::setFlash('error', 'Unauthorized access');
            redirect('/dashboard');
        }

        // Validate CSRF token
        if (!validateCSRFToken($_POST['csrf_token'] ?? '')) {
            Session::setFlash('error', 'Invalid request');
            redirect('/admin/payments');
        }

        $paymentId = $_POST['payment_id'] ?? 0;
        $refundAmount = floatval($_POST['refund_amount'] ?? 0);
        $reason = $_POST['reason'] ?? '';
        $userId = Session::get('user_id');

        if ($refundAmount <= 0) {
            Session::setFlash('error', 'Invalid refund amount');
            redirect('/admin/payments/refund/' . $paymentId);
        }

        if (empty($reason)) {
            Session::setFlash('error', 'Refund reason is required');
            redirect('/admin/payments/refund/' . $paymentId);
        }

        $success = $this->paymentModel->refund($paymentId, $refundAmount, $userId, $reason);

        if ($success) {
            Session::setFlash('success', 'Payment refunded successfully');
            redirect('/admin/payments/view/' . $paymentId);
        } else {
            Session::setFlash('error', 'Failed to process refund');
            redirect('/admin/payments/refund/' . $paymentId);
        }
    }

    /**
     * View payment proof image
     *
     * @param int $id Payment ID
     */
    public function viewProof($id) {
        $payment = $this->paymentModel->findById($id);

        if (!$payment) {
            Session::setFlash('error', 'Payment not found');
            redirect('/client/payments');
        }

        // Check authorization
        $userId = Session::get('user_id');
        $roleId = Session::get('role_id');

        if ($roleId == 5 && $payment['client_id'] != $userId) {
            Session::setFlash('error', 'Unauthorized access');
            redirect('/client/payments');
        }

        if (empty($payment['payment_proof'])) {
            Session::setFlash('error', 'No payment proof available');
            redirect('/client/payments/view/' . $id);
        }

        // Display image
        $proofPath = ROOT_PATH . '/public/uploads/payments/' . $payment['payment_proof'];

        if (!file_exists($proofPath)) {
            Session::setFlash('error', 'Payment proof file not found');
            redirect('/client/payments/view/' . $id);
        }

        $imageInfo = getimagesize($proofPath);
        header('Content-Type: ' . $imageInfo['mime']);
        readfile($proofPath);
        exit;
    }

    /**
     * Download payment proof
     *
     * @param int $id Payment ID
     */
    public function downloadProof($id) {
        $payment = $this->paymentModel->findById($id);

        if (!$payment) {
            Session::setFlash('error', 'Payment not found');
            redirect('/client/payments');
        }

        // Check authorization
        $userId = Session::get('user_id');
        $roleId = Session::get('role_id');

        if ($roleId == 5 && $payment['client_id'] != $userId) {
            Session::setFlash('error', 'Unauthorized access');
            redirect('/client/payments');
        }

        if (empty($payment['payment_proof'])) {
            Session::setFlash('error', 'No payment proof available');
            redirect('/client/payments/view/' . $id);
        }

        $proofPath = ROOT_PATH . '/public/uploads/payments/' . $payment['payment_proof'];

        if (!file_exists($proofPath)) {
            Session::setFlash('error', 'Payment proof file not found');
            redirect('/client/payments/view/' . $id);
        }

        // Force download
        header('Content-Type: application/octet-stream');
        header('Content-Disposition: attachment; filename="' . basename($payment['payment_proof']) . '"');
        header('Content-Length: ' . filesize($proofPath));
        readfile($proofPath);
        exit;
    }

    /**
     * Admin: Payment statistics dashboard
     */
    public function statistics() {
        // Check admin/manager authorization
        $roleId = Session::get('role_id');
        if (!in_array($roleId, [1, 2])) {
            Session::setFlash('error', 'Unauthorized access');
            redirect('/dashboard');
        }

        $stats = $this->paymentModel->getStatistics();
        $methodsSummary = $this->paymentModel->getPaymentMethodsSummary();

        $data = [
            'title' => 'Payment Statistics',
            'stats' => $stats,
            'methods' => $methodsSummary
        ];

        $this->view('admin/payment-statistics', $data);
    }
}
