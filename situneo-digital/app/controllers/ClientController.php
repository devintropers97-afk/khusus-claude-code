<?php
/**
 * ClientController
 * Controller untuk mengelola Client operations
 *
 * Handles:
 * - Client dashboard
 * - Client profile management
 * - Orders and subscriptions
 * - Support tickets
 */

class ClientController {
    private $clientModel;
    private $validator;

    public function __construct() {
        $this->clientModel = new Client();
        $this->validator = new Validator();
    }

    /**
     * Client dashboard
     *
     * @return void
     */
    public function dashboard() {
        // Require login as client
        Session::requireLogin();
        Session::requireRole(5); // Client role

        $clientId = Session::getUserId();

        // Get dashboard stats
        $stats = $this->clientModel->getDashboardStats($clientId);

        if (!$stats) {
            Session::flash('error', 'Data client tidak ditemukan.');
            redirect(url('logout.php'));
            return;
        }

        // Load dashboard view
        require_once APP_PATH . '/views/client/dashboard.php';
    }

    /**
     * Show client profile
     *
     * @return void
     */
    public function profile() {
        Session::requireLogin();
        Session::requireRole(5);

        $clientId = Session::getUserId();
        $client = $this->clientModel->findById($clientId);

        if (!$client) {
            Session::flash('error', 'Profile tidak ditemukan.');
            redirect(url('client/dashboard.php'));
            return;
        }

        // Load profile view
        require_once APP_PATH . '/views/client/profile.php';
    }

    /**
     * Update client profile
     *
     * @return void
     */
    public function updateProfile() {
        Session::requireLogin();
        Session::requireRole(5);

        if (!CSRF::validate()) {
            return;
        }

        $clientId = Session::getUserId();
        $data = Validator::sanitizeArray($_POST);

        // Validate
        $rules = [
            'first_name' => 'required|min:2|max:100',
            'last_name' => 'required|min:2|max:100',
            'phone' => 'phone',
            'company_name' => 'max:255',
            'address' => 'max:500'
        ];

        if (!$this->validator->validate($data, $rules)) {
            Session::flash('error', $this->validator->firstError());
            Session::setOldInput($_POST);
            redirect(url('client/profile.php'));
            return;
        }

        // Update profile
        $success = $this->clientModel->update($clientId, $data);

        if ($success) {
            Session::flash('success', 'Profile berhasil diupdate!');
        } else {
            Session::flash('error', 'Gagal mengupdate profile. Silakan coba lagi.');
        }

        redirect(url('client/profile.php'));
    }

