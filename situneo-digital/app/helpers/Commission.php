<?php
/**
 * Commission Helper Class
 * Class untuk kalkulasi komisi multi-tier dan ARPU
 *
 * Sistem Komisi:
 * - Partner: 30% (Tier 1), 40% (Tier 2), 50% (Tier 3), 55% (Tier 4)
 * - SPV: 10% dari total penjualan partner yang dihandle
 * - Manager: 5% dari total penjualan team
 * - ARPU Bonus: Bonus tambahan berdasarkan revenue per client
 */

class Commission {
    private $db;

    // Commission rates (default)
    const PARTNER_TIER1 = 30.00;  // 0-10 Juta/bulan
    const PARTNER_TIER2 = 40.00;  // 10-25 Juta/bulan
    const PARTNER_TIER3 = 50.00;  // 25-50 Juta/bulan
    const PARTNER_TIER4 = 55.00;  // 50+ Juta/bulan
    const SPV_RATE = 10.00;
    const MANAGER_RATE = 5.00;

    // Tier thresholds (in Rupiah)
    const TIER1_MIN = 0;
    const TIER1_MAX = 10000000;    // 10 Juta
    const TIER2_MIN = 10000000;
    const TIER2_MAX = 25000000;    // 25 Juta
    const TIER3_MIN = 25000000;
    const TIER3_MAX = 50000000;    // 50 Juta
    const TIER4_MIN = 50000000;    // 50+ Juta

    public function __construct() {
        $this->db = Database::getInstance();
    }

    /**
     * Calculate partner commission dari order
     *
     * @param int $partnerId
     * @param float $orderAmount Base amount dari order
     * @param int $orderId Optional order ID
     * @return array Commission details
     */
    public function calculatePartnerCommission($partnerId, $orderAmount, $orderId = null) {
        // Get partner profile with tier info
        $partner = $this->getPartnerProfile($partnerId);

        if (!$partner) {
            throw new Exception('Partner not found');
        }

        // Get commission rate based on current tier
        $commissionRate = $this->getPartnerCommissionRate($partner['tier']);

        // Calculate commission amount
        $commissionAmount = ($orderAmount * $commissionRate) / 100;

        $result = [
            'partner_id' => $partnerId,
            'partner_code' => $partner['partner_code'],
            'tier' => $partner['tier'],
            'base_amount' => $orderAmount,
            'commission_rate' => $commissionRate,
            'commission_amount' => $commissionAmount,
            'order_id' => $orderId
        ];

        // Save commission to database
        if ($orderId) {
            $this->savePartnerCommission($result);
        }

        return $result;
    }

    /**
     * Calculate SPV commission dari partner sales
     *
     * @param int $spvId
     * @param int $partnerId
     * @param float $orderAmount
     * @param int $orderId
     * @return array Commission details
     */
    public function calculateSPVCommission($spvId, $partnerId, $orderAmount, $orderId = null) {
        // SPV gets 10% dari penjualan partner yang dia handle
        $commissionRate = self::SPV_RATE;
        $commissionAmount = ($orderAmount * $commissionRate) / 100;

        $result = [
            'spv_id' => $spvId,
            'partner_id' => $partnerId,
            'base_amount' => $orderAmount,
            'commission_rate' => $commissionRate,
            'commission_amount' => $commissionAmount,
            'order_id' => $orderId
        ];

        // Save to database
        if ($orderId) {
            $this->saveSPVCommission($result);
        }

        return $result;
    }

    /**
     * Calculate Manager commission
     *
     * @param int $managerId
     * @param float $orderAmount
     * @param int $orderId
     * @return array Commission details
     */
    public function calculateManagerCommission($managerId, $orderAmount, $orderId = null) {
        // Manager gets 5% dari total penjualan team
        $commissionRate = self::MANAGER_RATE;
        $commissionAmount = ($orderAmount * $commissionRate) / 100;

        $result = [
            'manager_id' => $managerId,
            'base_amount' => $orderAmount,
            'commission_rate' => $commissionRate,
            'commission_amount' => $commissionAmount,
            'order_id' => $orderId
        ];

        // Save to database
        if ($orderId) {
            $this->saveManagerCommission($result);
        }

        return $result;
    }

