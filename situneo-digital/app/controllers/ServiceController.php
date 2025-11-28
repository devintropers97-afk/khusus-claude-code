<?php
/**
 * Service Controller
 * Handles service catalog browsing, search, and details
 */

class ServiceController
{
    private $serviceModel;
    private $db;

    public function __construct()
    {
        $this->db = Database::getInstance()->getConnection();
        $this->serviceModel = new Service();
    }

    /**
     * Display service catalog
     */
    public function catalog()
    {
        // Get filters from query string
        $category = $_GET['category'] ?? '';
        $search = $_GET['search'] ?? '';
        $sort = $_GET['sort'] ?? 'newest';
        $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
        $perPage = 12;

        // Build filter array
        $filters = [];
        if ($category) {
            $filters['category_slug'] = $category;
        }
        if ($search) {
            $filters['search'] = $search;
        }

        // Get sort order
        switch ($sort) {
            case 'price_low':
                $filters['order_by'] = 'base_price ASC';
                break;
            case 'price_high':
                $filters['order_by'] = 'base_price DESC';
                break;
            case 'popular':
                $filters['order_by'] = 'views DESC';
                break;
            default:
                $filters['order_by'] = 'created_at DESC';
        }

        // Get services with pagination
        $services = $this->serviceModel->getAll($filters, $page, $perPage);
        $totalServices = $this->serviceModel->count($filters);

        // Get all categories for filter
        $categories = $this->serviceModel->getCategories();

        // Get featured services (only on first page)
        $featuredServices = [];
        if ($page === 1) {
            $featuredServices = $this->serviceModel->getFeatured(3);
        }

        // Pagination data
        $pagination = [
            'page' => $page,
            'per_page' => $perPage,
            'total' => $totalServices,
            'total_pages' => ceil($totalServices / $perPage)
        ];

        // Pass data to view
        require_once APP_PATH . '/views/services/catalog.php';
    }

    /**
     * Display service detail
     */
    public function detail()
    {
        // Get service slug from URL
        $slug = $_GET['slug'] ?? '';

        if (empty($slug)) {
            Session::setFlash('error', 'Service not found');
            redirect(url('services.php'));
        }

        // Get service by slug
        $service = $this->serviceModel->findBySlug($slug);

        if (!$service) {
            Session::setFlash('error', 'Service not found');
            redirect(url('services.php'));
        }

        // Increment views
        $this->serviceModel->incrementViews($service['id']);

        // Get related services (same category)
        $relatedServices = $this->serviceModel->getRelated($service['id'], $service['category_id'], 4);

        // Get service features (if stored as JSON)
        $features = !empty($service['features']) ? json_decode($service['features'], true) : [];

        // Pass data to view
        require_once APP_PATH . '/views/services/detail.php';
    }

    /**
     * Search services (AJAX)
     */
    public function search()
    {
        header('Content-Type: application/json');

        // Only allow GET requests
        if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
            http_response_code(405);
            echo json_encode(['error' => 'Method not allowed']);
            return;
        }

        $query = $_GET['q'] ?? '';
        $category = $_GET['category'] ?? '';
        $limit = isset($_GET['limit']) ? (int)$_GET['limit'] : 10;

        if (empty($query) || strlen($query) < 2) {
            echo json_encode(['results' => []]);
            return;
        }

        // Build filters
        $filters = ['search' => $query];
        if ($category) {
            $filters['category_slug'] = $category;
        }

        // Search services
        $services = $this->serviceModel->getAll($filters, 1, $limit);

        // Format results
        $results = [];
        foreach ($services as $service) {
            $results[] = [
                'id' => $service['id'],
                'name' => $service['name'],
                'slug' => $service['slug'],
                'category' => $service['category_name'],
                'price' => rupiah($service['base_price']),
                'url' => url('service-detail.php?slug=' . $service['slug'])
            ];
        }

