# 📋 SITUNEO - BATCH BREAKDOWN LENGKAP
## PANDUAN DEVELOPMENT BERTAHAP (15 BATCH)

**Version:** 2.0 FINAL  
**Date:** 12 November 2025  
**Total Batch:** 15 BATCH  
**Estimasi Total:** 60-90 hari kerja  
**Approach:** Quality First, Modular, Tested per Batch

---

# 📊 RINGKASAN EKSEKUTIF

## Gambaran Keseluruhan

```
FASE 1: FOUNDATION (Batch 1-3)
├─ Batch 1: Database Setup (85 tables)
├─ Batch 2: Core System (Config, Auth, Router)
└─ Batch 3: Public Website (11 pages)
⏱️ Estimasi: 2-3 minggu

FASE 2: AUTHENTICATION & CLIENT (Batch 4-5)
├─ Batch 4: Authentication System (Login/Register/Reset)
└─ Batch 5: Client Dashboard (20+ pages)
⏱️ Estimasi: 2 minggu

FASE 3: PARTNER & SPV (Batch 6-8)
├─ Batch 6: Partner Dashboard (30+ pages)
├─ Batch 7: SPV Dashboard (35+ pages)
└─ Batch 8: Commission & ARPU System (Auto-calculate)
⏱️ Estimasi: 3 minggu

FASE 4: MANAGER & ADMIN (Batch 9-11)
├─ Batch 9: Manager Dashboard (35+ pages)
├─ Batch 10: Admin Dashboard Part 1 (User & Order Management)
└─ Batch 11: Admin Dashboard Part 2 (Commission & Settings)
⏱️ Estimasi: 3 minggu

FASE 5: ADVANCED FEATURES (Batch 12-13)
├─ Batch 12: Demo Request System (26 fields)
└─ Batch 13: Task Board System (Take & Submit Tasks)
⏱️ Estimasi: 2 minggu

FASE 6: DEMOS & POLISH (Batch 14-15)
├─ Batch 14: 50 Demo Websites (Production-ready)
└─ Batch 15: Final Polish & Deployment
⏱️ Estimasi: 2-3 minggu
```

## Prioritas Development

```
CRITICAL (Must Have):
✅ Batch 1-5: Database + Core + Auth + Client + Partner
   └─ Ini adalah minimum viable product (MVP)

HIGH PRIORITY:
✅ Batch 6-8: Partner + SPV + Commission System
   └─ Core business logic & revenue generation

MEDIUM PRIORITY:
✅ Batch 9-11: Manager + Admin Dashboards
   └─ Management & control system

LOW PRIORITY (Enhancement):
✅ Batch 12-15: Demo Request + Tasks + 50 Demos + Polish
   └─ Value-added features
```

---

# 🎯 BATCH 1: DATABASE SETUP
**Status:** 🔴 Belum Mulai  
**Prioritas:** 🔥 CRITICAL  
**Estimasi:** 3-5 hari kerja  
**Dependencies:** None (starting point)

## Tujuan Batch 1
Membuat seluruh struktur database lengkap (85+ tables) dengan relasi yang benar, indexes yang optimal, dan foreign keys yang tepat.

## Deliverables

### 1. Database Schema File
```sql
File: /database/schema.sql
Size: ~5000 baris SQL
Includes:
├─ 85+ CREATE TABLE statements
├─ All constraints (PRIMARY KEY, FOREIGN KEY, UNIQUE)
├─ All indexes (performance optimization)
├─ Default values & auto-increment
└─ Comments (explaining each table purpose)
```

### 2. Migration Scripts
```
/database/migrations/
├─ 001_create_user_tables.sql (User management - 6 tables)
├─ 002_create_client_tables.sql (Client data - 6 tables)
├─ 003_create_partner_tables.sql (Partner data - 10 tables)
├─ 004_create_spv_tables.sql (SPV data - 8 tables)
├─ 005_create_manager_tables.sql (Manager data - 8 tables)
├─ 006_create_hierarchy_tables.sql (Hierarchy - 4 tables)
├─ 007_create_service_tables.sql (Services - 7 tables)
├─ 008_create_order_tables.sql (Orders - 5 tables)
├─ 009_create_payment_tables.sql (Payments - 5 tables)
├─ 010_create_demo_tables.sql (Demos - 3 tables)
├─ 011_create_commission_tables.sql (Commissions - 6 tables)
├─ 012_create_withdrawal_tables.sql (Withdrawals - 4 tables)
├─ 013_create_task_tables.sql (Tasks - 5 tables)
├─ 014_create_cms_tables.sql (CMS Content - 6 tables)
├─ 015_create_leaderboard_tables.sql (Leaderboard - 4 tables)
├─ 016_create_settings_tables.sql (Settings - 5 tables)
├─ 017_create_notification_tables.sql (Notifications - 3 tables)
├─ 018_create_analytics_tables.sql (Analytics - 7 tables)
├─ 019_create_support_tables.sql (Support - 3 tables)
└─ 020_create_misc_tables.sql (SEO, Media, etc - 5 tables)
```

