<?php
/**
 * Review Controller
 * Mengelola service reviews dan ratings
 */

class ReviewController extends Controller {
    private $reviewModel;
    private $serviceModel;
    private $orderModel;

    public function __construct() {
        parent::__construct();

        if (!Session::isLoggedIn()) {
            redirect('/auth/login');
        }

        $this->reviewModel = new Review();
        $this->serviceModel = new Service();
        $this->orderModel = new Order();
    }

    /**
     * Display review form for a service
     *
     * @param int $serviceId
     * @param int|null $orderId
     */
    public function create($serviceId, $orderId = null) {
        $service = $this->serviceModel->findById($serviceId);

        if (!$service) {
            Session::setFlash('error', 'Service not found');
            redirect('/services');
        }

        $clientId = Session::get('user_id');

        // Check if client can review
        if (!$this->reviewModel->canReview($clientId, $serviceId, $orderId)) {
            Session::setFlash('error', 'You have already reviewed this service');
            redirect('/services/' . $service['slug']);
        }

        $order = null;
        if ($orderId) {
            $order = $this->orderModel->findById($orderId);
        }

        $data = [
            'title' => 'Write Review - ' . $service['name'],
            'service' => $service,
            'order' => $order
        ];

        $this->view('reviews/create', $data);
    }

