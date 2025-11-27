<?php
/**
 * AuthController
 * Controller untuk mengelola authentication (login, register, logout, dll)
 *
 * Handles all authentication-related operations
 */

class AuthController {
    private $userModel;
    private $validator;

    public function __construct() {
        $this->userModel = new User();
        $this->validator = new Validator();
    }

    /**
     * Process login
     *
     * @return void
     */
    public function login() {
        // Validate CSRF token
        if (!CSRF::validate()) {
            return;
        }

        // Sanitize input
        $email = Validator::sanitize($_POST['email'] ?? '');
        $password = $_POST['password'] ?? '';
        $remember = isset($_POST['remember']);

        // Validate input
        $rules = [
            'email' => 'required|email',
            'password' => 'required'
        ];

        if (!$this->validator->validate(['email' => $email, 'password' => $password], $rules)) {
            Session::flash('error', $this->validator->firstError());
            Session::setOldInput($_POST);
            redirect(url('login.php'));
            return;
        }

        // Verify credentials
        $user = $this->userModel->verifyPassword($email, $password);

        if (!$user) {
            Session::flash('error', 'Email atau password salah.');
            Session::setOldInput(['email' => $email]);
            redirect(url('login.php'));
            return;
        }

        // Check if email is verified
        if (empty($user['email_verified_at'])) {
            Session::flash('error', 'Silakan verifikasi email Anda terlebih dahulu. Cek inbox atau spam folder.');
            Session::setOldInput(['email' => $email]);
            redirect(url('login.php'));
            return;
        }

        // Set remember me cookie
        if ($remember) {
            $this->setRememberMeCookie($user['id']);
        }

        // Login user
        Session::login($user);

        // Redirect berdasarkan role
        $this->redirectToDashboard($user['role_id']);
    }

    /**
     * Process register
     *
     * @return void
     */
    public function register() {
        // Validate CSRF token
        if (!CSRF::validate()) {
            return;
        }

        // Sanitize input
        $data = Validator::sanitizeArray($_POST);

        // Validate input
        $rules = [
            'first_name' => 'required|min:2|max:100',
            'last_name' => 'required|min:2|max:100',
            'email' => 'required|email|unique:users,email',
            'phone' => 'phone',
            'password' => 'required|min:8',
            'password_confirmation' => 'required|confirmed'
        ];

        if (!$this->validator->validate($data, $rules)) {
            Session::flash('error', $this->validator->firstError());
            Session::setOldInput($_POST);
            redirect(url('register.php'));
            return;
        }

        // Create user
        $userData = [
            'first_name' => $data['first_name'],
            'last_name' => $data['last_name'],
            'email' => $data['email'],
            'phone' => $data['phone'] ?? null,
            'password' => $data['password'],
            'role_id' => 5, // Default: Client
            'status' => 'active'
        ];

        $userId = $this->userModel->create($userData);

        if (!$userId) {
            Session::flash('error', 'Terjadi kesalahan saat mendaftar. Silakan coba lagi.');
            Session::setOldInput($_POST);
            redirect(url('register.php'));
            return;
        }

        // Success
        Session::flash('success', 'Pendaftaran berhasil! Silakan cek email Anda untuk verifikasi.');
        redirect(url('login.php'));
    }

    /**
     * Process email verification
     *
     * @param string $token
     * @return void
     */
    public function verifyEmail($token) {
        if (empty($token)) {
            Session::flash('error', 'Token verifikasi tidak valid.');
            redirect(url('login.php'));
            return;
        }

        $success = $this->userModel->verifyEmail($token);

        if ($success) {
            Session::flash('success', 'Email berhasil diverifikasi! Silakan login.');
        } else {
            Session::flash('error', 'Token verifikasi tidak valid atau sudah kadaluarsa.');
        }

        redirect(url('login.php'));
    }

    /**
     * Process logout
     *
     * @return void
     */
    public function logout() {
        // Remove remember me cookie
        $this->clearRememberMeCookie();

        // Logout
        Session::logout();

        Session::flash('success', 'Anda telah logout.');
        redirect(url('login.php'));
    }

    /**
     * Show forgot password form (for future implementation)
     *
     * @return void
     */
    public function forgotPassword() {
        // Validate CSRF token
        if (!CSRF::validate()) {
            return;
        }

        $email = Validator::sanitize($_POST['email'] ?? '');

        // Validate email
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            Session::flash('error', 'Email tidak valid.');
            redirect(url('forgot-password.php'));
            return;
        }

        // Find user
        $user = $this->userModel->findByEmail($email);

        // Always show success message (security best practice)
        // Jangan kasih tahu apakah email ada atau tidak
        Session::flash('success', 'Jika email terdaftar, link reset password telah dikirim.');

        if ($user) {
            // Generate token
            $token = Mailer::generateToken();
            Mailer::saveToken($user['id'], $token, 'password_reset', 1); // 1 hour expiry

            // Send email
            $mailer = new Mailer();
            $mailer->sendPasswordResetEmail(
                $user['email'],
                $user['first_name'] . ' ' . $user['last_name'],
                $token
            );
        }