### 3. Seed Data (Sample Data)
```
/database/seeds/
├─ seed_admin.sql (1 admin user: vins@situneo.my.id)
├─ seed_services.sql (232+ services catalog)
├─ seed_packages.sql (3 packages: Starter, Business, Premium)
├─ seed_settings.sql (Default system settings)
├─ seed_email_templates.sql (14 email templates)
└─ seed_demo_data.sql (5 sample clients, partners for testing)
```

### 4. Database Documentation
```
/database/documentation/
├─ ERD.pdf (Entity Relationship Diagram - visual schema)
├─ TABLE_REFERENCE.md (All tables with column descriptions)
├─ RELATIONS.md (Foreign key relationships explained)
└─ INDEXES.md (Performance indexes explained)
```

## Database Credentials

```ini
DB_HOST=localhost
DB_USER=nrrskfvk_user_situneo_digital
DB_PASS=Devin1922$
DB_NAME=nrrskfvk_situneo_digital
DB_CHARSET=utf8mb4
DB_COLLATION=utf8mb4_unicode_ci
```

## Key Tables (Critical untuk Batch ini)

### 1. users (Master user table)
```sql
CREATE TABLE users (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    role ENUM('admin', 'manager', 'spv', 'partner', 'client') NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    full_name VARCHAR(100) NOT NULL,
    status ENUM('active', 'inactive', 'suspended', 'pending') DEFAULT 'pending',
    language_preference ENUM('id', 'en') DEFAULT 'id',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    email_verified BOOLEAN DEFAULT FALSE,
    avatar VARCHAR(255),
    INDEX idx_role (role),
    INDEX idx_status (status),
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### 2. partners (Partner management)
```sql
CREATE TABLE partners (
    partner_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    spv_id INT UNSIGNED NULL,
    tier_current ENUM('1', '2', '3', 'MAX') DEFAULT '1',
    total_orders_lifetime INT UNSIGNED DEFAULT 0,
    monthly_orders INT UNSIGNED DEFAULT 0,
    commission_balance DECIMAL(15,2) DEFAULT 0.00,
    commission_pending DECIMAL(15,2) DEFAULT 0.00,
    commission_paid_total DECIMAL(15,2) DEFAULT 0.00,
    referral_code VARCHAR(20) UNIQUE NOT NULL,
    status ENUM('active', 'inactive', 'suspended') DEFAULT 'active',
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (spv_id) REFERENCES spv_supervisors(spv_id) ON DELETE SET NULL,
    INDEX idx_tier (tier_current),
    INDEX idx_spv (spv_id)
) ENGINE=InnoDB;
```

### 3. orders (Order management)
```sql
CREATE TABLE orders (
    order_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    client_id INT UNSIGNED NOT NULL,
    partner_id INT UNSIGNED NULL,
    service_id INT UNSIGNED NULL,
    package_id INT UNSIGNED NULL,
    order_type ENUM('beli_putus', 'sewa') NOT NULL,
    total_pages INT UNSIGNED DEFAULT 1,
    total_amount DECIMAL(15,2) NOT NULL,
    status ENUM('pending', 'in_progress', 'testing', 'completed', 'cancelled') DEFAULT 'pending',
    assigned_to INT UNSIGNED NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP NULL,
    deadline DATE NULL,
    FOREIGN KEY (client_id) REFERENCES clients(client_id) ON DELETE CASCADE,
    FOREIGN KEY (partner_id) REFERENCES partners(partner_id) ON DELETE SET NULL,
    INDEX idx_status (status),
    INDEX idx_client (client_id)
) ENGINE=InnoDB;
```

### 4. demo_requests (26 FIELDS!)
```sql
CREATE TABLE demo_requests (
    demo_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    client_id INT UNSIGNED NOT NULL,
    partner_id INT UNSIGNED NULL,
    
    -- 26 FIELDS
    field_01_nama_bisnis VARCHAR(100) NOT NULL,
    field_02_jenis_usaha VARCHAR(100) NOT NULL,
    field_03_target_market TEXT,
    field_04_lokasi VARCHAR(100),
    field_05_website_existing VARCHAR(255),
    field_06_budget VARCHAR(50),
    field_07_timeline VARCHAR(50),
    field_08_fitur_utama TEXT,
    field_09_referensi_website TEXT,
    field_10_warna_brand VARCHAR(100),
    field_11_logo_existing VARCHAR(255),
    field_12_konten_ready ENUM('ya', 'tidak', 'sebagian'),
    field_13_jumlah_halaman INT UNSIGNED,
    field_14_bahasa ENUM('indonesia', 'english', 'both'),
    field_15_payment_gateway ENUM('ya', 'tidak'),
    field_16_hosting_preference ENUM('shared', 'vps', 'cloud'),
    field_17_domain_existing VARCHAR(100),
    field_18_seo_priority ENUM('low', 'medium', 'high'),
    field_19_social_media TEXT,
    field_20_email_marketing ENUM('ya', 'tidak'),
    field_21_mobile_app ENUM('ya', 'tidak', 'nanti'),
    field_22_special_request TEXT,
    field_23_competitor_websites TEXT,
    field_24_unique_selling_point TEXT,
    field_25_deadline_launch DATE,
    field_26_additional_notes TEXT,
    
    status ENUM('pending', 'approved', 'rejected', 'demo_sent') DEFAULT 'pending',
    reviewed_by INT UNSIGNED NULL,
    reviewed_at TIMESTAMP NULL,
    demo_link VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (client_id) REFERENCES clients(client_id) ON DELETE CASCADE,
    INDEX idx_status (status)
) ENGINE=InnoDB;
```

## Testing Checklist

```
✅ All tables created successfully (no errors)
✅ Foreign keys working (test cascade delete)
✅ Indexes created (check SHOW INDEX)
✅ Seed data inserted (verify counts)
✅ Admin user can login (test credentials)
✅ Services loaded (verify 232+ services exist)
✅ Backup created (mysqldump)
```

## Deliverables Summary

| File | Purpose | Lines | Status |
|------|---------|-------|--------|
| schema.sql | Complete DB schema | ~5000 | 🔴 Todo |
| migrations/*.sql | Individual table creation | ~3000 | 🔴 Todo |
| seeds/*.sql | Sample data | ~1000 | 🔴 Todo |
| ERD.pdf | Visual schema | 1 page | 🔴 Todo |
| docs/*.md | Documentation | ~500 | 🔴 Todo |

**Total Output:** ~10,000 lines of SQL + Documentation

---

# 🎯 BATCH 2: CORE SYSTEM
**Status:** 🔴 Belum Mulai  
**Prioritas:** 🔥 CRITICAL  
**Estimasi:** 5-7 hari kerja  
**Dependencies:** ✅ Batch 1 (Database must be ready)

## Tujuan Batch 2
Membuat sistem core yang robust: Configuration, Database Class, Router, Helper Functions, dan struktur folder modular.

## Struktur Folder

```
/
├─ /public/               # Document root (public-facing)
│  ├─ index.php          # Entry point (router)
│  ├─ .htaccess          # URL rewriting (Apache)
│  ├─ /assets/           # Static assets
│  │  ├─ /css/           # Stylesheets
│  │  ├─ /js/            # JavaScript
│  │  ├─ /img/           # Images (logo, icons, photos)
│  │  ├─ /fonts/         # Custom fonts
│  │  └─ /uploads/       # User uploads (protected)
│  └─ /demos/            # 50 demo websites (separate folders)
│
├─ /config/              # Configuration files
│  ├─ config.php         # Main config (DB, paths, constants)
│  ├─ database.php       # Database credentials
│  ├─ email.php          # SMTP email config
│  └─ constants.php      # Global constants
│
├─ /core/                # Core system classes
│  ├─ Database.php       # PDO database wrapper
│  ├─ Router.php         # URL routing & controller loading
│  ├─ Controller.php     # Base controller (parent class)
│  ├─ Model.php          # Base model (parent class)
│  ├─ View.php           # View renderer
│  ├─ Session.php        # Session management
│  ├─ Auth.php           # Authentication helper
│  ├─ CSRF.php           # CSRF protection
│  ├─ Validator.php      # Input validation
│  ├─ Uploader.php       # File upload handler
│  └─ Mailer.php         # PHPMailer wrapper
│
├─ /app/                 # Application code
│  ├─ /controllers/      # Controllers (by role)
│  │  ├─ /public/        # Public pages (homepage, about, etc)
│  │  ├─ /auth/          # Auth pages (login, register, reset)
│  │  ├─ /client/        # Client dashboard
│  │  ├─ /partner/       # Partner dashboard
│  │  ├─ /spv/           # SPV dashboard
│  │  ├─ /manager/       # Manager dashboard
│  │  └─ /admin/         # Admin dashboard
│  ├─ /models/           # Models (database interaction)
│  │  ├─ User.php
│  │  ├─ Client.php
│  │  ├─ Partner.php
│  │  ├─ SPV.php
│  │  ├─ Manager.php
│  │  ├─ Order.php
│  │  ├─ Service.php
│  │  ├─ Payment.php
│  │  └─ ... (85+ models, one per table)
│  └─ /views/            # View templates (HTML + PHP)
│     ├─ /public/
│     ├─ /auth/
│     ├─ /client/
│     ├─ /partner/
│     ├─ /spv/
│     ├─ /manager/
│     ├─ /admin/
│     └─ /partials/      # Reusable components
│        ├─ header.php
│        ├─ footer.php
│        ├─ sidebar.php
│        └─ navbar.php
│
├─ /helpers/             # Helper functions
│  ├─ functions.php      # General utility functions
│  ├─ html.php           # HTML generation helpers
│  ├─ date.php           # Date/time helpers
│  ├─ format.php         # Formatting (currency, phone, etc)
│  └─ security.php       # Security helpers (escape, sanitize)
│
├─ /cron/                # Scheduled jobs (cron)
│  ├─ tier-update.php    # Auto-update partner tiers (monthly)
│  ├─ arpu-calculate.php # Auto-calculate ARPU bonus (monthly)
│  └─ invoice-generate.php # Auto-generate recurring invoices
│
├─ /vendor/              # Third-party libraries (Composer)
│  └─ ... (PHPMailer, etc)
│
├─ /logs/                # Application logs
│  ├─ error.log
│  ├─ access.log
│  └─ activity.log
│
├─ /database/            # Database files (from Batch 1)
│  ├─ schema.sql
│  ├─ /migrations/
│  └─ /seeds/
│
├─ composer.json         # PHP dependencies
├─ .env                  # Environment variables (Git ignored)
├─ .gitignore            # Git ignore rules
└─ README.md             # Project documentation
```

## Core Files Detail

### 1. config/config.php
```php
<?php
// Main Configuration File
define('APP_NAME', 'SITUNEO Digital');
define('APP_URL', 'https://situneo.my.id');
define('APP_ENV', 'production'); // or 'development'
define('APP_DEBUG', false);

