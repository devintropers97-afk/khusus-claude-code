<?php
/**
 * API Endpoint: Apply Promo Code
 * AJAX endpoint untuk apply promotional code ke cart
 */

require_once '../../app/config/config.php';
require_once '../../app/core/Database.php';
require_once '../../app/helpers/functions.php';
require_once '../../app/models/Cart.php';
require_once '../../app/models/PromoCode.php';

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
if (empty($input['promo_code'])) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Promo code is required']);
    exit;
}

$promoCode = trim(strtoupper($input['promo_code']));

try {
    $cartModel = new Cart();
    $promoModel = new PromoCode();

    // Check if cart is empty
    if ($cartModel->isEmpty()) {
        echo json_encode(['success' => false, 'message' => 'Cart is empty']);
        exit;
    }

    // Get client ID if logged in
    $clientId = Session::isLoggedIn() ? Session::get('user_id') : null;

    // Validate promo code
    $promo = $promoModel->validateCode($promoCode, $clientId);

    if (!$promo) {
        echo json_encode(['success' => false, 'message' => 'Invalid or expired promo code']);
        exit;
    }

    // Get cart total
    $cartTotal = $cartModel->getTotal();

    // Check minimum purchase requirement
    if ($promo['min_purchase'] > 0 && $cartTotal['subtotal'] < $promo['min_purchase']) {
        echo json_encode([
            'success' => false,
            'message' => 'Minimum purchase of Rp ' . number_format($promo['min_purchase'], 0, ',', '.') . ' required'
        ]);
        exit;
    }

    // Calculate discount
    $discount = $promoModel->calculateDiscount($promo, $cartTotal['subtotal'], $cartTotal['setup_fees']);

    // Apply promo code
    $applied = $cartModel->applyPromoCode($promoCode);

    if ($applied) {
        echo json_encode([
            'success' => true,
            'message' => 'Promo code applied successfully',
            'discount' => $discount,
            'discount_formatted' => 'Rp ' . number_format($discount, 0, ',', '.'),
            'new_total' => $cartTotal['total'] - $discount,
            'new_total_formatted' => 'Rp ' . number_format($cartTotal['total'] - $discount, 0, ',', '.'),
            'promo_description' => $promo['description']
        ]);
    } else {
        http_response_code(500);
        echo json_encode(['success' => false, 'message' => 'Failed to apply promo code']);
    }

} catch (Exception $e) {
    http_response_code(500);
    logError('Apply promo code API error: ' . $e->getMessage());
    echo json_encode(['success' => false, 'message' => 'Server error']);
}
