<?php
/**
 * Register Page
 */

// Load configuration
require_once __DIR__ . '/../config/config.php';

// Redirect jika sudah login
Session::requireGuest();

// Load register view
require_once __DIR__ . '/../app/views/auth/register.php';
