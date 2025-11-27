<?php
/**
 * SITUNEO DIGITAL - Configuration File
 * PT SITUNEO DIGITAL SOLUSI INDONESIA
 * NIB: 1401250064281
 *
 * File ini memuat semua konfigurasi aplikasi dari file .env
 * dan mendefinisikan konstanta yang digunakan di seluruh aplikasi
 */

// Memulai session jika belum dimulai
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// Load environment variables dari .env file
function loadEnv($path) {
    if (!file_exists($path)) {
        die('File .env tidak ditemukan! Silakan copy .env.example menjadi .env');
    }

    $lines = file($path, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    foreach ($lines as $line) {
        // Skip comments
        if (strpos(trim($line), '#') === 0) {
            continue;
        }

        // Parse key=value
        if (strpos($line, '=') !== false) {
            list($key, $value) = explode('=', $line, 2);
            $key = trim($key);
            $value = trim($value);

            // Remove quotes if present
            $value = trim($value, '"\'');

            // Set as environment variable and constant
            putenv("$key=$value");
            if (!defined($key)) {
                define($key, $value);
            }
        }
    }
}

// Load .env file dari root directory
$envPath = dirname(__DIR__) . '/.env';
loadEnv($envPath);

// ==============================================
// APLIKASI
// ==============================================
define('APP_NAME', getenv('APP_NAME') ?: 'SITUNEO DIGITAL');
define('APP_ENV', getenv('APP_ENV') ?: 'local');
define('APP_DEBUG', getenv('APP_DEBUG') === 'true');
define('APP_URL', getenv('APP_URL') ?: 'http://localhost/situneo-digital/public');
define('APP_TIMEZONE', getenv('APP_TIMEZONE') ?: 'Asia/Jakarta');
define('APP_LOCALE', getenv('APP_LOCALE') ?: 'id');

// Set timezone
date_default_timezone_set(APP_TIMEZONE);

// ==============================================
// DATABASE
// ==============================================
define('DB_CONNECTION', getenv('DB_CONNECTION') ?: 'mysql');
define('DB_HOST', getenv('DB_HOST') ?: 'localhost');
define('DB_PORT', getenv('DB_PORT') ?: '3306');
define('DB_DATABASE', getenv('DB_DATABASE') ?: 'situneo_digital');
define('DB_USERNAME', getenv('DB_USERNAME') ?: 'root');
define('DB_PASSWORD', getenv('DB_PASSWORD') ?: '');

// ==============================================
// EMAIL (SMTP)
// ==============================================
define('MAIL_MAILER', getenv('MAIL_MAILER') ?: 'smtp');
define('MAIL_HOST', getenv('MAIL_HOST') ?: 'smtp.gmail.com');
define('MAIL_PORT', getenv('MAIL_PORT') ?: '587');
define('MAIL_USERNAME', getenv('MAIL_USERNAME') ?: '');
define('MAIL_PASSWORD', getenv('MAIL_PASSWORD') ?: '');
define('MAIL_ENCRYPTION', getenv('MAIL_ENCRYPTION') ?: 'tls');
define('MAIL_FROM_ADDRESS', getenv('MAIL_FROM_ADDRESS') ?: 'noreply@situneo.com');
define('MAIL_FROM_NAME', getenv('MAIL_FROM_NAME') ?: 'SITUNEO DIGITAL');

// ==============================================
// SESSION & SECURITY
// ==============================================
define('SESSION_LIFETIME', getenv('SESSION_LIFETIME') ?: 120);
define('SESSION_DRIVER', getenv('SESSION_DRIVER') ?: 'file');
define('BCRYPT_COST', getenv('BCRYPT_COST') ?: 12);
define('CSRF_TOKEN_NAME', getenv('CSRF_TOKEN_NAME') ?: 'csrf_token');
define('SESSION_NAME', getenv('SESSION_NAME') ?: 'situneo_session');

// Konfigurasi session
ini_set('session.cookie_httponly', 1);
ini_set('session.use_only_cookies', 1);
ini_set('session.cookie_secure', APP_ENV === 'production' ? 1 : 0);
session_name(SESSION_NAME);

// ==============================================
// COMPANY INFORMATION
// ==============================================
define('COMPANY_NAME', getenv('COMPANY_NAME') ?: 'PT SITUNEO DIGITAL SOLUSI INDONESIA');
define('COMPANY_NIB', getenv('COMPANY_NIB') ?: '1401250064281');
define('COMPANY_EMAIL', getenv('COMPANY_EMAIL') ?: 'info@situneo.com');
define('COMPANY_PHONE', getenv('COMPANY_PHONE') ?: '+62-xxx-xxxx-xxxx');

// ==============================================
// PRICING (dalam Rupiah)
// ==============================================
define('PRICE_BELI_PER_PAGE', (int)getenv('PRICE_BELI_PER_PAGE') ?: 350000);
define('PRICE_SEWA_PER_MONTH', (int)getenv('PRICE_SEWA_PER_MONTH') ?: 150000);
define('SEWA_MIN_MONTHS', (int)getenv('SEWA_MIN_MONTHS') ?: 3);

// ==============================================
// COMMISSION TIERS (dalam persen)
// ==============================================
define('COMMISSION_PARTNER_TIER1', (int)getenv('COMMISSION_PARTNER_TIER1') ?: 30);
define('COMMISSION_PARTNER_TIER2', (int)getenv('COMMISSION_PARTNER_TIER2') ?: 40);
define('COMMISSION_PARTNER_TIER3', (int)getenv('COMMISSION_PARTNER_TIER3') ?: 50);
define('COMMISSION_PARTNER_TIER4', (int)getenv('COMMISSION_PARTNER_TIER4') ?: 55);
define('COMMISSION_SPV', (int)getenv('COMMISSION_SPV') ?: 10);
define('COMMISSION_MANAGER', (int)getenv('COMMISSION_MANAGER') ?: 5);

// ==============================================
// FILE UPLOAD
// ==============================================
define('UPLOAD_MAX_SIZE', (int)getenv('UPLOAD_MAX_SIZE') ?: 5242880); // 5MB
define('UPLOAD_ALLOWED_TYPES', getenv('UPLOAD_ALLOWED_TYPES') ?: 'jpg,jpeg,png,pdf,doc,docx');

// ==============================================
// PATHS
// ==============================================
define('ROOT_PATH', dirname(__DIR__));
define('APP_PATH', ROOT_PATH . '/app');
define('CONFIG_PATH', ROOT_PATH . '/config');
define('PUBLIC_PATH', ROOT_PATH . '/public');
define('STORAGE_PATH', ROOT_PATH . '/storage');
define('UPLOAD_PATH', PUBLIC_PATH . '/uploads');
define('LOGS_PATH', STORAGE_PATH . '/logs');

// ==============================================
// ERROR REPORTING
// ==============================================
if (APP_DEBUG) {
    error_reporting(E_ALL);
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
} else {
    error_reporting(0);
    ini_set('display_errors', 0);
    ini_set('display_startup_errors', 0);
}

// ==============================================
// AUTOLOADER
// ==============================================
spl_autoload_register(function ($class) {
    // Coba load dari app/helpers/
    $helperFile = APP_PATH . '/helpers/' . $class . '.php';
    if (file_exists($helperFile)) {
        require_once $helperFile;
        return;
    }

    // Coba load dari app/models/
    $modelFile = APP_PATH . '/models/' . $class . '.php';
    if (file_exists($modelFile)) {
        require_once $modelFile;
        return;
    }

    // Coba load dari app/controllers/
    $controllerFile = APP_PATH . '/controllers/' . $class . '.php';
    if (file_exists($controllerFile)) {
        require_once $controllerFile;
        return;
    }
});

// ==============================================
// HELPER FUNCTIONS
// ==============================================

/**
 * Redirect ke URL tertentu
 */
function redirect($url) {
    header("Location: $url");
    exit;
}

/**
 * Get full URL dari path
 */
function url($path = '') {
    return APP_URL . '/' . ltrim($path, '/');
}

/**
 * Get asset URL
 */
function asset($path) {
    return APP_URL . '/assets/' . ltrim($path, '/');
}

/**
 * Escape HTML output
 */
function e($string) {
    return htmlspecialchars($string, ENT_QUOTES, 'UTF-8');
}

/**
 * Format currency Rupiah
 */
function rupiah($amount) {
    return 'Rp ' . number_format($amount, 0, ',', '.');
}

/**
 * Format date Indonesia
 */
function tanggal($date, $format = 'd/m/Y H:i') {
    if (empty($date)) return '-';
    return date($format, strtotime($date));
}

/**
 * Debug helper
 */
function dd(...$vars) {
    echo '<pre>';
    foreach ($vars as $var) {
        var_dump($var);
    }
    echo '</pre>';
    die();
}

/**
 * Log error ke file
 */
function logError($message, $context = []) {
    $logFile = LOGS_PATH . '/error-' . date('Y-m-d') . '.log';
    $timestamp = date('Y-m-d H:i:s');
    $contextStr = !empty($context) ? json_encode($context) : '';
    $logMessage = "[$timestamp] $message $contextStr" . PHP_EOL;
    file_put_contents($logFile, $logMessage, FILE_APPEND);
}
