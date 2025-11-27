# 🎓 ULTIMATE DIY DEVELOPMENT GUIDE
## PT SITUNEO DIGITAL SOLUSI INDONESIA - FULL SYSTEM

**Target:** Maksimal & Perfect Development
**Skill Level:** Beginner → Advanced (Complete learning path)
**Timeline:** Self-paced with realistic estimates
**Result:** Production-ready system

---

## 📋 TABLE OF CONTENTS

1. [Prerequisites & Setup](#1-prerequisites--setup)
2. [Database Development](#2-database-development)
3. [Backend Development (PHP)](#3-backend-development)
4. [Frontend Development](#4-frontend-development)
5. [Authentication System](#5-authentication-system)
6. [Admin Panel](#6-admin-panel)
7. [User Dashboards](#7-user-dashboards)
8. [Services & Orders](#8-services--orders)
9. [Commission System](#9-commission-system)
10. [Payment System](#10-payment-system)
11. [Email System](#11-email-system)
12. [Job Board](#12-job-board)
13. [Testing & QA](#13-testing--qa)
14. [Deployment](#14-deployment)
15. [Optimization](#15-optimization)

---

## 1. PREREQUISITES & SETUP

### 1.1 Development Environment

**Required Software:**

```bash
# Local Development (Windows/Mac/Linux)

# Option A: XAMPP (Recommended for beginners)
- Download: https://www.apacheampp.org/
- Install: PHP 8.0+, MySQL 8.0+, Apache
- phpMyAdmin included

# Option B: Laragon (Recommended for Windows)
- Download: https://laragon.org/
- Faster, more features
- Auto-SSL, auto-vhost

# Option C: Docker (Advanced)
- Download: https://www.docker.com/
- Consistent environment
- Easier team collaboration
```

**Code Editor:**

```bash
# Choose one:

# Visual Studio Code (FREE, Recommended)
- Download: https://code.visualstudio.com/
- Extensions needed:
  * PHP Intelephense
  * MySQL
  * Better Comments
  * GitLens
  * Live Server
  * Prettier

# PhpStorm (PAID, Professional)
- Download: https://www.jetbrains.com/phpstorm/
- Best PHP IDE
- 30-day free trial

# Sublime Text (FREE/PAID)
- Download: https://www.sublimetext.com/
- Fast, lightweight
```

**Version Control:**

```bash
# Git
- Download: https://git-scm.com/
- Learn basics: https://git-scm.com/book/en/v2

# GitHub Account
- Register: https://github.com/
- Create repository: situneo-digital

# Git Commands (Essential)
git init                    # Initialize repository
git add .                   # Stage all files
git commit -m "message"     # Commit changes
git push origin main        # Push to GitHub
git pull origin main        # Pull from GitHub
```

**Database Tools:**

```bash
# phpMyAdmin (Included in XAMPP/Laragon)
- Access: http://localhost/phpmyadmin

# MySQL Workbench (Advanced)
- Download: https://www.mysql.com/products/workbench/
- Better for database design

# TablePlus (Modern, Paid)
- Download: https://tableplus.com/
- Beautiful UI, fast
```

### 1.2 Project Structure Setup

**Create Folder Structure:**

```bash
# Navigate to your web root
cd C:/xampp/htdocs/        # Windows XAMPP
cd ~/Sites/                # Mac
cd /var/www/html/          # Linux

# Create project folder
mkdir situneo-digital
cd situneo-digital

# Create main folders
mkdir public app config database storage docs

# Create subfolders
mkdir public/assets
mkdir public/assets/css
mkdir public/assets/js
mkdir public/assets/images
mkdir public/uploads

mkdir app/controllers
mkdir app/models
mkdir app/views
mkdir app/helpers
mkdir app/middleware

mkdir app/views/layouts
mkdir app/views/auth
mkdir app/views/admin
mkdir app/views/client
mkdir app/views/partner
mkdir app/views/spv
mkdir app/views/manager
mkdir app/views/emails
mkdir app/views/errors

mkdir storage/logs
mkdir storage/cache

mkdir database/migrations
mkdir database/seeds
```

**Initialize Git:**

```bash
git init
echo "vendor/" > .gitignore
echo "storage/" >> .gitignore
echo "config/database.php" >> .gitignore
echo ".env" >> .gitignore
git add .
git commit -m "Initial project structure"
```

---

## 2. DATABASE DEVELOPMENT

### 2.1 Create Database

**Via phpMyAdmin:**

1. Open: `http://localhost/phpmyadmin`
2. Click **New** (left sidebar)
3. Database name: `situneo_digital`
4. Collation: `utf8mb4_unicode_ci`
5. Click **Create**

**Via MySQL Command:**

```sql
CREATE DATABASE situneo_digital
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE situneo_digital;
```

### 2.2 Create Tables (ALL 208 TABLES)

**Category A: User Management (18 tables)**

```sql
-- 1. users table (CORE)
CREATE TABLE users (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    role_id INT UNSIGNED NOT NULL DEFAULT 5,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    avatar VARCHAR(255),
    status ENUM('active', 'inactive', 'suspended') DEFAULT 'active',
    email_verified_at TIMESTAMP NULL,
    remember_token VARCHAR(100),
    last_login_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    INDEX idx_role_status (role_id, status),
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2. user_roles table
CREATE TABLE user_roles (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE,
    role_display_name VARCHAR(100) NOT NULL,
    permissions JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert default roles
INSERT INTO user_roles (id, role_name, role_display_name, permissions) VALUES
(1, 'super_admin', 'Super Admin', '["all"]'),
(2, 'manager', 'Manager', '["view_reports", "manage_spv", "view_analytics"]'),
(3, 'spv', 'Supervisor', '["manage_partners", "view_team", "approve_sales"]'),
(4, 'partner', 'Partner', '["create_sales", "view_commission", "manage_clients"]'),
(5, 'client', 'Client', '["place_orders", "view_orders", "make_payments"]');

-- 3. user_permissions table
CREATE TABLE user_permissions (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    permission_name VARCHAR(100) NOT NULL,
    permission_value ENUM('allow', 'deny') DEFAULT 'allow',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4. user_profiles table
CREATE TABLE user_profiles (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL UNIQUE,
    date_of_birth DATE,
    gender ENUM('male', 'female', 'other'),
    address TEXT,
    city VARCHAR(100),
    province VARCHAR(100),
    postal_code VARCHAR(10),
    country VARCHAR(100) DEFAULT 'Indonesia',
    company_name VARCHAR(255),
    job_title VARCHAR(100),
    website VARCHAR(255),
    bio TEXT,
    social_facebook VARCHAR(255),
    social_twitter VARCHAR(255),
    social_instagram VARCHAR(255),
    social_linkedin VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 5. user_sessions table
CREATE TABLE user_sessions (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    ip_address VARCHAR(45),
    user_agent TEXT,
    session_token VARCHAR(255) NOT NULL UNIQUE,
    last_activity TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_token (user_id, session_token),
    INDEX idx_expires (expires_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 6. user_login_history table
CREATE TABLE user_login_history (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    ip_address VARCHAR(45),
    user_agent TEXT,
    login_status ENUM('success', 'failed') DEFAULT 'success',
    failure_reason VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_created (user_id, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 7. user_activity_logs table
CREATE TABLE user_activity_logs (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    activity_type VARCHAR(100) NOT NULL,
    activity_description TEXT,
    model_type VARCHAR(100),
    model_id BIGINT UNSIGNED,
    ip_address VARCHAR(45),
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_created (user_id, created_at),
    INDEX idx_model (model_type, model_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 8. user_notifications table
CREATE TABLE user_notifications (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    notification_type VARCHAR(100) NOT NULL,
    title VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    action_url VARCHAR(255),
    read_at TIMESTAMP NULL,
    sent_via ENUM('in_app', 'email', 'sms') DEFAULT 'in_app',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_read (user_id, read_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 9. user_notification_settings table
CREATE TABLE user_notification_settings (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL UNIQUE,
    email_notifications BOOLEAN DEFAULT TRUE,
    sms_notifications BOOLEAN DEFAULT FALSE,
    push_notifications BOOLEAN DEFAULT TRUE,
    notification_types JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 10. user_api_tokens table
CREATE TABLE user_api_tokens (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    token_name VARCHAR(100) NOT NULL,
    token_hash VARCHAR(255) NOT NULL UNIQUE,
    abilities JSON,
    last_used_at TIMESTAMP NULL,
    expires_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user (user_id),
    INDEX idx_token (token_hash)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 11. user_two_factor_auth table
CREATE TABLE user_two_factor_auth (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL UNIQUE,
    is_enabled BOOLEAN DEFAULT FALSE,
    method ENUM('sms', 'email', 'authenticator') DEFAULT 'email',
    phone_number VARCHAR(20),
    secret_key VARCHAR(255),
    backup_codes JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 12. user_settings table
CREATE TABLE user_settings (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL UNIQUE,
    language VARCHAR(10) DEFAULT 'id',
    timezone VARCHAR(50) DEFAULT 'Asia/Jakarta',
    currency VARCHAR(10) DEFAULT 'IDR',
    date_format VARCHAR(20) DEFAULT 'Y-m-d',
    theme ENUM('light', 'dark') DEFAULT 'light',
    email_signature TEXT,
    settings_json JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 13. user_documents table
CREATE TABLE user_documents (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    document_type ENUM('ktp', 'npwp', 'certificate', 'contract', 'other') NOT NULL,
    document_name VARCHAR(255) NOT NULL,
    file_path VARCHAR(255) NOT NULL,
    file_size INT UNSIGNED,
    mime_type VARCHAR(100),
    verified_at TIMESTAMP NULL,
    verified_by BIGINT UNSIGNED,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 14. user_bank_accounts table
CREATE TABLE user_bank_accounts (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    bank_name VARCHAR(100) NOT NULL,
    account_number VARCHAR(50) NOT NULL,
    account_holder_name VARCHAR(255) NOT NULL,
    branch VARCHAR(255),
    is_primary BOOLEAN DEFAULT FALSE,
    verified_at TIMESTAMP NULL,
    verified_by BIGINT UNSIGNED,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 15. user_verification_requests table
CREATE TABLE user_verification_requests (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    verification_type VARCHAR(100) NOT NULL,
    verification_data JSON,
    status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
    reviewed_by BIGINT UNSIGNED,
    reviewed_at TIMESTAMP NULL,
    rejection_reason TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_status (user_id, status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 16. user_referrals table
CREATE TABLE user_referrals (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    referrer_id BIGINT UNSIGNED NOT NULL,
    referred_id BIGINT UNSIGNED NOT NULL,
    referral_code VARCHAR(50) NOT NULL UNIQUE,
    registration_completed_at TIMESTAMP NULL,
    first_purchase_at TIMESTAMP NULL,
    reward_claimed BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (referrer_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (referred_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_referrer (referrer_id),
    INDEX idx_referred (referred_id),
    INDEX idx_code (referral_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 17. user_blocks table
CREATE TABLE user_blocks (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    blocked_by BIGINT UNSIGNED NOT NULL,
    reason TEXT NOT NULL,
    block_type ENUM('temporary', 'permanent') DEFAULT 'temporary',
    expires_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (blocked_by) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_expires (user_id, expires_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 18. password_resets table
CREATE TABLE password_resets (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    token VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_email_token (email, token),
    INDEX idx_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

**⚠️ NOTE:** This is 18 out of 208 tables. Creating ALL tables here would be 20,000+ lines.

**FULL DATABASE SQL FILE:** I'll create complete file separately.

### 2.3 Sample Data (Essential)

```sql
-- Insert Default Super Admin
INSERT INTO users (id, role_id, email, password, first_name, last_name, phone, status, email_verified_at) VALUES
(1, 1, 'admin@situneo.my.id', '$2y$12$LQv3c1yYqBW/XC9gQx7WCe92pso/czJQjNGg.hKNE9K8F7kVJlO4W', 'Super', 'Admin', '081234567890', 'active', NOW());
-- Password: Admin123!

-- Insert admin profile
INSERT INTO user_profiles (user_id, city, province, country) VALUES
(1, 'Jakarta', 'DKI Jakarta', 'Indonesia');

-- Insert default system settings
INSERT INTO system_settings (setting_key, setting_value, setting_type, setting_category) VALUES
('site_name', 'PT SITUNEO DIGITAL', 'string', 'general'),
('site_url', 'https://situneo.my.id', 'string', 'general'),
('site_email', 'admin@situneo.my.id', 'string', 'general'),
('nib', '1401250064281', 'string', 'company'),
('company_phone', '+62 812-3456-7890', 'string', 'company'),
('company_address', 'Jakarta, Indonesia', 'string', 'company');
```

---

## 3. BACKEND DEVELOPMENT (PHP)

### 3.1 Configuration Files

**File: `config/config.php`**

```php
<?php
/**
 * Application Configuration
 * PT SITUNEO DIGITAL SOLUSI INDONESIA
 */

return [
    // Application
    'app_name' => 'PT SITUNEO DIGITAL',
    'app_url' => 'https://situneo.my.id',
    'app_env' => 'production', // development, staging, production
    'app_debug' => false,

    // Company Information
    'company' => [
        'name' => 'PT SITUNEO DIGITAL SOLUSI INDONESIA',
        'nib' => '1401250064281',
        'address' => 'Jakarta, Indonesia',
        'phone' => '+62 812-3456-7890',
        'email' => 'admin@situneo.my.id',
        'website' => 'https://situneo.my.id',
    ],

    // Paths
    'base_path' => dirname(__DIR__),
    'public_path' => dirname(__DIR__) . '/public',
    'storage_path' => dirname(__DIR__) . '/storage',
    'upload_path' => dirname(__DIR__) . '/public/uploads',

    // Security
    'session_lifetime' => 120, // minutes
    'csrf_token_length' => 32,
    'password_hash_cost' => 12,

    // Pagination
    'per_page' => 20,
    'max_per_page' => 100,

    // Email (SMTP)
    'mail' => [
        'driver' => 'smtp',
        'host' => 'mail.situneo.my.id',
        'port' => 587,
        'username' => 'noreply@situneo.my.id',
        'password' => '', // Fill in production
        'encryption' => 'tls',
        'from' => [
            'address' => 'noreply@situneo.my.id',
            'name' => 'PT SITUNEO DIGITAL',
        ],
    ],

    // Upload Limits
    'upload' => [
        'max_size' => 5242880, // 5MB in bytes
        'allowed_types' => ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
        'image_types' => ['jpg', 'jpeg', 'png', 'gif'],
        'document_types' => ['pdf', 'doc', 'docx', 'xls', 'xlsx'],
    ],

    // Commission Rates
    'commission' => [
        'tiers' => [
            1 => ['name' => 'TIER 1', 'rate' => 0.30, 'min_sales' => 0, 'max_sales' => 10000000],
            2 => ['name' => 'TIER 2', 'rate' => 0.40, 'min_sales' => 10000000, 'max_sales' => 25000000],
            3 => ['name' => 'TIER 3', 'rate' => 0.50, 'min_sales' => 25000000, 'max_sales' => 50000000],
            4 => ['name' => 'TIER MAX', 'rate' => 0.55, 'min_sales' => 50000000, 'max_sales' => PHP_INT_MAX],
        ],
        'spv_rate' => 0.10,
        'manager_rate' => 0.05,
    ],

    // Pricing
    'pricing' => [
        'price_per_page' => 350000,
        'monthly_rent' => 150000,
        'min_rent_months' => 3,
    ],

    // Features (toggle on/off)
    'features' => [
        'registration_enabled' => true,
        'maintenance_mode' => false,
        'email_verification_required' => true,
        '2fa_enabled' => false,
        'job_board_enabled' => true,
    ],
];
```

**File: `config/database.php`**

```php
<?php
/**
 * Database Configuration
 */

return [
    'driver' => 'mysql',
    'host' => 'localhost',
    'port' => '3306',
    'database' => 'situneo_digital',
    'username' => 'root',
    'password' => '',
    'charset' => 'utf8mb4',
    'collation' => 'utf8mb4_unicode_ci',
    'prefix' => '',
    'options' => [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false,
    ],
];
```

**File: `.env.example`**

```env
# Application
APP_NAME="PT SITUNEO DIGITAL"
APP_URL=https://situneo.my.id
APP_ENV=production
APP_DEBUG=false

# Database
DB_HOST=localhost
DB_PORT=3306
DB_DATABASE=situneo_digital
DB_USERNAME=root
DB_PASSWORD=

# Email (SMTP)
MAIL_HOST=mail.situneo.my.id
MAIL_PORT=587
MAIL_USERNAME=noreply@situneo.my.id
MAIL_PASSWORD=
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=noreply@situneo.my.id
MAIL_FROM_NAME="PT SITUNEO DIGITAL"

# Security
SESSION_LIFETIME=120
CSRF_TOKEN_LENGTH=32
```

### 3.2 Database Helper Class

**File: `app/helpers/Database.php`**

```php
<?php
/**
 * Database Helper Class
 * PDO Wrapper for MySQL
 */

class Database {
    private static $instance = null;
    private $pdo;

    private function __construct() {
        $config = require dirname(__DIR__, 2) . '/config/database.php';

        $dsn = sprintf(
            "mysql:host=%s;port=%s;dbname=%s;charset=%s",
            $config['host'],
            $config['port'],
            $config['database'],
            $config['charset']
        );

        try {
            $this->pdo = new PDO(
                $dsn,
                $config['username'],
                $config['password'],
                $config['options']
            );
        } catch (PDOException $e) {
            die("Database connection failed: " . $e->getMessage());
        }
    }

    public static function getInstance() {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    public function getConnection() {
        return $this->pdo;
    }

    /**
     * Execute a query (SELECT)
     */
    public function query($sql, $params = []) {
        try {
            $stmt = $this->pdo->prepare($sql);
            $stmt->execute($params);
            return $stmt;
        } catch (PDOException $e) {
            $this->logError($e->getMessage(), $sql, $params);
            throw $e;
        }
    }

    /**
     * Fetch all rows
     */
    public function fetchAll($sql, $params = []) {
        return $this->query($sql, $params)->fetchAll();
    }

    /**
     * Fetch single row
     */
    public function fetch($sql, $params = []) {
        return $this->query($sql, $params)->fetch();
    }

    /**
     * Fetch single column value
     */
    public function fetchColumn($sql, $params = []) {
        return $this->query($sql, $params)->fetchColumn();
    }

    /**
     * Execute INSERT, UPDATE, DELETE
     */
    public function execute($sql, $params = []) {
        try {
            $stmt = $this->pdo->prepare($sql);
            return $stmt->execute($params);
        } catch (PDOException $e) {
            $this->logError($e->getMessage(), $sql, $params);
            throw $e;
        }
    }

    /**
     * Get last inserted ID
     */
    public function lastInsertId() {
        return $this->pdo->lastInsertId();
    }

    /**
     * Begin transaction
     */
    public function beginTransaction() {
        return $this->pdo->beginTransaction();
    }

    /**
     * Commit transaction
     */
    public function commit() {
        return $this->pdo->commit();
    }

    /**
     * Rollback transaction
     */
    public function rollback() {
        return $this->pdo->rollBack();
    }

    /**
     * Log database errors
     */
    private function logError($message, $sql, $params) {
        $log = sprintf(
            "[%s] Database Error: %s\nSQL: %s\nParams: %s\n\n",
            date('Y-m-d H:i:s'),
            $message,
            $sql,
            json_encode($params)
        );

        $logFile = dirname(__DIR__, 2) . '/storage/logs/database.log';
        file_put_contents($logFile, $log, FILE_APPEND);
    }
}
```

**Usage Example:**

```php
// Get database instance
$db = Database::getInstance();

// Fetch all users
$users = $db->fetchAll("SELECT * FROM users WHERE status = ?", ['active']);

// Fetch single user
$user = $db->fetch("SELECT * FROM users WHERE id = ?", [1]);

// Insert new user
$db->execute(
    "INSERT INTO users (email, password, first_name, last_name) VALUES (?, ?, ?, ?)",
    ['test@example.com', password_hash('password', PASSWORD_BCRYPT), 'John', 'Doe']
);

// Get last inserted ID
$userId = $db->lastInsertId();

// Transaction example
$db->beginTransaction();
try {
    $db->execute("INSERT INTO orders (...) VALUES (...)", [...]);
    $db->execute("INSERT INTO order_items (...) VALUES (...)", [...]);
    $db->commit();
} catch (Exception $e) {
    $db->rollback();
    throw $e;
}
```

---

**(CONTINUING IN NEXT FILE due to length...)**

This guide is getting very long. Shall I:

**A.** Continue in same file (will be 50,000+ lines total)
**B.** Split into multiple guide files (recommended)
**C.** Create summary with links to detailed sections

**Your choice?**
