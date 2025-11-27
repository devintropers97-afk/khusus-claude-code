<?php
/**
 * Partner Dashboard Entry Point
 */

// Load configuration
require_once __DIR__ . '/../../config/config.php';

// Require login as partner
Session::requireLogin();
Session::requireRole(4); // Partner role

// Initialize controller
$controller = new PartnerController();
$controller->dashboard();