// Paths
define('ROOT_PATH', dirname(__DIR__));
define('APP_PATH', ROOT_PATH . '/app');
define('PUBLIC_PATH', ROOT_PATH . '/public');
define('UPLOAD_PATH', PUBLIC_PATH . '/assets/uploads');

// Database (from database.php)
require_once __DIR__ . '/database.php';

// Email (from email.php)
require_once __DIR__ . '/email.php';

// Constants
require_once __DIR__ . '/constants.php';

// Timezone
date_default_timezone_set('Asia/Jakarta');

// Error Reporting
if (APP_DEBUG) {
    error_reporting(E_ALL);
    ini_set('display_errors', 1);
} else {
    error_reporting(0);
    ini_set('display_errors', 0);
}
```

### 2. core/Database.php (PDO Wrapper)
```php
<?php
class Database {
    private $conn;
    private $stmt;
    
    public function __construct() {
        $dsn = "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=" . DB_CHARSET;
        $options = [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
        ];
        
        try {
            $this->conn = new PDO($dsn, DB_USER, DB_PASS, $options);
        } catch(PDOException $e) {
            die("Connection failed: " . $e->getMessage());
        }
    }
    
    // Prepare statement
    public function query($sql) {
        $this->stmt = $this->conn->prepare($sql);
        return $this;
    }
    