    /**
     * Calculate FULL commission chain untuk satu order
     * Partner → SPV → Manager
     *
     * @param int $partnerId
     * @param float $orderAmount
     * @param int $orderId
     * @return array All commissions
     */
    public function calculateFullCommissionChain($partnerId, $orderAmount, $orderId) {
        $commissions = [];

        // Get partner dengan SPV dan Manager info
        $partner = $this->getPartnerProfile($partnerId);

        if (!$partner) {
            throw new Exception('Partner not found');
        }

        // 1. Partner Commission
        $partnerCommission = $this->calculatePartnerCommission($partnerId, $orderAmount, $orderId);
        $commissions['partner'] = $partnerCommission;

        // 2. SPV Commission (jika ada SPV assigned)
        if ($partner['spv_id']) {
            $spvCommission = $this->calculateSPVCommission($partner['spv_id'], $partnerId, $orderAmount, $orderId);
            $commissions['spv'] = $spvCommission;
        }

        // 3. Manager Commission (jika ada manager assigned)
        if ($partner['manager_id']) {
            $managerCommission = $this->calculateManagerCommission($partner['manager_id'], $orderAmount, $orderId);
            $commissions['manager'] = $managerCommission;
        }

        // Total commission yang keluar
        $totalCommission = $partnerCommission['commission_amount'];
        if (isset($commissions['spv'])) {
            $totalCommission += $commissions['spv']['commission_amount'];
        }
        if (isset($commissions['manager'])) {
            $totalCommission += $commissions['manager']['commission_amount'];
        }

        $commissions['summary'] = [
            'order_amount' => $orderAmount,
            'total_commission' => $totalCommission,
            'net_revenue' => $orderAmount - $totalCommission,
            'commission_percentage' => ($totalCommission / $orderAmount) * 100
        ];

        return $commissions;
    }

