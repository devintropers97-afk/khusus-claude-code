<?php
/**
 * Logout
 * Handler untuk logout user
 */

// Load configuration
require_once __DIR__ . '/../config/config.php';

// Require login
Session::requireLogin();

// Process logout via AuthController
$authController = new AuthController();
$authController->logout();