    // Bind values
    public function bind($param, $value, $type = null) {
        if (is_null($type)) {
            switch (true) {
                case is_int($value):
                    $type = PDO::PARAM_INT;
                    break;
                case is_bool($value):
                    $type = PDO::PARAM_BOOL;
                    break;
                case is_null($value):
                    $type = PDO::PARAM_NULL;
                    break;
                default:
                    $type = PDO::PARAM_STR;
            }
        }
        $this->stmt->bindValue($param, $value, $type);
        return $this;
    }
    
    // Execute statement
    public function execute() {
        return $this->stmt->execute();
    }
    
    // Get all results
    public function all() {
        $this->execute();
        return $this->stmt->fetchAll();
    }
    
    // Get single result
    public function one() {
        $this->execute();
        return $this->stmt->fetch();
    }
    
    // Get row count
    public function count() {
        return $this->stmt->rowCount();
    }
    
    // Get last insert ID
    public function lastInsertId() {
        return $this->conn->lastInsertId();
    }
    
    // Begin transaction
    public function beginTransaction() {
        return $this->conn->beginTransaction();
    }
    
    // Commit transaction
    public function commit() {
        return $this->conn->commit();
    }
    
    // Rollback transaction
    public function rollBack() {
        return $this->conn->rollBack();
    }
}
```

### 3. core/Router.php
```php
<?php
class Router {
    private $routes = [];
    private $currentController = 'HomeController';
    private $currentMethod = 'index';
    private $params = [];
    
    public function __construct() {
        $this->parseUrl();
    }
    
