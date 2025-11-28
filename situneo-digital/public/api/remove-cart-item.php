<?php
/**
 * API Endpoint: Remove Cart Item
 * AJAX endpoint untuk menghapus item dari cart
 */

require_once '../../app/config/config.php';
require_once '../../app/core/Database.php';
require_once '../../app/helpers/functions.php';
require_once '../../app/models/Cart.php';

// Set JSON response header
header('Content-Type: application/json');

// Only accept POST/DELETE requests
if (!in_array($_SERVER['REQUEST_METHOD'], ['POST', 'DELETE'])) {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Method not allowed']);
    exit;
}

// Get JSON input
$input = json_decode(file_get_contents('php://input'), true);

// Validate required fields
if (empty($input['item_id'])) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Item ID is required']);
    exit;
}

$itemId = $input['item_id'];

try {
    $cartModel = new Cart();
    $success = $cartModel->remove($itemId);

    if ($success) {
        // Get updated cart count and total
        $cartCount = $cartModel->getCount();
        $cartTotal = $cartModel->getTotal();

        echo json_encode([
            'success' => true,
            'message' => 'Item removed from cart',
            'cart_count' => $cartCount,
            'cart_total' => $cartTotal
        ]);
    } else {
        http_response_code(500);
        echo json_encode(['success' => false, 'message' => 'Failed to remove item']);
    }

} catch (Exception $e) {
    http_response_code(500);
    logError('Remove cart item API error: ' . $e->getMessage());
    echo json_encode(['success' => false, 'message' => 'Server error']);
}
