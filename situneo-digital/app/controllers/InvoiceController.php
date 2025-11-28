<?php
/**
 * Invoice Controller
 * Mengelola invoice management untuk clients
 *
 * Handles invoice viewing, payment, and PDF download
 */

class InvoiceController extends Controller {
    private $invoiceModel;
    private $clientModel;

    public function __construct() {
        parent::__construct();

        // Check if user is logged in
        if (!Session::isLoggedIn()) {
            redirect('/auth/login');
        }

        $this->invoiceModel = new Invoice();
        $this->clientModel = new Client();
    }

    /**
     * List all invoices for current client
     */
    public function index() {
        $userId = Session::get('user_id');
        $roleId = Session::get('role_id');

        // Get pagination and filters
        $page = $_GET['page'] ?? 1;
        $perPage = 20;
        $filters = [
            'status' => $_GET['status'] ?? '',
            'search' => $_GET['search'] ?? ''
        ];

        // Admin/Manager can see all invoices
        if (in_array($roleId, [1, 2])) {
            $result = $this->invoiceModel->getAll($page, $perPage, $filters);
        } else {
            // Client can only see their own invoices
            $result = $this->invoiceModel->getByClient($userId, $page, $perPage, $filters);
        }

        $data = [
            'title' => 'My Invoices',
            'invoices' => $result['invoices'],
            'pagination' => [
                'current_page' => $result['page'],
                'total_pages' => $result['total_pages'],
                'total' => $result['total'],
                'per_page' => $result['per_page']
            ],
            'filters' => $filters
        ];

        $this->view('client/invoices', $data);
    }

    /**
     * View invoice detail
     *
     * @param int $id Invoice ID
     */
    public function view($id) {
        $invoice = $this->invoiceModel->findById($id);

        if (!$invoice) {
            Session::setFlash('error', 'Invoice not found');
            redirect('/client/invoices');
        }

        // Check authorization
        $userId = Session::get('user_id');
        $roleId = Session::get('role_id');

        if ($roleId == 5 && $invoice['client_id'] != $userId) {
            Session::setFlash('error', 'Unauthorized access');
            redirect('/client/invoices');
        }

        // Get invoice items
        $items = $this->invoiceModel->getItems($id);

        $data = [
            'title' => 'Invoice ' . $invoice['invoice_number'],
            'invoice' => $invoice,
            'items' => $items
        ];

        $this->view('client/invoice-detail', $data);
    }

    /**
     * Download invoice as PDF
     *
     * @param int $id Invoice ID
     */
    public function download($id) {
        $invoice = $this->invoiceModel->findById($id);

        if (!$invoice) {
            Session::setFlash('error', 'Invoice not found');
            redirect('/client/invoices');
        }

        // Check authorization
        $userId = Session::get('user_id');
        $roleId = Session::get('role_id');

        if ($roleId == 5 && $invoice['client_id'] != $userId) {
            Session::setFlash('error', 'Unauthorized access');
            redirect('/client/invoices');
        }

        // Get invoice items
        $items = $this->invoiceModel->getItems($id);

        // Generate PDF
        $this->generatePDF($invoice, $items);
    }

    /**
     * Show payment form for invoice
     *
     * @param int $id Invoice ID
     */
    public function pay($id) {
        $invoice = $this->invoiceModel->findById($id);

        if (!$invoice) {
            Session::setFlash('error', 'Invoice not found');
            redirect('/client/invoices');
        }

        // Check authorization
        $userId = Session::get('user_id');
        if ($invoice['client_id'] != $userId) {
            Session::setFlash('error', 'Unauthorized access');
            redirect('/client/invoices');
        }

        // Check if already paid
        if ($invoice['status'] == 'paid') {
            Session::setFlash('info', 'This invoice has already been paid');
            redirect('/client/invoices/view/' . $id);
        }

        $data = [
            'title' => 'Pay Invoice',
            'invoice' => $invoice,
            'remaining' => $invoice['total_amount'] - $invoice['paid_amount']
        ];

        $this->view('client/invoice-pay', $data);
    }

