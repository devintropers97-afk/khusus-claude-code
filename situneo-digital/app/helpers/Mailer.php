<?php
/**
 * Mailer Helper Class
 * Class untuk mengirim email menggunakan SMTP
 *
 * Menggunakan PHP mail() function dengan konfigurasi SMTP
 * Untuk production, disarankan menggunakan library PHPMailer atau SwiftMailer
 */

class Mailer {
    /**
     * SMTP Configuration
     */
    private $host;
    private $port;
    private $username;
    private $password;
    private $encryption;
    private $fromAddress;
    private $fromName;

    /**
     * Constructor
     */
    public function __construct() {
        $this->host = MAIL_HOST;
        $this->port = MAIL_PORT;
        $this->username = MAIL_USERNAME;
        $this->password = MAIL_PASSWORD;
        $this->encryption = MAIL_ENCRYPTION;
        $this->fromAddress = MAIL_FROM_ADDRESS;
        $this->fromName = MAIL_FROM_NAME;
    }

    /**
     * Send email
     *
     * @param string $to Recipient email
     * @param string $subject Email subject
     * @param string $body Email body (HTML)
     * @param array $attachments Optional file attachments
     * @return bool Success status
     */
    public function send($to, $subject, $body, $attachments = []) {
        try {
            // Setup headers
            $headers = $this->buildHeaders();

            // Wrap body in HTML template
            $htmlBody = $this->wrapInTemplate($subject, $body);

            // Send email
            $success = mail($to, $subject, $htmlBody, $headers);

            if (!$success) {
                logError('Failed to send email', [
                    'to' => $to,
                    'subject' => $subject
                ]);
            }

            return $success;

        } catch (Exception $e) {
            logError('Email sending error: ' . $e->getMessage(), [
                'to' => $to,
                'subject' => $subject
            ]);
            return false;
        }
    }

    /**
     * Send verification email
     *
     * @param string $to
     * @param string $name
     * @param string $token
     * @return bool
     */
    public function sendVerificationEmail($to, $name, $token) {
        $verifyUrl = url("verify-email.php?token=$token");

        $subject = "Verifikasi Email Anda - " . APP_NAME;

        $body = "
        <h2>Halo, $name!</h2>
        <p>Terima kasih telah mendaftar di <strong>" . APP_NAME . "</strong>.</p>
        <p>Silakan klik tombol di bawah ini untuk memverifikasi email Anda:</p>
        <p style='text-align: center; margin: 30px 0;'>
            <a href='$verifyUrl' style='background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 15px 40px; text-decoration: none; border-radius: 5px; display: inline-block; font-weight: bold;'>
                Verifikasi Email
            </a>
        </p>
        <p>Atau copy dan paste link berikut ke browser Anda:</p>
        <p><a href='$verifyUrl'>$verifyUrl</a></p>
        <p>Link ini akan kadaluarsa dalam 24 jam.</p>
        <p>Jika Anda tidak merasa mendaftar, abaikan email ini.</p>
        ";

        return $this->send($to, $subject, $body);
    }

    /**
     * Send password reset email
     *
     * @param string $to
     * @param string $name
     * @param string $token
     * @return bool
     */
    public function sendPasswordResetEmail($to, $name, $token) {
        $resetUrl = url("reset-password.php?token=$token");

        $subject = "Reset Password - " . APP_NAME;

        $body = "
        <h2>Halo, $name!</h2>
        <p>Kami menerima permintaan untuk mereset password akun Anda.</p>
        <p>Silakan klik tombol di bawah ini untuk mereset password:</p>
        <p style='text-align: center; margin: 30px 0;'>
            <a href='$resetUrl' style='background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 15px 40px; text-decoration: none; border-radius: 5px; display: inline-block; font-weight: bold;'>
                Reset Password
            </a>
        </p>
        <p>Atau copy dan paste link berikut ke browser Anda:</p>
        <p><a href='$resetUrl'>$resetUrl</a></p>
        <p>Link ini akan kadaluarsa dalam 1 jam.</p>
        <p>Jika Anda tidak meminta reset password, abaikan email ini.</p>
        ";

        return $this->send($to, $subject, $body);
    }

    /**
     * Send welcome email
     *
     * @param string $to
     * @param string $name
     * @return bool
     */
    public function sendWelcomeEmail($to, $name) {
        $loginUrl = url('login.php');

        $subject = "Selamat Datang di " . APP_NAME;

        $body = "
        <h2>Selamat Datang, $name!</h2>
        <p>Email Anda telah berhasil diverifikasi.</p>
        <p>Sekarang Anda dapat login dan mulai menggunakan layanan kami:</p>
        <p style='text-align: center; margin: 30px 0;'>
            <a href='$loginUrl' style='background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 15px 40px; text-decoration: none; border-radius: 5px; display: inline-block; font-weight: bold;'>
                Login Sekarang
            </a>
        </p>
        <p>Terima kasih telah bergabung dengan <strong>" . COMPANY_NAME . "</strong>.</p>
        ";

        return $this->send($to, $subject, $body);
    }

