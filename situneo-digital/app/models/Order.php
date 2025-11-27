<?php
/**
 * Order Model
 * Model untuk mengelola orders dan order processing
 *
 * Menyediakan order creation, tracking, dan commission calculation
 */

class Order {
    private $db;
    private $commission;

    public function __construct() {
        $this->db = Database::getInstance();
        $this->commission = new Commission();
    }

    /**
     * Create new order
     *
     * @param array $data Order data with items
     * @return int|false Order ID
     */
    public function create($data) {
        try {
            $this->db->beginTransaction();

            // Generate order number
            $orderNumber = $this->generateOrderNumber();

            // Calculate totals
            $subtotal = 0;
            foreach ($data['items'] as $item) {
                $subtotal += $item['total_price'];
            }

            $taxAmount = isset($data['tax_amount']) ? $data['tax_amount'] : 0;
            $discountAmount = isset($data['discount_amount']) ? $data['discount_amount'] : 0;
            $totalAmount = $subtotal + $taxAmount - $discountAmount;

            // Create order
            $this->db->query("
                INSERT INTO orders
                (order_number, client_id, partner_id, order_type, status, subtotal, tax_amount, discount_amount, total_amount, payment_status, notes)
                VALUES
                (:order_number, :client_id, :partner_id, :order_type, 'pending', :subtotal, :tax_amount, :discount_amount, :total_amount, 'unpaid', :notes)
            ");

            $this->db->bind(':order_number', $orderNumber);
            $this->db->bind(':client_id', $data['client_id']);
            $this->db->bind(':partner_id', $data['partner_id'] ?? null);
            $this->db->bind(':order_type', $data['order_type']);
            $this->db->bind(':subtotal', $subtotal);
            $this->db->bind(':tax_amount', $taxAmount);
            $this->db->bind(':discount_amount', $discountAmount);
            $this->db->bind(':total_amount', $totalAmount);
            $this->db->bind(':notes', $data['notes'] ?? null);

            $this->db->execute();
            $orderId = $this->db->lastInsertId();

            // Create order items
            foreach ($data['items'] as $item) {
                $this->db->query("
                    INSERT INTO order_items
                    (order_id, service_id, item_name, quantity, unit_price, total_price)
                    VALUES
                    (:order_id, :service_id, :item_name, :quantity, :unit_price, :total_price)
                ");

                $this->db->bind(':order_id', $orderId);
                $this->db->bind(':service_id', $item['service_id']);
                $this->db->bind(':item_name', $item['item_name']);
                $this->db->bind(':quantity', $item['quantity']);
                $this->db->bind(':unit_price', $item['unit_price']);
                $this->db->bind(':total_price', $item['total_price']);
                $this->db->execute();
            }

            // Log status
            $this->logStatus($orderId, 'pending', 'Order created', $data['client_id']);

            // If partner assigned, calculate commissions
            if (!empty($data['partner_id'])) {
                $this->commission->calculateFullCommissionChain($data['partner_id'], $totalAmount, $orderId);
            }

            $this->db->commit();

            // Log activity
            Session::logActivity($data['client_id'], 'order_created', "Order created: $orderNumber", [
                'order_id' => $orderId,
                'total_amount' => $totalAmount
            ]);

            return $orderId;

        } catch (Exception $e) {
            $this->db->rollback();
            logError('Order creation failed: ' . $e->getMessage(), $data);
            return false;
        }
    }

    /**
     * Get order by ID
     *
     * @param int $id
     * @return array|false
     */
    public function findById($id) {
        $this->db->query("
            SELECT
                o.*,
                c.first_name as client_first_name,
                c.last_name as client_last_name,
                c.email as client_email,
                p.first_name as partner_first_name,
                p.last_name as partner_last_name
            FROM orders o
            LEFT JOIN users c ON o.client_id = c.id
            LEFT JOIN users p ON o.partner_id = p.id
            WHERE o.id = :id
        ");

        $this->db->bind(':id', $id);
        return $this->db->single();
    }

    /**
     * Get order items
     *
     * @param int $orderId
     * @return array
     */
    public function getItems($orderId) {
        $this->db->query("
            SELECT
                oi.*,
                s.name as service_name,
                s.service_code
            FROM order_items oi
            LEFT JOIN services s ON oi.service_id = s.id
            WHERE oi.order_id = :order_id
        ");

        $this->db->bind(':order_id', $orderId);
        return $this->db->resultSet();
    }

    /**
     * Get orders with filters
     *
     * @param array $filters
     * @param int $page
     * @param int $perPage
     * @return array
     */
    public function getAll($filters = [], $page = 1, $perPage = 20) {
        $offset = ($page - 1) * $perPage;

        $where = ['1=1'];
        $params = [];

        if (!empty($filters['client_id'])) {
            $where[] = 'o.client_id = :client_id';
            $params[':client_id'] = $filters['client_id'];
        }

        if (!empty($filters['partner_id'])) {
            $where[] = 'o.partner_id = :partner_id';
            $params[':partner_id'] = $filters['partner_id'];
        }

        if (!empty($filters['status'])) {
            $where[] = 'o.status = :status';
            $params[':status'] = $filters['status'];
        }

        if (!empty($filters['payment_status'])) {
            $where[] = 'o.payment_status = :payment_status';
            $params[':payment_status'] = $filters['payment_status'];
        }

        if (!empty($filters['order_type'])) {
            $where[] = 'o.order_type = :order_type';
            $params[':order_type'] = $filters['order_type'];
        }

        $whereStr = implode(' AND ', $where);

        // Get total count
        $this->db->query("SELECT COUNT(*) as total FROM orders o WHERE $whereStr");
        foreach ($params as $param => $value) {
            $this->db->bind($param, $value);
        }
        $totalResult = $this->db->single();
        $total = $totalResult['total'];

        // Get orders
        $this->db->query("
            SELECT
                o.*,
                c.first_name as client_first_name,
                c.last_name as client_last_name,
                p.first_name as partner_first_name,
                p.last_name as partner_last_name,
                (SELECT COUNT(*) FROM order_items WHERE order_id = o.id) as items_count
            FROM orders o
            LEFT JOIN users c ON o.client_id = c.id
            LEFT JOIN users p ON o.partner_id = p.id
            WHERE $whereStr
            ORDER BY o.created_at DESC
            LIMIT :limit OFFSET :offset
        ");

        foreach ($params as $param => $value) {
            $this->db->bind($param, $value);
        }
        $this->db->bind(':limit', $perPage, PDO::PARAM_INT);
        $this->db->bind(':offset', $offset, PDO::PARAM_INT);

        $orders = $this->db->resultSet();

        return [
            'orders' => $orders,
            'total' => $total,
            'page' => $page,
            'per_page' => $perPage,
            'total_pages' => ceil($total / $perPage)
        ];
    }

    /**
     * Update order status
     *
     * @param int $orderId
     * @param string $status
     * @param string $notes
     * @param int $changedBy
     * @return bool
     */
    public function updateStatus($orderId, $status, $notes = '', $changedBy = null) {
        $allowedStatuses = ['pending', 'confirmed', 'processing', 'completed', 'cancelled'];

        if (!in_array($status, $allowedStatuses)) {
            return false;
        }

        try {
            $this->db->beginTransaction();

            // Update order status
            $this->db->query("UPDATE orders SET status = :status, updated_at = NOW() WHERE id = :id");
            $this->db->bind(':status', $status);
            $this->db->bind(':id', $orderId);
            $this->db->execute();

            // Log status change
            $this->logStatus($orderId, $status, $notes, $changedBy);

            // If completed, update payment commissions to 'approved'
            if ($status === 'completed') {
                $this->approveCommissions($orderId);
            }

            $this->db->commit();
            return true;

        } catch (Exception $e) {
            $this->db->rollback();
            logError('Order status update failed: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Update payment status
     *
     * @param int $orderId
     * @param string $paymentStatus
     * @return bool
     */
    public function updatePaymentStatus($orderId, $paymentStatus) {
        $allowedStatuses = ['unpaid', 'partial', 'paid', 'refunded'];

        if (!in_array($paymentStatus, $allowedStatuses)) {
            return false;
        }

        try {
            $this->db->query("UPDATE orders SET payment_status = :payment_status, updated_at = NOW() WHERE id = :id");
            $this->db->bind(':payment_status', $paymentStatus);
            $this->db->bind(':id', $orderId);

            return $this->db->execute();

        } catch (Exception $e) {
            logError('Payment status update failed: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Cancel order
     *
     * @param int $orderId
     * @param string $reason
     * @param int $cancelledBy
     * @return bool
     */
    public function cancel($orderId, $reason = '', $cancelledBy = null) {
        return $this->updateStatus($orderId, 'cancelled', "Cancelled: $reason", $cancelledBy);
    }

    /**
     * Log order status change
     *
     * @param int $orderId
     * @param string $status
     * @param string $notes
     * @param int $changedBy
     * @return bool
     */
    private function logStatus($orderId, $status, $notes = '', $changedBy = null) {
        try {
            $this->db->query("
                INSERT INTO order_status_history
                (order_id, status, notes, changed_by)
                VALUES
                (:order_id, :status, :notes, :changed_by)
            ");

            $this->db->bind(':order_id', $orderId);
            $this->db->bind(':status', $status);
            $this->db->bind(':notes', $notes);
            $this->db->bind(':changed_by', $changedBy);

            return $this->db->execute();

        } catch (Exception $e) {
            logError('Status logging failed: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Approve commissions when order is completed
     *
     * @param int $orderId
     * @return void
     */
    private function approveCommissions($orderId) {
        try {
            // Update partner commissions
            $this->db->query("UPDATE partner_commissions SET status = 'approved' WHERE order_id = :order_id");
            $this->db->bind(':order_id', $orderId);
            $this->db->execute();

            // Update SPV commissions
            $this->db->query("UPDATE spv_commissions SET status = 'approved' WHERE order_id = :order_id");
            $this->db->bind(':order_id', $orderId);
            $this->db->execute();

            // Update Manager commissions
            $this->db->query("UPDATE manager_commissions SET status = 'approved' WHERE order_id = :order_id");
            $this->db->bind(':order_id', $orderId);
            $this->db->execute();

        } catch (Exception $e) {
            logError('Commission approval failed: ' . $e->getMessage());
        }
    }

    /**
     * Generate order number
     *
     * @return string ORD-YYYYMMDD-XXXX
     */
    private function generateOrderNumber() {
        $date = date('Ymd');
        $prefix = "ORD-$date-";

        $this->db->query("SELECT COUNT(*) as count FROM orders WHERE order_number LIKE :prefix");
        $this->db->bind(':prefix', $prefix . '%');
        $result = $this->db->single();

        $sequence = str_pad($result['count'] + 1, 4, '0', STR_PAD_LEFT);
        return $prefix . $sequence;
    }

    /**
     * Get order statistics
     *
     * @param array $filters
     * @return array
     */
    public function getStatistics($filters = []) {
        $where = ['1=1'];
        $params = [];

        if (!empty($filters['partner_id'])) {
            $where[] = 'partner_id = :partner_id';
            $params[':partner_id'] = $filters['partner_id'];
        }

        if (!empty($filters['client_id'])) {
            $where[] = 'client_id = :client_id';
            $params[':client_id'] = $filters['client_id'];
        }

        $whereStr = implode(' AND ', $where);

        // Total orders
        $this->db->query("SELECT COUNT(*) as count, COALESCE(SUM(total_amount), 0) as total
                         FROM orders WHERE $whereStr");
        foreach ($params as $param => $value) {
            $this->db->bind($param, $value);
        }
        $totals = $this->db->single();

        // By status
        $this->db->query("SELECT status, COUNT(*) as count FROM orders WHERE $whereStr GROUP BY status");
        foreach ($params as $param => $value) {
            $this->db->bind($param, $value);
        }
        $byStatus = $this->db->resultSet();

        // This month
        $this->db->query("SELECT COUNT(*) as count, COALESCE(SUM(total_amount), 0) as total
                         FROM orders
                         WHERE $whereStr
                         AND YEAR(created_at) = YEAR(CURDATE())
                         AND MONTH(created_at) = MONTH(CURDATE())");
        foreach ($params as $param => $value) {
            $this->db->bind($param, $value);
        }
        $thisMonth = $this->db->single();

        return [
            'total_orders' => $totals['count'],
            'total_revenue' => $totals['total'],
            'by_status' => $byStatus,
            'this_month_orders' => $thisMonth['count'],
            'this_month_revenue' => $thisMonth['total']
        ];
    }

    /**
     * Get order status history
     *
     * @param int $orderId
     * @return array
     */
    public function getStatusHistory($orderId) {
        $this->db->query("
            SELECT
                osh.*,
                u.first_name,
                u.last_name
            FROM order_status_history osh
            LEFT JOIN users u ON osh.changed_by = u.id
            WHERE osh.order_id = :order_id
            ORDER BY osh.created_at DESC
        ");

        $this->db->bind(':order_id', $orderId);
        return $this->db->resultSet();
    }
}
