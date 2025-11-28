<?php
/**
 * Review Model
 * Model untuk mengelola service reviews dan ratings
 *
 * Menyediakan review creation, moderation, dan rating aggregation
 */

class Review {
    private $db;

    public function __construct() {
        $this->db = Database::getInstance();
    }

    /**
     * Create new review
     *
     * @param array $data Review data
     * @return int|false Review ID
     */
    public function create($data) {
        try {
            $this->db->beginTransaction();

            $this->db->query("
                INSERT INTO service_reviews
                (service_id, client_id, order_id, rating, review_title, review_text,
                 pros, cons, status)
                VALUES
                (:service_id, :client_id, :order_id, :rating, :review_title, :review_text,
                 :pros, :cons, :status)
            ");

            $this->db->bind(':service_id', $data['service_id']);
            $this->db->bind(':client_id', $data['client_id']);
            $this->db->bind(':order_id', $data['order_id'] ?? null);
            $this->db->bind(':rating', $data['rating']);
            $this->db->bind(':review_title', $data['review_title'] ?? null);
            $this->db->bind(':review_text', $data['review_text']);
            $this->db->bind(':pros', $data['pros'] ?? null);
            $this->db->bind(':cons', $data['cons'] ?? null);
            $this->db->bind(':status', $data['status'] ?? 'pending');

            $this->db->execute();
            $reviewId = $this->db->lastInsertId();

            // Update service rating statistics
            $this->updateServiceRating($data['service_id']);

            $this->db->commit();

            Session::logActivity($data['client_id'], 'review_submitted', 'Review submitted for service', [
                'service_id' => $data['service_id'],
                'rating' => $data['rating']
            ]);

            return $reviewId;

        } catch (Exception $e) {
            $this->db->rollback();
            logError('Review creation failed: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Find review by ID
     *
     * @param int $id
     * @return array|false
     */
    public function findById($id) {
        $this->db->query("
            SELECT
                sr.*,
                u.first_name, u.last_name,
                cp.company_name,
                s.name as service_name, s.service_code,
                o.order_number
            FROM service_reviews sr
            JOIN users u ON sr.client_id = u.id
            LEFT JOIN client_profiles cp ON u.id = cp.user_id
            JOIN services s ON sr.service_id = s.id
            LEFT JOIN orders o ON sr.order_id = o.id
            WHERE sr.id = :id
        ");

        $this->db->bind(':id', $id);
        return $this->db->single();
    }

    /**
     * Get reviews for a service
     *
     * @param int $serviceId
     * @param int $page
     * @param int $perPage
     * @param array $filters
     * @return array
     */
    public function getByService($serviceId, $page = 1, $perPage = 10, $filters = []) {
        $offset = ($page - 1) * $perPage;

        $where = ['sr.service_id = :service_id', 'sr.status = \'approved\''];
        $params = [':service_id' => $serviceId];

        if (!empty($filters['rating'])) {
            $where[] = 'sr.rating = :rating';
            $params[':rating'] = $filters['rating'];
        }

        $whereStr = implode(' AND ', $where);

        // Get total count
        $this->db->query("SELECT COUNT(*) as total FROM service_reviews sr WHERE $whereStr");
        foreach ($params as $param => $value) {
            $this->db->bind($param, $value);
        }
        $totalResult = $this->db->single();
        $total = $totalResult['total'];

        // Get reviews
        $this->db->query("
            SELECT
                sr.*,
                u.first_name, u.last_name,
                cp.company_name
            FROM service_reviews sr
            JOIN users u ON sr.client_id = u.id
            LEFT JOIN client_profiles cp ON u.id = cp.user_id
            WHERE $whereStr
            ORDER BY sr.created_at DESC
            LIMIT :limit OFFSET :offset
        ");

        foreach ($params as $param => $value) {
            $this->db->bind($param, $value);
        }
        $this->db->bind(':limit', $perPage, PDO::PARAM_INT);
        $this->db->bind(':offset', $offset, PDO::PARAM_INT);

        $reviews = $this->db->resultSet();

        return [
            'reviews' => $reviews,
            'total' => $total,
            'page' => $page,
            'per_page' => $perPage,
            'total_pages' => ceil($total / $perPage)
        ];
    }

    /**
     * Get reviews by client
     *
     * @param int $clientId
     * @param int $page
     * @param int $perPage
     * @return array
     */
    public function getByClient($clientId, $page = 1, $perPage = 20) {
        $offset = ($page - 1) * $perPage;

        // Get total count
        $this->db->query("SELECT COUNT(*) as total FROM service_reviews WHERE client_id = :client_id");
        $this->db->bind(':client_id', $clientId);
        $totalResult = $this->db->single();
        $total = $totalResult['total'];

        // Get reviews
        $this->db->query("
            SELECT
                sr.*,
                s.name as service_name, s.service_code, s.slug as service_slug
            FROM service_reviews sr
            JOIN services s ON sr.service_id = s.id
            WHERE sr.client_id = :client_id
            ORDER BY sr.created_at DESC
            LIMIT :limit OFFSET :offset
        ");

        $this->db->bind(':client_id', $clientId);
        $this->db->bind(':limit', $perPage, PDO::PARAM_INT);
        $this->db->bind(':offset', $offset, PDO::PARAM_INT);

        $reviews = $this->db->resultSet();

        return [
            'reviews' => $reviews,
            'total' => $total,
            'page' => $page,
            'per_page' => $perPage,
            'total_pages' => ceil($total / $perPage)
        ];
    }

    /**
     * Get all reviews (admin view)
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
            $where[] = 'sr.status = :status';
            $params[':status'] = $filters['status'];
        }

        if (!empty($filters['rating'])) {
            $where[] = 'sr.rating = :rating';
            $params[':rating'] = $filters['rating'];
        }

        if (!empty($filters['service_id'])) {
            $where[] = 'sr.service_id = :service_id';
            $params[':service_id'] = $filters['service_id'];
        }

        $whereStr = implode(' AND ', $where);

        // Get total count
        $this->db->query("SELECT COUNT(*) as total FROM service_reviews sr WHERE $whereStr");
        foreach ($params as $param => $value) {
            $this->db->bind($param, $value);
        }
        $totalResult = $this->db->single();
        $total = $totalResult['total'];

        // Get reviews
        $this->db->query("
            SELECT
                sr.*,
                u.first_name, u.last_name,
                cp.company_name,
                s.name as service_name, s.service_code
            FROM service_reviews sr
            JOIN users u ON sr.client_id = u.id
            LEFT JOIN client_profiles cp ON u.id = cp.user_id
            JOIN services s ON sr.service_id = s.id
            WHERE $whereStr
            ORDER BY sr.created_at DESC
            LIMIT :limit OFFSET :offset
        ");

        foreach ($params as $param => $value) {
            $this->db->bind($param, $value);
        }
        $this->db->bind(':limit', $perPage, PDO::PARAM_INT);
        $this->db->bind(':offset', $offset, PDO::PARAM_INT);

        $reviews = $this->db->resultSet();

        return [
            'reviews' => $reviews,
            'total' => $total,
            'page' => $page,
            'per_page' => $perPage,
            'total_pages' => ceil($total / $perPage)
        ];
    }

    /**
     * Update review status (approve/reject)
     *
     * @param int $id
     * @param string $status
     * @param int $moderatedBy Admin user ID
     * @return bool
     */
    public function updateStatus($id, $status, $moderatedBy) {
        $allowedStatuses = ['approved', 'rejected', 'pending'];

        if (!in_array($status, $allowedStatuses)) {
            return false;
        }

        try {
            $this->db->beginTransaction();

            $this->db->query("
                UPDATE service_reviews
                SET status = :status,
                    moderated_by = :moderated_by,
                    moderated_at = NOW()
                WHERE id = :id
            ");

            $this->db->bind(':status', $status);
            $this->db->bind(':moderated_by', $moderatedBy);
            $this->db->bind(':id', $id);

            $this->db->execute();

            // Update service rating if approved/rejected
            $review = $this->findById($id);
            if ($review) {
                $this->updateServiceRating($review['service_id']);
            }

            $this->db->commit();

            return true;

        } catch (Exception $e) {
            $this->db->rollback();
            logError('Review status update failed: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Update service rating statistics
     *
     * @param int $serviceId
     * @return bool
     */
    private function updateServiceRating($serviceId) {
        try {
            // Calculate average rating from approved reviews
            $this->db->query("
                SELECT
                    COUNT(*) as review_count,
                    AVG(rating) as avg_rating,
                    SUM(CASE WHEN rating = 5 THEN 1 ELSE 0 END) as rating_5,
                    SUM(CASE WHEN rating = 4 THEN 1 ELSE 0 END) as rating_4,
                    SUM(CASE WHEN rating = 3 THEN 1 ELSE 0 END) as rating_3,
                    SUM(CASE WHEN rating = 2 THEN 1 ELSE 0 END) as rating_2,
                    SUM(CASE WHEN rating = 1 THEN 1 ELSE 0 END) as rating_1
                FROM service_reviews
                WHERE service_id = :service_id AND status = 'approved'
            ");

            $this->db->bind(':service_id', $serviceId);
            $stats = $this->db->single();

            // Update service rating stats
            $this->db->query("
                UPDATE services
                SET rating = :rating,
                    review_count = :review_count
                WHERE id = :id
            ");

            $this->db->bind(':rating', round($stats['avg_rating'], 2));
            $this->db->bind(':review_count', $stats['review_count']);
            $this->db->bind(':id', $serviceId);

            return $this->db->execute();

        } catch (Exception $e) {
            logError('Failed to update service rating: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Get service rating breakdown
     *
     * @param int $serviceId
     * @return array
     */
    public function getServiceRatingBreakdown($serviceId) {
        $this->db->query("
            SELECT
                COUNT(*) as total_reviews,
                AVG(rating) as avg_rating,
                SUM(CASE WHEN rating = 5 THEN 1 ELSE 0 END) as rating_5,
                SUM(CASE WHEN rating = 4 THEN 1 ELSE 0 END) as rating_4,
                SUM(CASE WHEN rating = 3 THEN 1 ELSE 0 END) as rating_3,
                SUM(CASE WHEN rating = 2 THEN 1 ELSE 0 END) as rating_2,
                SUM(CASE WHEN rating = 1 THEN 1 ELSE 0 END) as rating_1
            FROM service_reviews
            WHERE service_id = :service_id AND status = 'approved'
        ");

        $this->db->bind(':service_id', $serviceId);
        $stats = $this->db->single();

        if ($stats['total_reviews'] > 0) {
            $stats['rating_5_percent'] = ($stats['rating_5'] / $stats['total_reviews']) * 100;
            $stats['rating_4_percent'] = ($stats['rating_4'] / $stats['total_reviews']) * 100;
            $stats['rating_3_percent'] = ($stats['rating_3'] / $stats['total_reviews']) * 100;
            $stats['rating_2_percent'] = ($stats['rating_2'] / $stats['total_reviews']) * 100;
            $stats['rating_1_percent'] = ($stats['rating_1'] / $stats['total_reviews']) * 100;
        } else {
            $stats['rating_5_percent'] = 0;
            $stats['rating_4_percent'] = 0;
            $stats['rating_3_percent'] = 0;
            $stats['rating_2_percent'] = 0;
            $stats['rating_1_percent'] = 0;
        }

        return $stats;
    }

    /**
     * Check if client can review service
     *
     * @param int $clientId
     * @param int $serviceId
     * @param int|null $orderId
     * @return bool
     */
    public function canReview($clientId, $serviceId, $orderId = null) {
        // Check if client has already reviewed this service
        $this->db->query("
            SELECT COUNT(*) as count
            FROM service_reviews
            WHERE client_id = :client_id
                AND service_id = :service_id
                " . ($orderId ? "AND order_id = :order_id" : "") . "
        ");

        $this->db->bind(':client_id', $clientId);
        $this->db->bind(':service_id', $serviceId);

        if ($orderId) {
            $this->db->bind(':order_id', $orderId);
        }

        $result = $this->db->single();

        return $result['count'] == 0;
    }

    /**
     * Add admin response to review
     *
     * @param int $reviewId
     * @param string $response
     * @param int $respondedBy Admin user ID
     * @return bool
     */
    public function addResponse($reviewId, $response, $respondedBy) {
        try {
            $this->db->query("
                UPDATE service_reviews
                SET admin_response = :response,
                    responded_by = :responded_by,
                    responded_at = NOW()
                WHERE id = :id
            ");

            $this->db->bind(':response', $response);
            $this->db->bind(':responded_by', $respondedBy);
            $this->db->bind(':id', $reviewId);

            return $this->db->execute();

        } catch (Exception $e) {
            logError('Failed to add review response: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Mark review as helpful
     *
     * @param int $reviewId
     * @return bool
     */
    public function markHelpful($reviewId) {
        try {
            $this->db->query("
                UPDATE service_reviews
                SET helpful_count = helpful_count + 1
                WHERE id = :id
            ");

            $this->db->bind(':id', $reviewId);
            return $this->db->execute();

        } catch (Exception $e) {
            logError('Failed to mark review as helpful: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Get recent reviews
     *
     * @param int $limit
     * @return array
     */
    public function getRecent($limit = 10) {
        $this->db->query("
            SELECT
                sr.*,
                u.first_name, u.last_name,
                s.name as service_name, s.slug as service_slug
            FROM service_reviews sr
            JOIN users u ON sr.client_id = u.id
            JOIN services s ON sr.service_id = s.id
            WHERE sr.status = 'approved'
            ORDER BY sr.created_at DESC
            LIMIT :limit
        ");

        $this->db->bind(':limit', $limit, PDO::PARAM_INT);
        return $this->db->resultSet();
    }

    /**
     * Get review statistics
     *
     * @return array
     */
    public function getStatistics() {
        // Total reviews
        $this->db->query("SELECT COUNT(*) as total FROM service_reviews");
        $total = $this->db->single()['total'];

        // By status
        $this->db->query("SELECT status, COUNT(*) as count FROM service_reviews GROUP BY status");
        $byStatus = $this->db->resultSet();

        // Average rating
        $this->db->query("SELECT AVG(rating) as avg FROM service_reviews WHERE status = 'approved'");
        $avgRating = $this->db->single()['avg'];

        // Pending moderation
        $this->db->query("SELECT COUNT(*) as count FROM service_reviews WHERE status = 'pending'");
        $pending = $this->db->single()['count'];

        return [
            'total' => $total,
            'by_status' => $byStatus,
            'avg_rating' => round($avgRating, 2),
            'pending_moderation' => $pending
        ];
    }
}
