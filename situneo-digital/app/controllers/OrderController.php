<?php
/**
 * Order Controller
 * Handles order creation, checkout, and payment processing
 */

class OrderController
{
    private $orderModel;
    private $serviceModel;
    private $clientModel;
    private $db;

    public function __construct()
    {
        $this->db = Database::getInstance()->getConnection();
        $this->orderModel = new Order();
        $this->serviceModel = new Service();
        $this->clientModel = new Client();
    }

    /**
     * Display checkout page
     */
    public function checkout()
    {
        // Require login
        Session::requireLogin();

        // Get cart from session
        $cartItems = $_SESSION['cart'] ?? [];

        // Check if cart is empty
        if (empty($cartItems)) {
            Session::setFlash('error', 'Your cart is empty');
            redirect(url('services.php'));
        }

        // Calculate totals
        $subtotal = 0;
        $setupFees = 0;
        foreach ($cartItems as $item) {
            $subtotal += $item['total'];
            $setupFees += $item['setup_fee'];
        }

        $total = $subtotal;

        // Get user data
        $userId = Session::getUserId();
        $user = $this->db->query("SELECT * FROM users WHERE id = ?", [$userId])->fetch();
        $profile = $this->db->query("SELECT * FROM user_profiles WHERE user_id = ?", [$userId])->fetch();

        // Get client profile if exists
        $client = null;
        if (Session::getRole() === 5) {
            $client = $this->clientModel->findByUserId($userId);
        }

        // Pass data to view
        require_once APP_PATH . '/views/orders/checkout.php';
    }

    /**
     * Process checkout
     */
    public function processCheckout()
    {
        // Only allow POST requests
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            redirect(url('checkout.php'));
        }

        // Require login
        Session::requireLogin();

        // Verify CSRF token
        if (!CSRF::validate($_POST['csrf_token'] ?? '')) {
            Session::setFlash('error', 'Invalid request');
            redirect(url('checkout.php'));
        }

        // Get cart from session
        $cartItems = $_SESSION['cart'] ?? [];

        // Check if cart is empty
        if (empty($cartItems)) {
            Session::setFlash('error', 'Your cart is empty');
            redirect(url('services.php'));
        }

        // Get POST data
        $orderType = $_POST['order_type'] ?? 'layanan';
        $notes = trim($_POST['notes'] ?? '');
        $paymentMethod = $_POST['payment_method'] ?? 'transfer';
        $partnerId = !empty($_POST['partner_id']) ? (int)$_POST['partner_id'] : null;

        // Validate payment method
        $validPaymentMethods = ['transfer', 'ewallet', 'credit_card'];
        if (!in_array($paymentMethod, $validPaymentMethods)) {
            Session::setFlash('error', 'Invalid payment method');
            redirect(url('checkout.php'));
        }

        // Get user ID
        $userId = Session::getUserId();

        // Check if user is a client
        $client = null;
        if (Session::getRole() === 5) {
            $client = $this->clientModel->findByUserId($userId);
        }

        // If not a client, create client profile first
        if (!$client) {
            // Get user data
            $user = $this->db->query("SELECT * FROM users WHERE id = ?", [$userId])->fetch();

            $clientData = [
                'user_id' => $userId,
                'email' => $user['email'],
                'partner_id' => $partnerId,
                'source' => 'order'
            ];

            $clientId = $this->clientModel->create($clientData);

            if (!$clientId) {
                Session::setFlash('error', 'Failed to create client profile');
                redirect(url('checkout.php'));
            }

            // Reload client data
            $client = $this->clientModel->findById($clientId);

            // Update user role to client (5)
            $this->db->query("UPDATE users SET role_id = 5 WHERE id = ?", [$userId]);
            $_SESSION['user_role'] = 5;
        }

        // Calculate total
        $totalAmount = 0;
        foreach ($cartItems as $item) {
            $totalAmount += $item['total'];
        }

        // Prepare order data
        $orderData = [
            'client_id' => $client['id'],
            'partner_id' => $partnerId,
            'order_type' => $orderType,
            'total_amount' => $totalAmount,
            'payment_method' => $paymentMethod,
            'notes' => $notes,
            'items' => []
        ];

        // Add cart items to order
        foreach ($cartItems as $item) {
            $orderData['items'][] = [
                'service_id' => $item['service_id'],
                'quantity' => 1,
                'unit_price' => $item['base_price'],
                'monthly_price' => $item['monthly_price'],
                'setup_fee' => $item['setup_fee'],
                'contract_months' => $item['months'],
                'purchase_type' => $item['type'],
                'subtotal' => $item['total']
            ];
        }

