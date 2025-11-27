<?php
/**
 * Login Page
 */

// Load configuration
require_once __DIR__ . '/../config/config.php';

// Check remember me cookie
AuthController::checkRememberMe();

// Redirect jika sudah login
Session::requireGuest();

// Load login view
require_once __DIR__ . '/../app/views/auth/login.php';
