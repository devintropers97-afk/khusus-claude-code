<?php
/**
 * CSRF Helper Class
 * Class untuk CSRF (Cross-Site Request Forgery) protection
 *
 * Menyediakan token generation dan validation untuk mencegah CSRF attacks
 */

class CSRF {
    /**
     * Generate CSRF token dan simpan ke session
     *
     * @return string Token yang di-generate
     */
    public static function generateToken() {
        Session::start();

        // Generate random token
        $token = bin2hex(random_bytes(32));

        // Simpan ke session
        Session::set(CSRF_TOKEN_NAME, $token);

        return $token;
    }

    /**
     * Get CSRF token dari session (generate jika belum ada)
     *
     * @return string
     */
    public static function getToken() {
        Session::start();

        $token = Session::get(CSRF_TOKEN_NAME);

        // Generate new token jika belum ada
        if (empty($token)) {
            $token = self::generateToken();
        }

        return $token;
    }

    /**
     * Validate CSRF token
     *
     * @param string|null $token Token yang akan divalidasi (default dari POST)
     * @return bool True jika valid
     */
    public static function validate($token = null) {
        Session::start();

        // Ambil token dari POST jika tidak dispesifikkan
        if ($token === null) {
            $token = $_POST[CSRF_TOKEN_NAME] ?? '';
        }

        // Get token dari session
        $sessionToken = Session::get(CSRF_TOKEN_NAME);

        // Validate
        if (empty($token) || empty($sessionToken)) {
            self::handleInvalidToken();
            return false;
        }

        // Compare using hash_equals untuk mencegah timing attacks
        if (!hash_equals($sessionToken, $token)) {
            self::handleInvalidToken();
            return false;
        }

        return true;
    }

    /**
     * Generate hidden input field untuk form
     *
     * @return string HTML input field
     */
    public static function inputField() {
        $token = self::getToken();
        $name = CSRF_TOKEN_NAME;

        return "<input type='hidden' name='$name' value='$token'>";
    }

    /**
     * Generate meta tag untuk AJAX requests
     *
     * @return string HTML meta tag
     */
    public static function metaTag() {
        $token = self::getToken();

        return "<meta name='csrf-token' content='$token'>";
    }

    /**
     * Get token as array (untuk JSON/AJAX)
     *
     * @return array
     */
    public static function tokenArray() {
        return [
            CSRF_TOKEN_NAME => self::getToken()
        ];
    }

    /**
     * Handle invalid token
     *
     * @return void
     */
    private static function handleInvalidToken() {
        logError('CSRF token validation failed', [
            'ip' => $_SERVER['REMOTE_ADDR'] ?? 'unknown',
            'url' => $_SERVER['REQUEST_URI'] ?? 'unknown',
            'method' => $_SERVER['REQUEST_METHOD'] ?? 'unknown'
        ]);

        Session::flash('error', 'Token keamanan tidak valid. Silakan coba lagi.');

        // Redirect back atau ke home
        $referer = $_SERVER['HTTP_REFERER'] ?? url('');
        redirect($referer);
    }

    /**
     * Refresh token (generate baru)
     * Digunakan setelah form submission berhasil
     *
     * @return string New token
     */
    public static function refreshToken() {
        Session::remove(CSRF_TOKEN_NAME);
        return self::generateToken();
    }

    /**
     * Verify request adalah POST dengan CSRF token valid
     *
     * @return bool
     */
    public static function verifyPostRequest() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            Session::flash('error', 'Invalid request method.');
            redirect($_SERVER['HTTP_REFERER'] ?? url(''));
            return false;
        }

        return self::validate();
    }

    /**
     * Middleware untuk protect route
     * Usage: CSRF::protect() di awal file yang perlu protection
     *
     * @return void
     */
    public static function protect() {
        // Hanya check untuk POST, PUT, DELETE, PATCH requests
        $method = $_SERVER['REQUEST_METHOD'] ?? 'GET';
        $protectedMethods = ['POST', 'PUT', 'DELETE', 'PATCH'];

        if (in_array($method, $protectedMethods)) {
            self::validate();
        }
    }

    /**
     * Create signed URL dengan token
     * Untuk link yang trigger actions (delete, approve, etc.)
     *
     * @param string $url
     * @param int $expiryMinutes
     * @return string
     */
    public static function signUrl($url, $expiryMinutes = 60) {
        $token = self::getToken();
        $expires = time() + ($expiryMinutes * 60);

        // Create signature
        $signature = hash_hmac('sha256', $url . $expires, $token);

        // Add parameters
        $separator = strpos($url, '?') !== false ? '&' : '?';
        return $url . $separator . 'signature=' . $signature . '&expires=' . $expires;
    }

    /**
     * Verify signed URL
     *
     * @param string $url
     * @return bool
     */
    public static function verifySignedUrl($url) {
        // Parse URL
        $parts = parse_url($url);
        parse_str($parts['query'] ?? '', $query);

        if (!isset($query['signature']) || !isset($query['expires'])) {
            return false;
        }

        // Check expiry
        if (time() > $query['expires']) {
            Session::flash('error', 'Link sudah kadaluarsa.');
            return false;
        }

        // Remove signature and expires from URL untuk verification
        $baseUrl = strtok($url, '?');
        $params = $query;
        unset($params['signature']);
        unset($params['expires']);

        $queryString = http_build_query($params);
        $urlToVerify = $baseUrl . ($queryString ? '?' . $queryString : '');

        // Create expected signature
        $token = self::getToken();
        $expectedSignature = hash_hmac('sha256', $urlToVerify . $query['expires'], $token);

        // Compare signatures
        return hash_equals($expectedSignature, $query['signature']);
    }

    /**
     * Generate token untuk specific action
     * Useful untuk one-time actions
     *
     * @param string $action Action identifier
     * @return string
     */
    public static function generateActionToken($action) {
        Session::start();

        $token = bin2hex(random_bytes(32));

        // Store dengan key berdasarkan action
        $key = 'csrf_action_' . $action;
        Session::set($key, $token);

        return $token;
    }

    /**
     * Validate action token dan remove setelah digunakan
     *
     * @param string $action
     * @param string $token
     * @return bool
     */
    public static function validateActionToken($action, $token) {
        Session::start();

        $key = 'csrf_action_' . $action;
        $sessionToken = Session::get($key);

        // Remove token (one-time use)
        Session::remove($key);

        if (empty($token) || empty($sessionToken)) {
            return false;
        }

        return hash_equals($sessionToken, $token);
    }
}