        // Create order
        try {
            $orderId = $this->orderModel->create($orderData);

            if (!$orderId) {
                Session::setFlash('error', 'Failed to create order. Please try again.');
                redirect(url('checkout.php'));
            }

            // Clear cart
            $_SESSION['cart'] = [];

            // Log activity
            logError("Order created successfully: $orderId by user $userId");

            // Redirect to order confirmation
            Session::setFlash('success', 'Order created successfully! Please complete the payment.');
            redirect(url('order-confirmation.php?id=' . $orderId));

        } catch (Exception $e) {
            logError('Order creation failed: ' . $e->getMessage());
            Session::setFlash('error', 'Failed to create order. Please try again.');
            redirect(url('checkout.php'));
        }
    }

    /**
     * Display order confirmation page
     */
    public function confirmation()
    {
        // Require login
        Session::requireLogin();

        // Get order ID from URL
        $orderId = isset($_GET['id']) ? (int)$_GET['id'] : 0;

        if (!$orderId) {
            Session::setFlash('error', 'Order not found');
            redirect(url('client/orders.php'));
        }

        // Get order details
        $order = $this->orderModel->findById($orderId);

        if (!$order) {
            Session::setFlash('error', 'Order not found');
            redirect(url('client/orders.php'));
        }

        // Check if user owns this order
        $userId = Session::getUserId();
        $client = $this->clientModel->findByUserId($userId);

        if (!$client || $order['client_id'] != $client['id']) {
            Session::setFlash('error', 'Unauthorized access');
            redirect(url('client/orders.php'));
        }

        // Get order items
        $orderItems = $this->orderModel->getOrderItems($orderId);

        // Get payment info
        $paymentInfo = $this->getPaymentInfo($order['payment_method']);

        // Pass data to view
        require_once APP_PATH . '/views/orders/confirmation.php';
    }

    /**
     * Upload payment proof
     */
    public function uploadPaymentProof()
    {
        // Only allow POST requests
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            redirect(url('client/orders.php'));
        }

        // Require login
        Session::requireLogin();

        // Verify CSRF token
        if (!CSRF::validate($_POST['csrf_token'] ?? '')) {
            Session::setFlash('error', 'Invalid request');
            redirect(url('client/orders.php'));
        }

        // Get order ID
        $orderId = isset($_POST['order_id']) ? (int)$_POST['order_id'] : 0;

        if (!$orderId) {
            Session::setFlash('error', 'Order not found');
            redirect(url('client/orders.php'));
        }

        // Get order details
        $order = $this->orderModel->findById($orderId);

        if (!$order) {
            Session::setFlash('error', 'Order not found');
            redirect(url('client/orders.php'));
        }

        // Check if user owns this order
        $userId = Session::getUserId();
        $client = $this->clientModel->findByUserId($userId);

        if (!$client || $order['client_id'] != $client['id']) {
            Session::setFlash('error', 'Unauthorized access');
            redirect(url('client/orders.php'));
        }

        // Check if order is still pending payment
        if ($order['payment_status'] !== 'unpaid') {
            Session::setFlash('error', 'Payment proof already submitted or order is already paid');
            redirect(url('order-confirmation.php?id=' . $orderId));
        }

        // Validate file upload
        if (!isset($_FILES['payment_proof']) || $_FILES['payment_proof']['error'] !== UPLOAD_ERR_OK) {
            Session::setFlash('error', 'Please select a valid file');
            redirect(url('order-confirmation.php?id=' . $orderId));
        }

        $file = $_FILES['payment_proof'];

        // Validate file type
        $allowedTypes = ['image/jpeg', 'image/png', 'image/jpg', 'application/pdf'];
        if (!in_array($file['type'], $allowedTypes)) {
            Session::setFlash('error', 'Invalid file type. Only JPG, PNG, and PDF are allowed.');
            redirect(url('order-confirmation.php?id=' . $orderId));
        }

        // Validate file size (max 2MB)
        if ($file['size'] > 2 * 1024 * 1024) {
            Session::setFlash('error', 'File size too large. Maximum 2MB allowed.');
            redirect(url('order-confirmation.php?id=' . $orderId));
        }

        // Upload file
        $uploadDir = BASE_PATH . '/uploads/payment_proofs/';
        if (!file_exists($uploadDir)) {
            mkdir($uploadDir, 0755, true);
        }

        $fileExtension = pathinfo($file['name'], PATHINFO_EXTENSION);
        $fileName = 'payment_' . $orderId . '_' . time() . '.' . $fileExtension;
        $uploadPath = $uploadDir . $fileName;

        if (!move_uploaded_file($file['tmp_name'], $uploadPath)) {
            Session::setFlash('error', 'Failed to upload file');
            redirect(url('order-confirmation.php?id=' . $orderId));
        }

        // Update order with payment proof
        $paymentAmount = isset($_POST['payment_amount']) ? (float)$_POST['payment_amount'] : $order['total_amount'];
        $paymentDate = $_POST['payment_date'] ?? date('Y-m-d');
        $paymentNotes = trim($_POST['payment_notes'] ?? '');

        $updateResult = $this->orderModel->addPaymentProof($orderId, [
            'payment_proof' => $fileName,
            'payment_amount' => $paymentAmount,
            'payment_date' => $paymentDate,
            'payment_notes' => $paymentNotes
        ]);

        if ($updateResult) {
            Session::setFlash('success', 'Payment proof uploaded successfully. We will verify your payment soon.');
        } else {
            Session::setFlash('error', 'Failed to update payment proof');
        }

        redirect(url('order-confirmation.php?id=' . $orderId));
    }

    /**
     * Get payment info based on payment method
     */
    private function getPaymentInfo($method)
    {
        $paymentInfo = [
            'transfer' => [
                'name' => 'Bank Transfer',
                'description' => 'Transfer to our bank account',
                'accounts' => [
                    [
                        'bank' => 'Bank BCA',
                        'account_number' => '1234567890',
                        'account_name' => 'PT Situneo Digital'
                    ],
                    [
                        'bank' => 'Bank Mandiri',
                        'account_number' => '0987654321',
                        'account_name' => 'PT Situneo Digital'
                    ]
                ],
                'instructions' => [
                    'Transfer exact amount to one of the accounts above',
                    'Upload payment proof after transfer',
                    'Payment will be verified within 1x24 hours'
                ]
            ],
            'ewallet' => [
                'name' => 'E-Wallet',
                'description' => 'Pay via GoPay, OVO, or DANA',
                'accounts' => [
                    [
                        'bank' => 'GoPay',
                        'account_number' => '081234567890',
                        'account_name' => 'PT Situneo Digital'
                    ],
                    [
                        'bank' => 'OVO',
                        'account_number' => '081234567890',
                        'account_name' => 'PT Situneo Digital'
                    ]
                ],
                'instructions' => [
                    'Send payment to one of the e-wallet numbers above',
                    'Upload payment proof/screenshot after sending',
                    'Payment will be verified within 1x24 hours'
                ]
            ],
            'credit_card' => [
                'name' => 'Credit Card',
                'description' => 'Pay with credit card (coming soon)',
                'accounts' => [],
                'instructions' => [
                    'Credit card payment integration coming soon',
                    'Please use bank transfer or e-wallet for now'
                ]
            ]
        ];

        return $paymentInfo[$method] ?? $paymentInfo['transfer'];
    }

    /**
     * Cancel order (by client)
     */
    public function cancel()
    {
        // Only allow POST requests
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            redirect(url('client/orders.php'));
        }

        // Require login
        Session::requireLogin();

        // Verify CSRF token
        if (!CSRF::validate($_POST['csrf_token'] ?? '')) {
            Session::setFlash('error', 'Invalid request');
            redirect(url('client/orders.php'));
        }

        // Get order ID
        $orderId = isset($_POST['order_id']) ? (int)$_POST['order_id'] : 0;

        if (!$orderId) {
            Session::setFlash('error', 'Order not found');
            redirect(url('client/orders.php'));
        }

        // Get order details
        $order = $this->orderModel->findById($orderId);

        if (!$order) {
            Session::setFlash('error', 'Order not found');
            redirect(url('client/orders.php'));
        }

        // Check if user owns this order
        $userId = Session::getUserId();
        $client = $this->clientModel->findByUserId($userId);

        if (!$client || $order['client_id'] != $client['id']) {
            Session::setFlash('error', 'Unauthorized access');
            redirect(url('client/orders.php'));
        }

        // Check if order can be cancelled
        if (!in_array($order['status'], ['pending', 'confirmed'])) {
            Session::setFlash('error', 'Order cannot be cancelled at this stage');
            redirect(url('client/order-detail.php?id=' . $orderId));
        }

        // Cancel order
        $cancelReason = trim($_POST['cancel_reason'] ?? 'Cancelled by client');
        $cancelled = $this->orderModel->updateStatus($orderId, 'cancelled', $cancelReason, $userId);

        if ($cancelled) {
            Session::setFlash('success', 'Order cancelled successfully');
        } else {
            Session::setFlash('error', 'Failed to cancel order');
        }

        redirect(url('client/order-detail.php?id=' . $orderId));
    }
}
