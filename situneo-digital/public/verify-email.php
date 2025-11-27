<?php
/**
 * Email Verification
 * Handler untuk verifikasi email via token
 */

// Load configuration
require_once __DIR__ . '/../config/config.php';

// Get token dari URL
$token = $_GET['token'] ?? '';

// Process verification via AuthController
$authController = new AuthController();
$authController->verifyEmail($token);