    /**
     * Show client orders
     *
     * @return void
     */
    public function orders() {
        Session::requireLogin();
        Session::requireRole(5);

        $clientId = Session::getUserId();
        $page = $_GET['page'] ?? 1;

        // Get orders
        $db = Database::getInstance();
        $offset = ($page - 1) * 20;

        $db->query("
            SELECT o.*, COUNT(oi.id) as items_count
            FROM orders o
            LEFT JOIN order_items oi ON o.id = oi.order_id
            WHERE o.client_id = :client_id
            GROUP BY o.id
            ORDER BY o.created_at DESC
            LIMIT 20 OFFSET :offset
        ");

        $db->bind(':client_id', $clientId);
        $db->bind(':offset', $offset, PDO::PARAM_INT);
        $orders = $db->resultSet();

        // Get total count
        $db->query("SELECT COUNT(*) as total FROM orders WHERE client_id = :client_id");
        $db->bind(':client_id', $clientId);
        $totalResult = $db->single();
        $total = $totalResult['total'];

        $pagination = [
            'page' => $page,
            'per_page' => 20,
            'total' => $total,
            'total_pages' => ceil($total / 20)
        ];

        // Load view
        require_once APP_PATH . '/views/client/orders.php';
    }

    /**
     * Show order details
     *
     * @param int $orderId
     * @return void
     */
    public function orderDetail($orderId) {
        Session::requireLogin();
        Session::requireRole(5);

        $clientId = Session::getUserId();
        $db = Database::getInstance();

        // Get order with verification
        $db->query("
            SELECT o.*
            FROM orders o
            WHERE o.id = :order_id AND o.client_id = :client_id
        ");

        $db->bind(':order_id', $orderId);
        $db->bind(':client_id', $clientId);
        $order = $db->single();

        if (!$order) {
            Session::flash('error', 'Order tidak ditemukan.');
            redirect(url('client/orders.php'));
            return;
        }

        // Get order items
        $db->query("
            SELECT oi.*, s.name as service_name
            FROM order_items oi
            LEFT JOIN services s ON oi.service_id = s.id
            WHERE oi.order_id = :order_id
        ");

        $db->bind(':order_id', $orderId);
        $items = $db->resultSet();

        // Get order status history
        $db->query("
            SELECT osh.*, u.first_name, u.last_name
            FROM order_status_history osh
            LEFT JOIN users u ON osh.changed_by = u.id
            WHERE osh.order_id = :order_id
            ORDER BY osh.created_at DESC
        ");

        $db->bind(':order_id', $orderId);
        $statusHistory = $db->resultSet();

        // Load view
        require_once APP_PATH . '/views/client/order-detail.php';
    }

    /**
     * Show client subscriptions
     *
     * @return void
     */
    public function subscriptions() {
        Session::requireLogin();
        Session::requireRole(5);

        $clientId = Session::getUserId();
        $db = Database::getInstance();

        // Get active subscriptions
        $db->query("
            SELECT cs.*, s.name as service_name, s.service_code
            FROM client_subscriptions cs
            LEFT JOIN services s ON cs.service_id = s.id
            WHERE cs.client_id = :client_id
            ORDER BY cs.status ASC, cs.next_billing_date ASC
        ");

        $db->bind(':client_id', $clientId);
        $subscriptions = $db->resultSet();

        // Load view
        require_once APP_PATH . '/views/client/subscriptions.php';
    }

    /**
     * Show client invoices
     *
     * @return void
     */
    public function invoices() {
        Session::requireLogin();
        Session::requireRole(5);

        $clientId = Session::getUserId();
        $db = Database::getInstance();

        // Get invoices
        $db->query("
            SELECT *
            FROM client_invoices
            WHERE client_id = :client_id
            ORDER BY invoice_date DESC
            LIMIT 50
        ");

        $db->bind(':client_id', $clientId);
        $invoices = $db->resultSet();

        // Load view
        require_once APP_PATH . '/views/client/invoices.php';
    }

    /**
     * Show client support tickets
     *
     * @return void
     */
    public function tickets() {
        Session::requireLogin();
        Session::requireRole(5);

        $clientId = Session::getUserId();
        $db = Database::getInstance();

        // Get tickets
        $db->query("
            SELECT t.*, u.first_name as assigned_first_name, u.last_name as assigned_last_name
            FROM client_support_tickets t
            LEFT JOIN users u ON t.assigned_to = u.id
            WHERE t.client_id = :client_id
            ORDER BY t.status ASC, t.opened_at DESC
        ");

        $db->bind(':client_id', $clientId);
        $tickets = $db->resultSet();

        // Load view
        require_once APP_PATH . '/views/client/tickets.php';
    }

    /**
     * Create new support ticket
     *
     * @return void
     */
    public function createTicket() {
        Session::requireLogin();
        Session::requireRole(5);

        if (!CSRF::validate()) {
            return;
        }

        $clientId = Session::getUserId();
        $data = Validator::sanitizeArray($_POST);

        // Validate
        $rules = [
            'category' => 'required|in:technical,billing,general,complaint,feature_request',
            'priority' => 'required|in:low,medium,high,urgent',
            'subject' => 'required|min:5|max:255',
            'description' => 'required|min:20'
        ];

        if (!$this->validator->validate($data, $rules)) {
            Session::flash('error', $this->validator->firstError());
            Session::setOldInput($_POST);
            redirect(url('client/tickets.php'));
            return;
        }

        try {
            $db = Database::getInstance();

            // Generate ticket number
            $ticketNumber = 'TKT-' . date('Ymd') . '-' . strtoupper(substr(uniqid(), -6));

            // Create ticket
            $db->query("
                INSERT INTO client_support_tickets
                (ticket_number, client_id, category, priority, subject, description, status, opened_at)
                VALUES (:ticket_number, :client_id, :category, :priority, :subject, :description, 'open', NOW())
            ");

            $db->bind(':ticket_number', $ticketNumber);
            $db->bind(':client_id', $clientId);
            $db->bind(':category', $data['category']);
            $db->bind(':priority', $data['priority']);
            $db->bind(':subject', $data['subject']);
            $db->bind(':description', $data['description']);

            $success = $db->execute();

            if ($success) {
                Session::flash('success', "Ticket berhasil dibuat dengan nomor: $ticketNumber");
            } else {
                Session::flash('error', 'Gagal membuat ticket. Silakan coba lagi.');
            }

        } catch (Exception $e) {
            logError('Ticket creation failed: ' . $e->getMessage());
            Session::flash('error', 'Terjadi kesalahan. Silakan coba lagi.');
        }

        redirect(url('client/tickets.php'));
    }

    /**
     * Show ticket detail
     *
     * @param int $ticketId
     * @return void
     */
    public function ticketDetail($ticketId) {
        Session::requireLogin();
        Session::requireRole(5);

        $clientId = Session::getUserId();
        $db = Database::getInstance();

        // Get ticket
        $db->query("
            SELECT t.*, u.first_name as assigned_first_name, u.last_name as assigned_last_name
            FROM client_support_tickets t
            LEFT JOIN users u ON t.assigned_to = u.id
            WHERE t.id = :ticket_id AND t.client_id = :client_id
        ");

        $db->bind(':ticket_id', $ticketId);
        $db->bind(':client_id', $clientId);
        $ticket = $db->single();

        if (!$ticket) {
            Session::flash('error', 'Ticket tidak ditemukan.');
            redirect(url('client/tickets.php'));
            return;
        }

        // Get responses
        $db->query("
            SELECT r.*, u.first_name, u.last_name, u.role_id
            FROM client_ticket_responses r
            JOIN users u ON r.user_id = u.id
            WHERE r.ticket_id = :ticket_id
                AND r.is_internal = FALSE
            ORDER BY r.created_at ASC
        ");

        $db->bind(':ticket_id', $ticketId);
        $responses = $db->resultSet();

        // Load view
        require_once APP_PATH . '/views/client/ticket-detail.php';
    }
}
