<?php
/**
 * Process Login
 * Handler untuk form login
 */

// Load configuration
require_once __DIR__ . '/../config/config.php';

// Only allow POST requests
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    redirect(url('login.php'));
}

// Require guest (harus belum login)
Session::requireGuest();

// Process login via AuthController
$authController = new AuthController();
$authController->login();
