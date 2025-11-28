<?php
/**
 * Invoice Model
 * Model untuk mengelola invoices dan payment tracking
 *
 * Menyediakan invoice generation, payment tracking, dan PDF export
 */

class Invoice {
    private $db;

    public function __construct() {
        $this->db = Database::getInstance();
    }

    /**
     * Create invoice from order
     *
     * @param int $orderId
     * @return int|false Invoice ID
     */
    public function createFromOrder($orderId) {
        try {
            $this->db->beginTransaction();

            // Get order details
            $orderModel = new Order();
            $order = $orderModel->findById($orderId);

            if (!$order) {
                throw new Exception('Order not found');
            }

            // Generate invoice number
            $invoiceNumber = $this->generateInvoiceNumber();

            // Calculate due date (14 days from now)
            $dueDate = date('Y-m-d', strtotime('+14 days'));

            // Create invoice
            $this->db->query("
                INSERT INTO client_invoices
                (invoice_number, client_id, order_id, total_amount, tax_amount, discount_amount,
                 subtotal, due_date, status, payment_terms, notes)
                VALUES
                (:invoice_number, :client_id, :order_id, :total_amount, :tax_amount, :discount_amount,
                 :subtotal, :due_date, 'draft', '14 days', :notes)
            ");

            $taxAmount = $order['total_amount'] * 0.11; // PPN 11%
            $subtotal = $order['total_amount'];
            $total = $subtotal + $taxAmount - ($order['discount_amount'] ?? 0);

            $this->db->bind(':invoice_number', $invoiceNumber);
            $this->db->bind(':client_id', $order['client_id']);
            $this->db->bind(':order_id', $orderId);
            $this->db->bind(':total_amount', $total);
            $this->db->bind(':tax_amount', $taxAmount);
            $this->db->bind(':discount_amount', $order['discount_amount'] ?? 0);
            $this->db->bind(':subtotal', $subtotal);
            $this->db->bind(':due_date', $dueDate);
            $this->db->bind(':notes', 'Invoice for Order #' . $order['order_number']);

            $this->db->execute();
            $invoiceId = $this->db->lastInsertId();

            // Create invoice items from order items
            $orderItems = $orderModel->getOrderItems($orderId);

            foreach ($orderItems as $item) {
                $this->db->query("
                    INSERT INTO client_invoice_items
                    (invoice_id, description, quantity, unit_price, subtotal, tax_amount)
                    VALUES
                    (:invoice_id, :description, :quantity, :unit_price, :subtotal, :tax_amount)
                ");

                $itemSubtotal = $item['quantity'] * $item['unit_price'];
                $itemTax = $itemSubtotal * 0.11;

                $this->db->bind(':invoice_id', $invoiceId);
                $this->db->bind(':description', $item['service_name']);
                $this->db->bind(':quantity', $item['quantity']);
                $this->db->bind(':unit_price', $item['unit_price']);
                $this->db->bind(':subtotal', $itemSubtotal);
                $this->db->bind(':tax_amount', $itemTax);
                $this->db->execute();
            }

            $this->db->commit();

            // Log activity
            Session::logActivity($order['client_id'], 'invoice_created', 'Invoice created', [
                'invoice_number' => $invoiceNumber,
                'order_id' => $orderId
            ]);

            return $invoiceId;

        } catch (Exception $e) {
            $this->db->rollback();
            logError('Invoice creation failed: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Create manual invoice (not from order)
     *
     * @param array $data Invoice data
     * @return int|false Invoice ID
     */
    public function create($data) {
        try {
            $this->db->beginTransaction();

            $invoiceNumber = $this->generateInvoiceNumber();

            $this->db->query("
                INSERT INTO client_invoices
                (invoice_number, client_id, total_amount, tax_amount, discount_amount,
                 subtotal, due_date, status, payment_terms, notes)
                VALUES
                (:invoice_number, :client_id, :total_amount, :tax_amount, :discount_amount,
                 :subtotal, :due_date, :status, :payment_terms, :notes)
            ");

            $this->db->bind(':invoice_number', $invoiceNumber);
            $this->db->bind(':client_id', $data['client_id']);
            $this->db->bind(':total_amount', $data['total_amount']);
            $this->db->bind(':tax_amount', $data['tax_amount'] ?? 0);
            $this->db->bind(':discount_amount', $data['discount_amount'] ?? 0);
            $this->db->bind(':subtotal', $data['subtotal']);
            $this->db->bind(':due_date', $data['due_date']);
            $this->db->bind(':status', $data['status'] ?? 'draft');
            $this->db->bind(':payment_terms', $data['payment_terms'] ?? '14 days');
            $this->db->bind(':notes', $data['notes'] ?? null);

            $this->db->execute();
            $invoiceId = $this->db->lastInsertId();

            // Create invoice items
            if (!empty($data['items'])) {
                foreach ($data['items'] as $item) {
                    $this->db->query("
                        INSERT INTO client_invoice_items
                        (invoice_id, description, quantity, unit_price, subtotal, tax_amount)
                        VALUES
                        (:invoice_id, :description, :quantity, :unit_price, :subtotal, :tax_amount)
                    ");

                    $this->db->bind(':invoice_id', $invoiceId);
                    $this->db->bind(':description', $item['description']);
                    $this->db->bind(':quantity', $item['quantity']);
                    $this->db->bind(':unit_price', $item['unit_price']);
                    $this->db->bind(':subtotal', $item['subtotal']);
                    $this->db->bind(':tax_amount', $item['tax_amount'] ?? 0);
                    $this->db->execute();
                }
            }

            $this->db->commit();

            Session::logActivity($data['client_id'], 'invoice_created', 'Manual invoice created', [
                'invoice_number' => $invoiceNumber
            ]);

            return $invoiceId;

        } catch (Exception $e) {
            $this->db->rollback();
            logError('Manual invoice creation failed: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Find invoice by ID
     *
     * @param int $id
     * @return array|false
     */
    public function findById($id) {
        $this->db->query("
            SELECT
                ci.*,
                u.first_name, u.last_name, u.email,
                cp.company_name, cp.client_code,
                up.address, up.city, up.province,
                o.order_number
            FROM client_invoices ci
            JOIN users u ON ci.client_id = u.id
            LEFT JOIN client_profiles cp ON u.id = cp.user_id
            LEFT JOIN user_profiles up ON u.id = up.user_id
            LEFT JOIN orders o ON ci.order_id = o.id
            WHERE ci.id = :id
        ");

        $this->db->bind(':id', $id);
        return $this->db->single();
    }

    /**
     * Find invoice by invoice number
     *
     * @param string $invoiceNumber
     * @return array|false
     */
    public function findByNumber($invoiceNumber) {
        $this->db->query("
            SELECT
                ci.*,
                u.first_name, u.last_name, u.email,
                cp.company_name, cp.client_code
            FROM client_invoices ci
            JOIN users u ON ci.client_id = u.id
            LEFT JOIN client_profiles cp ON u.id = cp.user_id
            WHERE ci.invoice_number = :invoice_number
        ");

        $this->db->bind(':invoice_number', $invoiceNumber);
        return $this->db->single();
    }

    /**
     * Get all invoices for a client
     *
     * @param int $clientId
     * @param int $page
     * @param int $perPage
     * @param array $filters
     * @return array
     */
    public function getByClient($clientId, $page = 1, $perPage = 20, $filters = []) {
        $offset = ($page - 1) * $perPage;

        $where = ['ci.client_id = :client_id'];
        $params = [':client_id' => $clientId];

        if (!empty($filters['status'])) {
            $where[] = 'ci.status = :status';
            $params[':status'] = $filters['status'];
        }

        if (!empty($filters['search'])) {
            $where[] = '(ci.invoice_number LIKE :search OR ci.notes LIKE :search)';
            $params[':search'] = '%' . $filters['search'] . '%';
        }

        $whereStr = implode(' AND ', $where);

        // Get total count
        $this->db->query("SELECT COUNT(*) as total FROM client_invoices ci WHERE $whereStr");
        foreach ($params as $param => $value) {
            $this->db->bind($param, $value);
        }
        $totalResult = $this->db->single();
        $total = $totalResult['total'];

        // Get invoices
        $this->db->query("
            SELECT
                ci.*,
                o.order_number
            FROM client_invoices ci
            LEFT JOIN orders o ON ci.order_id = o.id
            WHERE $whereStr
            ORDER BY ci.created_at DESC
            LIMIT :limit OFFSET :offset
        ");

        foreach ($params as $param => $value) {
            $this->db->bind($param, $value);
        }
        $this->db->bind(':limit', $perPage, PDO::PARAM_INT);
        $this->db->bind(':offset', $offset, PDO::PARAM_INT);

        $invoices = $this->db->resultSet();

        return [
            'invoices' => $invoices,
            'total' => $total,
            'page' => $page,
            'per_page' => $perPage,
            'total_pages' => ceil($total / $perPage)
        ];
    }

    /**
     * Get all invoices (admin view)
     *
     * @param int $page
     * @param int $perPage
     * @param array $filters
     * @return array
     */
    public function getAll($page = 1, $perPage = 20, $filters = []) {
        $offset = ($page - 1) * $perPage;

        $where = ['1=1'];
        $params = [];

        if (!empty($filters['status'])) {
            $where[] = 'ci.status = :status';
            $params[':status'] = $filters['status'];
        }

        if (!empty($filters['client_id'])) {
            $where[] = 'ci.client_id = :client_id';
            $params[':client_id'] = $filters['client_id'];
        }

        if (!empty($filters['search'])) {
            $where[] = '(ci.invoice_number LIKE :search OR u.first_name LIKE :search OR u.last_name LIKE :search OR cp.company_name LIKE :search)';
            $params[':search'] = '%' . $filters['search'] . '%';
        }

        $whereStr = implode(' AND ', $where);

        // Get total count
        $this->db->query("
            SELECT COUNT(*) as total
            FROM client_invoices ci
            JOIN users u ON ci.client_id = u.id
            LEFT JOIN client_profiles cp ON u.id = cp.user_id
            WHERE $whereStr
        ");
        foreach ($params as $param => $value) {
            $this->db->bind($param, $value);
        }
        $totalResult = $this->db->single();
        $total = $totalResult['total'];

        // Get invoices
        $this->db->query("
            SELECT
                ci.*,
                u.first_name, u.last_name, u.email,
                cp.company_name, cp.client_code,
                o.order_number
            FROM client_invoices ci
            JOIN users u ON ci.client_id = u.id
            LEFT JOIN client_profiles cp ON u.id = cp.user_id
            LEFT JOIN orders o ON ci.order_id = o.id
            WHERE $whereStr
            ORDER BY ci.created_at DESC
            LIMIT :limit OFFSET :offset
        ");

        foreach ($params as $param => $value) {
            $this->db->bind($param, $value);
        }
        $this->db->bind(':limit', $perPage, PDO::PARAM_INT);
        $this->db->bind(':offset', $offset, PDO::PARAM_INT);

        $invoices = $this->db->resultSet();

        return [
            'invoices' => $invoices,
            'total' => $total,
            'page' => $page,
            'per_page' => $perPage,
            'total_pages' => ceil($total / $perPage)
        ];
    }

    /**
     * Get invoice items
     *
     * @param int $invoiceId
     * @return array
     */
    public function getItems($invoiceId) {
        $this->db->query("
            SELECT * FROM client_invoice_items
            WHERE invoice_id = :invoice_id
            ORDER BY id ASC
        ");

        $this->db->bind(':invoice_id', $invoiceId);
        return $this->db->resultSet();
    }

    /**
     * Update invoice status
     *
     * @param int $id
     * @param string $status
     * @return bool
     */
    public function updateStatus($id, $status) {
        $allowedStatuses = ['draft', 'sent', 'partial', 'paid', 'overdue', 'cancelled'];

        if (!in_array($status, $allowedStatuses)) {
            return false;
        }

        try {
            $this->db->query("
                UPDATE client_invoices
                SET status = :status, updated_at = NOW()
                WHERE id = :id
            ");

            $this->db->bind(':status', $status);
            $this->db->bind(':id', $id);

            $success = $this->db->execute();

            if ($success) {
                $invoice = $this->findById($id);
                Session::logActivity($invoice['client_id'], 'invoice_status_changed', "Invoice status changed to $status", [
                    'invoice_number' => $invoice['invoice_number']
                ]);
            }

            return $success;

        } catch (Exception $e) {
            logError('Invoice status update failed: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Record payment for invoice
     *
     * @param int $invoiceId
     * @param array $paymentData
     * @return bool
     */
    public function recordPayment($invoiceId, $paymentData) {
        try {
            $this->db->beginTransaction();

            $invoice = $this->findById($invoiceId);
            if (!$invoice) {
                throw new Exception('Invoice not found');
            }

            // Update paid amount
            $newPaidAmount = $invoice['paid_amount'] + $paymentData['amount'];

            $this->db->query("
                UPDATE client_invoices
                SET paid_amount = :paid_amount,
                    updated_at = NOW()
                WHERE id = :id
            ");

            $this->db->bind(':paid_amount', $newPaidAmount);
            $this->db->bind(':id', $invoiceId);
            $this->db->execute();

            // Update status based on payment
            if ($newPaidAmount >= $invoice['total_amount']) {
                $this->updateStatus($invoiceId, 'paid');
                $this->db->query("UPDATE client_invoices SET paid_at = NOW() WHERE id = :id");
                $this->db->bind(':id', $invoiceId);
                $this->db->execute();
            } elseif ($newPaidAmount > 0) {
                $this->updateStatus($invoiceId, 'partial');
            }

            $this->db->commit();

            Session::logActivity($invoice['client_id'], 'invoice_payment_recorded', 'Payment recorded for invoice', [
                'invoice_number' => $invoice['invoice_number'],
                'amount' => $paymentData['amount']
            ]);

            return true;

        } catch (Exception $e) {
            $this->db->rollback();
            logError('Payment recording failed: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Send invoice to client (mark as sent)
     *
     * @param int $id
     * @return bool
     */
    public function send($id) {
        try {
            $invoice = $this->findById($id);
            if (!$invoice) {
                return false;
            }

            $this->db->query("
                UPDATE client_invoices
                SET status = 'sent', sent_at = NOW(), updated_at = NOW()
                WHERE id = :id
            ");

            $this->db->bind(':id', $id);
            $success = $this->db->execute();

            if ($success) {
                // TODO: Send email notification
                Session::logActivity($invoice['client_id'], 'invoice_sent', 'Invoice sent to client', [
                    'invoice_number' => $invoice['invoice_number']
                ]);
            }

            return $success;

        } catch (Exception $e) {
            logError('Invoice send failed: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Check and update overdue invoices
     *
     * @return int Number of invoices marked as overdue
     */
    public function checkOverdue() {
        try {
            $this->db->query("
                UPDATE client_invoices
                SET status = 'overdue'
                WHERE status IN ('sent', 'partial')
                    AND due_date < CURDATE()
                    AND paid_amount < total_amount
            ");

            return $this->db->rowCount();

        } catch (Exception $e) {
            logError('Overdue check failed: ' . $e->getMessage());
            return 0;
        }
    }

    /**
     * Generate unique invoice number
     *
     * @return string INV-YYYYMM-XXXX
     */
    private function generateInvoiceNumber() {
        $yearMonth = date('Ym');
        $prefix = "INV-$yearMonth-";

        $this->db->query("
            SELECT COUNT(*) as count
            FROM client_invoices
            WHERE invoice_number LIKE :prefix
        ");
        $this->db->bind(':prefix', $prefix . '%');
        $result = $this->db->single();

        $sequence = str_pad($result['count'] + 1, 4, '0', STR_PAD_LEFT);

        return $prefix . $sequence;
    }

    /**
     * Get invoice statistics
     *
     * @return array
     */
    public function getStatistics() {
        // Total invoices
        $this->db->query("SELECT COUNT(*) as total FROM client_invoices");
        $total = $this->db->single()['total'];

        // By status
        $this->db->query("SELECT status, COUNT(*) as count FROM client_invoices GROUP BY status");
        $byStatus = $this->db->resultSet();

        // Total revenue
        $this->db->query("SELECT COALESCE(SUM(paid_amount), 0) as revenue FROM client_invoices WHERE status = 'paid'");
        $revenue = $this->db->single()['revenue'];

        // Outstanding amount
        $this->db->query("SELECT COALESCE(SUM(total_amount - paid_amount), 0) as outstanding FROM client_invoices WHERE status IN ('sent', 'partial', 'overdue')");
        $outstanding = $this->db->single()['outstanding'];

        // Overdue invoices
        $this->db->query("SELECT COUNT(*) as count, COALESCE(SUM(total_amount - paid_amount), 0) as amount FROM client_invoices WHERE status = 'overdue'");
        $overdue = $this->db->single();

        return [
            'total' => $total,
            'by_status' => $byStatus,
            'total_revenue' => $revenue,
            'outstanding_amount' => $outstanding,
            'overdue_count' => $overdue['count'],
            'overdue_amount' => $overdue['amount']
        ];
    }
}
