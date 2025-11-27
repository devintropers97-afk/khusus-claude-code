<?php
/**
 * Session Helper Class
 * Class untuk mengelola session dan flash messages
 *
 * Menyediakan fungsi untuk login, logout, dan session management
 */

class Session {
    /**
     * Start session jika belum dimulai
     *
     * @return void
     */
    public static function start() {
        if (session_status() === PHP_SESSION_NONE) {
            session_start();
        }
    }

    /**
     * Set session value
     *
     * @param string $key
     * @param mixed $value
     * @return void
     */
    public static function set($key, $value) {
        self::start();
        $_SESSION[$key] = $value;
    }

    /**
     * Get session value
     *
     * @param string $key
     * @param mixed $default Default value jika key tidak ada
     * @return mixed
     */
    public static function get($key, $default = null) {
        self::start();
        return isset($_SESSION[$key]) ? $_SESSION[$key] : $default;
    }

    /**
     * Check if session key exists
     *
     * @param string $key
     * @return bool
     */
    public static function has($key) {
        self::start();
        return isset($_SESSION[$key]);
    }

    /**
     * Remove session key
     *
     * @param string $key
     * @return void
     */
    public static function remove($key) {
        self::start();
        if (isset($_SESSION[$key])) {
            unset($_SESSION[$key]);
        }
    }

    /**
     * Destroy all session data
     *
     * @return void
     */
    public static function destroy() {
        self::start();
        session_unset();
        session_destroy();
    }

    /**
     * Set flash message (message yang hanya tampil sekali)
     *
     * @param string $type success, error, warning, info
     * @param string $message
     * @return void
     */
    public static function flash($type, $message) {
        self::set('flash', [
            'type' => $type,
            'message' => $message
        ]);
    }

    /**
     * Get and remove flash message
     *
     * @return array|null ['type' => 'success', 'message' => 'Text']
     */
    public static function getFlash() {
        self::start();
        if (isset($_SESSION['flash'])) {
            $flash = $_SESSION['flash'];
            unset($_SESSION['flash']);
            return $flash;
        }
        return null;
    }

    /**
     * Check if flash message exists
     *
     * @return bool
     */
    public static function hasFlash() {
        self::start();
        return isset($_SESSION['flash']);
    }

    /**
     * Display flash message HTML
     *
     * @return string HTML untuk flash message
     */
    public static function displayFlash() {
        $flash = self::getFlash();
        if (!$flash) {
            return '';
        }

        $type = $flash['type'];
        $message = $flash['message'];

        // Bootstrap alert class mapping
        $alertClass = [
            'success' => 'alert-success',
            'error' => 'alert-danger',
            'warning' => 'alert-warning',
            'info' => 'alert-info'
        ];

        $class = isset($alertClass[$type]) ? $alertClass[$type] : 'alert-info';

        return "
        <div class='alert $class alert-dismissible fade show' role='alert'>
            $message
            <button type='button' class='btn-close' data-bs-dismiss='alert'></button>
        </div>
        ";
    }

    /**
     * Login user - set session dan update database
     *
     * @param array $user User data dari database
     * @return void
     */
    public static function login($user) {
        self::start();

        // Regenerate session ID untuk security
        session_regenerate_id(true);

        // Set session data
        self::set('user_id', $user['id']);
        self::set('user_email', $user['email']);
        self::set('user_name', $user['first_name'] . ' ' . $user['last_name']);
        self::set('user_role', $user['role_id']);
        self::set('logged_in', true);

        // Update last login di database
        $db = Database::getInstance();
        $db->query("UPDATE users SET last_login_at = NOW() WHERE id = :id");
        $db->bind(':id', $user['id']);
        $db->execute();

        // Log login activity
        self::logActivity($user['id'], 'login', 'User logged in');
    }

    /**
     * Logout user
     *
     * @return void
     */
    public static function logout() {
        $userId = self::get('user_id');

        // Log logout activity
        if ($userId) {
            self::logActivity($userId, 'logout', 'User logged out');
        }

        // Destroy session
        self::destroy();
    }