    /**
     * Build email headers
     *
     * @return string
     */
    private function buildHeaders() {
        $headers = [];
        $headers[] = "MIME-Version: 1.0";
        $headers[] = "Content-Type: text/html; charset=UTF-8";
        $headers[] = "From: {$this->fromName} <{$this->fromAddress}>";
        $headers[] = "Reply-To: {$this->fromAddress}";
        $headers[] = "X-Mailer: PHP/" . phpversion();

        return implode("\r\n", $headers);
    }

    /**
     * Wrap email body in HTML template
     *
     * @param string $subject
     * @param string $body
     * @return string
     */
    private function wrapInTemplate($subject, $body) {
        return "
        <!DOCTYPE html>
        <html lang='id'>
        <head>
            <meta charset='UTF-8'>
            <meta name='viewport' content='width=device-width, initial-scale=1.0'>
            <title>$subject</title>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    line-height: 1.6;
                    color: #333;
                    background-color: #f4f4f4;
                    margin: 0;
                    padding: 0;
                }
                .container {
                    max-width: 600px;
                    margin: 20px auto;
                    background: white;
                    padding: 30px;
                    border-radius: 10px;
                    box-shadow: 0 0 10px rgba(0,0,0,0.1);
                }
                .header {
                    text-align: center;
                    padding-bottom: 20px;
                    border-bottom: 2px solid #667eea;
                    margin-bottom: 30px;
                }
                .header h1 {
                    color: #667eea;
                    margin: 0;
                    font-size: 24px;
                }
                .content {
                    padding: 20px 0;
                }
                .footer {
                    margin-top: 40px;
                    padding-top: 20px;
                    border-top: 1px solid #eee;
                    text-align: center;
                    font-size: 12px;
                    color: #999;
                }
                a {
                    color: #667eea;
                    text-decoration: none;
                }
            </style>
        </head>
        <body>
            <div class='container'>
                <div class='header'>
                    <h1>" . APP_NAME . "</h1>
                    <p>" . COMPANY_NAME . "</p>
                </div>
                <div class='content'>
                    $body
                </div>
                <div class='footer'>
                    <p>&copy; " . date('Y') . " " . COMPANY_NAME . ". All rights reserved.</p>
                    <p>NIB: " . COMPANY_NIB . "</p>
                    <p>Email: " . COMPANY_EMAIL . " | Phone: " . COMPANY_PHONE . "</p>
                </div>
            </div>
        </body>
        </html>
        ";
    }

    /**
     * Generate random verification token
     *
     * @return string
     */
    public static function generateToken() {
        return bin2hex(random_bytes(32));
    }

    /**
     * Save verification token to database
     *
     * @param int $userId
     * @param string $token
     * @param string $type 'email_verification' or 'password_reset'
     * @param int $expiryHours
     * @return bool
     */
    public static function saveToken($userId, $token, $type = 'email_verification', $expiryHours = 24) {
        $db = Database::getInstance();

        $expiresAt = date('Y-m-d H:i:s', strtotime("+$expiryHours hours"));

        $db->query("INSERT INTO verification_tokens (user_id, token, type, expires_at)
                    VALUES (:user_id, :token, :type, :expires_at)");
        $db->bind(':user_id', $userId);
        $db->bind(':token', $token);
        $db->bind(':type', $type);
        $db->bind(':expires_at', $expiresAt);

        return $db->execute();
    }

    /**
     * Verify token
     *
     * @param string $token
     * @param string $type
     * @return array|false User data if valid, false if invalid/expired
     */
    public static function verifyToken($token, $type = 'email_verification') {
        $db = Database::getInstance();

        $db->query("SELECT vt.*, u.*
                    FROM verification_tokens vt
                    JOIN users u ON vt.user_id = u.id
                    WHERE vt.token = :token
                    AND vt.type = :type
                    AND vt.expires_at > NOW()
                    AND vt.used_at IS NULL");
        $db->bind(':token', $token);
        $db->bind(':type', $type);

        return $db->single();
    }

    /**
     * Mark token as used
     *
     * @param string $token
     * @return bool
     */
    public static function markTokenAsUsed($token) {
        $db = Database::getInstance();

        $db->query("UPDATE verification_tokens SET used_at = NOW() WHERE token = :token");
        $db->bind(':token', $token);

        return $db->execute();
    }
}