    /**
     * Process payment submission
     */
    public function submitPayment() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            redirect('/client/invoices');
        }

        // Validate CSRF token
        if (!validateCSRFToken($_POST['csrf_token'] ?? '')) {
            Session::setFlash('error', 'Invalid request');
            redirect('/client/invoices');
        }

        $invoiceId = $_POST['invoice_id'] ?? 0;
        $invoice = $this->invoiceModel->findById($invoiceId);

        if (!$invoice) {
            Session::setFlash('error', 'Invoice not found');
            redirect('/client/invoices');
        }

        // Check authorization
        $userId = Session::get('user_id');
        if ($invoice['client_id'] != $userId) {
            Session::setFlash('error', 'Unauthorized access');
            redirect('/client/invoices');
        }

        // Validate payment data
        $amount = floatval($_POST['amount'] ?? 0);
        $paymentMethod = $_POST['payment_method'] ?? '';

        if ($amount <= 0) {
            Session::setFlash('error', 'Invalid payment amount');
            redirect('/client/invoices/pay/' . $invoiceId);
        }

        $remaining = $invoice['total_amount'] - $invoice['paid_amount'];
        if ($amount > $remaining) {
            Session::setFlash('error', 'Payment amount exceeds remaining balance');
            redirect('/client/invoices/pay/' . $invoiceId);
        }

        // Handle payment proof upload
        $paymentProof = null;
        if (!empty($_FILES['payment_proof']['name'])) {
            $upload = $this->uploadPaymentProof($_FILES['payment_proof']);
            if ($upload['success']) {
                $paymentProof = $upload['filename'];
            } else {
                Session::setFlash('error', $upload['error']);
                redirect('/client/invoices/pay/' . $invoiceId);
            }
        }

        // Create payment record
        $paymentModel = new Payment();
        $paymentData = [
            'client_id' => $userId,
            'invoice_id' => $invoiceId,
            'amount' => $amount,
            'payment_method' => $paymentMethod,
            'payment_proof' => $paymentProof,
            'notes' => $_POST['notes'] ?? null
        ];

        $paymentId = $paymentModel->create($paymentData);

        if ($paymentId) {
            // Record payment in invoice
            $this->invoiceModel->recordPayment($invoiceId, ['amount' => $amount]);

            Session::setFlash('success', 'Payment submitted successfully. Awaiting verification.');
            redirect('/client/invoices/view/' . $invoiceId);
        } else {
            Session::setFlash('error', 'Failed to submit payment');
            redirect('/client/invoices/pay/' . $invoiceId);
        }
    }

    /**
     * Admin: Create invoice from order
     *
     * @param int $orderId
     */
    public function createFromOrder($orderId) {
        // Check admin/manager authorization
        $roleId = Session::get('role_id');
        if (!in_array($roleId, [1, 2])) {
            Session::setFlash('error', 'Unauthorized access');
            redirect('/dashboard');
        }

        $invoiceId = $this->invoiceModel->createFromOrder($orderId);

        if ($invoiceId) {
            Session::setFlash('success', 'Invoice created successfully');
            redirect('/admin/invoices/view/' . $invoiceId);
        } else {
            Session::setFlash('error', 'Failed to create invoice');
            redirect('/admin/orders/view/' . $orderId);
        }
    }

    /**
     * Admin: Send invoice to client
     *
     * @param int $id
     */
    public function send($id) {
        // Check admin/manager authorization
        $roleId = Session::get('role_id');
        if (!in_array($roleId, [1, 2])) {
            Session::setFlash('error', 'Unauthorized access');
            redirect('/dashboard');
        }

        $success = $this->invoiceModel->send($id);

        if ($success) {
            Session::setFlash('success', 'Invoice sent to client');
        } else {
            Session::setFlash('error', 'Failed to send invoice');
        }

        redirect('/admin/invoices/view/' . $id);
    }

    /**
     * Admin: Update invoice status
     */
    public function updateStatus() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            redirect('/admin/invoices');
        }

        // Check admin/manager authorization
        $roleId = Session::get('role_id');
        if (!in_array($roleId, [1, 2])) {
            Session::setFlash('error', 'Unauthorized access');
            redirect('/dashboard');
        }

        // Validate CSRF token
        if (!validateCSRFToken($_POST['csrf_token'] ?? '')) {
            Session::setFlash('error', 'Invalid request');
            redirect('/admin/invoices');
        }

        $id = $_POST['invoice_id'] ?? 0;
        $status = $_POST['status'] ?? '';

        $success = $this->invoiceModel->updateStatus($id, $status);

        if ($success) {
            Session::setFlash('success', 'Invoice status updated');
        } else {
            Session::setFlash('error', 'Failed to update status');
        }

        redirect('/admin/invoices/view/' . $id);
    }

    /**
     * Upload payment proof file
     *
     * @param array $file
     * @return array
     */
    private function uploadPaymentProof($file) {
        $uploadDir = ROOT_PATH . '/public/uploads/payments/';

        // Create directory if not exists
        if (!is_dir($uploadDir)) {
            mkdir($uploadDir, 0755, true);
        }

        // Validate file
        $allowedTypes = ['image/jpeg', 'image/png', 'image/jpg', 'application/pdf'];
        $maxSize = 5 * 1024 * 1024; // 5MB

        if (!in_array($file['type'], $allowedTypes)) {
            return ['success' => false, 'error' => 'Invalid file type. Only JPG, PNG, and PDF allowed.'];
        }

        if ($file['size'] > $maxSize) {
            return ['success' => false, 'error' => 'File too large. Maximum 5MB allowed.'];
        }

        // Generate unique filename
        $extension = pathinfo($file['name'], PATHINFO_EXTENSION);
        $filename = 'payment_' . time() . '_' . uniqid() . '.' . $extension;
        $filepath = $uploadDir . $filename;

        // Move file
        if (move_uploaded_file($file['tmp_name'], $filepath)) {
            return ['success' => true, 'filename' => $filename];
        } else {
            return ['success' => false, 'error' => 'Failed to upload file'];
        }
    }

    /**
     * Generate PDF invoice
     *
     * @param array $invoice
     * @param array $items
     */
    private function generatePDF($invoice, $items) {
        // Simple HTML to PDF conversion
        // In production, use a library like TCPDF or DomPDF

        $html = $this->generateInvoiceHTML($invoice, $items);

        // Set headers for PDF download
        header('Content-Type: application/pdf');
        header('Content-Disposition: attachment; filename="' . $invoice['invoice_number'] . '.pdf"');

        // For now, output HTML
        // TODO: Implement proper PDF generation
        echo $html;
        exit;
    }

    /**
     * Generate invoice HTML
     *
     * @param array $invoice
     * @param array $items
     * @return string
     */
    private function generateInvoiceHTML($invoice, $items) {
        ob_start();
        ?>
        <!DOCTYPE html>
        <html>
        <head>
            <meta charset="UTF-8">
            <title>Invoice <?= $invoice['invoice_number'] ?></title>
            <style>
                body { font-family: Arial, sans-serif; margin: 40px; }
                .header { text-align: center; margin-bottom: 30px; }
                .company-info { margin-bottom: 20px; }
                .invoice-info { margin-bottom: 20px; }
                table { width: 100%; border-collapse: collapse; margin-top: 20px; }
                th, td { padding: 10px; text-align: left; border-bottom: 1px solid #ddd; }
                th { background-color: #f8f9fa; }
                .text-right { text-align: right; }
                .total-row { font-weight: bold; font-size: 1.1em; }
            </style>
        </head>
        <body>
            <div class="header">
                <h1>INVOICE</h1>
                <h2><?= $invoice['invoice_number'] ?></h2>
            </div>

            <div class="company-info">
                <strong>Situneo Digital</strong><br>
                Jakarta, Indonesia<br>
                Email: info@situneo.digital<br>
                Phone: +62 xxx xxx xxx
            </div>

            <div class="invoice-info">
                <strong>Bill To:</strong><br>
                <?= htmlspecialchars($invoice['company_name'] ?? ($invoice['first_name'] . ' ' . $invoice['last_name'])) ?><br>
                <?= htmlspecialchars($invoice['email']) ?><br>
                <?php if ($invoice['address']): ?>
                    <?= htmlspecialchars($invoice['address']) ?><br>
                    <?= htmlspecialchars($invoice['city']) ?>, <?= htmlspecialchars($invoice['province']) ?>
                <?php endif; ?>
            </div>

            <table>
                <tr>
                    <td><strong>Invoice Date:</strong></td>
                    <td><?= date('d M Y', strtotime($invoice['created_at'])) ?></td>
                    <td><strong>Due Date:</strong></td>
                    <td><?= date('d M Y', strtotime($invoice['due_date'])) ?></td>
                </tr>
                <tr>
                    <td><strong>Status:</strong></td>
                    <td><?= strtoupper($invoice['status']) ?></td>
                    <?php if ($invoice['order_number']): ?>
                        <td><strong>Order:</strong></td>
                        <td><?= $invoice['order_number'] ?></td>
                    <?php endif; ?>
                </tr>
            </table>

            <table>
                <thead>
                    <tr>
                        <th>Description</th>
                        <th class="text-right">Qty</th>
                        <th class="text-right">Unit Price</th>
                        <th class="text-right">Tax</th>
                        <th class="text-right">Total</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($items as $item): ?>
                        <tr>
                            <td><?= htmlspecialchars($item['description']) ?></td>
                            <td class="text-right"><?= $item['quantity'] ?></td>
                            <td class="text-right">Rp <?= number_format($item['unit_price'], 0, ',', '.') ?></td>
                            <td class="text-right">Rp <?= number_format($item['tax_amount'], 0, ',', '.') ?></td>
                            <td class="text-right">Rp <?= number_format($item['subtotal'] + $item['tax_amount'], 0, ',', '.') ?></td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="4" class="text-right"><strong>Subtotal:</strong></td>
                        <td class="text-right">Rp <?= number_format($invoice['subtotal'], 0, ',', '.') ?></td>
                    </tr>
                    <tr>
                        <td colspan="4" class="text-right"><strong>Tax (PPN 11%):</strong></td>
                        <td class="text-right">Rp <?= number_format($invoice['tax_amount'], 0, ',', '.') ?></td>
                    </tr>
                    <?php if ($invoice['discount_amount'] > 0): ?>
                        <tr>
                            <td colspan="4" class="text-right"><strong>Discount:</strong></td>
                            <td class="text-right">- Rp <?= number_format($invoice['discount_amount'], 0, ',', '.') ?></td>
                        </tr>
                    <?php endif; ?>
                    <tr class="total-row">
                        <td colspan="4" class="text-right"><strong>TOTAL:</strong></td>
                        <td class="text-right">Rp <?= number_format($invoice['total_amount'], 0, ',', '.') ?></td>
                    </tr>
                    <?php if ($invoice['paid_amount'] > 0): ?>
                        <tr>
                            <td colspan="4" class="text-right"><strong>Paid:</strong></td>
                            <td class="text-right">Rp <?= number_format($invoice['paid_amount'], 0, ',', '.') ?></td>
                        </tr>
                        <tr class="total-row">
                            <td colspan="4" class="text-right"><strong>Balance Due:</strong></td>
                            <td class="text-right">Rp <?= number_format($invoice['total_amount'] - $invoice['paid_amount'], 0, ',', '.') ?></td>
                        </tr>
                    <?php endif; ?>
                </tfoot>
            </table>

            <?php if ($invoice['notes']): ?>
                <div style="margin-top: 30px;">
                    <strong>Notes:</strong><br>
                    <?= nl2br(htmlspecialchars($invoice['notes'])) ?>
                </div>
            <?php endif; ?>

            <div style="margin-top: 50px; text-align: center; color: #666;">
                <p>Thank you for your business!</p>
            </div>
        </body>
        </html>
        <?php
        return ob_get_clean();
    }
}
