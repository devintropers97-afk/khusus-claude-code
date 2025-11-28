<?php
/**
 * API Endpoint: Add to Cart
 * AJAX endpoint untuk menambahkan item ke shopping cart
 */

require_once '../../app/config/config.php';
require_once '../../app/core/Database.php';
require_once '../../app/helpers/functions.php';
require_once '../../app/models/Service.php';
require_once '../../app/models/Cart.php';

// Set JSON response header
header('Content-Type: application/json');

// Only accept POST requests
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Method not allowed']);
    exit;
}

// Get JSON input
$input = json_decode(file_get_contents('php://input'), true);

// Validate required fields
if (empty($input['service_id'])) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Service ID is required']);
    exit;
}

$serviceId = intval($input['service_id']);
$quantity = isset($input['quantity']) ? intval($input['quantity']) : 1;
$type = $input['type'] ?? 'beli'; // 'beli' or 'sewa'
$months = isset($input['months']) ? intval($input['months']) : 1;

// Validate quantity
if ($quantity <= 0) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Invalid quantity']);
    exit;
}

// Validate type
if (!in_array($type, ['beli', 'sewa'])) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Invalid order type']);
    exit;
}

try {
    // Check if service exists
    $serviceModel = new Service();
    $service = $serviceModel->findById($serviceId);

    if (!$service) {
        http_response_code(404);
        echo json_encode(['success' => false, 'message' => 'Service not found']);
        exit;
    }

    // Add to cart
    $cartModel = new Cart();
    $success = $cartModel->add($serviceId, [
        'quantity' => $quantity,
        'type' => $type,
        'months' => $months
    ]);

    if ($success) {
        // Get updated cart count and total
        $cartCount = $cartModel->getCount();
        $cartTotal = $cartModel->getTotal();

        echo json_encode([
            'success' => true,
            'message' => 'Item added to cart',
            'cart_count' => $cartCount,
            'cart_total' => $cartTotal['total'],
            'service_name' => $service['name']
        ]);
    } else {
        http_response_code(500);
        echo json_encode(['success' => false, 'message' => 'Failed to add item to cart']);
    }

} catch (Exception $e) {
    http_response_code(500);
    logError('Add to cart API error: ' . $e->getMessage());
    echo json_encode(['success' => false, 'message' => 'Server error']);
}