        redirect(url('login.php'));
    }

    /**
     * Process password reset
     *
     * @return void
     */
    public function resetPassword() {
        // Validate CSRF token
        if (!CSRF::validate()) {
            return;
        }

        $token = $_POST['token'] ?? '';
        $password = $_POST['password'] ?? '';
        $passwordConfirmation = $_POST['password_confirmation'] ?? '';

        // Validate input
        $rules = [
            'password' => 'required|min:8',
            'password_confirmation' => 'required|confirmed'
        ];

        if (!$this->validator->validate(['password' => $password, 'password_confirmation' => $passwordConfirmation], $rules)) {
            Session::flash('error', $this->validator->firstError());
            redirect(url("reset-password.php?token=$token"));
            return;
        }

        // Reset password
        $success = $this->userModel->resetPassword($token, $password);

        if ($success) {
            Session::flash('success', 'Password berhasil direset. Silakan login dengan password baru.');
            redirect(url('login.php'));
        } else {
            Session::flash('error', 'Token tidak valid atau sudah kadaluarsa.');
            redirect(url('forgot-password.php'));
        }
    }

    /**
     * Redirect ke dashboard berdasarkan role
     *
     * @param int $roleId
     * @return void
     */
    private function redirectToDashboard($roleId) {
        $dashboards = [
            1 => 'admin/dashboard.php',      // Super Admin
            2 => 'manager/dashboard.php',    // Manager
            3 => 'spv/dashboard.php',        // SPV
            4 => 'partner/dashboard.php',    // Partner
            5 => 'client/dashboard.php',     // Client
        ];

        $dashboard = isset($dashboards[$roleId]) ? $dashboards[$roleId] : 'dashboard.php';

        Session::flash('success', 'Selamat datang, ' . Session::getUserName() . '!');
        redirect(url($dashboard));
    }

    /**
     * Set remember me cookie
     *
     * @param int $userId
     * @return void
     */
    private function setRememberMeCookie($userId) {
        // Generate random token
        $token = bin2hex(random_bytes(32));

        // Save to database
        $db = Database::getInstance();
        $expiresAt = date('Y-m-d H:i:s', strtotime('+30 days'));

        $db->query("INSERT INTO remember_tokens (user_id, token, expires_at)
                    VALUES (:user_id, :token, :expires_at)
                    ON DUPLICATE KEY UPDATE token = :token, expires_at = :expires_at");
        $db->bind(':user_id', $userId);
        $db->bind(':token', hash('sha256', $token));
        $db->bind(':expires_at', $expiresAt);
        $db->execute();

        // Set cookie (30 days)
        setcookie('remember_me', $token, time() + (30 * 24 * 60 * 60), '/', '', false, true);
    }

    /**
     * Clear remember me cookie
     *
     * @return void
     */
    private function clearRememberMeCookie() {
        if (isset($_COOKIE['remember_me'])) {
            $token = $_COOKIE['remember_me'];

            // Delete from database
            $db = Database::getInstance();
            $db->query("DELETE FROM remember_tokens WHERE token = :token");
            $db->bind(':token', hash('sha256', $token));
            $db->execute();

            // Delete cookie
            setcookie('remember_me', '', time() - 3600, '/', '', false, true);
        }
    }

    /**
     * Check remember me cookie dan auto-login
     * Panggil ini di config/config.php atau index.php
     *
     * @return bool
     */
    public static function checkRememberMe() {
        // Skip jika sudah login
        if (Session::isLoggedIn()) {
            return true;
        }

        // Check cookie
        if (!isset($_COOKIE['remember_me'])) {
            return false;
        }

        $token = $_COOKIE['remember_me'];
        $hashedToken = hash('sha256', $token);

        // Find token in database
        $db = Database::getInstance();
        $db->query("SELECT rt.*, u.*
                   FROM remember_tokens rt
                   JOIN users u ON rt.user_id = u.id
                   WHERE rt.token = :token
                   AND rt.expires_at > NOW()
                   AND u.deleted_at IS NULL
                   AND u.status = 'active'");
        $db->bind(':token', $hashedToken);

        $result = $db->single();

        if ($result) {
            // Auto-login
            Session::login($result);
            return true;
        }

        // Invalid token, clear cookie
        setcookie('remember_me', '', time() - 3600, '/', '', false, true);
        return false;
    }

    /**
     * Resend verification email
     *
     * @return void
     */
    public function resendVerification() {
        // Validate CSRF token
        if (!CSRF::validate()) {
            return;
        }

        $email = Validator::sanitize($_POST['email'] ?? '');

        // Find user
        $user = $this->userModel->findByEmail($email);

        if (!$user) {
            Session::flash('error', 'Email tidak ditemukan.');
            redirect(url('login.php'));
            return;
        }

        // Check if already verified
        if (!empty($user['email_verified_at'])) {
            Session::flash('info', 'Email Anda sudah diverifikasi. Silakan login.');
            redirect(url('login.php'));
            return;
        }

        // Generate new token
        $token = Mailer::generateToken();
        Mailer::saveToken($user['id'], $token, 'email_verification', 24);

        // Send email
        $mailer = new Mailer();
        $mailer->sendVerificationEmail(
            $user['email'],
            $user['first_name'] . ' ' . $user['last_name'],
            $token
        );

        Session::flash('success', 'Email verifikasi telah dikirim ulang. Silakan cek inbox atau spam folder.');
        redirect(url('login.php'));
    }
}
