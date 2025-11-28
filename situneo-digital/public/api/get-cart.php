<?php
/**
 * API Endpoint: Get Cart Data
 * AJAX endpoint untuk mengambil cart data
 */

require_once '../../app/config/config.php';
require_once '../../app/core/Database.php';
require_once '../../app/helpers/functions.php';
require_once '../../app/models/Cart.php';

// Set JSON response header
header('Content-Type: application/json');

// Only accept GET requests
if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Method not allowed']);
    exit;
}

try {
    $cartModel = new Cart();

    // Get cart items
    $items = $cartModel->getItems();

    // Get cart total
    $cartTotal = $cartModel->getTotal();

    // Get applied promo
    $appliedPromo = $cartModel->getAppliedPromo();

    // Format items for response
    $formattedItems = [];
    foreach ($items as $item) {
        $formattedItems[] = [
            'id' => $item['id'] ?? ($item['service_id'] . '_' . $item['type']),
            'service_id' => $item['service_id'],
            'service_name' => $item['service_name'],
            'service_code' => $item['service_code'] ?? '',
            'quantity' => $item['quantity'],
            'type' => $item['type'] ?? $item['order_type'] ?? 'beli',
            'months' => $item['months'] ?? 1,
            'unit_price' => $item['unit_price'],
            'unit_price_formatted' => 'Rp ' . number_format($item['unit_price'], 0, ',', '.'),
            'setup_fee' => $item['setup_fee'],
            'setup_fee_formatted' => 'Rp ' . number_format($item['setup_fee'], 0, ',', '.'),
            'subtotal' => $item['subtotal'],
            'subtotal_formatted' => 'Rp ' . number_format($item['subtotal'], 0, ',', '.'),
            'total' => $item['total'],
            'total_formatted' => 'Rp ' . number_format($item['total'], 0, ',', '.')
        ];
    }

    // Calculate final total with promo discount
    $finalTotal = $cartTotal['total'];
    $promoDiscount = 0;

    if ($appliedPromo) {
        $promoDiscount = $appliedPromo['discount_amount'];
        $finalTotal -= $promoDiscount;
    }

    echo json_encode([
        'success' => true,
        'items' => $formattedItems,
        'cart_count' => $cartModel->getCount(),
        'subtotal' => $cartTotal['subtotal'],
        'subtotal_formatted' => 'Rp ' . number_format($cartTotal['subtotal'], 0, ',', '.'),
        'setup_fees' => $cartTotal['setup_fees'],
        'setup_fees_formatted' => 'Rp ' . number_format($cartTotal['setup_fees'], 0, ',', '.'),
        'discount' => $promoDiscount,
        'discount_formatted' => 'Rp ' . number_format($promoDiscount, 0, ',', '.'),
        'total' => $finalTotal,
        'total_formatted' => 'Rp ' . number_format($finalTotal, 0, ',', '.'),
        'applied_promo' => $appliedPromo
    ]);

} catch (Exception $e) {
    http_response_code(500);
    logError('Get cart API error: ' . $e->getMessage());
    echo json_encode(['success' => false, 'message' => 'Server error']);
}
