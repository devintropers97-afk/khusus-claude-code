<?php
/**
 * API Endpoint: Update Cart Item
 * AJAX endpoint untuk update quantity item di cart
 */

require_once '../../app/config/config.php';
require_once '../../app/core/Database.php';
require_once '../../app/helpers/functions.php';
require_once '../../app/models/Cart.php';

// Set JSON response header
header('Content-Type: application/json');

// Only accept POST/PUT requests
if (!in_array($_SERVER['REQUEST_METHOD'], ['POST', 'PUT'])) {
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

if (!isset($input['quantity'])) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Quantity is required']);
    exit;
}

$itemId = $input['item_id'];
$quantity = intval($input['quantity']);

// Validate quantity
if ($quantity < 0) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Invalid quantity']);
    exit;
}

try {
    $cartModel = new Cart();

    // If quantity is 0, remove item
    if ($quantity === 0) {
        $success = $cartModel->remove($itemId);
        $message = 'Item removed from cart';
    } else {
        $success = $cartModel->updateQuantity($itemId, $quantity);
        $message = 'Cart updated';
    }

    if ($success) {
        // Get updated cart count and total
        $cartCount = $cartModel->getCount();
        $cartTotal = $cartModel->getTotal();

        echo json_encode([
            'success' => true,
            'message' => $message,
            'cart_count' => $cartCount,
            'cart_total' => $cartTotal
        ]);
    } else {
        http_response_code(500);
        echo json_encode(['success' => false, 'message' => 'Failed to update cart']);
    }

} catch (Exception $e) {
    http_response_code(500);
    logError('Update cart API error: ' . $e->getMessage());
    echo json_encode(['success' => false, 'message' => 'Server error']);
}
