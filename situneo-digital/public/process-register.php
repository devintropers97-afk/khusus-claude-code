<?php
/**
 * Process Registration
 * Handler untuk form register
 */

// Load configuration
require_once __DIR__ . '/../config/config.php';

// Only allow POST requests
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    redirect(url('register.php'));
}

// Require guest (harus belum login)
Session::requireGuest();

// Process registration via AuthController
$authController = new AuthController();
$authController->register();
