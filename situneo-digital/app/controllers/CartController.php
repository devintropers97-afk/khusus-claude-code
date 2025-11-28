<?php
/**
 * Cart Controller
 * Mengelola shopping cart UI dan checkout process
 */

class CartController extends Controller {
    private $cartModel;
    private $serviceModel;
    private $promoModel;

    public function __construct() {
        parent::__construct();

        $this->cartModel = new Cart();
        $this->serviceModel = new Service();
        $this->promoModel = new PromoCode();
    }

    /**
     * Display shopping cart page
     */
    public function index() {
        $items = $this->cartModel->getItems();
        $cartTotal = $this->cartModel->getTotal();
        $appliedPromo = $this->cartModel->getAppliedPromo();

        $data = [
            'title' => 'Shopping Cart',
            'items' => $items,
            'cart_total' => $cartTotal,
            'applied_promo' => $appliedPromo
        ];

        $this->view('services/cart', $data);
    }

    /**
     * Update cart (form submission)
     */
    public function update() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            redirect('/cart');
        }

        // Validate CSRF token
        if (!validateCSRFToken($_POST['csrf_token'] ?? '')) {
            Session::setFlash('error', 'Invalid request');
            redirect('/cart');
        }

        $updates = $_POST['quantity'] ?? [];

        foreach ($updates as $itemId => $quantity) {
            $quantity = intval($quantity);

            if ($quantity <= 0) {
                $this->cartModel->remove($itemId);
            } else {
                $this->cartModel->updateQuantity($itemId, $quantity);
            }
        }

        Session::setFlash('success', 'Cart updated successfully');
        redirect('/cart');
    }

    /**
     * Apply promo code (form submission)
     */
    public function applyPromo() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            redirect('/cart');
        }

        // Validate CSRF token
        if (!validateCSRFToken($_POST['csrf_token'] ?? '')) {
            Session::setFlash('error', 'Invalid request');
            redirect('/cart');
        }

        $promoCode = trim(strtoupper($_POST['promo_code'] ?? ''));

        if (empty($promoCode)) {
            Session::setFlash('error', 'Please enter a promo code');
            redirect('/cart');
        }

        // Get client ID if logged in
        $clientId = Session::isLoggedIn() ? Session::get('user_id') : null;

        // Validate promo code
        $promo = $this->promoModel->validateCode($promoCode, $clientId);

        if (!$promo) {
            Session::setFlash('error', 'Invalid or expired promo code');
            redirect('/cart');
        }

        // Get cart total
        $cartTotal = $this->cartModel->getTotal();

        // Check minimum purchase
        if ($promo['min_purchase'] > 0 && $cartTotal['subtotal'] < $promo['min_purchase']) {
            Session::setFlash('error', 'Minimum purchase of Rp ' . number_format($promo['min_purchase'], 0, ',', '.') . ' required');
            redirect('/cart');
        }

        // Apply promo
        $applied = $this->cartModel->applyPromoCode($promoCode);

        if ($applied) {
            Session::setFlash('success', 'Promo code applied successfully');
        } else {
            Session::setFlash('error', 'Failed to apply promo code');
        }

        redirect('/cart');
    }

    /**
     * Remove promo code
     */
    public function removePromo() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            redirect('/cart');
        }

        // Validate CSRF token
        if (!validateCSRFToken($_POST['csrf_token'] ?? '')) {
            Session::setFlash('error', 'Invalid request');
            redirect('/cart');
        }

        $this->cartModel->removePromoCode();
        Session::setFlash('success', 'Promo code removed');
        redirect('/cart');
    }

    /**
     * Clear cart
     */
    public function clear() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            redirect('/cart');
        }

        // Validate CSRF token
        if (!validateCSRFToken($_POST['csrf_token'] ?? '')) {
            Session::setFlash('error', 'Invalid request');
            redirect('/cart');
        }

        $this->cartModel->clear();
        Session::setFlash('success', 'Cart cleared');
        redirect('/cart');
    }

    /**
     * Proceed to checkout
     */
    public function checkout() {
        // Check if cart is empty
        if ($this->cartModel->isEmpty()) {
            Session::setFlash('error', 'Your cart is empty');
            redirect('/services');
        }

        // Check if user is logged in
        if (!Session::isLoggedIn()) {
            Session::set('redirect_after_login', '/cart/checkout');
            Session::setFlash('info', 'Please login to continue checkout');
            redirect('/auth/login');
        }

        // Get cart data
        $items = $this->cartModel->getItems();
        $cartTotal = $this->cartModel->getTotal();
        $appliedPromo = $this->cartModel->getAppliedPromo();

        // Get client profile
        $clientModel = new Client();
        $client = $clientModel->findById(Session::get('user_id'));

        $data = [
            'title' => 'Checkout',
            'items' => $items,
            'cart_total' => $cartTotal,
            'applied_promo' => $appliedPromo,
            'client' => $client
        ];

        $this->view('orders/checkout', $data);
    }

    /**
     * Process checkout and create order
     */
    public function processCheckout() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            redirect('/cart/checkout');
        }

        // Validate CSRF token
        if (!validateCSRFToken($_POST['csrf_token'] ?? '')) {
            Session::setFlash('error', 'Invalid request');
            redirect('/cart/checkout');
        }

        // Check if cart is empty
        if ($this->cartModel->isEmpty()) {
            Session::setFlash('error', 'Your cart is empty');
            redirect('/services');
        }

        // Check if user is logged in
        if (!Session::isLoggedIn()) {
            redirect('/auth/login');
        }

        $clientId = Session::get('user_id');

        try {
            // Get cart items and total
            $items = $this->cartModel->getItems();
            $cartTotal = $this->cartModel->getTotal();
            $appliedPromo = $this->cartModel->getAppliedPromo();

            // Calculate final amounts
            $subtotal = $cartTotal['subtotal'];
            $setupFees = $cartTotal['setup_fees'];
            $discount = $appliedPromo ? $appliedPromo['discount_amount'] : 0;
            $total = $subtotal + $setupFees - $discount;

            // Create order
            $orderModel = new Order();
            $orderData = [
                'client_id' => $clientId,
                'subtotal' => $subtotal,
                'setup_fees' => $setupFees,
                'discount_amount' => $discount,
                'total_amount' => $total,
                'notes' => $_POST['notes'] ?? null,
                'billing_address' => $_POST['billing_address'] ?? null,
                'billing_city' => $_POST['billing_city'] ?? null,
                'billing_province' => $_POST['billing_province'] ?? null,
                'billing_postal_code' => $_POST['billing_postal_code'] ?? null
            ];

            $orderId = $orderModel->create($orderData, $items);

            if (!$orderId) {
                throw new Exception('Failed to create order');
            }

            // Record promo code usage if applied
            if ($appliedPromo) {
                $this->promoModel->recordUsage(
                    $appliedPromo['promo_id'],
                    $clientId,
                    $orderId,
                    $discount
                );
            }

            // Clear cart
            $this->cartModel->clear();

            // Redirect to order confirmation
            Session::setFlash('success', 'Order placed successfully!');
            redirect('/orders/confirmation/' . $orderId);

        } catch (Exception $e) {
            logError('Checkout failed: ' . $e->getMessage());
            Session::setFlash('error', 'Failed to process order. Please try again.');
            redirect('/cart/checkout');
        }
    }
}
