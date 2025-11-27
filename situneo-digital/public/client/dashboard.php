<?php
/**
 * Client Dashboard Entry Point
 */

// Load configuration
require_once __DIR__ . '/../../config/config.php';

// Require login as client
Session::requireLogin();
Session::requireRole(5); // Client role

// Initialize controller
$controller = new ClientController();
$controller->dashboard();
