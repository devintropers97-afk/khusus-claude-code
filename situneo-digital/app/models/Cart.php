<?php
/**
 * Cart Model
 * Model untuk mengelola shopping cart
 *
 * Menyediakan cart management untuk session-based dan database-based cart
 */

class Cart {
    private $db;
    private $sessionKey = 'shopping_cart';

    public function __construct() {
        $this->db = Database::getInstance();

        // Initialize session cart if not exists
        if (!isset($_SESSION[$this->sessionKey])) {
            $_SESSION[$this->sessionKey] = [];
        }
    }

    /**
     * Add item to cart
     *
     * @param int $serviceId
     * @param array $options (quantity, type, months)
     * @return bool
     */
    public function add($serviceId, $options = []) {
        $serviceModel = new Service();
        $service = $serviceModel->findById($serviceId);

        if (!$service) {
            return false;
        }

        $quantity = $options['quantity'] ?? 1;
        $type = $options['type'] ?? 'beli'; // 'beli' or 'sewa'
        $months = $options['months'] ?? 1;

        // Calculate price
        $priceBreakdown = $serviceModel->calculatePrice($serviceId, $type, $months);

        if (!$priceBreakdown) {
            return false;
        }

        // Create cart item
        $item = [
            'service_id' => $serviceId,
            'service_name' => $service['name'],
            'service_code' => $service['service_code'],
            'service_slug' => $service['slug'],
            'quantity' => $quantity,
            'type' => $type,
            'months' => $months,
            'unit_price' => ($type === 'beli') ? $service['base_price'] : $service['monthly_price'],
            'setup_fee' => $service['setup_fee'],
            'subtotal' => $priceBreakdown['subtotal'],
            'total' => $priceBreakdown['total'],
            'added_at' => date('Y-m-d H:i:s')
        ];

        // If user is logged in, save to database
        if (Session::isLoggedIn()) {
            return $this->addToDatabase(Session::get('user_id'), $item);
        } else {
            // Save to session
            return $this->addToSession($item);
        }
    }

    /**
     * Add item to session cart
     *
     * @param array $item
     * @return bool
     */
    private function addToSession($item) {
        $cartId = $item['service_id'] . '_' . $item['type'];

        // Check if item already exists
        if (isset($_SESSION[$this->sessionKey][$cartId])) {
            // Update quantity
            $_SESSION[$this->sessionKey][$cartId]['quantity'] += $item['quantity'];
            $_SESSION[$this->sessionKey][$cartId]['subtotal'] = $_SESSION[$this->sessionKey][$cartId]['unit_price'] * $_SESSION[$this->sessionKey][$cartId]['quantity'];
            $_SESSION[$this->sessionKey][$cartId]['total'] = $_SESSION[$this->sessionKey][$cartId]['subtotal'] + $_SESSION[$this->sessionKey][$cartId]['setup_fee'];
        } else {
            $_SESSION[$this->sessionKey][$cartId] = $item;
        }

        return true;
    }