    // Parse URL
    private function parseUrl() {
        if (isset($_GET['url'])) {
            $url = rtrim($_GET['url'], '/');
            $url = filter_var($url, FILTER_SANITIZE_URL);
            $url = explode('/', $url);
            
            // Role-based routing
            $role = isset($url[0]) ? $url[0] : 'public';
            $controller = isset($url[1]) ? ucfirst($url[1]) . 'Controller' : $this->currentController;
            $method = isset($url[2]) ? $url[2] : $this->currentMethod;
            $params = array_slice($url, 3);
            
            // Build controller path
            $controllerPath = APP_PATH . '/controllers/' . $role . '/' . $controller . '.php';
            
            if (file_exists($controllerPath)) {
                require_once $controllerPath;
                $this->currentController = new $controller;
                $this->currentMethod = $method;
                $this->params = $params;
                
                // Call controller method with params
                call_user_func_array([$this->currentController, $this->currentMethod], $this->params);
            } else {
                // 404 Not Found
                http_response_code(404);
                require_once APP_PATH . '/views/errors/404.php';
            }
        } else {
            // Home page
            require_once APP_PATH . '/controllers/public/HomeController.php';
            $controller = new HomeController();
            $controller->index();
        }
    }
}
```

### 4. core/Controller.php (Base Controller)
```php
<?php
class Controller {
    // Load model
    protected function model($model) {
        $modelPath = APP_PATH . '/models/' . $model . '.php';
        if (file_exists($modelPath)) {
            require_once $modelPath;
            return new $model();
        }
        return null;
    }
    
    // Load view
    protected function view($view, $data = []) {
        $viewPath = APP_PATH . '/views/' . $view . '.php';
        if (file_exists($viewPath)) {
            extract($data);
            require_once $viewPath;
        } else {
            die("View not found: " . $view);
        }
    }
    
    // Redirect
    protected function redirect($url) {
        header('Location: ' . APP_URL . '/' . $url);
        exit;
    }
    
    // JSON response
    protected function json($data, $status = 200) {
        http_response_code($status);
        header('Content-Type: application/json');
        echo json_encode($data);
        exit;
    }
}
```

### 5. helpers/functions.php
```php
<?php
// Escape HTML
function e($string) {
    return htmlspecialchars($string, ENT_QUOTES, 'UTF-8');
}

// Format currency (Rupiah)
function rupiah($amount) {
    return 'Rp ' . number_format($amount, 0, ',', '.');
}

// Format date
function tanggal($date, $format = 'd M Y') {
    return date($format, strtotime($date));
}

// Generate random string
function randomString($length = 10) {
    return bin2hex(random_bytes($length / 2));
}

// Check if user is logged in
function isLoggedIn() {
    return isset($_SESSION['user_id']);
}

// Get current user
function currentUser() {
    return $_SESSION['user'] ?? null;
}

// Get user role
function userRole() {
    return $_SESSION['user']['role'] ?? 'guest';
}

// Check user role
function hasRole($role) {
    return userRole() === $role;
}

// Flash message
function flash($key, $value = null) {
    if ($value === null) {
        $value = $_SESSION['flash'][$key] ?? null;
        unset($_SESSION['flash'][$key]);
        return $value;
    }
    $_SESSION['flash'][$key] = $value;
}

// Asset URL
function asset($path) {
    return APP_URL . '/assets/' . $path;
}

// App URL
function url($path = '') {
    return APP_URL . '/' . $path;
}
```

## Testing Checklist

```
✅ Config loaded (no errors)
✅ Database connection works (test query)
✅ Router works (access homepage)
✅ Controller/Model loading works
✅ View rendering works
✅ Helper functions work
✅ Session management works
✅ CSRF protection works
```

## Deliverables Summary

| Component | Files | Lines | Status |
|-----------|-------|-------|--------|
| Config | 4 files | ~200 | 🔴 Todo |
| Core Classes | 10 files | ~1500 | 🔴 Todo |
| Helpers | 5 files | ~500 | 🔴 Todo |
| Base Structure | Folders | - | 🔴 Todo |

**Total Output:** ~2,200 lines PHP

---

# 🎯 BATCH 3: PUBLIC WEBSITE
**Status:** 🔴 Belum Mulai  
**Prioritas:** 🔥 HIGH  
**Estimasi:** 5-7 hari kerja  
**Dependencies:** ✅ Batch 1-2 (DB + Core ready)

## Tujuan Batch 3
Membuat public-facing website lengkap dengan design premium, animations, dan konten yang menarik. Total 11 halaman publik.

## Halaman yang Dibuat (11 Pages)

```
1. Homepage (index.php) ⭐ PALING PENTING
2. About Us (about.php)
3. Services Catalog (services.php)
4. Service Detail (service-detail.php)
5. Pricing (pricing.php) - dengan calculator
6. Portfolio/Demos (portfolio.php)
7. Portfolio Detail (portfolio-detail.php)
8. Contact (contact.php)
9. Blog (blog.php)
10. Blog Detail (blog-detail.php)
11. Career (career.php)