    /**
     * Submit review
     */
    public function submit() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            redirect('/services');
        }

        // Validate CSRF token
        if (!validateCSRFToken($_POST['csrf_token'] ?? '')) {
            Session::setFlash('error', 'Invalid request');
            redirect('/services');
        }

        $serviceId = intval($_POST['service_id'] ?? 0);
        $orderId = !empty($_POST['order_id']) ? intval($_POST['order_id']) : null;
        $rating = intval($_POST['rating'] ?? 0);

        // Validate rating
        if ($rating < 1 || $rating > 5) {
            Session::setFlash('error', 'Invalid rating. Please select 1-5 stars.');
            redirect('/reviews/create/' . $serviceId . ($orderId ? '/' . $orderId : ''));
        }

        // Validate review text
        $reviewText = trim($_POST['review_text'] ?? '');
        if (empty($reviewText)) {
            Session::setFlash('error', 'Please write your review');
            redirect('/reviews/create/' . $serviceId . ($orderId ? '/' . $orderId : ''));
        }

        $clientId = Session::get('user_id');

        // Check if can review
        if (!$this->reviewModel->canReview($clientId, $serviceId, $orderId)) {
            Session::setFlash('error', 'You have already reviewed this service');
            redirect('/services');
        }

        // Create review
        $reviewData = [
            'service_id' => $serviceId,
            'client_id' => $clientId,
            'order_id' => $orderId,
            'rating' => $rating,
            'review_title' => trim($_POST['review_title'] ?? ''),
            'review_text' => $reviewText,
            'pros' => trim($_POST['pros'] ?? ''),
            'cons' => trim($_POST['cons'] ?? ''),
            'status' => 'pending' // Will be moderated by admin
        ];

        $reviewId = $this->reviewModel->create($reviewData);

        if ($reviewId) {
            Session::setFlash('success', 'Thank you for your review! It will be published after moderation.');

            // Get service for redirect
            $service = $this->serviceModel->findById($serviceId);
            redirect('/services/' . $service['slug']);
        } else {
            Session::setFlash('error', 'Failed to submit review. Please try again.');
            redirect('/reviews/create/' . $serviceId . ($orderId ? '/' . $orderId : ''));
        }
    }

    /**
     * Client's reviews list
     */
    public function myReviews() {
        $clientId = Session::get('user_id');
        $page = $_GET['page'] ?? 1;
        $perPage = 20;

        $result = $this->reviewModel->getByClient($clientId, $page, $perPage);

        $data = [
            'title' => 'My Reviews',
            'reviews' => $result['reviews'],
            'pagination' => [
                'current_page' => $result['page'],
                'total_pages' => $result['total_pages'],
                'total' => $result['total'],
                'per_page' => $result['per_page']
            ]
        ];

        $this->view('reviews/my-reviews', $data);
    }

    /**
     * Admin: List all reviews for moderation
     */
    public function adminList() {
        // Check admin/manager authorization
        $roleId = Session::get('role_id');
        if (!in_array($roleId, [1, 2])) {
            Session::setFlash('error', 'Unauthorized access');
            redirect('/dashboard');
        }

        $page = $_GET['page'] ?? 1;
        $perPage = 20;

        $filters = [
            'status' => $_GET['status'] ?? '',
            'rating' => $_GET['rating'] ?? '',
            'service_id' => $_GET['service_id'] ?? ''
        ];

        $result = $this->reviewModel->getAll($page, $perPage, $filters);

        $data = [
            'title' => 'Manage Reviews',
            'reviews' => $result['reviews'],
            'pagination' => [
                'current_page' => $result['page'],
                'total_pages' => $result['total_pages'],
                'total' => $result['total'],
                'per_page' => $result['per_page']
            ],
            'filters' => $filters
        ];

        $this->view('admin/reviews', $data);
    }

    /**
     * Admin: View review detail
     *
     * @param int $id
     */
    public function adminView($id) {
        // Check admin/manager authorization
        $roleId = Session::get('role_id');
        if (!in_array($roleId, [1, 2])) {
            Session::setFlash('error', 'Unauthorized access');
            redirect('/dashboard');
        }

        $review = $this->reviewModel->findById($id);

        if (!$review) {
            Session::setFlash('error', 'Review not found');
            redirect('/admin/reviews');
        }

        $data = [
            'title' => 'Review Detail',
            'review' => $review
        ];

        $this->view('admin/review-detail', $data);
    }

    /**
     * Admin: Approve review
     */
    public function approve() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            redirect('/admin/reviews');
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
            redirect('/admin/reviews');
        }

        $reviewId = intval($_POST['review_id'] ?? 0);
        $userId = Session::get('user_id');

        $success = $this->reviewModel->updateStatus($reviewId, 'approved', $userId);

        if ($success) {
            Session::setFlash('success', 'Review approved');
        } else {
            Session::setFlash('error', 'Failed to approve review');
        }

        redirect('/admin/reviews');
    }

    /**
     * Admin: Reject review
     */
    public function reject() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            redirect('/admin/reviews');
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
            redirect('/admin/reviews');
        }

        $reviewId = intval($_POST['review_id'] ?? 0);
        $userId = Session::get('user_id');

        $success = $this->reviewModel->updateStatus($reviewId, 'rejected', $userId);

        if ($success) {
            Session::setFlash('success', 'Review rejected');
        } else {
            Session::setFlash('error', 'Failed to reject review');
        }

        redirect('/admin/reviews');
    }

    /**
     * Admin: Add response to review
     */
    public function addResponse() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            redirect('/admin/reviews');
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
            redirect('/admin/reviews');
        }

        $reviewId = intval($_POST['review_id'] ?? 0);
        $response = trim($_POST['response'] ?? '');
        $userId = Session::get('user_id');

        if (empty($response)) {
            Session::setFlash('error', 'Response cannot be empty');
            redirect('/admin/reviews/view/' . $reviewId);
        }

        $success = $this->reviewModel->addResponse($reviewId, $response, $userId);

        if ($success) {
            Session::setFlash('success', 'Response added successfully');
        } else {
            Session::setFlash('error', 'Failed to add response');
        }

        redirect('/admin/reviews/view/' . $reviewId);
    }

    /**
     * Mark review as helpful
     *
     * @param int $id
     */
    public function markHelpful($id) {
        $success = $this->reviewModel->markHelpful($id);

        if ($success) {
            echo json_encode(['success' => true, 'message' => 'Marked as helpful']);
        } else {
            echo json_encode(['success' => false, 'message' => 'Failed to mark as helpful']);
        }
        exit;
    }
}
