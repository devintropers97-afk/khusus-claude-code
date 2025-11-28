<?php
/**
 * Order Confirmation Page
 */

// Load configuration
require_once __DIR__ . '/../config/config.php';

// Require login
Session::requireLogin();

// Initialize controller
$controller = new OrderController();
$controller->confirmation();