PLUS:
12. Terms & Conditions (terms.php)
13. Privacy Policy (privacy.php)
14. Sitemap HTML (sitemap.php)
```

## Homepage Design (PREMIUM!)

### Section Breakdown

```html
<!-- SECTION 1: HERO -->
<section id="hero" class="hero-section">
    <!-- Network particle animation background -->
    <canvas id="network-canvas"></canvas>
    
    <div class="hero-content">
        <h1 class="headline">Wujudkan Website Impian Anda</h1>
        <p class="tagline">Build Your Future, Today</p>
        
        <!-- 3 CTA Buttons -->
        <div class="cta-buttons">
            <a href="/register" class="btn btn-primary">Lihat Demo Gratis</a>
            <a href="/pricing#calculator" class="btn btn-secondary">Hitung Estimasi Harga</a>
            <a href="https://wa.me/6283173868915" class="btn btn-success">
                <i class="bi bi-whatsapp"></i> Chat WhatsApp
            </a>
        </div>
        
        <!-- Stats Counter (Animated) -->
        <div class="stats-counter">
            <div class="stat-item">
                <span class="stat-number" data-count="500">0</span>
                <span class="stat-label">Clients</span>
            </div>
            <div class="stat-item">
                <span class="stat-number" data-count="1200">0</span>
                <span class="stat-label">Projects</span>
            </div>
            <div class="stat-item">
                <span class="stat-number" data-count="98">0</span>
                <span class="stat-label">% Satisfaction</span>
            </div>
        </div>
    </div>
</section>

<!-- SECTION 2: SERVICES PREVIEW -->
<section id="services-preview" class="py-5">
    <div class="container">
        <h2 class="section-title">232+ Layanan Digital untuk Bisnis Anda</h2>
        <p class="section-subtitle">Pilih dari 10 divisi layanan digital terlengkap</p>
        
        <!-- 10 Divisi Showcase -->
        <div class="services-grid">
            <!-- Each service category card -->
            <div class="service-card" data-aos="fade-up">
                <div class="service-icon">
                    <i class="bi bi-globe"></i>
                </div>
                <h3 class="service-name">Website Development</h3>
                <p class="service-brief">50+ jenis website profesional</p>
                <a href="/services/website" class="service-link">Lihat Detail →</a>
            </div>
            <!-- Repeat for 9 other divisions -->
        </div>
        
        <div class="text-center mt-4">
            <a href="/services" class="btn btn-outline-primary">Lihat Semua Layanan</a>
        </div>
    </div>
</section>

<!-- SECTION 3: PRICING OVERVIEW -->
<section id="pricing-overview" class="py-5 bg-light">
    <div class="container">
        <h2 class="section-title">Harga Transparan, Tidak Ada Hidden Cost</h2>
        
        <!-- Comparison Table: Beli vs Sewa -->
        <div class="pricing-comparison">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Feature</th>
                        <th>Beli Putus</th>
                        <th>Sewa Bulanan</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Harga per Halaman</td>
                        <td>Rp 350,000 (sekali bayar)</td>
                        <td>Rp 150,000/bulan</td>
                    </tr>
                    <tr>
                        <td>Ownership</td>
                        <td>✅ 100% milik Anda</td>
                        <td>❌ Milik SITUNEO</td>
                    </tr>
                    <!-- More rows -->
                </tbody>
            </table>
        </div>
        
        <!-- Package Cards -->
        <div class="packages-grid">
            <!-- Starter Package -->
            <div class="package-card" data-aos="zoom-in">
                <div class="package-badge">BEST FOR UMKM</div>
                <h3 class="package-name">Starter Package</h3>
                <div class="package-price">Rp 2,500,000</div>
                <ul class="package-features">
                    <li>✅ Website 3 Halaman</li>
                    <li>✅ Basic SEO</li>
                    <li>✅ Logo Design</li>
                    <li>✅ 1 Bulan Support</li>
                </ul>
                <a href="/pricing" class="btn btn-primary">Pilih Paket</a>
            </div>
            <!-- Business & Premium packages -->
        </div>
        
        <!-- Price Calculator Widget -->
        <div class="price-calculator mt-5">
            <h3>Hitung Estimasi Harga</h3>
            <form id="price-calculator-form">
                <div class="form-group">
                    <label>Jumlah Halaman</label>
                    <input type="number" id="pages" min="1" value="5" class="form-control">
                </div>
                <div class="form-group">
                    <label>Tipe Pembelian</label>
                    <select id="type" class="form-control">
                        <option value="beli">Beli Putus</option>
                        <option value="sewa">Sewa Bulanan</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Estimasi Harga</label>
                    <div id="estimated-price" class="price-display">Rp 1,750,000</div>
                </div>
            </form>
        </div>
    </div>
</section>

<!-- Continue with other sections... -->
```

### Animations & Interactions

```javascript
// Network Particle Animation
const canvas = document.getElementById('network-canvas');
const ctx = canvas.getContext('2d');
canvas.width = window.innerWidth;
canvas.height = window.innerHeight;