        echo json_encode(['results' => $results]);
    }

    /**
     * Add to cart (AJAX)
     */
    public function addToCart()
    {
        header('Content-Type: application/json');

        // Only allow POST requests
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            http_response_code(405);
            echo json_encode(['success' => false, 'message' => 'Method not allowed']);
            return;
        }

        // Get POST data
        $data = json_decode(file_get_contents('php://input'), true);

        $serviceId = $data['service_id'] ?? 0;
        $type = $data['type'] ?? 'beli'; // beli or sewa
        $months = isset($data['months']) ? (int)$data['months'] : 1;

        // Validate service
        $service = $this->serviceModel->findById($serviceId);
        if (!$service) {
            echo json_encode(['success' => false, 'message' => 'Service not found']);
            return;
        }

        // Validate type
        if ($type === 'beli' && !$service['available_for_purchase']) {
            echo json_encode(['success' => false, 'message' => 'This service is not available for purchase']);
            return;
        }

        if ($type === 'sewa' && !$service['available_for_rent']) {
            echo json_encode(['success' => false, 'message' => 'This service is not available for rent']);
            return;
        }

        // Initialize cart in session
        if (!isset($_SESSION['cart'])) {
            $_SESSION['cart'] = [];
        }

        // Generate cart item key
        $cartKey = $serviceId . '_' . $type . '_' . $months;

        // Check if item already in cart
        if (isset($_SESSION['cart'][$cartKey])) {
            echo json_encode([
                'success' => false,
                'message' => 'This service is already in your cart'
            ]);
            return;
        }

        // Calculate price
        $priceBreakdown = $this->serviceModel->calculatePrice($serviceId, $type, $months);

        // Add to cart
        $_SESSION['cart'][$cartKey] = [
            'service_id' => $serviceId,
            'service_name' => $service['name'],
            'service_slug' => $service['slug'],
            'type' => $type,
            'months' => $months,
            'base_price' => $service['base_price'],
            'monthly_price' => $service['monthly_price'],
            'setup_fee' => $service['setup_fee'],
            'total' => $priceBreakdown['total'],
            'added_at' => time()
        ];

        // Get cart summary
        $cartCount = count($_SESSION['cart']);
        $cartTotal = 0;
        foreach ($_SESSION['cart'] as $item) {
            $cartTotal += $item['total'];
        }

        echo json_encode([
            'success' => true,
            'message' => 'Service added to cart successfully',
            'cart' => [
                'count' => $cartCount,
                'total' => rupiah($cartTotal)
            ]
        ]);
    }

    /**
     * View cart
     */
    public function cart()
    {
        // Get cart from session
        $cartItems = $_SESSION['cart'] ?? [];

        // Calculate totals
        $subtotal = 0;
        $setupFees = 0;
        foreach ($cartItems as $item) {
            $subtotal += $item['total'];
            $setupFees += $item['setup_fee'];
        }

        $total = $subtotal;

        // Pass data to view
        require_once APP_PATH . '/views/services/cart.php';
    }

    /**
     * Update cart item (AJAX)
     */
    public function updateCartItem()
    {
        header('Content-Type: application/json');

        // Only allow POST requests
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            http_response_code(405);
            echo json_encode(['success' => false, 'message' => 'Method not allowed']);
            return;
        }

        // Get POST data
        $data = json_decode(file_get_contents('php://input'), true);

        $cartKey = $data['cart_key'] ?? '';
        $months = isset($data['months']) ? (int)$data['months'] : 1;

        // Check if item exists in cart
        if (!isset($_SESSION['cart'][$cartKey])) {
            echo json_encode(['success' => false, 'message' => 'Item not found in cart']);
            return;
        }

        $item = $_SESSION['cart'][$cartKey];

        // Recalculate price
        $priceBreakdown = $this->serviceModel->calculatePrice($item['service_id'], $item['type'], $months);

        // Update cart item
        $_SESSION['cart'][$cartKey]['months'] = $months;
        $_SESSION['cart'][$cartKey]['total'] = $priceBreakdown['total'];

        // Get cart summary
        $cartTotal = 0;
        foreach ($_SESSION['cart'] as $cartItem) {
            $cartTotal += $cartItem['total'];
        }

        echo json_encode([
            'success' => true,
            'message' => 'Cart updated successfully',
            'item_total' => rupiah($priceBreakdown['total']),
            'cart_total' => rupiah($cartTotal)
        ]);
    }

    /**
     * Remove cart item (AJAX)
     */
    public function removeCartItem()
    {
        header('Content-Type: application/json');

        // Only allow POST requests
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            http_response_code(405);
            echo json_encode(['success' => false, 'message' => 'Method not allowed']);
            return;
        }

        // Get POST data
        $data = json_decode(file_get_contents('php://input'), true);

        $cartKey = $data['cart_key'] ?? '';

        // Check if item exists in cart
        if (!isset($_SESSION['cart'][$cartKey])) {
            echo json_encode(['success' => false, 'message' => 'Item not found in cart']);
            return;
        }

        // Remove item
        unset($_SESSION['cart'][$cartKey]);

        // Get cart summary
        $cartCount = count($_SESSION['cart']);
        $cartTotal = 0;
        foreach ($_SESSION['cart'] as $item) {
            $cartTotal += $item['total'];
        }

        echo json_encode([
            'success' => true,
            'message' => 'Item removed from cart',
            'cart' => [
                'count' => $cartCount,
                'total' => rupiah($cartTotal)
            ]
        ]);
    }

    /**
     * Clear cart
     */
    public function clearCart()
    {
        $_SESSION['cart'] = [];
        Session::setFlash('success', 'Cart cleared successfully');
        redirect(url('services.php'));
    }
}
