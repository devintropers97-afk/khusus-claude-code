<?php
/**
 * Process Checkout Handler
 */

// Load configuration
require_once __DIR__ . '/../config/config.php';

// Only allow POST requests
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    redirect(url('checkout.php'));
}

// Initialize controller
$controller = new OrderController();
$controller->processCheckout();
