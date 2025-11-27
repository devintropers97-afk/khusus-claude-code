<?php
/**
 * Resend Email Verification
 * Handler untuk kirim ulang email verifikasi
 */

// Load configuration
require_once __DIR__ . '/../config/config.php';

// Only allow POST requests
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    redirect(url('login.php'));
}

// Process resend via AuthController
$authController = new AuthController();
$authController->resendVerification();
