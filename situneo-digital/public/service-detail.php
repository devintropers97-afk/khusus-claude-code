<?php
/**
 * Service Detail Page
 */

// Load configuration
require_once __DIR__ . '/../config/config.php';

// Initialize controller
$controller = new ServiceController();
$controller->detail();
