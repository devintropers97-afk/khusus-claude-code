<?php
/**
 * SITUNEO DIGITAL - Homepage
 * PT SITUNEO DIGITAL SOLUSI INDONESIA
 *
 * Main entry point untuk aplikasi
 */

// Load configuration
require_once __DIR__ . '/../config/config.php';

// Check remember me cookie
AuthController::checkRememberMe();

// Redirect jika sudah login
if (Session::isLoggedIn()) {
    $roleId = Session::getUserRole();

    $dashboards = [
        1 => 'admin/dashboard.php',      // Super Admin
        2 => 'manager/dashboard.php',    // Manager
        3 => 'spv/dashboard.php',        // SPV
        4 => 'partner/dashboard.php',    // Partner
        5 => 'client/dashboard.php',     // Client
    ];

    $dashboard = isset($dashboards[$roleId]) ? $dashboards[$roleId] : 'dashboard.php';
    redirect(url($dashboard));
}

// Redirect ke login page jika belum login
redirect(url('login.php'));
