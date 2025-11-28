<?php
/**
 * API Endpoint: Remove Promo Code
 * AJAX endpoint untuk menghapus applied promo code
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

try {
    $cartModel = new Cart();
    $success = $cartModel->removePromoCode();

    if ($success) {
        // Get updated cart total
        $cartTotal = $cartModel->getTotal();

        echo json_encode([
            'success' => true,
            'message' => 'Promo code removed',
            'cart_total' => $cartTotal
        ]);
    } else {
        echo json_encode(['success' => false, 'message' => 'No promo code to remove']);
    }

} catch (Exception $e) {
    http_response_code(500);
    logError('Remove promo code API error: ' . $e->getMessage());
    echo json_encode(['success' => false, 'message' => 'Server error']);
}