    /**
     * Check if user is logged in
     *
     * @return bool
     */
    public static function isLoggedIn() {
        self::start();
        return self::get('logged_in', false) === true;
    }

    /**
     * Get current user ID
     *
     * @return int|null
     */
    public static function getUserId() {
        return self::get('user_id');
    }

    /**
     * Get current user role
     *
     * @return int|null
     */
    public static function getUserRole() {
        return self::get('user_role');
    }

    /**
     * Get current user name
     *
     * @return string|null
     */
    public static function getUserName() {
        return self::get('user_name');
    }

    /**
     * Require login - redirect jika belum login
     *
     * @return void
     */
    public static function requireLogin() {
        if (!self::isLoggedIn()) {
            self::flash('error', 'Silakan login terlebih dahulu.');
            redirect(url('login.php'));
        }
    }

    /**
     * Require specific role - redirect jika role tidak sesuai
     *
     * @param int|array $allowedRoles Role ID atau array of role IDs
     * @return void
     */
    public static function requireRole($allowedRoles) {
        self::requireLogin();

        $userRole = self::getUserRole();
        $allowedRoles = is_array($allowedRoles) ? $allowedRoles : [$allowedRoles];

        if (!in_array($userRole, $allowedRoles)) {
            self::flash('error', 'Anda tidak memiliki akses ke halaman ini.');
            redirect(url('dashboard.php'));
        }
    }

    /**
     * Require guest - redirect jika sudah login
     *
     * @return void
     */
    public static function requireGuest() {
        if (self::isLoggedIn()) {
            redirect(url('dashboard.php'));
        }
    }

    /**
     * Get current user data dari database
     *
     * @return array|false
     */
    public static function getCurrentUser() {
        if (!self::isLoggedIn()) {
            return false;
        }

        $userId = self::getUserId();
        $db = Database::getInstance();

        $db->query("SELECT u.*, r.name as role_name
                    FROM users u
                    LEFT JOIN roles r ON u.role_id = r.id
                    WHERE u.id = :id AND u.deleted_at IS NULL");
        $db->bind(':id', $userId);

        return $db->single();
    }

    /**
     * Log user activity
     *
     * @param int $userId
     * @param string $action
     * @param string $description
     * @param array $metadata Optional additional data
     * @return bool
     */
    public static function logActivity($userId, $action, $description, $metadata = []) {
        try {
            $db = Database::getInstance();

            $ipAddress = $_SERVER['REMOTE_ADDR'] ?? null;
            $userAgent = $_SERVER['HTTP_USER_AGENT'] ?? null;
            $metadataJson = !empty($metadata) ? json_encode($metadata) : null;

            $db->query("INSERT INTO activity_logs (user_id, action, description, ip_address, user_agent, metadata)
                        VALUES (:user_id, :action, :description, :ip_address, :user_agent, :metadata)");
            $db->bind(':user_id', $userId);
            $db->bind(':action', $action);
            $db->bind(':description', $description);
            $db->bind(':ip_address', $ipAddress);
            $db->bind(':user_agent', $userAgent);
            $db->bind(':metadata', $metadataJson);

            return $db->execute();

        } catch (Exception $e) {
            logError('Failed to log activity: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Store old input (untuk form validation error)
     *
     * @param array $data
     * @return void
     */
    public static function setOldInput($data) {
        self::set('old_input', $data);
    }

    /**
     * Get old input value
     *
     * @param string $key
     * @param string $default
     * @return string
     */
    public static function old($key, $default = '') {
        self::start();
        $oldInput = self::get('old_input', []);
        $value = isset($oldInput[$key]) ? $oldInput[$key] : $default;

        // Remove old input after retrieval
        if (isset($_SESSION['old_input'])) {
            unset($_SESSION['old_input']);
        }

        return $value;
    }
}