    /**
     * Calculate ARPU (Average Revenue Per User) untuk partner
     *
     * @param int $partnerId
     * @param int $year
     * @param int $month
     * @return array ARPU data
     */
    public function calculateARPU($partnerId, $year, $month) {
        // Get total revenue dan active clients untuk bulan ini
        $this->db->query("
            SELECT
                COUNT(DISTINCT pc.client_id) as active_clients,
                COALESCE(SUM(o.total_amount), 0) as total_revenue
            FROM partner_clients pc
            LEFT JOIN orders o ON o.client_id = pc.client_id
                AND o.partner_id = :partner_id
                AND YEAR(o.created_at) = :year
                AND MONTH(o.created_at) = :month
                AND o.status = 'completed'
            WHERE pc.partner_id = :partner_id
                AND pc.status = 'active'
        ");

        $this->db->bind(':partner_id', $partnerId);
        $this->db->bind(':year', $year);
        $this->db->bind(':month', $month);

        $result = $this->db->single();

        $activeClients = $result['active_clients'];
        $totalRevenue = $result['total_revenue'];
        $arpu = $activeClients > 0 ? ($totalRevenue / $activeClients) : 0;

        // Calculate bonus based on ARPU
        $bonus = $this->calculateARPUBonus($arpu);

        $arpuData = [
            'partner_id' => $partnerId,
            'year' => $year,
            'month' => $month,
            'total_revenue' => $totalRevenue,
            'active_clients' => $activeClients,
            'arpu' => $arpu,
            'bonus_earned' => $bonus
        ];

        // Save ARPU tracking
        $this->saveARPUTracking($arpuData);

        return $arpuData;
    }

    /**
     * Calculate bonus berdasarkan ARPU
     * Semakin tinggi ARPU, semakin besar bonus
     *
     * @param float $arpu
     * @return float Bonus amount
     */
    private function calculateARPUBonus($arpu) {
        // ARPU Bonus Tiers (example):
        // Rp 1-5 Juta/client: 2% bonus
        // Rp 5-10 Juta/client: 5% bonus
        // Rp 10-20 Juta/client: 8% bonus
        // Rp 20+ Juta/client: 10% bonus

        if ($arpu >= 20000000) {
            return $arpu * 0.10; // 10% bonus
        } elseif ($arpu >= 10000000) {
            return $arpu * 0.08; // 8% bonus
        } elseif ($arpu >= 5000000) {
            return $arpu * 0.05; // 5% bonus
        } elseif ($arpu >= 1000000) {
            return $arpu * 0.02; // 2% bonus
        }

        return 0;
    }

    /**
     * Check dan update partner tier berdasarkan monthly sales
     *
     * @param int $partnerId
     * @param int $year
     * @param int $month
     * @return array Tier update info
     */
    public function checkAndUpdatePartnerTier($partnerId, $year, $month) {
        // Get total sales bulan ini
        $this->db->query("
            SELECT COALESCE(SUM(total_amount), 0) as total_sales
            FROM orders
            WHERE partner_id = :partner_id
                AND YEAR(created_at) = :year
                AND MONTH(created_at) = :month
                AND status = 'completed'
        ");

        $this->db->bind(':partner_id', $partnerId);
        $this->db->bind(':year', $year);
        $this->db->bind(':month', $month);

        $result = $this->db->single();
        $totalSales = $result['total_sales'];

        // Determine new tier
        $newTier = $this->determineT ierFromSales($totalSales);

        // Get current tier
        $partner = $this->getPartnerProfile($partnerId);
        $currentTier = $partner['tier'];

        // If tier changed, update it
        if ($newTier !== $currentTier) {
            $this->updatePartnerTier($partnerId, $newTier, $currentTier, $totalSales);

            return [
                'tier_changed' => true,
                'previous_tier' => $currentTier,
                'new_tier' => $newTier,
                'previous_rate' => $this->getPartnerCommissionRate($currentTier),
                'new_rate' => $this->getPartnerCommissionRate($newTier),
                'total_sales' => $totalSales
            ];
        }

        return [
            'tier_changed' => false,
            'current_tier' => $currentTier,
            'total_sales' => $totalSales
        ];
    }

    /**
     * Determine tier dari total sales
     *
     * @param float $totalSales
     * @return string Tier name
     */
    private function determineTierFromSales($totalSales) {
        if ($totalSales >= self::TIER4_MIN) {
            return 'tier4'; // 50+ Juta
        } elseif ($totalSales >= self::TIER3_MIN) {
            return 'tier3'; // 25-50 Juta
        } elseif ($totalSales >= self::TIER2_MIN) {
            return 'tier2'; // 10-25 Juta
        } else {
            return 'tier1'; // 0-10 Juta
        }
    }

    /**
     * Get commission rate based on tier
     *
     * @param string $tier
     * @return float Commission percentage
     */
    private function getPartnerCommissionRate($tier) {
        switch ($tier) {
            case 'tier4':
                return self::PARTNER_TIER4; // 55%
            case 'tier3':
                return self::PARTNER_TIER3; // 50%
            case 'tier2':
                return self::PARTNER_TIER2; // 40%
            case 'tier1':
            default:
                return self::PARTNER_TIER1; // 30%
        }
    }

    /**
     * Get partner profile dengan tier info
     *
     * @param int $partnerId
     * @return array|false
     */
    private function getPartnerProfile($partnerId) {
        $this->db->query("
            SELECT pp.*, u.email, u.first_name, u.last_name
            FROM partner_profiles pp
            JOIN users u ON pp.user_id = u.id
            WHERE pp.user_id = :partner_id
                AND pp.status = 'active'
        ");

        $this->db->bind(':partner_id', $partnerId);
        return $this->db->single();
    }

    /**
     * Save partner commission to database
     *
     * @param array $data
     * @return bool
     */
    private function savePartnerCommission($data) {
        try {
            $this->db->query("
                INSERT INTO partner_commissions
                (partner_id, order_id, commission_type, base_amount, commission_rate, commission_amount, status)
                VALUES
                (:partner_id, :order_id, 'direct_sale', :base_amount, :commission_rate, :commission_amount, 'pending')
            ");

            $this->db->bind(':partner_id', $data['partner_id']);
            $this->db->bind(':order_id', $data['order_id']);
            $this->db->bind(':base_amount', $data['base_amount']);
            $this->db->bind(':commission_rate', $data['commission_rate']);
            $this->db->bind(':commission_amount', $data['commission_amount']);

            return $this->db->execute();
        } catch (Exception $e) {
            logError('Failed to save partner commission: ' . $e->getMessage(), $data);
            return false;
        }
    }

    /**
     * Save SPV commission
     *
     * @param array $data
     * @return bool
     */
    private function saveSPVCommission($data) {
        try {
            $this->db->query("
                INSERT INTO spv_commissions
                (spv_id, partner_id, order_id, base_amount, commission_rate, commission_amount, status)
                VALUES
                (:spv_id, :partner_id, :order_id, :base_amount, :commission_rate, :commission_amount, 'pending')
            ");

            $this->db->bind(':spv_id', $data['spv_id']);
            $this->db->bind(':partner_id', $data['partner_id']);
            $this->db->bind(':order_id', $data['order_id']);
            $this->db->bind(':base_amount', $data['base_amount']);
            $this->db->bind(':commission_rate', $data['commission_rate']);
            $this->db->bind(':commission_amount', $data['commission_amount']);

            return $this->db->execute();
        } catch (Exception $e) {
            logError('Failed to save SPV commission: ' . $e->getMessage(), $data);
            return false;
        }
    }

    /**
     * Save Manager commission
     *
     * @param array $data
     * @return bool
     */
    private function saveManagerCommission($data) {
        try {
            $this->db->query("
                INSERT INTO manager_commissions
                (manager_id, order_id, base_amount, commission_rate, commission_amount, status)
                VALUES
                (:manager_id, :order_id, :base_amount, :commission_rate, :commission_amount, 'pending')
            ");

            $this->db->bind(':manager_id', $data['manager_id']);
            $this->db->bind(':order_id', $data['order_id']);
            $this->db->bind(':base_amount', $data['base_amount']);
            $this->db->bind(':commission_rate', $data['commission_rate']);
            $this->db->bind(':commission_amount', $data['commission_amount']);

            return $this->db->execute();
        } catch (Exception $e) {
            logError('Failed to save manager commission: ' . $e->getMessage(), $data);
            return false;
        }
    }

    /**
     * Save ARPU tracking data
     *
     * @param array $data
     * @return bool
     */
    private function saveARPUTracking($data) {
        try {
            $this->db->query("
                INSERT INTO partner_arpu_tracking
                (partner_id, year, month, total_revenue, active_clients, arpu, bonus_earned)
                VALUES
                (:partner_id, :year, :month, :total_revenue, :active_clients, :arpu, :bonus_earned)
                ON DUPLICATE KEY UPDATE
                    total_revenue = :total_revenue,
                    active_clients = :active_clients,
                    arpu = :arpu,
                    bonus_earned = :bonus_earned
            ");

            $this->db->bind(':partner_id', $data['partner_id']);
            $this->db->bind(':year', $data['year']);
            $this->db->bind(':month', $data['month']);
            $this->db->bind(':total_revenue', $data['total_revenue']);
            $this->db->bind(':active_clients', $data['active_clients']);
            $this->db->bind(':arpu', $data['arpu']);
            $this->db->bind(':bonus_earned', $data['bonus_earned']);

            return $this->db->execute();
        } catch (Exception $e) {
            logError('Failed to save ARPU tracking: ' . $e->getMessage(), $data);
            return false;
        }
    }

    /**
     * Update partner tier
     *
     * @param int $partnerId
     * @param string $newTier
     * @param string $currentTier
     * @param float $totalSales
     * @return bool
     */
    private function updatePartnerTier($partnerId, $newTier, $currentTier, $totalSales) {
        try {
            $this->db->beginTransaction();

            // Update tier di partner_profiles
            $this->db->query("
                UPDATE partner_profiles
                SET tier = :new_tier,
                    commission_rate = :new_rate
                WHERE user_id = :partner_id
            ");

            $this->db->bind(':new_tier', $newTier);
            $this->db->bind(':new_rate', $this->getPartnerCommissionRate($newTier));
            $this->db->bind(':partner_id', $partnerId);
            $this->db->execute();

            // Log tier change history
            $this->db->query("
                INSERT INTO partner_tier_history
                (partner_id, previous_tier, new_tier, previous_rate, new_rate, reason, effective_date)
                VALUES
                (:partner_id, :previous_tier, :new_tier, :previous_rate, :new_rate, :reason, CURDATE())
            ");

            $this->db->bind(':partner_id', $partnerId);
            $this->db->bind(':previous_tier', $currentTier);
            $this->db->bind(':new_tier', $newTier);
            $this->db->bind(':previous_rate', $this->getPartnerCommissionRate($currentTier));
            $this->db->bind(':new_rate', $this->getPartnerCommissionRate($newTier));
            $this->db->bind(':reason', "Tier upgraded based on monthly sales: " . rupiah($totalSales));
            $this->db->execute();

            $this->db->commit();
            return true;

        } catch (Exception $e) {
            $this->db->rollback();
            logError('Failed to update partner tier: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Get total pending commissions untuk partner
     *
     * @param int $partnerId
     * @return float Total pending amount
     */
    public function getPartnerPendingCommissions($partnerId) {
        $this->db->query("
            SELECT COALESCE(SUM(commission_amount), 0) as total
            FROM partner_commissions
            WHERE partner_id = :partner_id
                AND status = 'pending'
        ");

        $this->db->bind(':partner_id', $partnerId);
        $result = $this->db->single();

        return $result['total'];
    }

    /**
     * Get total paid commissions untuk partner
     *
     * @param int $partnerId
     * @param int $year Optional
     * @param int $month Optional
     * @return float Total paid amount
     */
    public function getPartnerPaidCommissions($partnerId, $year = null, $month = null) {
        $sql = "
            SELECT COALESCE(SUM(commission_amount), 0) as total
            FROM partner_commissions
            WHERE partner_id = :partner_id
                AND status = 'paid'
        ";

        if ($year) {
            $sql .= " AND YEAR(paid_at) = :year";
        }

        if ($month) {
            $sql .= " AND MONTH(paid_at) = :month";
        }

        $this->db->query($sql);
        $this->db->bind(':partner_id', $partnerId);

        if ($year) {
            $this->db->bind(':year', $year);
        }

        if ($month) {
            $this->db->bind(':month', $month);
        }

        $result = $this->db->single();
        return $result['total'];
    }
}