class Particle {
    constructor() {
        this.x = Math.random() * canvas.width;
        this.y = Math.random() * canvas.height;
        this.vx = (Math.random() - 0.5) * 0.5;
        this.vy = (Math.random() - 0.5) * 0.5;
        this.radius = 2;
    }
    
    draw() {
        ctx.beginPath();
        ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2);
        ctx.fillStyle = 'rgba(255, 180, 0, 0.3)';
        ctx.fill();
    }
    
    update() {
        this.x += this.vx;
        this.y += this.vy;
        
        if (this.x < 0 || this.x > canvas.width) this.vx *= -1;
        if (this.y < 0 || this.y > canvas.height) this.vy *= -1;
    }
}

// Create particles
const particles = [];
for (let i = 0; i < 40; i++) {
    particles.push(new Particle());
}

// Animation loop
function animate() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    
    particles.forEach(particle => {
        particle.update();
        particle.draw();
    });
    
    // Draw connections
    particles.forEach((p1, i) => {
        particles.slice(i + 1).forEach(p2 => {
            const dx = p1.x - p2.x;
            const dy = p1.y - p2.y;
            const distance = Math.sqrt(dx * dx + dy * dy);
            
            if (distance < 150) {
                ctx.beginPath();
                ctx.moveTo(p1.x, p1.y);
                ctx.lineTo(p2.x, p2.y);
                ctx.strokeStyle = `rgba(30, 92, 153, ${1 - distance / 150})`;
                ctx.lineWidth = 0.5;
                ctx.stroke();
            }
        });
    });
    
    requestAnimationFrame(animate);
}
animate();

// Counter Animation (Stats)
function animateCounter() {
    const counters = document.querySelectorAll('.stat-number');
    counters.forEach(counter => {
        const target = parseInt(counter.getAttribute('data-count'));
        let current = 0;
        const increment = target / 100;
        
        const updateCounter = () => {
            current += increment;
            if (current < target) {
                counter.textContent = Math.floor(current);
                requestAnimationFrame(updateCounter);
            } else {
                counter.textContent = target;
            }
        };
        updateCounter();
    });
}

// Trigger counter when in viewport
const observer = new IntersectionObserver(entries => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            animateCounter();
            observer.disconnect();
        }
    });
});
observer.observe(document.querySelector('.stats-counter'));

// Price Calculator (Real-time)
const pagesInput = document.getElementById('pages');
const typeSelect = document.getElementById('type');
const priceDisplay = document.getElementById('estimated-price');

function calculatePrice() {
    const pages = parseInt(pagesInput.value);
    const type = typeSelect.value;
    
    let pricePerPage = type === 'beli' ? 350000 : 150000;
    let total = pages * pricePerPage;
    
    // Format rupiah
    priceDisplay.textContent = 'Rp ' + total.toLocaleString('id-ID');
}

pagesInput.addEventListener('input', calculatePrice);
typeSelect.addEventListener('change', calculatePrice);
```

## Components & Partials

### 1. Header (partials/header.php)
```php
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= $title ?? 'SITUNEO Digital' ?></title>
    
    <!-- SEO Meta Tags -->
    <meta name="description" content="<?= $description ?? 'Platform Digital Agency Terlengkap di Indonesia' ?>">
    <meta name="keywords" content="<?= $keywords ?? 'website, digital agency, jasa website' ?>">
    
    <!-- Bootstrap 5.3.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Plus+Jakarta+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    
    <!-- AOS (Animate on Scroll) -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link href="<?= asset('css/main.css') ?>" rel="stylesheet">
    <link href="<?= asset('css/animations.css') ?>" rel="stylesheet">
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white fixed-top shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="/">
            <img src="<?= asset('img/logo.png') ?>" alt="SITUNEO" height="40">
        </a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="/">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="/about">Tentang Kami</a></li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">Layanan</a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="/services">Semua Layanan (232+)</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="/services/website">Website Development</a></li>
                        <li><a class="dropdown-item" href="/services/seo">SEO & Digital Marketing</a></li>
                        <!-- 8 other divisions -->
                    </ul>
                </li>
                <li class="nav-item"><a class="nav-link" href="/pricing">Harga</a></li>
                <li class="nav-item"><a class="nav-link" href="/portfolio">Portfolio</a></li>
                <li class="nav-item"><a class="nav-link" href="/contact">Kontak</a></li>
                <li class="nav-item"><a class="nav-link" href="/login">Login</a></li>
                <li class="nav-item"><a class="btn btn-primary ms-2" href="/register">Daftar Gratis</a></li>
            </ul>
        </div>
    </div>
