<?php
/**
 * Client Support Tickets Page
 */

// Load configuration
require_once __DIR__ . '/../../config/config.php';

// Require login as client
Session::requireLogin();
Session::requireRole(5);

// Initialize controller
$controller = new ClientController();
$controller->tickets();
