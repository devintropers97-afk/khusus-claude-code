<?php
/**
 * Create Support Ticket Handler
 */

// Load configuration
require_once __DIR__ . '/../../config/config.php';

// Only allow POST requests
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    redirect(url('client/tickets.php'));
}

// Require login as client
Session::requireLogin();
Session::requireRole(5);

// Process ticket creation
$controller = new ClientController();
$controller->createTicket();