</nav>
```

### 2. Footer (partials/footer.php)
```php
<!-- Footer -->
<footer class="footer bg-dark text-white pt-5 pb-3">
    <div class="container">
        <div class="row">
            <!-- Column 1: Company Info -->
            <div class="col-md-3">
                <h5>SITUNEO Digital</h5>
                <p>Platform Digital Agency Terlengkap di Indonesia</p>
                <div class="social-links mt-3">
                    <a href="#" class="text-white me-2"><i class="bi bi-facebook"></i></a>
                    <a href="#" class="text-white me-2"><i class="bi bi-instagram"></i></a>
                    <a href="#" class="text-white me-2"><i class="bi bi-linkedin"></i></a>
                    <a href="#" class="text-white"><i class="bi bi-youtube"></i></a>
                </div>
            </div>
            
            <!-- Column 2: Quick Links -->
            <div class="col-md-2">
                <h6>Tautan Cepat</h6>
                <ul class="list-unstyled">
                    <li><a href="/about" class="text-white-50">Tentang Kami</a></li>
                    <li><a href="/services" class="text-white-50">Layanan</a></li>
                    <li><a href="/pricing" class="text-white-50">Harga</a></li>
                    <li><a href="/portfolio" class="text-white-50">Portfolio</a></li>
                    <li><a href="/contact" class="text-white-50">Kontak</a></li>
                </ul>
            </div>
            
            <!-- Column 3: Services -->
            <div class="col-md-2">
                <h6>Layanan</h6>
                <ul class="list-unstyled">
                    <li><a href="/services/website" class="text-white-50">Website</a></li>
                    <li><a href="/services/seo" class="text-white-50">SEO</a></li>
                    <li><a href="/services/ads" class="text-white-50">Digital Ads</a></li>
                    <li><a href="/services/branding" class="text-white-50">Branding</a></li>
                    <li><a href="/services" class="text-white-50">Lihat Semua</a></li>
                </ul>
            </div>
            
            <!-- Column 4: Contact Info -->
            <div class="col-md-3">
                <h6>Kontak</h6>
                <p class="text-white-50 small">
                    <i class="bi bi-geo-alt"></i> Jl. Bekasi Timur IX Dalam No. 27<br>
                    Jakarta Timur 13450
                </p>
                <p class="text-white-50 small">
                    <i class="bi bi-telephone"></i> 021-8880-7229
                </p>
                <p class="text-white-50 small">
                    <i class="bi bi-whatsapp"></i> +62 831-7386-8915
                </p>
                <p class="text-white-50 small">
                    <i class="bi bi-envelope"></i> vins@situneo.my.id
                </p>
            </div>
            
            <!-- Column 5: NIB Badge -->
            <div class="col-md-2">
                <div class="nib-badge">
                    <img src="<?= asset('img/nib-badge.png') ?>" alt="NIB Badge" class="img-fluid pulse-animation">
                    <p class="text-white-50 small mt-2">NIB: 20250-9261-4570-4515-5453</p>
                </div>
            </div>
        </div>
        
        <hr class="bg-white-50 my-4">
        
        <div class="row">
            <div class="col-md-6">
                <p class="text-white-50 small mb-0">
                    © 2025 SITUNEO Digital. All rights reserved.
                </p>
            </div>
            <div class="col-md-6 text-md-end">
                <a href="/terms" class="text-white-50 small me-3">Terms & Conditions</a>
                <a href="/privacy" class="text-white-50 small">Privacy Policy</a>
            </div>
        </div>
    </div>
</footer>

<!-- WhatsApp Floating Button -->
<a href="https://wa.me/6283173868915" class="whatsapp-float" target="_blank">
    <i class="bi bi-whatsapp"></i>
</a>

<!-- Back to Top Button -->
<button id="back-to-top" class="back-to-top" style="display: none;">
    <i class="bi bi-arrow-up"></i>
</button>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- GSAP -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.5/gsap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.5/ScrollTrigger.min.js"></script>

<!-- AOS -->
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>

<!-- Custom JS -->
<script src="<?= asset('js/main.js') ?>"></script>
<script>
    // Initialize AOS
    AOS.init({
        duration: 800,
        once: true,
        offset: 100
    });
    
    // Back to Top
    window.addEventListener('scroll', () => {
        const btn = document.getElementById('back-to-top');
        if (window.scrollY > 300) {
            btn.style.display = 'block';
        } else {
            btn.style.display = 'none';
        }
    });
    
    document.getElementById('back-to-top').addEventListener('click', () => {
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });
</script>

</body>
</html>
```

## Deliverables Summary

| Component | Files | Lines | Status |
|-----------|-------|-------|--------|
| Public Pages | 14 files | ~3000 | 🔴 Todo |
| Partials | 5 files | ~500 | 🔴 Todo |
| CSS | 3 files | ~1500 | 🔴 Todo |
| JavaScript | 3 files | ~1000 | 🔴 Todo |
| Images/Assets | 50+ files | - | 🔴 Todo |

**Total Output:** ~6,000 lines HTML/CSS/JS + Assets

---

Saya akan buat file untuk **REMAINING BATCHES** (4-15) di file terpisah karena sudah terlalu panjang.

Mau saya lanjutkan dengan **BATCH 4-15** di file kedua? 📄