    /**
     * Add item to database cart
     *
     * @param int $clientId
     * @param array $item
     * @return bool
     */
    private function addToDatabase($clientId, $item) {
        try {
            // Check if item already exists in cart
            $this->db->query("
                SELECT id, quantity FROM shopping_cart
                WHERE client_id = :client_id
                    AND service_id = :service_id
                    AND order_type = :order_type
                    AND status = 'active'
            ");

            $this->db->bind(':client_id', $clientId);
            $this->db->bind(':service_id', $item['service_id']);
            $this->db->bind(':order_type', $item['type']);

            $existing = $this->db->single();

            if ($existing) {
                // Update quantity
                $newQuantity = $existing['quantity'] + $item['quantity'];
                $newSubtotal = $item['unit_price'] * $newQuantity;
                $newTotal = $newSubtotal + $item['setup_fee'];

                $this->db->query("
                    UPDATE shopping_cart
                    SET quantity = :quantity,
                        subtotal = :subtotal,
                        total = :total,
                        updated_at = NOW()
                    WHERE id = :id
                ");

                $this->db->bind(':quantity', $newQuantity);
                $this->db->bind(':subtotal', $newSubtotal);
                $this->db->bind(':total', $newTotal);
                $this->db->bind(':id', $existing['id']);

                return $this->db->execute();
            } else {
                // Insert new item
                $this->db->query("
                    INSERT INTO shopping_cart
                    (client_id, service_id, quantity, order_type, months, unit_price, setup_fee, subtotal, total, status)
                    VALUES
                    (:client_id, :service_id, :quantity, :order_type, :months, :unit_price, :setup_fee, :subtotal, :total, 'active')
                ");

                $this->db->bind(':client_id', $clientId);
                $this->db->bind(':service_id', $item['service_id']);
                $this->db->bind(':quantity', $item['quantity']);
                $this->db->bind(':order_type', $item['type']);
                $this->db->bind(':months', $item['months']);
                $this->db->bind(':unit_price', $item['unit_price']);
                $this->db->bind(':setup_fee', $item['setup_fee']);
                $this->db->bind(':subtotal', $item['subtotal']);
                $this->db->bind(':total', $item['total']);

                return $this->db->execute();
            }

        } catch (Exception $e) {
            logError('Failed to add item to cart: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Update cart item quantity
     *
     * @param string|int $itemId Cart ID or service_id for session
     * @param int $quantity
     * @return bool
     */
    public function updateQuantity($itemId, $quantity) {
        if ($quantity <= 0) {
            return $this->remove($itemId);
        }

        if (Session::isLoggedIn()) {
            return $this->updateDatabaseQuantity($itemId, $quantity);
        } else {
            return $this->updateSessionQuantity($itemId, $quantity);
        }
    }

    /**
     * Update session cart quantity
     *
     * @param string $cartId
     * @param int $quantity
     * @return bool
     */
    private function updateSessionQuantity($cartId, $quantity) {
        if (!isset($_SESSION[$this->sessionKey][$cartId])) {
            return false;
        }

        $_SESSION[$this->sessionKey][$cartId]['quantity'] = $quantity;
        $_SESSION[$this->sessionKey][$cartId]['subtotal'] = $_SESSION[$this->sessionKey][$cartId]['unit_price'] * $quantity;
        $_SESSION[$this->sessionKey][$cartId]['total'] = $_SESSION[$this->sessionKey][$cartId]['subtotal'] + $_SESSION[$this->sessionKey][$cartId]['setup_fee'];

        return true;
    }

    /**
     * Update database cart quantity
     *
     * @param int $cartId
     * @param int $quantity
     * @return bool
     */
    private function updateDatabaseQuantity($cartId, $quantity) {
        try {
            // Get current item
            $this->db->query("SELECT * FROM shopping_cart WHERE id = :id AND status = 'active'");
            $this->db->bind(':id', $cartId);
            $item = $this->db->single();

            if (!$item) {
                return false;
            }

            $newSubtotal = $item['unit_price'] * $quantity;
            $newTotal = $newSubtotal + $item['setup_fee'];

            $this->db->query("
                UPDATE shopping_cart
                SET quantity = :quantity,
                    subtotal = :subtotal,
                    total = :total,
                    updated_at = NOW()
                WHERE id = :id
            ");

            $this->db->bind(':quantity', $quantity);
            $this->db->bind(':subtotal', $newSubtotal);
            $this->db->bind(':total', $newTotal);
            $this->db->bind(':id', $cartId);

            return $this->db->execute();

        } catch (Exception $e) {
            logError('Failed to update cart quantity: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Remove item from cart
     *
     * @param string|int $itemId
     * @return bool
     */
    public function remove($itemId) {
        if (Session::isLoggedIn()) {
            return $this->removeFromDatabase($itemId);
        } else {
            return $this->removeFromSession($itemId);
        }
    }

    /**
     * Remove from session cart
     *
     * @param string $cartId
     * @return bool
     */
    private function removeFromSession($cartId) {
        if (isset($_SESSION[$this->sessionKey][$cartId])) {
            unset($_SESSION[$this->sessionKey][$cartId]);
            return true;
        }
        return false;
    }

    /**
     * Remove from database cart
     *
     * @param int $cartId
     * @return bool
     */
    private function removeFromDatabase($cartId) {
        try {
            $this->db->query("DELETE FROM shopping_cart WHERE id = :id");
            $this->db->bind(':id', $cartId);
            return $this->db->execute();

        } catch (Exception $e) {
            logError('Failed to remove cart item: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Get all cart items
     *
     * @return array
     */
    public function getItems() {
        if (Session::isLoggedIn()) {
            return $this->getDatabaseItems(Session::get('user_id'));
        } else {
            return $this->getSessionItems();
        }
    }

    /**
     * Get session cart items
     *
     * @return array
     */
    private function getSessionItems() {
        return array_values($_SESSION[$this->sessionKey]);
    }

    /**
     * Get database cart items
     *
     * @param int $clientId
     * @return array
     */
    private function getDatabaseItems($clientId) {
        $this->db->query("
            SELECT
                sc.*,
                s.name as service_name,
                s.service_code,
                s.slug as service_slug,
                s.short_description
            FROM shopping_cart sc
            JOIN services s ON sc.service_id = s.id
            WHERE sc.client_id = :client_id AND sc.status = 'active'
            ORDER BY sc.created_at DESC
        ");

        $this->db->bind(':client_id', $clientId);
        return $this->db->resultSet();
    }

    /**
     * Get cart count
     *
     * @return int
     */
    public function getCount() {
        $items = $this->getItems();
        $count = 0;

        foreach ($items as $item) {
            $count += $item['quantity'];
        }

        return $count;
    }

    /**
     * Get cart total
     *
     * @return array Total breakdown
     */
    public function getTotal() {
        $items = $this->getItems();

        $subtotal = 0;
        $setupFees = 0;
        $discount = 0; // TODO: Apply promo codes

        foreach ($items as $item) {
            $subtotal += $item['subtotal'];
            $setupFees += $item['setup_fee'];
        }

        $total = $subtotal + $setupFees - $discount;

        return [
            'subtotal' => $subtotal,
            'setup_fees' => $setupFees,
            'discount' => $discount,
            'total' => $total,
            'item_count' => count($items)
        ];
    }

    /**
     * Clear cart
     *
     * @return bool
     */
    public function clear() {
        if (Session::isLoggedIn()) {
            return $this->clearDatabase(Session::get('user_id'));
        } else {
            return $this->clearSession();
        }
    }

    /**
     * Clear session cart
     *
     * @return bool
     */
    private function clearSession() {
        $_SESSION[$this->sessionKey] = [];
        return true;
    }

    /**
     * Clear database cart
     *
     * @param int $clientId
     * @return bool
     */
    private function clearDatabase($clientId) {
        try {
            $this->db->query("DELETE FROM shopping_cart WHERE client_id = :client_id");
            $this->db->bind(':client_id', $clientId);
            return $this->db->execute();

        } catch (Exception $e) {
            logError('Failed to clear cart: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Migrate session cart to database when user logs in
     *
     * @param int $clientId
     * @return bool
     */
    public function migrateSessionToDatabase($clientId) {
        if (empty($_SESSION[$this->sessionKey])) {
            return true;
        }

        try {
            foreach ($_SESSION[$this->sessionKey] as $item) {
                $this->addToDatabase($clientId, $item);
            }

            // Clear session cart after migration
            $this->clearSession();

            return true;

        } catch (Exception $e) {
            logError('Cart migration failed: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Apply promo code to cart
     *
     * @param string $promoCode
     * @return array|false Discount details or false
     */
    public function applyPromoCode($promoCode) {
        $promoModel = new PromoCode();
        $promo = $promoModel->validateCode($promoCode);

        if (!$promo) {
            return false;
        }

        $cartTotal = $this->getTotal();

        // Calculate discount based on type
        $discount = 0;

        switch ($promo['discount_type']) {
            case 'percentage':
                $discount = $cartTotal['subtotal'] * ($promo['discount_value'] / 100);
                if ($promo['max_discount'] > 0 && $discount > $promo['max_discount']) {
                    $discount = $promo['max_discount'];
                }
                break;

            case 'fixed_amount':
                $discount = $promo['discount_value'];
                break;

            case 'free_shipping':
                $discount = $cartTotal['setup_fees'];
                break;
        }

        // Check minimum purchase
        if ($promo['min_purchase'] > 0 && $cartTotal['subtotal'] < $promo['min_purchase']) {
            return false;
        }

        // Store promo in session
        $_SESSION['applied_promo'] = [
            'code' => $promoCode,
            'promo_id' => $promo['id'],
            'discount_type' => $promo['discount_type'],
            'discount_value' => $promo['discount_value'],
            'discount_amount' => $discount
        ];

        return $_SESSION['applied_promo'];
    }

    /**
     * Remove applied promo code
     *
     * @return bool
     */
    public function removePromoCode() {
        if (isset($_SESSION['applied_promo'])) {
            unset($_SESSION['applied_promo']);
            return true;
        }
        return false;
    }

    /**
     * Get applied promo code
     *
     * @return array|null
     */
    public function getAppliedPromo() {
        return $_SESSION['applied_promo'] ?? null;
    }

    /**
     * Check if cart is empty
     *
     * @return bool
     */
    public function isEmpty() {
        return $this->getCount() === 0;
    }

    /**
     * Clean up expired cart items (database only)
     * Remove items older than 30 days
     *
     * @return int Number of items removed
     */
    public function cleanExpiredItems() {
        try {
            $this->db->query("
                DELETE FROM shopping_cart
                WHERE created_at < DATE_SUB(NOW(), INTERVAL 30 DAY)
                    AND status = 'active'
            ");

            return $this->db->rowCount();

        } catch (Exception $e) {
            logError('Failed to clean expired cart items: ' . $e->getMessage());
            return 0;
        }
    }
}
