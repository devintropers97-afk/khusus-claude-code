<?php
/**
 * Payment Model
 * Model untuk mengelola payment processing dan verification
 *
 * Menyediakan payment recording, verification, dan refund management
 */

class Payment {
    private $db;

    public function __construct() {
        $this->db = Database::getInstance();
    }

    /**
     * Create new payment record
     *
     * @param array $data Payment data
     * @return int|false Payment ID
     */
    public function create($data) {
        try {
            $this->db->beginTransaction();

            // Generate payment reference
            $paymentReference = $this->generatePaymentReference();

            $this->db->query("
                INSERT INTO client_payments
                (payment_reference, client_id, invoice_id, order_id, amount, payment_method,
                 payment_proof, transaction_id, status, notes)
                VALUES
                (:payment_reference, :client_id, :invoice_id, :order_id, :amount, :payment_method,
                 :payment_proof, :transaction_id, :status, :notes)
            ");

            $this->db->bind(':payment_reference', $paymentReference);
            $this->db->bind(':client_id', $data['client_id']);
            $this->db->bind(':invoice_id', $data['invoice_id'] ?? null);
            $this->db->bind(':order_id', $data['order_id'] ?? null);
            $this->db->bind(':amount', $data['amount']);
            $this->db->bind(':payment_method', $data['payment_method']);
            $this->db->bind(':payment_proof', $data['payment_proof'] ?? null);
            $this->db->bind(':transaction_id', $data['transaction_id'] ?? null);
            $this->db->bind(':status', $data['status'] ?? 'pending');
            $this->db->bind(':notes', $data['notes'] ?? null);

            $this->db->execute();
            $paymentId = $this->db->lastInsertId();

            $this->db->commit();

            // Log activity
            Session::logActivity($data['client_id'], 'payment_created', 'Payment submitted', [
                'payment_reference' => $paymentReference,
                'amount' => $data['amount']
            ]);

            return $paymentId;

        } catch (Exception $e) {
            $this->db->rollback();
            logError('Payment creation failed: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Find payment by ID
     *
     * @param int $id
     * @return array|false
     */
    public function findById($id) {
        $this->db->query("
            SELECT
                cp.*,
                u.first_name, u.last_name, u.email,
                cl.company_name, cl.client_code,
                ci.invoice_number,
                o.order_number
            FROM client_payments cp
            JOIN users u ON cp.client_id = u.id
            LEFT JOIN client_profiles cl ON u.id = cl.user_id
            LEFT JOIN client_invoices ci ON cp.invoice_id = ci.id
            LEFT JOIN orders o ON cp.order_id = o.id
            WHERE cp.id = :id
        ");

        $this->db->bind(':id', $id);
        return $this->db->single();
    }

    /**
     * Find payment by reference
     *
     * @param string $reference
     * @return array|false
     */
    public function findByReference($reference) {
        $this->db->query("
            SELECT
                cp.*,
                u.first_name, u.last_name, u.email,
                ci.invoice_number,
                o.order_number
            FROM client_payments cp
            JOIN users u ON cp.client_id = u.id
            LEFT JOIN client_invoices ci ON cp.invoice_id = ci.id
            LEFT JOIN orders o ON cp.order_id = o.id
            WHERE cp.payment_reference = :reference
        ");

        $this->db->bind(':reference', $reference);
        return $this->db->single();
    }

    /**
     * Get all payments for a client
     *
     * @param int $clientId
     * @param int $page
     * @param int $perPage
     * @param array $filters
     * @return array
     */
    public function getByClient($clientId, $page = 1, $perPage = 20, $filters = []) {
        $offset = ($page - 1) * $perPage;

        $where = ['cp.client_id = :client_id'];
        $params = [':client_id' => $clientId];

        if (!empty($filters['status'])) {
            $where[] = 'cp.status = :status';
            $params[':status'] = $filters['status'];
        }

        if (!empty($filters['payment_method'])) {
            $where[] = 'cp.payment_method = :payment_method';
            $params[':payment_method'] = $filters['payment_method'];
        }

        if (!empty($filters['search'])) {
            $where[] = '(cp.payment_reference LIKE :search OR cp.transaction_id LIKE :search)';
            $params[':search'] = '%' . $filters['search'] . '%';
        }

        $whereStr = implode(' AND ', $where);

        // Get total count
        $this->db->query("SELECT COUNT(*) as total FROM client_payments cp WHERE $whereStr");
        foreach ($params as $param => $value) {
            $this->db->bind($param, $value);
        }
        $totalResult = $this->db->single();
        $total = $totalResult['total'];

        // Get payments
        $this->db->query("
            SELECT
                cp.*,
                ci.invoice_number,
                o.order_number
            FROM client_payments cp
            LEFT JOIN client_invoices ci ON cp.invoice_id = ci.id
            LEFT JOIN orders o ON cp.order_id = o.id
            WHERE $whereStr
            ORDER BY cp.created_at DESC
            LIMIT :limit OFFSET :offset
        ");

        foreach ($params as $param => $value) {
            $this->db->bind($param, $value);
        }
        $this->db->bind(':limit', $perPage, PDO::PARAM_INT);
        $this->db->bind(':offset', $offset, PDO::PARAM_INT);

        $payments = $this->db->resultSet();

        return [
            'payments' => $payments,
            'total' => $total,
            'page' => $page,
            'per_page' => $perPage,
            'total_pages' => ceil($total / $perPage)
        ];
    }

    /**
     * Get all payments (admin view)
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
            $where[] = 'cp.status = :status';
            $params[':status'] = $filters['status'];
        }

        if (!empty($filters['payment_method'])) {
            $where[] = 'cp.payment_method = :payment_method';
            $params[':payment_method'] = $filters['payment_method'];
        }

        if (!empty($filters['client_id'])) {
            $where[] = 'cp.client_id = :client_id';
            $params[':client_id'] = $filters['client_id'];
        }

        if (!empty($filters['search'])) {
            $where[] = '(cp.payment_reference LIKE :search OR u.first_name LIKE :search OR u.last_name LIKE :search OR ci.invoice_number LIKE :search)';
            $params[':search'] = '%' . $filters['search'] . '%';
        }

        $whereStr = implode(' AND ', $where);

        // Get total count
        $this->db->query("
            SELECT COUNT(*) as total
            FROM client_payments cp
            JOIN users u ON cp.client_id = u.id
            LEFT JOIN client_invoices ci ON cp.invoice_id = ci.id
            WHERE $whereStr
        ");
        foreach ($params as $param => $value) {
            $this->db->bind($param, $value);
        }
        $totalResult = $this->db->single();
        $total = $totalResult['total'];

        // Get payments
        $this->db->query("
            SELECT
                cp.*,
                u.first_name, u.last_name, u.email,
                cl.company_name, cl.client_code,
                ci.invoice_number,
                o.order_number
            FROM client_payments cp
            JOIN users u ON cp.client_id = u.id
            LEFT JOIN client_profiles cl ON u.id = cl.user_id
            LEFT JOIN client_invoices ci ON cp.invoice_id = ci.id
            LEFT JOIN orders o ON cp.order_id = o.id
            WHERE $whereStr
            ORDER BY cp.created_at DESC
            LIMIT :limit OFFSET :offset
        ");

        foreach ($params as $param => $value) {
            $this->db->bind($param, $value);
        }
        $this->db->bind(':limit', $perPage, PDO::PARAM_INT);
        $this->db->bind(':offset', $offset, PDO::PARAM_INT);

        $payments = $this->db->resultSet();

        return [
            'payments' => $payments,
            'total' => $total,
            'page' => $page,
            'per_page' => $perPage,
            'total_pages' => ceil($total / $perPage)
        ];
    }

    /**
     * Get pending payments for admin verification
     *
     * @param int $page
     * @param int $perPage
     * @return array
     */
    public function getPendingPayments($page = 1, $perPage = 20) {
        return $this->getAll($page, $perPage, ['status' => 'pending']);
    }

    /**
     * Verify payment (admin action)
     *
     * @param int $paymentId
     * @param int $verifiedBy Admin user ID
     * @param array $data Additional data
     * @return bool
     */
    public function verify($paymentId, $verifiedBy, $data = []) {
        try {
            $this->db->beginTransaction();

            $payment = $this->findById($paymentId);
            if (!$payment) {
                throw new Exception('Payment not found');
            }

            if ($payment['status'] !== 'pending') {
                throw new Exception('Only pending payments can be verified');
            }

            // Update payment status
            $this->db->query("
                UPDATE client_payments
                SET status = 'verified',
                    verified_by = :verified_by,
                    verified_at = NOW(),
                    transaction_id = :transaction_id,
                    notes = :notes,
                    updated_at = NOW()
                WHERE id = :id
            ");

            $this->db->bind(':verified_by', $verifiedBy);
            $this->db->bind(':transaction_id', $data['transaction_id'] ?? $payment['transaction_id']);
            $this->db->bind(':notes', $data['notes'] ?? $payment['notes']);
            $this->db->bind(':id', $paymentId);
            $this->db->execute();

            // If linked to invoice, record payment
            if ($payment['invoice_id']) {
                $invoiceModel = new Invoice();
                $invoiceModel->recordPayment($payment['invoice_id'], [
                    'amount' => $payment['amount']
                ]);
            }

            // If linked to order, verify payment
            if ($payment['order_id']) {
                $orderModel = new Order();
                $orderModel->verifyPayment($payment['order_id'], $verifiedBy);
            }

            $this->db->commit();

            // Log activity
            Session::logActivity($payment['client_id'], 'payment_verified', 'Payment verified by admin', [
                'payment_reference' => $payment['payment_reference'],
                'amount' => $payment['amount']
            ]);

            // TODO: Send email notification to client

            return true;

        } catch (Exception $e) {
            $this->db->rollback();
            logError('Payment verification failed: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Reject payment (admin action)
     *
     * @param int $paymentId
     * @param int $rejectedBy Admin user ID
     * @param string $reason
     * @return bool
     */
    public function reject($paymentId, $rejectedBy, $reason) {
        try {
            $payment = $this->findById($paymentId);
            if (!$payment) {
                return false;
            }

            $this->db->query("
                UPDATE client_payments
                SET status = 'rejected',
                    verified_by = :rejected_by,
                    verified_at = NOW(),
                    notes = CONCAT(COALESCE(notes, ''), '\nRejection Reason: ', :reason),
                    updated_at = NOW()
                WHERE id = :id
            ");

            $this->db->bind(':rejected_by', $rejectedBy);
            $this->db->bind(':reason', $reason);
            $this->db->bind(':id', $paymentId);

            $success = $this->db->execute();

            if ($success) {
                Session::logActivity($payment['client_id'], 'payment_rejected', 'Payment rejected by admin', [
                    'payment_reference' => $payment['payment_reference'],
                    'reason' => $reason
                ]);

                // TODO: Send email notification to client
            }

            return $success;

        } catch (Exception $e) {
            logError('Payment rejection failed: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Process refund
     *
     * @param int $paymentId
     * @param float $refundAmount
     * @param int $processedBy Admin user ID
     * @param string $reason
     * @return bool
     */
    public function refund($paymentId, $refundAmount, $processedBy, $reason) {
        try {
            $this->db->beginTransaction();

            $payment = $this->findById($paymentId);
            if (!$payment) {
                throw new Exception('Payment not found');
            }

            if ($payment['status'] !== 'verified') {
                throw new Exception('Only verified payments can be refunded');
            }

            if ($refundAmount > $payment['amount']) {
                throw new Exception('Refund amount cannot exceed payment amount');
            }

            // Update payment status
            $this->db->query("
                UPDATE client_payments
                SET status = 'refunded',
                    refund_amount = :refund_amount,
                    refund_date = NOW(),
                    notes = CONCAT(COALESCE(notes, ''), '\nRefund Reason: ', :reason),
                    updated_at = NOW()
                WHERE id = :id
            ");

            $this->db->bind(':refund_amount', $refundAmount);
            $this->db->bind(':reason', $reason);
            $this->db->bind(':id', $paymentId);
            $this->db->execute();

            $this->db->commit();

            Session::logActivity($payment['client_id'], 'payment_refunded', 'Payment refunded', [
                'payment_reference' => $payment['payment_reference'],
                'amount' => $refundAmount,
                'reason' => $reason
            ]);

            // TODO: Send email notification to client

            return true;

        } catch (Exception $e) {
            $this->db->rollback();
            logError('Payment refund failed: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Generate unique payment reference
     *
     * @return string PAY-YYYYMMDD-XXXX
     */
    private function generatePaymentReference() {
        $date = date('Ymd');
        $prefix = "PAY-$date-";

        $this->db->query("
            SELECT COUNT(*) as count
            FROM client_payments
            WHERE payment_reference LIKE :prefix
        ");
        $this->db->bind(':prefix', $prefix . '%');
        $result = $this->db->single();

        $sequence = str_pad($result['count'] + 1, 4, '0', STR_PAD_LEFT);

        return $prefix . $sequence;
    }

    /**
     * Get payment statistics
     *
     * @return array
     */
    public function getStatistics() {
        // Total payments
        $this->db->query("SELECT COUNT(*) as total FROM client_payments");
        $total = $this->db->single()['total'];

        // By status
        $this->db->query("SELECT status, COUNT(*) as count FROM client_payments GROUP BY status");
        $byStatus = $this->db->resultSet();

        // Total verified amount
        $this->db->query("SELECT COALESCE(SUM(amount), 0) as total FROM client_payments WHERE status = 'verified'");
        $verifiedAmount = $this->db->single()['total'];

        // Pending verification count
        $this->db->query("SELECT COUNT(*) as count FROM client_payments WHERE status = 'pending'");
        $pendingCount = $this->db->single()['count'];

        // Total refunded amount
        $this->db->query("SELECT COALESCE(SUM(refund_amount), 0) as total FROM client_payments WHERE status = 'refunded'");
        $refundedAmount = $this->db->single()['total'];

        return [
            'total' => $total,
            'by_status' => $byStatus,
            'verified_amount' => $verifiedAmount,
            'pending_count' => $pendingCount,
            'refunded_amount' => $refundedAmount
        ];
    }

    /**
     * Get payment methods summary
     *
     * @return array
     */
    public function getPaymentMethodsSummary() {
        $this->db->query("
            SELECT
                payment_method,
                COUNT(*) as count,
                COALESCE(SUM(amount), 0) as total_amount
            FROM client_payments
            WHERE status = 'verified'
            GROUP BY payment_method
            ORDER BY total_amount DESC
        ");

        return $this->db->resultSet();
    }
}
