# 📘 MODULE 01: FOUNDATION & CORE SYSTEM

**PT SITUNEO DIGITAL SOLUSI INDONESIA**
**NIB:** 1401250064281

---

## 📋 DAFTAR ISI

1. [Pendahuluan](#1-pendahuluan)
2. [Environment Setup](#2-environment-setup)
3. [Project Structure](#3-project-structure)
4. [Database Development](#4-database-development)
5. [Configuration Files](#5-configuration-files)
6. [Helper Classes](#6-helper-classes)
7. [Models](#7-models)
8. [Controllers](#8-controllers)
9. [Views](#9-views)
10. [Assets](#10-assets)
11. [Testing](#11-testing)
12. [Troubleshooting](#12-troubleshooting)

---

## 1. PENDAHULUAN

### 1.1 Apa yang Akan Dibuat di Module Ini?

Module 01 adalah **FOUNDATION** dari seluruh sistem. Setelah selesai module ini, Anda akan punya:

✅ **Environment development** yang siap pakai
✅ **Database lengkap** dengan 208 tables
✅ **Authentication system** yang secure (login, register, verify email, reset password)
✅ **Admin panel basic** untuk manage users
✅ **Helper classes** untuk database, validation, email, session, CSRF
✅ **Structure** yang solid untuk 14 module berikutnya

### 1.2 Target Pembelajaran

**Beginner:**
- Cara setup environment development
- Membuat database & tables
- Basic PHP & MySQL operations
- HTML form & validation

**Intermediate:**
- PHP OOP (classes, methods)
- MVC pattern basics
- Session management
- Email sending (SMTP)

**Advanced:**
- Security best practices
- Database design & normalization
- PDO prepared statements
- CSRF protection

### 1.3 Estimasi Waktu

**Total:** 2-4 minggu (tergantung skill level)

**Breakdown:**
- Environment setup: 1 hari
- Database creation: 2-3 hari
- Helper classes: 3-4 hari
- Authentication: 5-7 hari
- Admin panel: 3-4 hari
- Testing & debugging: 3-5 hari

### 1.4 Prerequisites

**Required:**
- Komputer (Windows/Mac/Linux)
- Internet connection
- Basic computer literacy

**Helpful (tapi bisa dipelajari sambil jalan):**
- Basic HTML/CSS
- Basic PHP
- Basic MySQL

---

## 2. ENVIRONMENT SETUP

### 2.1 Install XAMPP (Recommended untuk Beginner)

**Download:**
1. Buka: https://www.apacheampp.org/
2. Download versi untuk OS Anda:
   - Windows: `xampp-windows-x64-8.0.30-installer.exe`
   - Mac: `xampp-osx-8.0.30-installer.dmg`
   - Linux: `xampp-linux-x64-8.0.30-installer.run`

**Install:**

**Windows:**
```
1. Double-click installer
2. Disable antivirus sementara (jika ada warning)
3. Choose components:
   ✅ Apache
   ✅ MySQL
   ✅ PHP
   ✅ phpMyAdmin
   ☐ Perl (tidak perlu)
   ☐ Tomcat (tidak perlu)
4. Install location: C:\xampp (default)
5. Click Next → Next → Install
6. Tunggu selesai (~5 menit)
7. Start XAMPP Control Panel
```

**Mac:**
```
1. Open .dmg file
2. Drag XAMPP to Applications
3. Open Terminal
4. Run: sudo /Applications/XAMPP/xamppfiles/xampp start
5. Enter password
```

**Linux (Ubuntu/Debian):**
```bash
# Make installer executable
chmod +x xampp-linux-x64-8.0.30-installer.run

# Run installer
sudo ./xampp-linux-x64-8.0.30-installer.run

# Start XAMPP
sudo /opt/lampp/lampp start
```

**Verify Installation:**
1. Open browser
2. Go to: `http://localhost`
3. Should see XAMPP dashboard
4. Go to: `http://localhost/phpmyadmin`
5. Should see phpMyAdmin

### 2.2 Alternative: Laragon (Windows Only)

**Download:**
https://laragon.org/download/

**Install:**
```
1. Double-click installer
2. Choose: Full
3. Install location: C:\laragon (default)
4. Auto-start: YES
5. Install
```

**Keuntungan Laragon:**
- ✅ Lebih ringan & cepat
- ✅ Auto virtual host (prettier URLs)
- ✅ Auto SSL (HTTPS)
- ✅ Terminal terintegrasi
- ✅ Easy switch PHP versions

### 2.3 Install Code Editor - Visual Studio Code

**Download:**
https://code.visualstudio.com/

**Install:**
1. Download installer
2. Install dengan default settings
3. Launch VS Code

**Install Extensions (Penting!):**

Buka VS Code → Extensions (Ctrl+Shift+X):

```
1. PHP Intelephense - PHP autocomplete & intellisense
2. MySQL - Database management
3. Better Comments - Color-coded comments
4. GitLens - Git integration
5. Live Server - Live preview HTML
6. Prettier - Code formatter
7. indent-rainbow - Lihat indentation jelas
8. Bracket Pair Colorizer - Colorful brackets
9. Path Intellisense - Autocomplete file paths
10. Auto Rename Tag - Rename HTML tags otomatis
```

**VS Code Settings (Optional tapi Recommended):**

File → Preferences → Settings → Search:

```json
{
    "editor.fontSize": 14,
    "editor.tabSize": 4,
    "editor.insertSpaces": true,
    "files.autoSave": "afterDelay",
    "files.autoSaveDelay": 1000,
    "php.validate.executablePath": "C:/xampp/php/php.exe",
    "php.suggest.basic": true
}
```

### 2.4 Install Git

**Download:**
- Windows: https://git-scm.com/download/win
- Mac: `brew install git` (via Homebrew)
- Linux: `sudo apt install git`

**Verify:**
```bash
git --version
# Should show: git version 2.x.x
```

**Configure:**
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### 2.5 Setup Project Folder

**Untuk XAMPP:**
```bash
# Windows
cd C:\xampp\htdocs

# Mac/Linux
cd /Applications/XAMPP/htdocs
```

**Untuk Laragon:**
```bash
cd C:\laragon\www
```

**Create Project:**
```bash
# Create folder
mkdir situneo-digital
cd situneo-digital

# Initialize Git
git init

# Create .gitignore
echo "vendor/" > .gitignore
echo "storage/" >> .gitignore
echo "config/database.php" >> .gitignore
echo ".env" >> .gitignore
echo ".DS_Store" >> .gitignore
echo "Thumbs.db" >> .gitignore

# First commit
git add .
git commit -m "Initial commit: Project structure"
```

---

## 3. PROJECT STRUCTURE

### 3.1 Create Folder Structure

**Run di Terminal/Command Prompt:**

```bash
# Di folder situneo-digital

# Main folders
mkdir public app config database storage docs

# Public folders
mkdir public/assets
mkdir public/assets/css
mkdir public/assets/js
mkdir public/assets/images
mkdir public/assets/fonts
mkdir public/uploads
mkdir public/uploads/profiles
mkdir public/uploads/documents
mkdir public/uploads/orders

# App folders
mkdir app/controllers
mkdir app/models
mkdir app/views
mkdir app/helpers
mkdir app/middleware

# Views folders
mkdir app/views/layouts
mkdir app/views/auth
mkdir app/views/admin
mkdir app/views/admin/users
mkdir app/views/admin/settings
mkdir app/views/client
mkdir app/views/partner
mkdir app/views/spv
mkdir app/views/manager
mkdir app/views/emails
mkdir app/views/errors
mkdir app/views/components

# Storage folders
mkdir storage/logs
mkdir storage/cache
mkdir storage/sessions

# Database folders
mkdir database/migrations
mkdir database/seeds
```

**Atau create manual via File Explorer/Finder.**

### 3.2 Final Structure

Setelah semua dibuat, structure akan seperti ini:

```
situneo-digital/
│
├── public/                          ← Web root (akses dari browser)
│   ├── index.php                    ← Entry point
│   ├── .htaccess                    ← URL rewriting
│   │
│   ├── assets/
│   │   ├── css/
│   │   │   ├── bootstrap.min.css
│   │   │   ├── style.css            ← Custom CSS
│   │   │   └── admin.css
│   │   │
│   │   ├── js/
│   │   │   ├── bootstrap.bundle.min.js
│   │   │   ├── jquery-3.7.1.min.js
│   │   │   ├── app.js
│   │   │   └── admin.js
│   │   │
│   │   ├── images/
│   │   │   ├── logo.png
│   │   │   ├── logo-white.png
│   │   │   ├── favicon.ico
│   │   │   └── placeholder.png
│   │   │
│   │   └── fonts/
│   │       └── (Font Awesome webfonts)
│   │
│   └── uploads/                     ← User uploads (chmod 777)
│       ├── profiles/
│       ├── documents/
│       └── orders/
│
├── app/
│   ├── controllers/
│   │   ├── AuthController.php       ← Login, register, verify
│   │   ├── DashboardController.php  ← Dashboards
│   │   ├── AdminController.php      ← Admin functions
│   │   ├── UserController.php       ← User management
│   │   └── ProfileController.php    ← Profile settings
│   │
│   ├── models/
│   │   ├── User.php                 ← User model
│   │   ├── UserRole.php
│   │   ├── UserProfile.php
│   │   ├── Admin.php
│   │   └── (208 models total - dibuat bertahap)
│   │
│   ├── views/
│   │   ├── layouts/
│   │   │   ├── header.php
│   │   │   ├── footer.php
│   │   │   ├── admin-header.php
│   │   │   └── admin-sidebar.php
│   │   │
│   │   ├── auth/
│   │   │   ├── login.php
│   │   │   ├── register.php
│   │   │   ├── verify-email.php
│   │   │   ├── forgot-password.php
│   │   │   └── reset-password.php
│   │   │
│   │   ├── admin/
│   │   │   ├── dashboard.php
│   │   │   ├── users/
│   │   │   │   ├── index.php
│   │   │   │   └── view.php
│   │   │   └── settings/
│   │   │       └── index.php
│   │   │
│   │   ├── client/
│   │   ├── partner/
│   │   ├── spv/
│   │   ├── manager/
│   │   ├── emails/
│   │   ├── errors/
│   │   └── components/
│   │
│   ├── helpers/
│   │   ├── Database.php             ← PDO wrapper
│   │   ├── Validator.php            ← Form validation
│   │   ├── Mailer.php               ← Email sending
│   │   ├── Session.php              ← Session management
│   │   ├── CSRF.php                 ← CSRF protection
│   │   ├── functions.php            ← Helper functions
│   │   └── constants.php            ← App constants
│   │
│   └── middleware/
│       ├── AuthMiddleware.php       ← Check if logged in
│       └── RoleMiddleware.php       ← Check user role
│
├── config/
│   ├── config.php                   ← App configuration
│   ├── database.php                 ← DB credentials
│   └── routes.php                   ← URL routing
│
├── database/
│   ├── situneo_digital.sql          ← Database SQL (208 tables)
│   └── sample_data.sql              ← Sample data
│
├── storage/
│   ├── logs/
│   │   ├── app.log
│   │   ├── error.log
│   │   ├── database.log
│   │   └── email.log
│   ├── cache/
│   └── sessions/
│
├── docs/
│   ├── API.md
│   └── CHANGELOG.md
│
├── .gitignore
├── .htaccess
├── .env
├── .env.example
└── README.md
```

**Total:** ~730 files (setelah semua module selesai)
**Module 01:** ~150 files

---

## 4. DATABASE DEVELOPMENT

### 4.1 Create Database

**Via phpMyAdmin:**

1. Buka: `http://localhost/phpmyadmin`
2. Click **New** (sidebar kiri)
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

### 4.2 Create Tables - ALL 208 TABLES

**IMPORTANT:** Copy semua SQL di bawah dan paste ke phpMyAdmin → SQL tab, lalu Execute.

Atau save ke file `database/situneo_digital.sql` dan import.

```sql
-- ============================================
-- PT SITUNEO DIGITAL SOLUSI INDONESIA
-- Database: situneo_digital
-- Tables: 208 tables
-- Version: 1.0
-- Generated: 2025-11-27
-- ============================================

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+07:00";

-- ============================================
-- CATEGORY A: USER MANAGEMENT (18 TABLES)
-- ============================================

-- 1. users (CORE TABLE)
CREATE TABLE `users` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `role_id` INT UNSIGNED NOT NULL DEFAULT 5 COMMENT '1=super_admin, 2=manager, 3=spv, 4=partner, 5=client',
  `email` VARCHAR(255) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL COMMENT 'bcrypt hashed',
  `first_name` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(20),
  `avatar` VARCHAR(255),
  `status` ENUM('active', 'inactive', 'suspended') DEFAULT 'active',
  `email_verified_at` TIMESTAMP NULL,
  `remember_token` VARCHAR(100),
  `last_login_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL COMMENT 'Soft delete',
  INDEX `idx_role_status` (`role_id`, `status`),
  INDEX `idx_email` (`email`),
  INDEX `idx_created` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabel utama untuk semua user (admin, manager, spv, partner, client)';

-- 2. user_roles
CREATE TABLE `user_roles` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `role_name` VARCHAR(50) NOT NULL UNIQUE COMMENT 'super_admin, manager, spv, partner, client',
  `role_display_name` VARCHAR(100) NOT NULL,
  `permissions` JSON COMMENT 'Array permissions',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Role user dan permissions';

-- Insert default roles
INSERT INTO `user_roles` (`id`, `role_name`, `role_display_name`, `permissions`) VALUES
(1, 'super_admin', 'Super Admin', '["all"]'),
(2, 'manager', 'Manager', '["view_reports", "manage_spv", "view_analytics"]'),
(3, 'spv', 'Supervisor', '["manage_partners", "view_team", "approve_sales"]'),
(4, 'partner', 'Partner', '["create_sales", "view_commission", "manage_clients"]'),
(5, 'client', 'Client', '["place_orders", "view_orders", "make_payments"]');

-- 3. user_permissions
CREATE TABLE `user_permissions` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `permission_name` VARCHAR(100) NOT NULL,
  `permission_value` ENUM('allow', 'deny') DEFAULT 'allow',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  INDEX `idx_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Custom permissions per user (override role permissions)';

-- 4. user_profiles
CREATE TABLE `user_profiles` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL UNIQUE,
  `date_of_birth` DATE,
  `gender` ENUM('male', 'female', 'other'),
  `address` TEXT,
  `city` VARCHAR(100),
  `province` VARCHAR(100),
  `postal_code` VARCHAR(10),
  `country` VARCHAR(100) DEFAULT 'Indonesia',
  `company_name` VARCHAR(255),
  `job_title` VARCHAR(100),
  `website` VARCHAR(255),
  `bio` TEXT,
  `social_facebook` VARCHAR(255),
  `social_twitter` VARCHAR(255),
  `social_instagram` VARCHAR(255),
  `social_linkedin` VARCHAR(255),
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Extended user information';

-- 5. user_sessions
CREATE TABLE `user_sessions` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `ip_address` VARCHAR(45),
  `user_agent` TEXT,
  `session_token` VARCHAR(255) NOT NULL UNIQUE,
  `last_activity` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `expires_at` TIMESTAMP NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  INDEX `idx_user_token` (`user_id`, `session_token`),
  INDEX `idx_expires` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Track user login sessions';

-- 6. user_login_history
CREATE TABLE `user_login_history` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `ip_address` VARCHAR(45),
  `user_agent` TEXT,
  `login_status` ENUM('success', 'failed') DEFAULT 'success',
  `failure_reason` VARCHAR(255),
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  INDEX `idx_user_created` (`user_id`, `created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Log semua login attempts';

-- 7. user_activity_logs
CREATE TABLE `user_activity_logs` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `activity_type` VARCHAR(100) NOT NULL,
  `activity_description` TEXT,
  `model_type` VARCHAR(100),
  `model_id` BIGINT UNSIGNED,
  `ip_address` VARCHAR(45),
  `user_agent` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  INDEX `idx_user_created` (`user_id`, `created_at`),
  INDEX `idx_model` (`model_type`, `model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Track user activities';

-- 8. user_notifications
CREATE TABLE `user_notifications` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `notification_type` VARCHAR(100) NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `message` TEXT NOT NULL,
  `action_url` VARCHAR(255),
  `read_at` TIMESTAMP NULL,
  `sent_via` ENUM('in_app', 'email', 'sms') DEFAULT 'in_app',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  INDEX `idx_user_read` (`user_id`, `read_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='User notifications';

-- 9. user_notification_settings
CREATE TABLE `user_notification_settings` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL UNIQUE,
  `email_notifications` BOOLEAN DEFAULT TRUE,
  `sms_notifications` BOOLEAN DEFAULT FALSE,
  `push_notifications` BOOLEAN DEFAULT TRUE,
  `notification_types` JSON,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='User notification preferences';

-- 10. user_api_tokens
CREATE TABLE `user_api_tokens` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `token_name` VARCHAR(100) NOT NULL,
  `token_hash` VARCHAR(255) NOT NULL UNIQUE,
  `abilities` JSON,
  `last_used_at` TIMESTAMP NULL,
  `expires_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  INDEX `idx_user` (`user_id`),
  INDEX `idx_token` (`token_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='API tokens untuk external integrations';

-- 11. user_two_factor_auth
CREATE TABLE `user_two_factor_auth` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL UNIQUE,
  `is_enabled` BOOLEAN DEFAULT FALSE,
  `method` ENUM('sms', 'email', 'authenticator') DEFAULT 'email',
  `phone_number` VARCHAR(20),
  `secret_key` VARCHAR(255),
  `backup_codes` JSON,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='2FA settings per user';

-- 12. user_settings
CREATE TABLE `user_settings` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL UNIQUE,
  `language` VARCHAR(10) DEFAULT 'id',
  `timezone` VARCHAR(50) DEFAULT 'Asia/Jakarta',
  `currency` VARCHAR(10) DEFAULT 'IDR',
  `date_format` VARCHAR(20) DEFAULT 'Y-m-d',
  `theme` ENUM('light', 'dark') DEFAULT 'light',
  `email_signature` TEXT,
  `settings_json` JSON,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='General user preferences';

-- 13. user_documents
CREATE TABLE `user_documents` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `document_type` ENUM('ktp', 'npwp', 'certificate', 'contract', 'other') NOT NULL,
  `document_name` VARCHAR(255) NOT NULL,
  `file_path` VARCHAR(255) NOT NULL,
  `file_size` INT UNSIGNED,
  `mime_type` VARCHAR(100),
  `verified_at` TIMESTAMP NULL,
  `verified_by` BIGINT UNSIGNED,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  INDEX `idx_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Upload KTP, NPWP, certificates, dll';

-- 14. user_bank_accounts
CREATE TABLE `user_bank_accounts` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `bank_name` VARCHAR(100) NOT NULL,
  `account_number` VARCHAR(50) NOT NULL,
  `account_holder_name` VARCHAR(255) NOT NULL,
  `branch` VARCHAR(255),
  `is_primary` BOOLEAN DEFAULT FALSE,
  `verified_at` TIMESTAMP NULL,
  `verified_by` BIGINT UNSIGNED,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  INDEX `idx_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bank account info untuk withdrawal';

-- 15. user_verification_requests
CREATE TABLE `user_verification_requests` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `verification_type` VARCHAR(100) NOT NULL,
  `verification_data` JSON,
  `status` ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
  `reviewed_by` BIGINT UNSIGNED,
  `reviewed_at` TIMESTAMP NULL,
  `rejection_reason` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  INDEX `idx_user_status` (`user_id`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Requests untuk verify documents/accounts';

-- 16. user_referrals
CREATE TABLE `user_referrals` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `referrer_id` BIGINT UNSIGNED NOT NULL COMMENT 'User yang refer',
  `referred_id` BIGINT UNSIGNED NOT NULL COMMENT 'User yang direferensikan',
  `referral_code` VARCHAR(50) NOT NULL UNIQUE,
  `registration_completed_at` TIMESTAMP NULL,
  `first_purchase_at` TIMESTAMP NULL,
  `reward_claimed` BOOLEAN DEFAULT FALSE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`referrer_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`referred_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  INDEX `idx_referrer` (`referrer_id`),
  INDEX `idx_referred` (`referred_id`),
  INDEX `idx_code` (`referral_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Track who referred who';

-- 17. user_blocks
CREATE TABLE `user_blocks` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `blocked_by` BIGINT UNSIGNED NOT NULL,
  `reason` TEXT NOT NULL,
  `block_type` ENUM('temporary', 'permanent') DEFAULT 'temporary',
  `expires_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`blocked_by`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  INDEX `idx_user_expires` (`user_id`, `expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Blocked users untuk prevent spam/abuse';

-- 18. password_resets
CREATE TABLE `password_resets` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `email` VARCHAR(255) NOT NULL,
  `token` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX `idx_email_token` (`email`, `token`),
  INDEX `idx_created` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Password reset tokens';
```

**CATATAN:** Ini baru **18 tables pertama** dari 208 total tables! Lanjut ke Category B-N di bawah.

```sql
-- ============================================
-- CATEGORY B: ADMIN SYSTEM (12 TABLES)
-- ============================================

-- 19. admins
CREATE TABLE `admins` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL UNIQUE COMMENT 'Reference ke users table',
  `admin_level` ENUM('super_admin', 'admin', 'moderator') DEFAULT 'admin',
  `department` VARCHAR(100),
  `employee_id` VARCHAR(50) UNIQUE,
  `hire_date` DATE,
  `salary` DECIMAL(15,2),
  `direct_phone` VARCHAR(20),
  `emergency_contact` VARCHAR(255),
  `notes` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  INDEX `idx_level` (`admin_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Extended info untuk admin users';

-- 20. admin_roles
CREATE TABLE `admin_roles` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `role_name` VARCHAR(100) NOT NULL UNIQUE,
  `role_description` TEXT,
  `permissions` JSON COMMENT 'Array of permission keys',
  `is_active` BOOLEAN DEFAULT TRUE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Custom admin roles untuk unlimited admins';

-- 21. admin_permissions
CREATE TABLE `admin_permissions` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `permission_key` VARCHAR(100) NOT NULL UNIQUE,
  `permission_name` VARCHAR(255) NOT NULL,
  `permission_group` VARCHAR(100),
  `description` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Master permissions list';

-- 22. admin_role_permissions
CREATE TABLE `admin_role_permissions` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `admin_id` BIGINT UNSIGNED NOT NULL,
  `admin_role_id` INT UNSIGNED NOT NULL,
  `assigned_by` BIGINT UNSIGNED,
  `assigned_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`admin_id`) REFERENCES `admins`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`admin_role_id`) REFERENCES `admin_roles`(`id`) ON DELETE CASCADE,
  INDEX `idx_admin` (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Mapping admin ke custom roles';

-- 23. admin_tasks
CREATE TABLE `admin_tasks` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `assigned_to` BIGINT UNSIGNED NOT NULL,
  `created_by` BIGINT UNSIGNED NOT NULL,
  `task_title` VARCHAR(255) NOT NULL,
  `task_description` TEXT,
  `priority` ENUM('low', 'medium', 'high', 'urgent') DEFAULT 'medium',
  `status` ENUM('pending', 'in_progress', 'completed', 'cancelled') DEFAULT 'pending',
  `due_date` TIMESTAMP NULL,
  `completed_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`assigned_to`) REFERENCES `admins`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`created_by`) REFERENCES `admins`(`id`) ON DELETE CASCADE,
  INDEX `idx_assignee_status` (`assigned_to`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Task management untuk admin team';

-- 24. admin_notes
CREATE TABLE `admin_notes` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `admin_id` BIGINT UNSIGNED NOT NULL,
  `note_type` VARCHAR(100) NOT NULL,
  `note_title` VARCHAR(255),
  `note_content` TEXT NOT NULL,
  `related_model` VARCHAR(100),
  `related_id` BIGINT UNSIGNED,
  `is_private` BOOLEAN DEFAULT FALSE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`admin_id`) REFERENCES `admins`(`id`) ON DELETE CASCADE,
  INDEX `idx_admin` (`admin_id`),
  INDEX `idx_related` (`related_model`, `related_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Internal notes untuk admin';

-- 25. admin_work_hours
CREATE TABLE `admin_work_hours` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `admin_id` BIGINT UNSIGNED NOT NULL,
  `date` DATE NOT NULL,
  `clock_in` TIME,
  `clock_out` TIME,
  `total_hours` DECIMAL(5,2),
  `break_minutes` INT DEFAULT 0,
  `notes` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`admin_id`) REFERENCES `admins`(`id`) ON DELETE CASCADE,
  UNIQUE KEY `idx_admin_date` (`admin_id`, `date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Track admin working hours';

-- 26. system_settings
CREATE TABLE `system_settings` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `setting_key` VARCHAR(100) NOT NULL UNIQUE,
  `setting_value` TEXT,
  `setting_type` ENUM('string', 'number', 'boolean', 'json') DEFAULT 'string',
  `setting_group` VARCHAR(100),
  `is_public` BOOLEAN DEFAULT FALSE,
  `updated_by` BIGINT UNSIGNED,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `idx_group` (`setting_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='System-wide configuration';

-- 27. system_maintenance
CREATE TABLE `system_maintenance` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `maintenance_mode` BOOLEAN DEFAULT FALSE,
  `maintenance_message` TEXT,
  `start_time` TIMESTAMP NULL,
  `end_time` TIMESTAMP NULL,
  `allowed_ips` JSON,
  `created_by` BIGINT UNSIGNED,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Maintenance mode settings';

-- 28. admin_announcement
CREATE TABLE `admin_announcement` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `created_by` BIGINT UNSIGNED NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `content` TEXT NOT NULL,
  `announcement_type` ENUM('info', 'warning', 'urgent') DEFAULT 'info',
  `target_roles` JSON COMMENT 'Array role_id yang ditarget',
  `is_published` BOOLEAN DEFAULT FALSE,
  `published_at` TIMESTAMP NULL,
  `expires_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`created_by`) REFERENCES `admins`(`id`) ON DELETE CASCADE,
  INDEX `idx_published` (`is_published`, `published_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Announcements dari admin ke users';

-- 29. admin_activity_logs
CREATE TABLE `admin_activity_logs` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `admin_id` BIGINT UNSIGNED NOT NULL,
  `action` VARCHAR(255) NOT NULL,
  `description` TEXT,
  `model_type` VARCHAR(100),
  `model_id` BIGINT UNSIGNED,
  `old_values` JSON,
  `new_values` JSON,
  `ip_address` VARCHAR(45),
  `user_agent` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`admin_id`) REFERENCES `admins`(`id`) ON DELETE CASCADE,
  INDEX `idx_admin_created` (`admin_id`, `created_at`),
  INDEX `idx_model` (`model_type`, `model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Audit trail untuk admin actions';

-- 30. admin_reports
CREATE TABLE `admin_reports` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `generated_by` BIGINT UNSIGNED NOT NULL,
  `report_name` VARCHAR(255) NOT NULL,
  `report_type` VARCHAR(100) NOT NULL,
  `parameters` JSON,
  `file_path` VARCHAR(255),
  `file_format` ENUM('pdf', 'excel', 'csv', 'json') DEFAULT 'pdf',
  `generated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`generated_by`) REFERENCES `admins`(`id`) ON DELETE CASCADE,
  INDEX `idx_generated` (`generated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Generated reports storage';

-- ============================================
-- CATEGORY C: PARTNER SYSTEM (28 TABLES)
-- ============================================

-- 31. partners
CREATE TABLE `partners` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL UNIQUE,
  `partner_code` VARCHAR(50) NOT NULL UNIQUE,
  `tier_id` INT UNSIGNED NOT NULL DEFAULT 1,
  `spv_id` BIGINT UNSIGNED NULL,
  `total_sales` DECIMAL(15,2) DEFAULT 0,
  `total_commission` DECIMAL(15,2) DEFAULT 0,
  `commission_rate` DECIMAL(5,2) DEFAULT 30.00 COMMENT 'Current rate based on tier',
  `join_date` DATE NOT NULL,
  `status` ENUM('active', 'inactive', 'suspended') DEFAULT 'active',
  `notes` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`spv_id`) REFERENCES `spv`(`id`) ON DELETE SET NULL,
  INDEX `idx_tier` (`tier_id`),
  INDEX `idx_spv` (`spv_id`),
  INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Partner data dengan commission tracking';

-- 32. partner_tiers
CREATE TABLE `partner_tiers` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `tier_name` VARCHAR(50) NOT NULL,
  `tier_number` INT NOT NULL UNIQUE,
  `min_sales` DECIMAL(15,2) NOT NULL COMMENT 'Minimum sales per month',
  `max_sales` DECIMAL(15,2) NULL,
  `commission_rate` DECIMAL(5,2) NOT NULL,
  `benefits` JSON,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Commission tiers (30-55%)';

-- Insert default tiers
INSERT INTO `partner_tiers` VALUES
(1, 'TIER 1', 1, 0, 10000000, 30.00, '["Basic training", "Email support"]', NOW(), NOW()),
(2, 'TIER 2', 2, 10000000, 25000000, 40.00, '["Advanced training", "Priority support", "Marketing materials"]', NOW(), NOW()),
(3, 'TIER 3', 3, 25000000, 50000000, 50.00, '["VIP training", "24/7 support", "Custom marketing", "Early access"]', NOW(), NOW()),
(4, 'TIER MAX', 4, 50000000, NULL, 55.00, '["All TIER 3 benefits", "Exclusive events", "Dedicated account manager"]', NOW(), NOW());

-- 33. partner_tier_history
CREATE TABLE `partner_tier_history` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `old_tier_id` INT UNSIGNED,
  `new_tier_id` INT UNSIGNED NOT NULL,
  `reason` TEXT,
  `effective_date` DATE NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  INDEX `idx_partner` (`partner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Track tier changes (up and down)';

-- 34. partner_sales
CREATE TABLE `partner_sales` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `order_id` BIGINT UNSIGNED NOT NULL,
  `client_id` BIGINT UNSIGNED NOT NULL,
  `sale_amount` DECIMAL(15,2) NOT NULL,
  `commission_rate` DECIMAL(5,2) NOT NULL,
  `commission_amount` DECIMAL(15,2) NOT NULL,
  `spv_commission` DECIMAL(15,2) DEFAULT 0,
  `manager_commission` DECIMAL(15,2) DEFAULT 0,
  `sale_date` DATE NOT NULL,
  `payment_status` ENUM('pending', 'paid', 'cancelled') DEFAULT 'pending',
  `paid_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`client_id`) REFERENCES `clients`(`id`) ON DELETE CASCADE,
  INDEX `idx_partner_date` (`partner_id`, `sale_date`),
  INDEX `idx_payment` (`payment_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Every sale by partner';

-- 35. partner_commission_summary
CREATE TABLE `partner_commission_summary` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `month` DATE NOT NULL COMMENT 'First day of month',
  `total_sales` DECIMAL(15,2) DEFAULT 0,
  `total_commission` DECIMAL(15,2) DEFAULT 0,
  `commission_paid` DECIMAL(15,2) DEFAULT 0,
  `commission_pending` DECIMAL(15,2) DEFAULT 0,
  `tier_at_month_end` INT UNSIGNED,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  UNIQUE KEY `idx_partner_month` (`partner_id`, `month`),
  INDEX `idx_month` (`month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Monthly commission summary per partner';

-- 36. partner_arpu_tracking
CREATE TABLE `partner_arpu_tracking` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `month` DATE NOT NULL,
  `total_clients` INT UNSIGNED DEFAULT 0,
  `total_revenue` DECIMAL(15,2) DEFAULT 0,
  `arpu` DECIMAL(15,2) DEFAULT 0 COMMENT 'Average Revenue Per User',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  UNIQUE KEY `idx_partner_month` (`partner_id`, `month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ARPU tracking untuk bonus calculation';

-- 37. partner_clients
CREATE TABLE `partner_clients` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `client_id` BIGINT UNSIGNED NOT NULL,
  `acquired_date` DATE NOT NULL,
  `first_order_date` DATE,
  `last_order_date` DATE,
  `total_orders` INT UNSIGNED DEFAULT 0,
  `total_spent` DECIMAL(15,2) DEFAULT 0,
  `status` ENUM('active', 'inactive', 'churned') DEFAULT 'active',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`client_id`) REFERENCES `clients`(`id`) ON DELETE CASCADE,
  UNIQUE KEY `idx_partner_client` (`partner_id`, `client_id`),
  INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Mapping partner ke clients mereka';

-- 38. partner_leads
CREATE TABLE `partner_leads` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `lead_name` VARCHAR(255) NOT NULL,
  `lead_email` VARCHAR(255),
  `lead_phone` VARCHAR(20),
  `lead_company` VARCHAR(255),
  `lead_source` VARCHAR(100),
  `status` ENUM('new', 'contacted', 'qualified', 'proposal', 'negotiation', 'won', 'lost') DEFAULT 'new',
  `expected_value` DECIMAL(15,2),
  `notes` TEXT,
  `converted_to_client_id` BIGINT UNSIGNED NULL,
  `converted_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  INDEX `idx_partner_status` (`partner_id`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Lead management untuk partners';

-- 39. partner_withdrawal_requests
CREATE TABLE `partner_withdrawal_requests` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `amount` DECIMAL(15,2) NOT NULL,
  `bank_account_id` BIGINT UNSIGNED NOT NULL,
  `status` ENUM('pending', 'approved', 'processing', 'completed', 'rejected', 'cancelled') DEFAULT 'pending',
  `requested_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `processed_by` BIGINT UNSIGNED NULL,
  `processed_at` TIMESTAMP NULL,
  `payment_proof` VARCHAR(255),
  `rejection_reason` TEXT,
  `notes` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`bank_account_id`) REFERENCES `user_bank_accounts`(`id`),
  INDEX `idx_partner_status` (`partner_id`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Partner withdrawal requests';

-- 40. partner_training_progress
CREATE TABLE `partner_training_progress` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `training_module` VARCHAR(255) NOT NULL,
  `module_category` VARCHAR(100),
  `progress_percentage` DECIMAL(5,2) DEFAULT 0,
  `completed_at` TIMESTAMP NULL,
  `quiz_score` DECIMAL(5,2),
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  INDEX `idx_partner` (`partner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Training completion tracking';

-- 41. partner_performance_metrics
CREATE TABLE `partner_performance_metrics` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `metric_date` DATE NOT NULL,
  `new_clients` INT UNSIGNED DEFAULT 0,
  `new_orders` INT UNSIGNED DEFAULT 0,
  `revenue_generated` DECIMAL(15,2) DEFAULT 0,
  `commission_earned` DECIMAL(15,2) DEFAULT 0,
  `client_retention_rate` DECIMAL(5,2) DEFAULT 0,
  `average_order_value` DECIMAL(15,2) DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  UNIQUE KEY `idx_partner_date` (`partner_id`, `metric_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Daily performance metrics';

-- 42. partner_targets
CREATE TABLE `partner_targets` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `month` DATE NOT NULL,
  `sales_target` DECIMAL(15,2) NOT NULL,
  `clients_target` INT UNSIGNED NOT NULL,
  `sales_achieved` DECIMAL(15,2) DEFAULT 0,
  `clients_achieved` INT UNSIGNED DEFAULT 0,
  `target_met` BOOLEAN DEFAULT FALSE,
  `bonus_earned` DECIMAL(15,2) DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  UNIQUE KEY `idx_partner_month` (`partner_id`, `month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Monthly targets & achievements';

-- 43. partner_incentives
CREATE TABLE `partner_incentives` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `incentive_type` VARCHAR(100) NOT NULL,
  `incentive_description` TEXT,
  `amount` DECIMAL(15,2) NOT NULL,
  `earned_date` DATE NOT NULL,
  `paid_status` ENUM('pending', 'paid') DEFAULT 'pending',
  `paid_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  INDEX `idx_partner_date` (`partner_id`, `earned_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Extra incentives & bonuses';

-- 44. partner_complaints
CREATE TABLE `partner_complaints` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `complaint_type` VARCHAR(100) NOT NULL,
  `subject` VARCHAR(255) NOT NULL,
  `description` TEXT NOT NULL,
  `priority` ENUM('low', 'medium', 'high', 'urgent') DEFAULT 'medium',
  `status` ENUM('open', 'investigating', 'resolved', 'closed') DEFAULT 'open',
  `assigned_to` BIGINT UNSIGNED NULL,
  `resolved_at` TIMESTAMP NULL,
  `resolution_notes` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  INDEX `idx_partner_status` (`partner_id`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Partner complaints & issues';

-- 45. partner_communication_logs
CREATE TABLE `partner_communication_logs` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `communication_type` ENUM('call', 'email', 'meeting', 'chat', 'sms') NOT NULL,
  `initiated_by` BIGINT UNSIGNED NOT NULL COMMENT 'User ID who initiated',
  `subject` VARCHAR(255),
  `notes` TEXT,
  `communication_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  INDEX `idx_partner_date` (`partner_id`, `communication_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Log all communications with partners';

-- 46. partner_documents
CREATE TABLE `partner_documents` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `document_type` VARCHAR(100) NOT NULL,
  `document_name` VARCHAR(255) NOT NULL,
  `file_path` VARCHAR(255) NOT NULL,
  `file_size` INT UNSIGNED,
  `uploaded_by` BIGINT UNSIGNED,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  INDEX `idx_partner` (`partner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Contracts, agreements, certificates';

-- 47. partner_ratings
CREATE TABLE `partner_ratings` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `rated_by` BIGINT UNSIGNED NOT NULL COMMENT 'Client or SPV',
  `rating_type` ENUM('client_satisfaction', 'spv_evaluation') NOT NULL,
  `rating` DECIMAL(3,2) NOT NULL COMMENT '1.00 to 5.00',
  `review` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  INDEX `idx_partner` (`partner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Performance ratings';

-- 48. partner_team_members
CREATE TABLE `partner_team_members` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `member_name` VARCHAR(255) NOT NULL,
  `member_role` VARCHAR(100),
  `member_email` VARCHAR(255),
  `member_phone` VARCHAR(20),
  `is_active` BOOLEAN DEFAULT TRUE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  INDEX `idx_partner` (`partner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Partner team members (for company partners)';

-- 49. partner_availability
CREATE TABLE `partner_availability` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `day_of_week` ENUM('monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday') NOT NULL,
  `start_time` TIME NOT NULL,
  `end_time` TIME NOT NULL,
  `is_available` BOOLEAN DEFAULT TRUE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  INDEX `idx_partner` (`partner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Partner working hours';

-- 50. partner_service_specialization
CREATE TABLE `partner_service_specialization` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `service_category_id` BIGINT UNSIGNED NOT NULL,
  `expertise_level` ENUM('beginner', 'intermediate', 'advanced', 'expert') DEFAULT 'intermediate',
  `years_experience` INT UNSIGNED DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  INDEX `idx_partner` (`partner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Partner expertise areas';

-- 51. partner_certifications
CREATE TABLE `partner_certifications` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `certification_name` VARCHAR(255) NOT NULL,
  `issuing_organization` VARCHAR(255),
  `issue_date` DATE,
  `expiry_date` DATE,
  `credential_id` VARCHAR(255),
  `credential_url` VARCHAR(255),
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  INDEX `idx_partner` (`partner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Professional certifications';

-- 52. partner_payout_methods
CREATE TABLE `partner_payout_methods` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `method_type` ENUM('bank_transfer', 'e_wallet', 'cryptocurrency') NOT NULL,
  `method_details` JSON NOT NULL,
  `is_primary` BOOLEAN DEFAULT FALSE,
  `is_verified` BOOLEAN DEFAULT FALSE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  INDEX `idx_partner` (`partner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Flexible payout options';

-- 53. partner_referral_codes
CREATE TABLE `partner_referral_codes` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `referral_code` VARCHAR(50) NOT NULL UNIQUE,
  `code_type` ENUM('personal', 'campaign', 'special') DEFAULT 'personal',
  `usage_count` INT UNSIGNED DEFAULT 0,
  `max_uses` INT UNSIGNED NULL,
  `discount_percentage` DECIMAL(5,2) DEFAULT 0,
  `is_active` BOOLEAN DEFAULT TRUE,
  `expires_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  INDEX `idx_code` (`referral_code`),
  INDEX `idx_partner` (`partner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Custom referral codes per partner';

-- 54. partner_login_restrictions
CREATE TABLE `partner_login_restrictions` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL UNIQUE,
  `allowed_ips` JSON,
  `allowed_countries` JSON,
  `two_factor_required` BOOLEAN DEFAULT FALSE,
  `max_concurrent_sessions` INT UNSIGNED DEFAULT 3,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Security restrictions per partner';

-- 55. partner_suspension_history
CREATE TABLE `partner_suspension_history` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `suspended_by` BIGINT UNSIGNED NOT NULL,
  `reason` TEXT NOT NULL,
  `suspended_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `lifted_at` TIMESTAMP NULL,
  `lifted_by` BIGINT UNSIGNED NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  INDEX `idx_partner` (`partner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Suspension audit trail';

-- 56. partner_earnings_adjustments
CREATE TABLE `partner_earnings_adjustments` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `adjustment_type` ENUM('bonus', 'penalty', 'correction', 'refund') NOT NULL,
  `amount` DECIMAL(15,2) NOT NULL COMMENT 'Positive or negative',
  `reason` TEXT NOT NULL,
  `adjusted_by` BIGINT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  INDEX `idx_partner` (`partner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Manual commission adjustments';

-- 57. partner_subscription_plans
CREATE TABLE `partner_subscription_plans` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `plan_name` VARCHAR(100) NOT NULL,
  `plan_features` JSON,
  `monthly_fee` DECIMAL(10,2) DEFAULT 0,
  `start_date` DATE NOT NULL,
  `end_date` DATE NULL,
  `auto_renew` BOOLEAN DEFAULT TRUE,
  `status` ENUM('active', 'cancelled', 'expired') DEFAULT 'active',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  INDEX `idx_partner` (`partner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Partner subscription tiers (if applicable)';

-- 58. partner_analytics_summary
CREATE TABLE `partner_analytics_summary` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `report_date` DATE NOT NULL,
  `total_clients` INT UNSIGNED DEFAULT 0,
  `active_clients` INT UNSIGNED DEFAULT 0,
  `total_revenue` DECIMAL(15,2) DEFAULT 0,
  `total_orders` INT UNSIGNED DEFAULT 0,
  `avg_order_value` DECIMAL(15,2) DEFAULT 0,
  `conversion_rate` DECIMAL(5,2) DEFAULT 0,
  `client_retention_rate` DECIMAL(5,2) DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  UNIQUE KEY `idx_partner_date` (`partner_id`, `report_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Daily analytics snapshot';
```

### 4.3 Insert Sample Data

```sql
-- ============================================
-- SAMPLE DATA
-- ============================================

-- Insert default Super Admin
INSERT INTO `users` (`id`, `role_id`, `email`, `password`, `first_name`, `last_name`, `phone`, `status`, `email_verified_at`) VALUES
(1, 1, 'admin@situneo.my.id', '$2y$12$LQv3c1yYqBW/XC9gQx7WCe92pso/czJQjNGg.hKNE9K8F7kVJlO4W', 'Super', 'Admin', '081234567890', 'active', NOW());
-- Password: Admin123!

-- Insert admin profile
INSERT INTO `user_profiles` (`user_id`, `city`, `province`, `country`) VALUES
(1, 'Jakarta', 'DKI Jakarta', 'Indonesia');
```

**Generate Password Hash** (untuk testing):

```php
<?php
// Jalankan ini di browser: http://localhost/situneo-digital/test-password.php
echo password_hash('Admin123!', PASSWORD_BCRYPT, ['cost' => 12]);
?>
```

-- ============================================
-- CATEGORY D: SPV SYSTEM (15 TABLES)
-- ============================================

-- 59. spv
CREATE TABLE `spv` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL UNIQUE,
  `spv_code` VARCHAR(50) NOT NULL UNIQUE,
  `manager_id` BIGINT UNSIGNED NULL,
  `total_partners` INT UNSIGNED DEFAULT 0,
  `total_team_sales` DECIMAL(15,2) DEFAULT 0,
  `total_commission` DECIMAL(15,2) DEFAULT 0,
  `commission_rate` DECIMAL(5,2) DEFAULT 10.00 COMMENT 'SPV gets 10%',
  `join_date` DATE NOT NULL,
  `status` ENUM('active', 'inactive', 'suspended') DEFAULT 'active',
  `notes` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`manager_id`) REFERENCES `managers`(`id`) ON DELETE SET NULL,
  INDEX `idx_manager` (`manager_id`),
  INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='SPV (Supervisor) managing partners';

-- 60. spv_partner_mapping
CREATE TABLE `spv_partner_mapping` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `assigned_date` DATE NOT NULL,
  `unassigned_date` DATE NULL,
  `is_active` BOOLEAN DEFAULT TRUE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`spv_id`) REFERENCES `spv`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  UNIQUE KEY `idx_spv_partner` (`spv_id`, `partner_id`),
  INDEX `idx_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Which partners belong to which SPV';

-- 61. spv_commission
CREATE TABLE `spv_commission` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `partner_sale_id` BIGINT UNSIGNED NOT NULL,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `sale_amount` DECIMAL(15,2) NOT NULL,
  `commission_rate` DECIMAL(5,2) NOT NULL DEFAULT 10.00,
  `commission_amount` DECIMAL(15,2) NOT NULL,
  `commission_date` DATE NOT NULL,
  `payment_status` ENUM('pending', 'paid', 'cancelled') DEFAULT 'pending',
  `paid_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`spv_id`) REFERENCES `spv`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`partner_sale_id`) REFERENCES `partner_sales`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  INDEX `idx_spv_date` (`spv_id`, `commission_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='SPV commission dari partner sales (10%)';

-- 62. spv_arpu_bonuses
CREATE TABLE `spv_arpu_bonuses` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `month` DATE NOT NULL,
  `total_team_revenue` DECIMAL(15,2) DEFAULT 0,
  `total_team_clients` INT UNSIGNED DEFAULT 0,
  `team_arpu` DECIMAL(15,2) DEFAULT 0,
  `bonus_tier` VARCHAR(50),
  `bonus_amount` DECIMAL(15,2) DEFAULT 0,
  `paid_status` ENUM('pending', 'paid') DEFAULT 'pending',
  `paid_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`spv_id`) REFERENCES `spv`(`id`) ON DELETE CASCADE,
  UNIQUE KEY `idx_spv_month` (`spv_id`, `month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ARPU bonuses untuk SPV (Rp 500K - Rp 10M)';

-- 63. spv_team_performance
CREATE TABLE `spv_team_performance` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `month` DATE NOT NULL,
  `total_partners` INT UNSIGNED DEFAULT 0,
  `active_partners` INT UNSIGNED DEFAULT 0,
  `total_sales` DECIMAL(15,2) DEFAULT 0,
  `total_commission_earned` DECIMAL(15,2) DEFAULT 0,
  `avg_partner_performance` DECIMAL(5,2) DEFAULT 0,
  `team_rank` INT UNSIGNED,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`spv_id`) REFERENCES `spv`(`id`) ON DELETE CASCADE,
  UNIQUE KEY `idx_spv_month` (`spv_id`, `month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Monthly team performance metrics';

-- 64. spv_targets
CREATE TABLE `spv_targets` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `month` DATE NOT NULL,
  `team_sales_target` DECIMAL(15,2) NOT NULL,
  `team_sales_achieved` DECIMAL(15,2) DEFAULT 0,
  `partners_target` INT UNSIGNED NOT NULL,
  `partners_achieved` INT UNSIGNED DEFAULT 0,
  `target_met` BOOLEAN DEFAULT FALSE,
  `bonus_earned` DECIMAL(15,2) DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`spv_id`) REFERENCES `spv`(`id`) ON DELETE CASCADE,
  UNIQUE KEY `idx_spv_month` (`spv_id`, `month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Monthly targets untuk SPV team';

-- 65. spv_partner_recruitment
CREATE TABLE `spv_partner_recruitment` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `recruited_partner_id` BIGINT UNSIGNED NOT NULL,
  `recruitment_date` DATE NOT NULL,
  `recruitment_source` VARCHAR(100),
  `onboarding_completed` BOOLEAN DEFAULT FALSE,
  `onboarding_completed_at` TIMESTAMP NULL,
  `first_sale_date` DATE NULL,
  `recruitment_bonus` DECIMAL(10,2) DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`spv_id`) REFERENCES `spv`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`recruited_partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  INDEX `idx_spv` (`spv_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Track partner recruitment by SPV';

-- 66. spv_training_sessions
CREATE TABLE `spv_training_sessions` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `training_title` VARCHAR(255) NOT NULL,
  `training_description` TEXT,
  `training_date` DATE NOT NULL,
  `training_time` TIME NOT NULL,
  `location` VARCHAR(255),
  `training_type` ENUM('onboarding', 'product', 'sales', 'technical', 'other') DEFAULT 'product',
  `max_participants` INT UNSIGNED,
  `total_attendees` INT UNSIGNED DEFAULT 0,
  `status` ENUM('scheduled', 'ongoing', 'completed', 'cancelled') DEFAULT 'scheduled',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`spv_id`) REFERENCES `spv`(`id`) ON DELETE CASCADE,
  INDEX `idx_spv_date` (`spv_id`, `training_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Training sessions organized by SPV';

-- 67. spv_team_meetings
CREATE TABLE `spv_team_meetings` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `meeting_title` VARCHAR(255) NOT NULL,
  `meeting_agenda` TEXT,
  `meeting_date` DATE NOT NULL,
  `meeting_time` TIME NOT NULL,
  `meeting_type` ENUM('weekly', 'monthly', 'quarterly', 'ad_hoc') DEFAULT 'weekly',
  `attendees` JSON COMMENT 'Array of partner IDs',
  `meeting_notes` TEXT,
  `action_items` JSON,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`spv_id`) REFERENCES `spv`(`id`) ON DELETE CASCADE,
  INDEX `idx_spv_date` (`spv_id`, `meeting_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Team meetings by SPV';

-- 68. spv_partner_performance_reviews
CREATE TABLE `spv_partner_performance_reviews` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `review_period_start` DATE NOT NULL,
  `review_period_end` DATE NOT NULL,
  `sales_performance` DECIMAL(3,2) COMMENT 'Rating 1-5',
  `client_satisfaction` DECIMAL(3,2),
  `communication_skills` DECIMAL(3,2),
  `professionalism` DECIMAL(3,2),
  `overall_rating` DECIMAL(3,2),
  `strengths` TEXT,
  `areas_for_improvement` TEXT,
  `action_plan` TEXT,
  `reviewed_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`spv_id`) REFERENCES `spv`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  INDEX `idx_spv_partner` (`spv_id`, `partner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Partner performance reviews by SPV';

-- 69. spv_withdrawal_requests
CREATE TABLE `spv_withdrawal_requests` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `amount` DECIMAL(15,2) NOT NULL,
  `bank_account_id` BIGINT UNSIGNED NOT NULL,
  `status` ENUM('pending', 'approved', 'processing', 'completed', 'rejected', 'cancelled') DEFAULT 'pending',
  `requested_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `processed_by` BIGINT UNSIGNED NULL,
  `processed_at` TIMESTAMP NULL,
  `payment_proof` VARCHAR(255),
  `rejection_reason` TEXT,
  `notes` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`spv_id`) REFERENCES `spv`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`bank_account_id`) REFERENCES `user_bank_accounts`(`id`),
  INDEX `idx_spv_status` (`spv_id`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='SPV withdrawal requests';

-- 70. spv_incentives
CREATE TABLE `spv_incentives` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `incentive_type` VARCHAR(100) NOT NULL,
  `incentive_description` TEXT,
  `amount` DECIMAL(15,2) NOT NULL,
  `earned_date` DATE NOT NULL,
  `paid_status` ENUM('pending', 'paid') DEFAULT 'pending',
  `paid_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`spv_id`) REFERENCES `spv`(`id`) ON DELETE CASCADE,
  INDEX `idx_spv_date` (`spv_id`, `earned_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Additional incentives untuk SPV';

-- 71. spv_complaints
CREATE TABLE `spv_complaints` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `complaint_type` VARCHAR(100) NOT NULL,
  `subject` VARCHAR(255) NOT NULL,
  `description` TEXT NOT NULL,
  `priority` ENUM('low', 'medium', 'high', 'urgent') DEFAULT 'medium',
  `status` ENUM('open', 'investigating', 'resolved', 'closed') DEFAULT 'open',
  `assigned_to` BIGINT UNSIGNED NULL,
  `resolved_at` TIMESTAMP NULL,
  `resolution_notes` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`spv_id`) REFERENCES `spv`(`id`) ON DELETE CASCADE,
  INDEX `idx_spv_status` (`spv_id`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='SPV complaints & issues';

-- 72. spv_reports
CREATE TABLE `spv_reports` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `report_type` VARCHAR(100) NOT NULL,
  `report_period_start` DATE NOT NULL,
  `report_period_end` DATE NOT NULL,
  `report_data` JSON,
  `generated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`spv_id`) REFERENCES `spv`(`id`) ON DELETE CASCADE,
  INDEX `idx_spv` (`spv_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Reports generated by SPV';

-- 73. spv_communication_logs
CREATE TABLE `spv_communication_logs` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `partner_id` BIGINT UNSIGNED NULL,
  `communication_type` ENUM('call', 'email', 'meeting', 'chat', 'sms') NOT NULL,
  `subject` VARCHAR(255),
  `notes` TEXT,
  `communication_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`spv_id`) REFERENCES `spv`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE SET NULL,
  INDEX `idx_spv_date` (`spv_id`, `communication_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Communication logs with partners';
```

**Progress: 73 of 208 tables complete!** File terus berlanjut dengan Category E, F, G, H, I, J, K, L, M, N...-- ============================================
-- CATEGORY E: MANAGER SYSTEM (15 TABLES)
-- Tables 74-88
-- ============================================

-- 74. managers
CREATE TABLE `managers` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL UNIQUE,
  `manager_code` VARCHAR(50) NOT NULL UNIQUE,
  `division` VARCHAR(100) NOT NULL COMMENT 'Which of 10 divisions',
  `total_spv` INT UNSIGNED DEFAULT 0,
  `total_partners` INT UNSIGNED DEFAULT 0,
  `total_division_sales` DECIMAL(15,2) DEFAULT 0,
  `total_commission` DECIMAL(15,2) DEFAULT 0,
  `commission_rate` DECIMAL(5,2) DEFAULT 5.00 COMMENT 'Manager gets 5%',
  `join_date` DATE NOT NULL,
  `status` ENUM('active', 'inactive', 'suspended') DEFAULT 'active',
  `notes` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  INDEX `idx_division` (`division`),
  INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Manager managing SPVs in a division';

-- 75. manager_spv_mapping
CREATE TABLE `manager_spv_mapping` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `assigned_date` DATE NOT NULL,
  `unassigned_date` DATE NULL,
  `is_active` BOOLEAN DEFAULT TRUE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`manager_id`) REFERENCES `managers`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`spv_id`) REFERENCES `spv`(`id`) ON DELETE CASCADE,
  UNIQUE KEY `idx_manager_spv` (`manager_id`, `spv_id`),
  INDEX `idx_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Which SPVs belong to which Manager';

-- 76. manager_commission
CREATE TABLE `manager_commission` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `partner_sale_id` BIGINT UNSIGNED NOT NULL,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `sale_amount` DECIMAL(15,2) NOT NULL,
  `commission_rate` DECIMAL(5,2) NOT NULL DEFAULT 5.00,
  `commission_amount` DECIMAL(15,2) NOT NULL,
  `commission_date` DATE NOT NULL,
  `payment_status` ENUM('pending', 'paid', 'cancelled') DEFAULT 'pending',
  `paid_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`manager_id`) REFERENCES `managers`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`partner_sale_id`) REFERENCES `partner_sales`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`spv_id`) REFERENCES `spv`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE CASCADE,
  INDEX `idx_manager_date` (`manager_id`, `commission_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Manager commission dari division sales (5%)';

-- 77. manager_arpu_bonuses
CREATE TABLE `manager_arpu_bonuses` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `month` DATE NOT NULL,
  `total_division_revenue` DECIMAL(15,2) DEFAULT 0,
  `total_division_clients` INT UNSIGNED DEFAULT 0,
  `division_arpu` DECIMAL(15,2) DEFAULT 0,
  `bonus_tier` VARCHAR(50),
  `bonus_amount` DECIMAL(15,2) DEFAULT 0,
  `paid_status` ENUM('pending', 'paid') DEFAULT 'pending',
  `paid_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`manager_id`) REFERENCES `managers`(`id`) ON DELETE CASCADE,
  UNIQUE KEY `idx_manager_month` (`manager_id`, `month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ARPU bonuses untuk Manager (Rp 1M - Rp 15M)';

-- 78. manager_team_performance
CREATE TABLE `manager_team_performance` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `month` DATE NOT NULL,
  `total_spv` INT UNSIGNED DEFAULT 0,
  `total_partners` INT UNSIGNED DEFAULT 0,
  `total_sales` DECIMAL(15,2) DEFAULT 0,
  `total_commission_earned` DECIMAL(15,2) DEFAULT 0,
  `avg_spv_performance` DECIMAL(5,2) DEFAULT 0,
  `division_rank` INT UNSIGNED,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`manager_id`) REFERENCES `managers`(`id`) ON DELETE CASCADE,
  UNIQUE KEY `idx_manager_month` (`manager_id`, `month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Monthly division performance';

-- 79. manager_targets
CREATE TABLE `manager_targets` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `month` DATE NOT NULL,
  `division_sales_target` DECIMAL(15,2) NOT NULL,
  `division_sales_achieved` DECIMAL(15,2) DEFAULT 0,
  `spv_target` INT UNSIGNED NOT NULL,
  `spv_achieved` INT UNSIGNED DEFAULT 0,
  `target_met` BOOLEAN DEFAULT FALSE,
  `bonus_earned` DECIMAL(15,2) DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`manager_id`) REFERENCES `managers`(`id`) ON DELETE CASCADE,
  UNIQUE KEY `idx_manager_month` (`manager_id`, `month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Monthly targets untuk Manager division';

-- 80. manager_spv_recruitment
CREATE TABLE `manager_spv_recruitment` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `recruited_spv_id` BIGINT UNSIGNED NOT NULL,
  `recruitment_date` DATE NOT NULL,
  `recruitment_source` VARCHAR(100),
  `onboarding_completed` BOOLEAN DEFAULT FALSE,
  `onboarding_completed_at` TIMESTAMP NULL,
  `first_team_sale_date` DATE NULL,
  `recruitment_bonus` DECIMAL(10,2) DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`manager_id`) REFERENCES `managers`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`recruited_spv_id`) REFERENCES `spv`(`id`) ON DELETE CASCADE,
  INDEX `idx_manager` (`manager_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Track SPV recruitment by Manager';

-- 81. manager_strategic_plans
CREATE TABLE `manager_strategic_plans` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `plan_title` VARCHAR(255) NOT NULL,
  `plan_description` TEXT,
  `plan_type` ENUM('quarterly', 'annual', 'campaign', 'other') DEFAULT 'quarterly',
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `objectives` JSON,
  `key_results` JSON,
  `budget` DECIMAL(15,2),
  `status` ENUM('draft', 'active', 'completed', 'cancelled') DEFAULT 'draft',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`manager_id`) REFERENCES `managers`(`id`) ON DELETE CASCADE,
  INDEX `idx_manager` (`manager_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Strategic plans untuk division';

-- 82. manager_spv_performance_reviews
CREATE TABLE `manager_spv_performance_reviews` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `review_period_start` DATE NOT NULL,
  `review_period_end` DATE NOT NULL,
  `team_management` DECIMAL(3,2) COMMENT 'Rating 1-5',
  `sales_leadership` DECIMAL(3,2),
  `partner_development` DECIMAL(3,2),
  `communication` DECIMAL(3,2),
  `strategic_thinking` DECIMAL(3,2),
  `overall_rating` DECIMAL(3,2),
  `strengths` TEXT,
  `areas_for_improvement` TEXT,
  `development_plan` TEXT,
  `reviewed_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`manager_id`) REFERENCES `managers`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`spv_id`) REFERENCES `spv`(`id`) ON DELETE CASCADE,
  INDEX `idx_manager_spv` (`manager_id`, `spv_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='SPV performance reviews by Manager';

-- 83. manager_division_meetings
CREATE TABLE `manager_division_meetings` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `meeting_title` VARCHAR(255) NOT NULL,
  `meeting_agenda` TEXT,
  `meeting_date` DATE NOT NULL,
  `meeting_time` TIME NOT NULL,
  `meeting_type` ENUM('weekly', 'monthly', 'quarterly', 'ad_hoc') DEFAULT 'monthly',
  `attendees` JSON COMMENT 'Array of SPV IDs',
  `meeting_notes` TEXT,
  `decisions_made` JSON,
  `action_items` JSON,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`manager_id`) REFERENCES `managers`(`id`) ON DELETE CASCADE,
  INDEX `idx_manager_date` (`manager_id`, `meeting_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Division meetings by Manager';

-- 84. manager_withdrawal_requests
CREATE TABLE `manager_withdrawal_requests` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `amount` DECIMAL(15,2) NOT NULL,
  `bank_account_id` BIGINT UNSIGNED NOT NULL,
  `status` ENUM('pending', 'approved', 'processing', 'completed', 'rejected', 'cancelled') DEFAULT 'pending',
  `requested_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `processed_by` BIGINT UNSIGNED NULL,
  `processed_at` TIMESTAMP NULL,
  `payment_proof` VARCHAR(255),
  `rejection_reason` TEXT,
  `notes` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`manager_id`) REFERENCES `managers`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`bank_account_id`) REFERENCES `user_bank_accounts`(`id`),
  INDEX `idx_manager_status` (`manager_id`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Manager withdrawal requests';

-- 85. manager_incentives
CREATE TABLE `manager_incentives` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `incentive_type` VARCHAR(100) NOT NULL,
  `incentive_description` TEXT,
  `amount` DECIMAL(15,2) NOT NULL,
  `earned_date` DATE NOT NULL,
  `paid_status` ENUM('pending', 'paid') DEFAULT 'pending',
  `paid_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`manager_id`) REFERENCES `managers`(`id`) ON DELETE CASCADE,
  INDEX `idx_manager_date` (`manager_id`, `earned_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Additional incentives untuk Manager';

-- 86. manager_complaints
CREATE TABLE `manager_complaints` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `complaint_type` VARCHAR(100) NOT NULL,
  `subject` VARCHAR(255) NOT NULL,
  `description` TEXT NOT NULL,
  `priority` ENUM('low', 'medium', 'high', 'urgent') DEFAULT 'medium',
  `status` ENUM('open', 'investigating', 'resolved', 'closed') DEFAULT 'open',
  `assigned_to` BIGINT UNSIGNED NULL,
  `resolved_at` TIMESTAMP NULL,
  `resolution_notes` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`manager_id`) REFERENCES `managers`(`id`) ON DELETE CASCADE,
  INDEX `idx_manager_status` (`manager_id`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Manager complaints & issues';

-- 87. manager_reports
CREATE TABLE `manager_reports` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `report_type` VARCHAR(100) NOT NULL,
  `report_period_start` DATE NOT NULL,
  `report_period_end` DATE NOT NULL,
  `report_data` JSON,
  `generated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`manager_id`) REFERENCES `managers`(`id`) ON DELETE CASCADE,
  INDEX `idx_manager` (`manager_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Reports generated by Manager';

-- 88. manager_budget_allocations
CREATE TABLE `manager_budget_allocations` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `budget_period` DATE NOT NULL COMMENT 'Month or quarter',
  `total_budget` DECIMAL(15,2) NOT NULL,
  `marketing_budget` DECIMAL(15,2) DEFAULT 0,
  `training_budget` DECIMAL(15,2) DEFAULT 0,
  `incentives_budget` DECIMAL(15,2) DEFAULT 0,
  `operational_budget` DECIMAL(15,2) DEFAULT 0,
  `budget_spent` DECIMAL(15,2) DEFAULT 0,
  `budget_remaining` DECIMAL(15,2) DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`manager_id`) REFERENCES `managers`(`id`) ON DELETE CASCADE,
  UNIQUE KEY `idx_manager_period` (`manager_id`, `budget_period`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Budget management untuk division';

-- ============================================
-- CATEGORY F: CLIENT SYSTEM (25 TABLES)
-- Tables 89-113
-- ============================================

-- 89. clients
CREATE TABLE `clients` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL UNIQUE,
  `client_code` VARCHAR(50) NOT NULL UNIQUE,
  `client_type` ENUM('individual', 'company') DEFAULT 'individual',
  `partner_id` BIGINT UNSIGNED NULL COMMENT 'Which partner acquired this client',
  `total_spent` DECIMAL(15,2) DEFAULT 0,
  `total_orders` INT UNSIGNED DEFAULT 0,
  `wallet_balance` DECIMAL(15,2) DEFAULT 0,
  `credit_limit` DECIMAL(15,2) DEFAULT 0,
  `loyalty_points` INT UNSIGNED DEFAULT 0,
  `registration_date` DATE NOT NULL,
  `status` ENUM('active', 'inactive', 'suspended', 'blacklisted') DEFAULT 'active',
  `notes` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`partner_id`) REFERENCES `partners`(`id`) ON DELETE SET NULL,
  INDEX `idx_partner` (`partner_id`),
  INDEX `idx_status` (`status`),
  INDEX `idx_type` (`client_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Client/customer data';

-- 90. client_companies
CREATE TABLE `client_companies` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `client_id` BIGINT UNSIGNED NOT NULL UNIQUE,
  `company_name` VARCHAR(255) NOT NULL,
  `company_legal_name` VARCHAR(255),
  `nib` VARCHAR(50) COMMENT 'Nomor Induk Berusaha',
  `npwp` VARCHAR(50) COMMENT 'Tax ID',
  `industry` VARCHAR(100),
  `company_size` ENUM('1-10', '11-50', '51-200', '201-500', '500+'),
  `annual_revenue` VARCHAR(50),
  `website` VARCHAR(255),
  `company_address` TEXT,
  `city` VARCHAR(100),
  `province` VARCHAR(100),
  `postal_code` VARCHAR(10),
  `country` VARCHAR(100) DEFAULT 'Indonesia',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`client_id`) REFERENCES `clients`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Extended info untuk company clients';

-- 91. client_contacts
CREATE TABLE `client_contacts` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `client_id` BIGINT UNSIGNED NOT NULL,
  `contact_name` VARCHAR(255) NOT NULL,
  `contact_title` VARCHAR(100),
  `contact_email` VARCHAR(255),
  `contact_phone` VARCHAR(20),
  `contact_role` ENUM('primary', 'billing', 'technical', 'decision_maker', 'other') DEFAULT 'other',
  `is_primary` BOOLEAN DEFAULT FALSE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`client_id`) REFERENCES `clients`(`id`) ON DELETE CASCADE,
  INDEX `idx_client` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Multiple contacts per client company';

-- 92. client_segments
CREATE TABLE `client_segments` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `segment_name` VARCHAR(100) NOT NULL UNIQUE,
  `segment_description` TEXT,
  `segment_criteria` JSON,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Client segmentation (VIP, Regular, New, etc)';

-- 93. client_segment_mapping
CREATE TABLE `client_segment_mapping` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `client_id` BIGINT UNSIGNED NOT NULL,
  `segment_id` INT UNSIGNED NOT NULL,
  `assigned_date` DATE NOT NULL,
  `assigned_by` BIGINT UNSIGNED,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`client_id`) REFERENCES `clients`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`segment_id`) REFERENCES `client_segments`(`id`) ON DELETE CASCADE,
  UNIQUE KEY `idx_client_segment` (`client_id`, `segment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Clients belong to segments';

-- 94. client_preferences
CREATE TABLE `client_preferences` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `client_id` BIGINT UNSIGNED NOT NULL UNIQUE,
  `preferred_payment_method` VARCHAR(50),
  `preferred_communication` ENUM('email', 'phone', 'whatsapp', 'sms') DEFAULT 'email',
  `marketing_emails` BOOLEAN DEFAULT TRUE,
  `promotional_notifications` BOOLEAN DEFAULT TRUE,
  `newsletter_subscription` BOOLEAN DEFAULT FALSE,
  `service_preferences` JSON,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`client_id`) REFERENCES `clients`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Client preferences & settings';

-- 95. client_credit_limits
CREATE TABLE `client_credit_limits` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `client_id` BIGINT UNSIGNED NOT NULL,
  `credit_limit` DECIMAL(15,2) NOT NULL DEFAULT 0,
  `credit_used` DECIMAL(15,2) DEFAULT 0,
  `credit_available` DECIMAL(15,2) DEFAULT 0,
  `payment_terms` INT UNSIGNED DEFAULT 30 COMMENT 'Days',
  `approved_by` BIGINT UNSIGNED,
  `approved_at` TIMESTAMP NULL,
  `effective_date` DATE NOT NULL,
  `expiry_date` DATE NULL,
  `status` ENUM('active', 'suspended', 'expired') DEFAULT 'active',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`client_id`) REFERENCES `clients`(`id`) ON DELETE CASCADE,
  INDEX `idx_client_status` (`client_id`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Credit limits untuk trusted clients';

-- 96. client_projects
CREATE TABLE `client_projects` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `client_id` BIGINT UNSIGNED NOT NULL,
  `project_name` VARCHAR(255) NOT NULL,
  `project_description` TEXT,
  `project_type` VARCHAR(100),
  `start_date` DATE,
  `end_date` DATE,
  `budget` DECIMAL(15,2),
  `actual_cost` DECIMAL(15,2) DEFAULT 0,
  `status` ENUM('planning', 'in_progress', 'on_hold', 'completed', 'cancelled') DEFAULT 'planning',
  `completion_percentage` DECIMAL(5,2) DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`client_id`) REFERENCES `clients`(`id`) ON DELETE CASCADE,
  INDEX `idx_client_status` (`client_id`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Client projects (multi-service bundles)';

-- 97. client_project_milestones
CREATE TABLE `client_project_milestones` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `project_id` BIGINT UNSIGNED NOT NULL,
  `milestone_name` VARCHAR(255) NOT NULL,
  `milestone_description` TEXT,
  `due_date` DATE,
  `completion_date` DATE NULL,
  `status` ENUM('pending', 'in_progress', 'completed', 'delayed') DEFAULT 'pending',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`project_id`) REFERENCES `client_projects`(`id`) ON DELETE CASCADE,
  INDEX `idx_project` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Project milestones & deliverables';

-- 98. client_service_subscriptions
CREATE TABLE `client_service_subscriptions` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `client_id` BIGINT UNSIGNED NOT NULL,
  `service_id` BIGINT UNSIGNED NOT NULL,
  `subscription_plan` VARCHAR(100) NOT NULL,
  `monthly_price` DECIMAL(10,2) NOT NULL,
  `billing_cycle` ENUM('monthly', 'quarterly', 'annually') DEFAULT 'monthly',
  `start_date` DATE NOT NULL,
  `next_billing_date` DATE NOT NULL,
  `end_date` DATE NULL,
  `auto_renew` BOOLEAN DEFAULT TRUE,
  `status` ENUM('active', 'suspended', 'cancelled', 'expired') DEFAULT 'active',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`client_id`) REFERENCES `clients`(`id`) ON DELETE CASCADE,
  INDEX `idx_client_status` (`client_id`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Monthly service subscriptions (Sewa model)';

-- 99. client_payment_methods
CREATE TABLE `client_payment_methods` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `client_id` BIGINT UNSIGNED NOT NULL,
  `method_type` ENUM('bank_transfer', 'credit_card', 'e_wallet', 'cryptocurrency') NOT NULL,
  `method_details` JSON,
  `is_primary` BOOLEAN DEFAULT FALSE,
  `is_verified` BOOLEAN DEFAULT FALSE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`client_id`) REFERENCES `clients`(`id`) ON DELETE CASCADE,
  INDEX `idx_client` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Saved payment methods';

-- 100. client_invoices
CREATE TABLE `client_invoices` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `client_id` BIGINT UNSIGNED NOT NULL,
  `order_id` BIGINT UNSIGNED NULL,
  `invoice_number` VARCHAR(50) NOT NULL UNIQUE,
  `invoice_date` DATE NOT NULL,
  `due_date` DATE NOT NULL,
  `subtotal` DECIMAL(15,2) NOT NULL,
  `tax_amount` DECIMAL(15,2) DEFAULT 0,
  `discount_amount` DECIMAL(15,2) DEFAULT 0,
  `total_amount` DECIMAL(15,2) NOT NULL,
  `amount_paid` DECIMAL(15,2) DEFAULT 0,
  `balance_due` DECIMAL(15,2) NOT NULL,
  `status` ENUM('draft', 'sent', 'viewed', 'partially_paid', 'paid', 'overdue', 'cancelled') DEFAULT 'draft',
  `paid_at` TIMESTAMP NULL,
  `notes` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`client_id`) REFERENCES `clients`(`id`) ON DELETE CASCADE,
  INDEX `idx_client_status` (`client_id`, `status`),
  INDEX `idx_invoice_number` (`invoice_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Client invoices (auto-generated)';

-- 101. client_payments
CREATE TABLE `client_payments` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `client_id` BIGINT UNSIGNED NOT NULL,
  `invoice_id` BIGINT UNSIGNED NULL,
  `order_id` BIGINT UNSIGNED NULL,
  `payment_number` VARCHAR(50) NOT NULL UNIQUE,
  `payment_method` VARCHAR(100) NOT NULL,
  `amount` DECIMAL(15,2) NOT NULL,
  `payment_date` DATE NOT NULL,
  `payment_proof` VARCHAR(255),
  `bank_name` VARCHAR(100),
  `account_number` VARCHAR(50),
  `account_holder` VARCHAR(255),
  `transfer_reference` VARCHAR(255),
  `status` ENUM('pending', 'verifying', 'verified', 'rejected') DEFAULT 'pending',
  `verified_by` BIGINT UNSIGNED,
  `verified_at` TIMESTAMP NULL,
  `rejection_reason` TEXT,
  `notes` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`client_id`) REFERENCES `clients`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`invoice_id`) REFERENCES `client_invoices`(`id`) ON DELETE SET NULL,
  INDEX `idx_client_status` (`client_id`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Client payment uploads (manual verification)';

-- 102. client_credit_notes
CREATE TABLE `client_credit_notes` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `client_id` BIGINT UNSIGNED NOT NULL,
  `invoice_id` BIGINT UNSIGNED NULL,
  `credit_note_number` VARCHAR(50) NOT NULL UNIQUE,
  `credit_date` DATE NOT NULL,
  `amount` DECIMAL(15,2) NOT NULL,
  `reason` TEXT NOT NULL,
  `created_by` BIGINT UNSIGNED,
  `status` ENUM('draft', 'issued', 'applied', 'cancelled') DEFAULT 'draft',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`client_id`) REFERENCES `clients`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`invoice_id`) REFERENCES `client_invoices`(`id`) ON DELETE SET NULL,
  INDEX `idx_client` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Credit notes untuk refunds/adjustments';

-- 103. client_communication_history
CREATE TABLE `client_communication_history` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `client_id` BIGINT UNSIGNED NOT NULL,
  `initiated_by` BIGINT UNSIGNED NOT NULL COMMENT 'Admin, Partner, or System',
  `communication_type` ENUM('call', 'email', 'meeting', 'chat', 'whatsapp', 'sms') NOT NULL,
  `subject` VARCHAR(255),
  `message` TEXT,
  `response` TEXT,
  `communication_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `follow_up_required` BOOLEAN DEFAULT FALSE,
  `follow_up_date` DATE NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`client_id`) REFERENCES `clients`(`id`) ON DELETE CASCADE,
  INDEX `idx_client_date` (`client_id`, `communication_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='All communication logs with clients';

-- 104. client_support_tickets
CREATE TABLE `client_support_tickets` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `client_id` BIGINT UNSIGNED NOT NULL,
  `ticket_number` VARCHAR(50) NOT NULL UNIQUE,
  `subject` VARCHAR(255) NOT NULL,
  `description` TEXT NOT NULL,
  `category` VARCHAR(100),
  `priority` ENUM('low', 'medium', 'high', 'urgent') DEFAULT 'medium',
  `status` ENUM('open', 'in_progress', 'waiting_client', 'resolved', 'closed', 'reopened') DEFAULT 'open',
  `assigned_to` BIGINT UNSIGNED NULL,
  `first_response_at` TIMESTAMP NULL,
  `resolved_at` TIMESTAMP NULL,
  `closed_at` TIMESTAMP NULL,
  `satisfaction_rating` INT UNSIGNED NULL COMMENT '1-5',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`client_id`) REFERENCES `clients`(`id`) ON DELETE CASCADE,
  INDEX `idx_client_status` (`client_id`, `status`),
  INDEX `idx_assigned` (`assigned_to`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Client support tickets';

-- 105. client_ticket_replies
CREATE TABLE `client_ticket_replies` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `ticket_id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL COMMENT 'Client or Admin',
  `reply_message` TEXT NOT NULL,
  `attachments` JSON,
  `is_internal_note` BOOLEAN DEFAULT FALSE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`ticket_id`) REFERENCES `client_support_tickets`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  INDEX `idx_ticket` (`ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Threaded replies untuk tickets';

-- 106. client_feedback
CREATE TABLE `client_feedback` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `client_id` BIGINT UNSIGNED NOT NULL,
  `order_id` BIGINT UNSIGNED NULL,
  `service_id` BIGINT UNSIGNED NULL,
  `feedback_type` ENUM('service_review', 'partner_review', 'platform_feedback', 'suggestion') NOT NULL,
  `rating` DECIMAL(3,2) COMMENT '1-5',
  `feedback_title` VARCHAR(255),
  `feedback_message` TEXT,
  `is_public` BOOLEAN DEFAULT FALSE,
  `is_featured` BOOLEAN DEFAULT FALSE,
  `responded_by` BIGINT UNSIGNED NULL,
  `response_message` TEXT,
  `responded_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`client_id`) REFERENCES `clients`(`id`) ON DELETE CASCADE,
  INDEX `idx_client` (`client_id`),
  INDEX `idx_rating` (`rating`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Client reviews & feedback';

-- 107. client_complaints
CREATE TABLE `client_complaints` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `client_id` BIGINT UNSIGNED NOT NULL,
  `order_id` BIGINT UNSIGNED NULL,
  `complaint_type` VARCHAR(100) NOT NULL,
  `subject` VARCHAR(255) NOT NULL,
  `description` TEXT NOT NULL,
  `priority` ENUM('low', 'medium', 'high', 'urgent') DEFAULT 'medium',
  `status` ENUM('open', 'investigating', 'resolved', 'closed', 'escalated') DEFAULT 'open',
  `assigned_to` BIGINT UNSIGNED NULL,
  `resolution` TEXT,
  `compensation_offered` DECIMAL(10,2) DEFAULT 0,
  `resolved_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`client_id`) REFERENCES `clients`(`id`) ON DELETE CASCADE,
  INDEX `idx_client_status` (`client_id`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Client complaints (serious issues)';

-- 108. client_referrals
CREATE TABLE `client_referrals` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `referrer_client_id` BIGINT UNSIGNED NOT NULL,
  `referred_email` VARCHAR(255) NOT NULL,
  `referred_name` VARCHAR(255),
  `referred_client_id` BIGINT UNSIGNED NULL,
  `referral_code` VARCHAR(50),
  `status` ENUM('pending', 'registered', 'converted', 'expired') DEFAULT 'pending',
  `reward_amount` DECIMAL(10,2) DEFAULT 0,
  `reward_claimed` BOOLEAN DEFAULT FALSE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`referrer_client_id`) REFERENCES `clients`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`referred_client_id`) REFERENCES `clients`(`id`) ON DELETE SET NULL,
  INDEX `idx_referrer` (`referrer_client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Client referral program';

-- 109. client_loyalty_points
CREATE TABLE `client_loyalty_points` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `client_id` BIGINT UNSIGNED NOT NULL,
  `current_points` INT UNSIGNED DEFAULT 0,
  `lifetime_points` INT UNSIGNED DEFAULT 0,
  `points_used` INT UNSIGNED DEFAULT 0,
  `tier_level` VARCHAR(50) DEFAULT 'Bronze',
  `tier_since` DATE,
  `next_tier` VARCHAR(50),
  `points_to_next_tier` INT UNSIGNED DEFAULT 0,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`client_id`) REFERENCES `clients`(`id`) ON DELETE CASCADE,
  UNIQUE KEY `idx_client` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Loyalty points balance per client';

-- 110. client_loyalty_transactions
CREATE TABLE `client_loyalty_transactions` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `client_id` BIGINT UNSIGNED NOT NULL,
  `transaction_type` ENUM('earned', 'redeemed', 'expired', 'adjusted') NOT NULL,
  `points` INT NOT NULL COMMENT 'Positive for earned, negative for used',
  `reason` VARCHAR(255) NOT NULL,
  `order_id` BIGINT UNSIGNED NULL,
  `expires_at` DATE NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`client_id`) REFERENCES `clients`(`id`) ON DELETE CASCADE,
  INDEX `idx_client_created` (`client_id`, `created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Loyalty points transaction history';

-- 111. client_contracts
CREATE TABLE `client_contracts` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `client_id` BIGINT UNSIGNED NOT NULL,
  `contract_number` VARCHAR(50) NOT NULL UNIQUE,
  `contract_title` VARCHAR(255) NOT NULL,
  `contract_type` VARCHAR(100),
  `start_date` DATE NOT NULL,
  `end_date` DATE NULL,
  `value` DECIMAL(15,2) NOT NULL,
  `payment_terms` TEXT,
  `contract_document` VARCHAR(255),
  `signed_by_client` BOOLEAN DEFAULT FALSE,
  `signed_date` DATE NULL,
  `status` ENUM('draft', 'sent', 'active', 'expired', 'terminated') DEFAULT 'draft',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`client_id`) REFERENCES `clients`(`id`) ON DELETE CASCADE,
  INDEX `idx_client_status` (`client_id`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Long-term contracts with clients';

-- 112. client_nda
CREATE TABLE `client_nda` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `client_id` BIGINT UNSIGNED NOT NULL,
  `nda_document` VARCHAR(255) NOT NULL,
  `signed_date` DATE,
  `expiry_date` DATE NULL,
  `is_active` BOOLEAN DEFAULT TRUE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`client_id`) REFERENCES `clients`(`id`) ON DELETE CASCADE,
  INDEX `idx_client` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Non-Disclosure Agreements';

-- 113. client_login_history
CREATE TABLE `client_login_history` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `client_id` BIGINT UNSIGNED NOT NULL,
  `login_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `ip_address` VARCHAR(45),
  `user_agent` TEXT,
  `device_type` VARCHAR(50),
  `browser` VARCHAR(50),
  `location` VARCHAR(255),
  `login_status` ENUM('success', 'failed') DEFAULT 'success',
  FOREIGN KEY (`client_id`) REFERENCES `clients`(`id`) ON DELETE CASCADE,
  INDEX `idx_client_time` (`client_id`, `login_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Client login activity tracking';

-- ==============================================================================
-- CATEGORY G: SERVICES & ORDERS (20 TABLES) - Tables 114-133
-- ==============================================================================

-- 114. service_categories
CREATE TABLE \`service_categories\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`category_name\` VARCHAR(255) NOT NULL,
  \`category_slug\` VARCHAR(255) NOT NULL UNIQUE,
  \`parent_id\` BIGINT UNSIGNED NULL,
  \`description\` TEXT,
  \`icon\` VARCHAR(255),
  \`display_order\` INT UNSIGNED DEFAULT 0,
  \`is_active\` BOOLEAN DEFAULT TRUE,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`updated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (\`parent_id\`) REFERENCES \`service_categories\`(\`id\`) ON DELETE SET NULL,
  INDEX \`idx_active_order\` (\`is_active\`, \`display_order\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Service categories (10 divisions)';

-- 115. services
CREATE TABLE \`services\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`category_id\` BIGINT UNSIGNED NOT NULL,
  \`service_name\` VARCHAR(255) NOT NULL,
  \`service_slug\` VARCHAR(255) NOT NULL UNIQUE,
  \`short_description\` TEXT,
  \`full_description\` TEXT,
  \`features\` JSON,
  \`price_beli\` DECIMAL(15,2) NOT NULL COMMENT 'Beli Putus price',
  \`price_sewa\` DECIMAL(10,2) NOT NULL COMMENT 'Monthly rental price',
  \`sewa_minimum_months\` INT UNSIGNED DEFAULT 3,
  \`estimated_delivery_days\` INT UNSIGNED,
  \`technologies_used\` JSON,
  \`demo_url\` VARCHAR(255),
  \`thumbnail\` VARCHAR(255),
  \`is_featured\` BOOLEAN DEFAULT FALSE,
  \`is_active\` BOOLEAN DEFAULT TRUE,
  \`view_count\` INT UNSIGNED DEFAULT 0,
  \`order_count\` INT UNSIGNED DEFAULT 0,
  \`average_rating\` DECIMAL(3,2) DEFAULT 0,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`updated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (\`category_id\`) REFERENCES \`service_categories\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_category_active\` (\`category_id\`, \`is_active\`),
  INDEX \`idx_featured\` (\`is_featured\`, \`is_active\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='All 306 services';

-- 116. service_addons
CREATE TABLE \`service_addons\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`service_id\` BIGINT UNSIGNED NOT NULL,
  \`addon_name\` VARCHAR(255) NOT NULL,
  \`addon_description\` TEXT,
  \`addon_price\` DECIMAL(10,2) NOT NULL,
  \`is_active\` BOOLEAN DEFAULT TRUE,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`updated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (\`service_id\`) REFERENCES \`services\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_service\` (\`service_id\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Add-ons untuk services';

-- 117. service_packages
CREATE TABLE \`service_packages\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`package_name\` VARCHAR(255) NOT NULL,
  \`package_description\` TEXT,
  \`services_included\` JSON COMMENT 'Array of service IDs',
  \`package_price\` DECIMAL(15,2) NOT NULL,
  \`discount_percentage\` DECIMAL(5,2) DEFAULT 0,
  \`is_active\` BOOLEAN DEFAULT TRUE,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`updated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bundled service packages';

-- 118. service_pricing_tiers
CREATE TABLE \`service_pricing_tiers\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`service_id\` BIGINT UNSIGNED NOT NULL,
  \`tier_name\` VARCHAR(100) NOT NULL,
  \`tier_description\` TEXT,
  \`tier_price\` DECIMAL(10,2) NOT NULL,
  \`tier_features\` JSON,
  \`display_order\` INT UNSIGNED DEFAULT 0,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`updated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (\`service_id\`) REFERENCES \`services\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_service_order\` (\`service_id\`, \`display_order\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tiered pricing per service';

-- 119. service_custom_fields
CREATE TABLE \`service_custom_fields\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`service_id\` BIGINT UNSIGNED NOT NULL,
  \`field_name\` VARCHAR(100) NOT NULL,
  \`field_label\` VARCHAR(255) NOT NULL,
  \`field_type\` ENUM('text', 'textarea', 'number', 'select', 'checkbox', 'file') NOT NULL,
  \`field_options\` JSON,
  \`is_required\` BOOLEAN DEFAULT FALSE,
  \`display_order\` INT UNSIGNED DEFAULT 0,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (\`service_id\`) REFERENCES \`services\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_service\` (\`service_id\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Custom order form fields per service';

-- 120. orders
CREATE TABLE \`orders\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`client_id\` BIGINT UNSIGNED NOT NULL,
  \`partner_id\` BIGINT UNSIGNED NULL,
  \`order_number\` VARCHAR(50) NOT NULL UNIQUE,
  \`order_type\` ENUM('beli', 'sewa') NOT NULL,
  \`subtotal\` DECIMAL(15,2) NOT NULL,
  \`tax_amount\` DECIMAL(15,2) DEFAULT 0,
  \`discount_amount\` DECIMAL(15,2) DEFAULT 0,
  \`total_amount\` DECIMAL(15,2) NOT NULL,
  \`status\` ENUM('pending_payment', 'paid', 'in_progress', 'review', 'completed', 'cancelled', 'refunded') DEFAULT 'pending_payment',
  \`payment_status\` ENUM('unpaid', 'pending_verification', 'paid', 'refunded') DEFAULT 'unpaid',
  \`order_date\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`paid_at\` TIMESTAMP NULL,
  \`completed_at\` TIMESTAMP NULL,
  \`notes\` TEXT,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`updated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (\`client_id\`) REFERENCES \`clients\`(\`id\`) ON DELETE CASCADE,
  FOREIGN KEY (\`partner_id\`) REFERENCES \`partners\`(\`id\`) ON DELETE SET NULL,
  INDEX \`idx_client_status\` (\`client_id\`, \`status\`),
  INDEX \`idx_order_number\` (\`order_number\`),
  INDEX \`idx_order_date\` (\`order_date\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Client orders';

-- 121. order_items
CREATE TABLE \`order_items\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`order_id\` BIGINT UNSIGNED NOT NULL,
  \`service_id\` BIGINT UNSIGNED NOT NULL,
  \`item_name\` VARCHAR(255) NOT NULL,
  \`quantity\` INT UNSIGNED DEFAULT 1,
  \`unit_price\` DECIMAL(10,2) NOT NULL,
  \`total_price\` DECIMAL(15,2) NOT NULL,
  \`custom_fields_data\` JSON COMMENT 'Client answers to custom fields',
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (\`order_id\`) REFERENCES \`orders\`(\`id\`) ON DELETE CASCADE,
  FOREIGN KEY (\`service_id\`) REFERENCES \`services\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_order\` (\`order_id\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Items dalam order';

-- 122. order_custom_requirements
CREATE TABLE \`order_custom_requirements\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`order_id\` BIGINT UNSIGNED NOT NULL,
  \`requirement_text\` TEXT NOT NULL,
  \`attachments\` JSON,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (\`order_id\`) REFERENCES \`orders\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_order\` (\`order_id\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Additional custom requirements per order';

-- 123. order_files
CREATE TABLE \`order_files\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`order_id\` BIGINT UNSIGNED NOT NULL,
  \`uploaded_by\` BIGINT UNSIGNED NOT NULL COMMENT 'User ID',
  \`file_type\` ENUM('requirement', 'deliverable', 'revision', 'reference') NOT NULL,
  \`file_name\` VARCHAR(255) NOT NULL,
  \`file_path\` VARCHAR(255) NOT NULL,
  \`file_size\` INT UNSIGNED,
  \`mime_type\` VARCHAR(100),
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (\`order_id\`) REFERENCES \`orders\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_order\` (\`order_id\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Files related to orders';

-- 124. order_deliverables
CREATE TABLE \`order_deliverables\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`order_id\` BIGINT UNSIGNED NOT NULL,
  \`deliverable_name\` VARCHAR(255) NOT NULL,
  \`deliverable_description\` TEXT,
  \`deliverable_url\` VARCHAR(255),
  \`deliverable_files\` JSON,
  \`delivered_by\` BIGINT UNSIGNED,
  \`delivered_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`accepted_by_client\` BOOLEAN DEFAULT FALSE,
  \`accepted_at\` TIMESTAMP NULL,
  \`revision_requested\` BOOLEAN DEFAULT FALSE,
  \`revision_notes\` TEXT,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (\`order_id\`) REFERENCES \`orders\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_order\` (\`order_id\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Deliverables untuk orders';

-- 125. order_revisions
CREATE TABLE \`order_revisions\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`order_id\` BIGINT UNSIGNED NOT NULL,
  \`revision_number\` INT UNSIGNED NOT NULL,
  \`requested_by\` BIGINT UNSIGNED NOT NULL,
  \`revision_description\` TEXT NOT NULL,
  \`status\` ENUM('pending', 'in_progress', 'completed') DEFAULT 'pending',
  \`completed_at\` TIMESTAMP NULL,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`updated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (\`order_id\`) REFERENCES \`orders\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_order\` (\`order_id\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Revision requests';

-- 126. order_timeline
CREATE TABLE \`order_timeline\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`order_id\` BIGINT UNSIGNED NOT NULL,
  \`event_type\` VARCHAR(100) NOT NULL,
  \`event_description\` TEXT NOT NULL,
  \`event_data\` JSON,
  \`created_by\` BIGINT UNSIGNED,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (\`order_id\`) REFERENCES \`orders\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_order_created\` (\`order_id\`, \`created_at\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Timeline of order events';

-- 127. order_assignments
CREATE TABLE \`order_assignments\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`order_id\` BIGINT UNSIGNED NOT NULL,
  \`assigned_to\` BIGINT UNSIGNED NOT NULL COMMENT 'Partner or Admin',
  \`assigned_by\` BIGINT UNSIGNED NOT NULL,
  \`assignment_date\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`notes\` TEXT,
  FOREIGN KEY (\`order_id\`) REFERENCES \`orders\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_order\` (\`order_id\`),
  INDEX \`idx_assigned\` (\`assigned_to\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Order assignment to team members';

-- 128. order_time_tracking
CREATE TABLE \`order_time_tracking\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`order_id\` BIGINT UNSIGNED NOT NULL,
  \`tracked_by\` BIGINT UNSIGNED NOT NULL,
  \`task_description\` VARCHAR(255),
  \`start_time\` TIMESTAMP NOT NULL,
  \`end_time\` TIMESTAMP NULL,
  \`total_minutes\` INT UNSIGNED DEFAULT 0,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (\`order_id\`) REFERENCES \`orders\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_order\` (\`order_id\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Time tracking untuk order work';

-- 129. order_status_history
CREATE TABLE \`order_status_history\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`order_id\` BIGINT UNSIGNED NOT NULL,
  \`old_status\` VARCHAR(50),
  \`new_status\` VARCHAR(50) NOT NULL,
  \`changed_by\` BIGINT UNSIGNED,
  \`change_reason\` TEXT,
  \`changed_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (\`order_id\`) REFERENCES \`orders\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_order\` (\`order_id\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Track all status changes';

-- 130. order_notes
CREATE TABLE \`order_notes\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`order_id\` BIGINT UNSIGNED NOT NULL,
  \`note_author\` BIGINT UNSIGNED NOT NULL,
  \`note_content\` TEXT NOT NULL,
  \`is_internal\` BOOLEAN DEFAULT FALSE COMMENT 'Internal admin notes vs client visible',
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (\`order_id\`) REFERENCES \`orders\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_order\` (\`order_id\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Notes & comments on orders';

-- 131. order_cancellations
CREATE TABLE \`order_cancellations\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`order_id\` BIGINT UNSIGNED NOT NULL,
  \`cancelled_by\` BIGINT UNSIGNED NOT NULL,
  \`cancellation_reason\` TEXT NOT NULL,
  \`refund_amount\` DECIMAL(15,2) DEFAULT 0,
  \`refund_status\` ENUM('pending', 'processed', 'rejected') DEFAULT 'pending',
  \`cancelled_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (\`order_id\`) REFERENCES \`orders\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_order\` (\`order_id\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Order cancellation records';

-- 132. order_reviews
CREATE TABLE \`order_reviews\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`order_id\` BIGINT UNSIGNED NOT NULL,
  \`client_id\` BIGINT UNSIGNED NOT NULL,
  \`service_id\` BIGINT UNSIGNED NOT NULL,
  \`rating\` DECIMAL(3,2) NOT NULL COMMENT '1-5',
  \`review_title\` VARCHAR(255),
  \`review_text\` TEXT,
  \`would_recommend\` BOOLEAN DEFAULT TRUE,
  \`is_featured\` BOOLEAN DEFAULT FALSE,
  \`admin_response\` TEXT,
  \`responded_at\` TIMESTAMP NULL,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (\`order_id\`) REFERENCES \`orders\`(\`id\`) ON DELETE CASCADE,
  FOREIGN KEY (\`client_id\`) REFERENCES \`clients\`(\`id\`) ON DELETE CASCADE,
  FOREIGN KEY (\`service_id\`) REFERENCES \`services\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_service_rating\` (\`service_id\`, \`rating\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Client reviews after order completion';

-- 133. coupons
CREATE TABLE \`coupons\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`coupon_code\` VARCHAR(50) NOT NULL UNIQUE,
  \`coupon_name\` VARCHAR(255) NOT NULL,
  \`discount_type\` ENUM('percentage', 'fixed_amount') NOT NULL,
  \`discount_value\` DECIMAL(10,2) NOT NULL,
  \`minimum_order_amount\` DECIMAL(15,2) DEFAULT 0,
  \`maximum_discount\` DECIMAL(10,2) NULL,
  \`usage_limit\` INT UNSIGNED NULL,
  \`usage_count\` INT UNSIGNED DEFAULT 0,
  \`user_limit\` INT UNSIGNED DEFAULT 1 COMMENT 'Per user usage limit',
  \`valid_from\` DATE NOT NULL,
  \`valid_until\` DATE NOT NULL,
  \`applicable_services\` JSON COMMENT 'Null = all services',
  \`is_active\` BOOLEAN DEFAULT TRUE,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`updated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX \`idx_code_active\` (\`coupon_code\`, \`is_active\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Discount coupons';


-- ==============================================================================
-- CATEGORY H: PORTFOLIO & SHOWCASE (10 TABLES) - Tables 134-143
-- ==============================================================================

-- 134. portfolio_categories
CREATE TABLE \`portfolio_categories\` (
  \`id\` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`category_name\` VARCHAR(100) NOT NULL UNIQUE,
  \`category_slug\` VARCHAR(100) NOT NULL UNIQUE,
  \`description\` TEXT,
  \`display_order\` INT UNSIGNED DEFAULT 0,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Portfolio categories';

-- 135. portfolio_projects
CREATE TABLE \`portfolio_projects\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`category_id\` INT UNSIGNED NOT NULL,
  \`project_title\` VARCHAR(255) NOT NULL,
  \`project_slug\` VARCHAR(255) NOT NULL UNIQUE,
  \`client_name\` VARCHAR(255),
  \`project_description\` TEXT,
  \`project_url\` VARCHAR(255),
  \`thumbnail\` VARCHAR(255),
  \`completion_date\` DATE,
  \`technologies_used\` JSON,
  \`is_featured\` BOOLEAN DEFAULT FALSE,
  \`view_count\` INT UNSIGNED DEFAULT 0,
  \`display_order\` INT UNSIGNED DEFAULT 0,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`updated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (\`category_id\`) REFERENCES \`portfolio_categories\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_category_featured\` (\`category_id\`, \`is_featured\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Portfolio projects showcase';

-- 136. portfolio_images
CREATE TABLE \`portfolio_images\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`project_id\` BIGINT UNSIGNED NOT NULL,
  \`image_path\` VARCHAR(255) NOT NULL,
  \`image_caption\` VARCHAR(255),
  \`display_order\` INT UNSIGNED DEFAULT 0,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (\`project_id\`) REFERENCES \`portfolio_projects\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_project\` (\`project_id\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Portfolio project images';

-- 137. portfolio_tags
CREATE TABLE \`portfolio_tags\` (
  \`id\` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`tag_name\` VARCHAR(100) NOT NULL UNIQUE,
  \`tag_slug\` VARCHAR(100) NOT NULL UNIQUE,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tags untuk portfolio';

-- 138. portfolio_tag_mapping
CREATE TABLE \`portfolio_tag_mapping\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`project_id\` BIGINT UNSIGNED NOT NULL,
  \`tag_id\` INT UNSIGNED NOT NULL,
  FOREIGN KEY (\`project_id\`) REFERENCES \`portfolio_projects\`(\`id\`) ON DELETE CASCADE,
  FOREIGN KEY (\`tag_id\`) REFERENCES \`portfolio_tags\`(\`id\`) ON DELETE CASCADE,
  UNIQUE KEY \`idx_project_tag\` (\`project_id\`, \`tag_id\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Portfolio project tags';

-- 139. portfolio_testimonials
CREATE TABLE \`portfolio_testimonials\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`project_id\` BIGINT UNSIGNED NULL,
  \`client_name\` VARCHAR(255) NOT NULL,
  \`client_company\` VARCHAR(255),
  \`client_position\` VARCHAR(100),
  \`client_photo\` VARCHAR(255),
  \`testimonial_text\` TEXT NOT NULL,
  \`rating\` DECIMAL(3,2) DEFAULT 5.00,
  \`is_featured\` BOOLEAN DEFAULT FALSE,
  \`display_order\` INT UNSIGNED DEFAULT 0,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (\`project_id\`) REFERENCES \`portfolio_projects\`(\`id\`) ON DELETE SET NULL,
  INDEX \`idx_featured\` (\`is_featured\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Client testimonials';

-- 140. portfolio_views
CREATE TABLE \`portfolio_views\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`project_id\` BIGINT UNSIGNED NOT NULL,
  \`viewer_ip\` VARCHAR(45),
  \`user_agent\` TEXT,
  \`viewed_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (\`project_id\`) REFERENCES \`portfolio_projects\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_project_viewed\` (\`project_id\`, \`viewed_at\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Track portfolio views';

-- 141. portfolio_likes
CREATE TABLE \`portfolio_likes\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`project_id\` BIGINT UNSIGNED NOT NULL,
  \`user_id\` BIGINT UNSIGNED NULL,
  \`ip_address\` VARCHAR(45),
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (\`project_id\`) REFERENCES \`portfolio_projects\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_project\` (\`project_id\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Portfolio likes';

-- 142. demo_websites
CREATE TABLE \`demo_websites\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`category_id\` INT UNSIGNED NOT NULL,
  \`demo_title\` VARCHAR(255) NOT NULL,
  \`demo_slug\` VARCHAR(255) NOT NULL UNIQUE,
  \`demo_url\` VARCHAR(255) NOT NULL,
  \`thumbnail\` VARCHAR(255),
  \`description\` TEXT,
  \`technologies\` JSON,
  \`is_featured\` BOOLEAN DEFAULT FALSE,
  \`view_count\` INT UNSIGNED DEFAULT 0,
  \`display_order\` INT UNSIGNED DEFAULT 0,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX \`idx_category_featured\` (\`category_id\`, \`is_featured\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='60 demo websites';

-- 143. demo_requests
CREATE TABLE \`demo_requests\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`client_id\` BIGINT UNSIGNED NULL,
  \`demo_id\` BIGINT UNSIGNED NOT NULL,
  \`name\` VARCHAR(255) NOT NULL,
  \`email\` VARCHAR(255) NOT NULL,
  \`phone\` VARCHAR(20),
  \`company\` VARCHAR(255),
  \`message\` TEXT,
  \`status\` ENUM('pending', 'contacted', 'converted', 'lost') DEFAULT 'pending',
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`updated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (\`demo_id\`) REFERENCES \`demo_websites\`(\`id\`) ON DELETE CASCADE,
  FOREIGN KEY (\`client_id\`) REFERENCES \`clients\`(\`id\`) ON DELETE SET NULL,
  INDEX \`idx_status\` (\`status\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Demo website requests (leads)';

-- ==============================================================================
-- CATEGORY I: JOB BOARD SYSTEM (10 TABLES) - Tables 144-153
-- ==============================================================================

-- 144. job_posts
CREATE TABLE \`job_posts\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`posted_by\` BIGINT UNSIGNED NOT NULL COMMENT 'Super Admin',
  \`job_title\` VARCHAR(255) NOT NULL,
  \`job_description\` TEXT NOT NULL,
  \`job_type\` VARCHAR(100),
  \`required_skills\` JSON,
  \`estimated_duration\` INT UNSIGNED COMMENT 'Days',
  \`commission_amount\` DECIMAL(10,2) NOT NULL,
  \`max_claims\` INT UNSIGNED DEFAULT 1,
  \`current_claims\` INT UNSIGNED DEFAULT 0,
  \`priority\` ENUM('low', 'medium', 'high', 'urgent') DEFAULT 'medium',
  \`status\` ENUM('open', 'claimed', 'in_progress', 'completed', 'cancelled') DEFAULT 'open',
  \`deadline\` DATE,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`updated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (\`posted_by\`) REFERENCES \`admins\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_status\` (\`status\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Job posts by Super Admin';

-- 145. job_claims
CREATE TABLE \`job_claims\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`job_id\` BIGINT UNSIGNED NOT NULL,
  \`claimed_by\` BIGINT UNSIGNED NOT NULL COMMENT 'Partner, SPV, or Manager',
  \`claim_type\` ENUM('partner', 'spv', 'manager') NOT NULL,
  \`claimed_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`acceptance_notes\` TEXT,
  \`status\` ENUM('claimed', 'rejected', 'cancelled') DEFAULT 'claimed',
  FOREIGN KEY (\`job_id\`) REFERENCES \`job_posts\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_job_claimed\` (\`job_id\`, \`claimed_by\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='First-come-first-serve claims';

-- 146. job_assignments
CREATE TABLE \`job_assignments\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`job_id\` BIGINT UNSIGNED NOT NULL,
  \`assigned_to\` BIGINT UNSIGNED NOT NULL,
  \`assigned_by\` BIGINT UNSIGNED NOT NULL,
  \`assigned_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`notes\` TEXT,
  FOREIGN KEY (\`job_id\`) REFERENCES \`job_posts\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_job\` (\`job_id\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Job assignments after claim';

-- 147. job_progress
CREATE TABLE \`job_progress\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`job_id\` BIGINT UNSIGNED NOT NULL,
  \`progress_percentage\` DECIMAL(5,2) DEFAULT 0,
  \`progress_notes\` TEXT,
  \`updated_by\` BIGINT UNSIGNED NOT NULL,
  \`updated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (\`job_id\`) REFERENCES \`job_posts\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_job\` (\`job_id\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Track job progress';

-- 148. job_deliverables
CREATE TABLE \`job_deliverables\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`job_id\` BIGINT UNSIGNED NOT NULL,
  \`submitted_by\` BIGINT UNSIGNED NOT NULL,
  \`deliverable_description\` TEXT,
  \`deliverable_files\` JSON,
  \`deliverable_url\` VARCHAR(255),
  \`submitted_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`review_status\` ENUM('pending', 'approved', 'revision_needed') DEFAULT 'pending',
  \`reviewed_by\` BIGINT UNSIGNED NULL,
  \`reviewed_at\` TIMESTAMP NULL,
  \`review_notes\` TEXT,
  FOREIGN KEY (\`job_id\`) REFERENCES \`job_posts\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_job_status\` (\`job_id\`, \`review_status\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Job deliverable submissions';

-- 149. job_commission_payments
CREATE TABLE \`job_commission_payments\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`job_id\` BIGINT UNSIGNED NOT NULL,
  \`paid_to\` BIGINT UNSIGNED NOT NULL,
  \`amount\` DECIMAL(10,2) NOT NULL,
  \`payment_status\` ENUM('pending', 'paid') DEFAULT 'pending',
  \`paid_at\` TIMESTAMP NULL,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (\`job_id\`) REFERENCES \`job_posts\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_job\` (\`job_id\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Commission payments for completed jobs';

-- 150. job_cancellations
CREATE TABLE \`job_cancellations\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`job_id\` BIGINT UNSIGNED NOT NULL,
  \`cancelled_by\` BIGINT UNSIGNED NOT NULL,
  \`cancellation_reason\` TEXT NOT NULL,
  \`cancelled_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (\`job_id\`) REFERENCES \`job_posts\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_job\` (\`job_id\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Job cancellations (NO penalty)';

-- 151. job_disputes
CREATE TABLE \`job_disputes\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`job_id\` BIGINT UNSIGNED NOT NULL,
  \`raised_by\` BIGINT UNSIGNED NOT NULL,
  \`dispute_description\` TEXT NOT NULL,
  \`dispute_type\` VARCHAR(100),
  \`status\` ENUM('open', 'investigating', 'resolved', 'closed') DEFAULT 'open',
  \`resolution\` TEXT,
  \`resolved_by\` BIGINT UNSIGNED NULL,
  \`resolved_at\` TIMESTAMP NULL,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`updated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (\`job_id\`) REFERENCES \`job_posts\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_job_status\` (\`job_id\`, \`status\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Job disputes';

-- 152. job_ratings
CREATE TABLE \`job_ratings\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`job_id\` BIGINT UNSIGNED NOT NULL,
  \`rated_by\` BIGINT UNSIGNED NOT NULL COMMENT 'Admin rating the worker',
  \`rated_user\` BIGINT UNSIGNED NOT NULL,
  \`quality_rating\` DECIMAL(3,2) COMMENT '1-5',
  \`timeliness_rating\` DECIMAL(3,2),
  \`communication_rating\` DECIMAL(3,2),
  \`overall_rating\` DECIMAL(3,2),
  \`review_comments\` TEXT,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (\`job_id\`) REFERENCES \`job_posts\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_job\` (\`job_id\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Ratings after job completion';

-- 153. job_templates
CREATE TABLE \`job_templates\` (
  \`id\` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`template_name\` VARCHAR(255) NOT NULL,
  \`template_description\` TEXT,
  \`default_commission\` DECIMAL(10,2),
  \`default_duration\` INT UNSIGNED,
  \`required_skills\` JSON,
  \`is_active\` BOOLEAN DEFAULT TRUE,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`updated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Reusable job templates';

-- ==============================================================================
-- CATEGORY J: COMMISSION & FINANCIALS (15 TABLES) - Tables 154-168
-- ==============================================================================

-- 154. commission_tiers
CREATE TABLE \`commission_tiers\` (
  \`id\` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`tier_name\` VARCHAR(50) NOT NULL,
  \`min_sales\` DECIMAL(15,2) NOT NULL,
  \`max_sales\` DECIMAL(15,2) NULL,
  \`commission_rate\` DECIMAL(5,2) NOT NULL,
  \`is_active\` BOOLEAN DEFAULT TRUE,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`updated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Commission tier definitions';

-- 155. commission_transactions
CREATE TABLE \`commission_transactions\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`user_id\` BIGINT UNSIGNED NOT NULL,
  \`user_type\` ENUM('partner', 'spv', 'manager') NOT NULL,
  \`transaction_type\` ENUM('earned', 'paid', 'adjusted', 'refunded') NOT NULL,
  \`amount\` DECIMAL(15,2) NOT NULL,
  \`reference_type\` VARCHAR(100),
  \`reference_id\` BIGINT UNSIGNED,
  \`description\` TEXT,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX \`idx_user\` (\`user_id\`, \`user_type\`),
  INDEX \`idx_type\` (\`transaction_type\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='All commission transactions';

-- 156. commission_calculations
CREATE TABLE \`commission_calculations\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`calculation_month\` DATE NOT NULL,
  \`user_id\` BIGINT UNSIGNED NOT NULL,
  \`user_type\` ENUM('partner', 'spv', 'manager') NOT NULL,
  \`total_sales\` DECIMAL(15,2) DEFAULT 0,
  \`commission_rate\` DECIMAL(5,2) NOT NULL,
  \`commission_earned\` DECIMAL(15,2) DEFAULT 0,
  \`arpu_bonus\` DECIMAL(15,2) DEFAULT 0,
  \`other_bonuses\` DECIMAL(15,2) DEFAULT 0,
  \`total_commission\` DECIMAL(15,2) DEFAULT 0,
  \`calculated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX \`idx_month_user\` (\`calculation_month\`, \`user_id\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Monthly commission calculations';

-- 157. arpu_calculations
CREATE TABLE \`arpu_calculations\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`user_id\` BIGINT UNSIGNED NOT NULL,
  \`user_type\` ENUM('partner', 'spv', 'manager') NOT NULL,
  \`calculation_month\` DATE NOT NULL,
  \`total_clients\` INT UNSIGNED DEFAULT 0,
  \`total_revenue\` DECIMAL(15,2) DEFAULT 0,
  \`arpu_value\` DECIMAL(15,2) DEFAULT 0,
  \`bonus_tier\` VARCHAR(50),
  \`bonus_amount\` DECIMAL(15,2) DEFAULT 0,
  \`calculated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY \`idx_user_month\` (\`user_id\`, \`user_type\`, \`calculation_month\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ARPU calculations untuk bonuses';

-- 158. withdrawal_requests
CREATE TABLE \`withdrawal_requests\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`user_id\` BIGINT UNSIGNED NOT NULL,
  \`user_type\` ENUM('partner', 'spv', 'manager') NOT NULL,
  \`amount\` DECIMAL(15,2) NOT NULL,
  \`bank_account_id\` BIGINT UNSIGNED NOT NULL,
  \`status\` ENUM('pending', 'approved', 'processing', 'completed', 'rejected', 'cancelled') DEFAULT 'pending',
  \`requested_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`processed_by\` BIGINT UNSIGNED NULL,
  \`processed_at\` TIMESTAMP NULL,
  \`payment_proof\` VARCHAR(255),
  \`rejection_reason\` TEXT,
  \`notes\` TEXT,
  \`updated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX \`idx_user_status\` (\`user_id\`, \`user_type\`, \`status\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Unified withdrawal requests';

-- 159. payment_transactions
CREATE TABLE \`payment_transactions\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`transaction_number\` VARCHAR(50) NOT NULL UNIQUE,
  \`payer_id\` BIGINT UNSIGNED NOT NULL,
  \`payee_id\` BIGINT UNSIGNED NULL,
  \`transaction_type\` VARCHAR(100) NOT NULL,
  \`amount\` DECIMAL(15,2) NOT NULL,
  \`payment_method\` VARCHAR(100),
  \`payment_gateway\` VARCHAR(100),
  \`transaction_reference\` VARCHAR(255),
  \`status\` ENUM('pending', 'processing', 'completed', 'failed', 'refunded') DEFAULT 'pending',
  \`transaction_date\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`completed_at\` TIMESTAMP NULL,
  INDEX \`idx_payer\` (\`payer_id\`),
  INDEX \`idx_status\` (\`status\`),
  INDEX \`idx_transaction_number\` (\`transaction_number\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='All payment transactions';

-- 160. invoices
CREATE TABLE \`invoices\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`invoice_number\` VARCHAR(50) NOT NULL UNIQUE,
  \`invoice_type\` ENUM('order', 'subscription', 'other') NOT NULL,
  \`billable_id\` BIGINT UNSIGNED NOT NULL,
  \`billable_type\` VARCHAR(100) NOT NULL,
  \`recipient_id\` BIGINT UNSIGNED NOT NULL,
  \`invoice_date\` DATE NOT NULL,
  \`due_date\` DATE NOT NULL,
  \`subtotal\` DECIMAL(15,2) NOT NULL,
  \`tax_amount\` DECIMAL(15,2) DEFAULT 0,
  \`total_amount\` DECIMAL(15,2) NOT NULL,
  \`amount_paid\` DECIMAL(15,2) DEFAULT 0,
  \`status\` ENUM('draft', 'sent', 'paid', 'overdue', 'cancelled') DEFAULT 'draft',
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`updated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX \`idx_recipient_status\` (\`recipient_id\`, \`status\`),
  INDEX \`idx_invoice_number\` (\`invoice_number\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='All invoices (unified)';

-- 161. invoice_items
CREATE TABLE \`invoice_items\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`invoice_id\` BIGINT UNSIGNED NOT NULL,
  \`item_description\` VARCHAR(255) NOT NULL,
  \`quantity\` INT UNSIGNED DEFAULT 1,
  \`unit_price\` DECIMAL(10,2) NOT NULL,
  \`total_price\` DECIMAL(15,2) NOT NULL,
  FOREIGN KEY (\`invoice_id\`) REFERENCES \`invoices\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_invoice\` (\`invoice_id\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Invoice line items';

-- 162. payment_gateways
CREATE TABLE \`payment_gateways\` (
  \`id\` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`gateway_name\` VARCHAR(100) NOT NULL,
  \`gateway_code\` VARCHAR(50) NOT NULL UNIQUE,
  \`gateway_logo\` VARCHAR(255),
  \`is_active\` BOOLEAN DEFAULT TRUE,
  \`configuration\` JSON,
  \`display_order\` INT UNSIGNED DEFAULT 0,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`updated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Payment gateway configurations';

-- 163. refunds
CREATE TABLE \`refunds\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`payment_transaction_id\` BIGINT UNSIGNED NOT NULL,
  \`refund_amount\` DECIMAL(15,2) NOT NULL,
  \`refund_reason\` TEXT NOT NULL,
  \`requested_by\` BIGINT UNSIGNED NOT NULL,
  \`approved_by\` BIGINT UNSIGNED NULL,
  \`status\` ENUM('pending', 'approved', 'processing', 'completed', 'rejected') DEFAULT 'pending',
  \`processed_at\` TIMESTAMP NULL,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (\`payment_transaction_id\`) REFERENCES \`payment_transactions\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_transaction\` (\`payment_transaction_id\`),
  INDEX \`idx_status\` (\`status\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Refund requests';

-- 164. transaction_fees
CREATE TABLE \`transaction_fees\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`transaction_id\` BIGINT UNSIGNED NOT NULL,
  \`fee_type\` VARCHAR(100) NOT NULL,
  \`fee_amount\` DECIMAL(10,2) NOT NULL,
  \`fee_percentage\` DECIMAL(5,2),
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (\`transaction_id\`) REFERENCES \`payment_transactions\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_transaction\` (\`transaction_id\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Transaction fees tracking';

-- 165. financial_reports
CREATE TABLE \`financial_reports\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`report_type\` VARCHAR(100) NOT NULL,
  \`report_period_start\` DATE NOT NULL,
  \`report_period_end\` DATE NOT NULL,
  \`report_data\` JSON,
  \`generated_by\` BIGINT UNSIGNED,
  \`generated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX \`idx_type_period\` (\`report_type\`, \`report_period_start\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Financial reports';

-- 166. revenue_summary
CREATE TABLE \`revenue_summary\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`summary_date\` DATE NOT NULL UNIQUE,
  \`gross_revenue\` DECIMAL(15,2) DEFAULT 0,
  \`refunds\` DECIMAL(15,2) DEFAULT 0,
  \`discounts\` DECIMAL(15,2) DEFAULT 0,
  \`net_revenue\` DECIMAL(15,2) DEFAULT 0,
  \`partner_commissions\` DECIMAL(15,2) DEFAULT 0,
  \`spv_commissions\` DECIMAL(15,2) DEFAULT 0,
  \`manager_commissions\` DECIMAL(15,2) DEFAULT 0,
  \`total_commissions\` DECIMAL(15,2) DEFAULT 0,
  \`profit\` DECIMAL(15,2) DEFAULT 0,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`updated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX \`idx_date\` (\`summary_date\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Daily revenue summary';

-- 167. budget_allocations
CREATE TABLE \`budget_allocations\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`budget_period\` DATE NOT NULL,
  \`department\` VARCHAR(100) NOT NULL,
  \`allocated_amount\` DECIMAL(15,2) NOT NULL,
  \`spent_amount\` DECIMAL(15,2) DEFAULT 0,
  \`remaining_amount\` DECIMAL(15,2) DEFAULT 0,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`updated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX \`idx_period_dept\` (\`budget_period\`, \`department\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Budget allocations';

-- 168. tax_records
CREATE TABLE \`tax_records\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`tax_period\` DATE NOT NULL COMMENT 'Month/Quarter',
  \`tax_type\` VARCHAR(100) NOT NULL,
  \`taxable_amount\` DECIMAL(15,2) NOT NULL,
  \`tax_rate\` DECIMAL(5,2) NOT NULL,
  \`tax_amount\` DECIMAL(15,2) NOT NULL,
  \`paid_status\` ENUM('unpaid', 'paid') DEFAULT 'unpaid',
  \`paid_at\` TIMESTAMP NULL,
  \`notes\` TEXT,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX \`idx_period\` (\`tax_period\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tax records';

-- ==============================================================================
-- CATEGORY K: EMAIL AUTOMATION (8 TABLES) - Tables 169-176
-- ==============================================================================

-- 169. email_templates
CREATE TABLE \`email_templates\` (
  \`id\` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`template_name\` VARCHAR(100) NOT NULL UNIQUE,
  \`template_slug\` VARCHAR(100) NOT NULL UNIQUE,
  \`template_subject\` VARCHAR(255) NOT NULL,
  \`template_body\` TEXT NOT NULL,
  \`template_variables\` JSON COMMENT 'Available placeholders',
  \`template_category\` VARCHAR(100),
  \`is_active\` BOOLEAN DEFAULT TRUE,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`updated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='27 email templates';

-- 170. email_campaigns
CREATE TABLE \`email_campaigns\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`campaign_name\` VARCHAR(255) NOT NULL,
  \`campaign_subject\` VARCHAR(255) NOT NULL,
  \`campaign_body\` TEXT NOT NULL,
  \`target_audience\` JSON COMMENT 'Criteria for recipients',
  \`send_date\` TIMESTAMP NULL,
  \`status\` ENUM('draft', 'scheduled', 'sending', 'sent', 'cancelled') DEFAULT 'draft',
  \`total_recipients\` INT UNSIGNED DEFAULT 0,
  \`emails_sent\` INT UNSIGNED DEFAULT 0,
  \`emails_opened\` INT UNSIGNED DEFAULT 0,
  \`emails_clicked\` INT UNSIGNED DEFAULT 0,
  \`created_by\` BIGINT UNSIGNED,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`updated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX \`idx_status\` (\`status\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Email marketing campaigns';

-- 171. email_queue
CREATE TABLE \`email_queue\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`recipient_email\` VARCHAR(255) NOT NULL,
  \`recipient_name\` VARCHAR(255),
  \`subject\` VARCHAR(255) NOT NULL,
  \`body\` TEXT NOT NULL,
  \`email_type\` VARCHAR(100),
  \`priority\` ENUM('low', 'medium', 'high') DEFAULT 'medium',
  \`status\` ENUM('pending', 'sending', 'sent', 'failed') DEFAULT 'pending',
  \`attempts\` INT UNSIGNED DEFAULT 0,
  \`last_attempt\` TIMESTAMP NULL,
  \`sent_at\` TIMESTAMP NULL,
  \`error_message\` TEXT,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX \`idx_status_priority\` (\`status\`, \`priority\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Email queue untuk delayed sending';

-- 172. email_logs
CREATE TABLE \`email_logs\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`recipient_email\` VARCHAR(255) NOT NULL,
  \`subject\` VARCHAR(255) NOT NULL,
  \`template_used\` VARCHAR(100),
  \`status\` ENUM('sent', 'failed', 'bounced') NOT NULL,
  \`sent_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`opened_at\` TIMESTAMP NULL,
  \`clicked_at\` TIMESTAMP NULL,
  \`error_message\` TEXT,
  INDEX \`idx_email\` (\`recipient_email\`),
  INDEX \`idx_sent\` (\`sent_at\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Email sending logs';

-- 173. email_clicks
CREATE TABLE \`email_clicks\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`email_log_id\` BIGINT UNSIGNED NOT NULL,
  \`clicked_url\` VARCHAR(255) NOT NULL,
  \`ip_address\` VARCHAR(45),
  \`user_agent\` TEXT,
  \`clicked_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (\`email_log_id\`) REFERENCES \`email_logs\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_email\` (\`email_log_id\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Track email link clicks';

-- 174. email_unsubscribes
CREATE TABLE \`email_unsubscribes\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`email\` VARCHAR(255) NOT NULL UNIQUE,
  \`user_id\` BIGINT UNSIGNED NULL,
  \`reason\` TEXT,
  \`unsubscribed_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX \`idx_email\` (\`email\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Unsubscribe list';

-- 175. email_automation_workflows
CREATE TABLE \`email_automation_workflows\` (
  \`id\` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`workflow_name\` VARCHAR(255) NOT NULL,
  \`trigger_event\` VARCHAR(100) NOT NULL,
  \`workflow_steps\` JSON NOT NULL COMMENT 'Array of email steps with delays',
  \`is_active\` BOOLEAN DEFAULT TRUE,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`updated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Automated email workflows';

-- 176. email_workflow_subscribers
CREATE TABLE \`email_workflow_subscribers\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`workflow_id\` INT UNSIGNED NOT NULL,
  \`user_id\` BIGINT UNSIGNED NOT NULL,
  \`current_step\` INT UNSIGNED DEFAULT 0,
  \`started_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`completed_at\` TIMESTAMP NULL,
  \`status\` ENUM('active', 'completed', 'cancelled') DEFAULT 'active',
  FOREIGN KEY (\`workflow_id\`) REFERENCES \`email_automation_workflows\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_workflow_user\` (\`workflow_id\`, \`user_id\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Users enrolled in workflows';

-- ==============================================================================
-- CATEGORY L: CONTENT MANAGEMENT (12 TABLES) - Tables 177-188
-- ==============================================================================

-- 177. pages
CREATE TABLE \`pages\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`page_title\` VARCHAR(255) NOT NULL,
  \`page_slug\` VARCHAR(255) NOT NULL UNIQUE,
  \`page_content\` LONGTEXT,
  \`meta_title\` VARCHAR(255),
  \`meta_description\` TEXT,
  \`meta_keywords\` TEXT,
  \`is_published\` BOOLEAN DEFAULT FALSE,
  \`published_at\` TIMESTAMP NULL,
  \`created_by\` BIGINT UNSIGNED,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`updated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX \`idx_slug\` (\`page_slug\`),
  INDEX \`idx_published\` (\`is_published\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='CMS pages';

-- 178. blog_categories
CREATE TABLE \`blog_categories\` (
  \`id\` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`category_name\` VARCHAR(100) NOT NULL UNIQUE,
  \`category_slug\` VARCHAR(100) NOT NULL UNIQUE,
  \`description\` TEXT,
  \`parent_id\` INT UNSIGNED NULL,
  \`display_order\` INT UNSIGNED DEFAULT 0,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (\`parent_id\`) REFERENCES \`blog_categories\`(\`id\`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Blog categories';

-- 179. blog_posts
CREATE TABLE \`blog_posts\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`category_id\` INT UNSIGNED NOT NULL,
  \`post_title\` VARCHAR(255) NOT NULL,
  \`post_slug\` VARCHAR(255) NOT NULL UNIQUE,
  \`post_excerpt\` TEXT,
  \`post_content\` LONGTEXT NOT NULL,
  \`featured_image\` VARCHAR(255),
  \`meta_title\` VARCHAR(255),
  \`meta_description\` TEXT,
  \`author_id\` BIGINT UNSIGNED NOT NULL,
  \`view_count\` INT UNSIGNED DEFAULT 0,
  \`is_published\` BOOLEAN DEFAULT FALSE,
  \`published_at\` TIMESTAMP NULL,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`updated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (\`category_id\`) REFERENCES \`blog_categories\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_slug\` (\`post_slug\`),
  INDEX \`idx_published\` (\`is_published\`, \`published_at\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Blog posts';

-- 180. blog_tags
CREATE TABLE \`blog_tags\` (
  \`id\` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`tag_name\` VARCHAR(100) NOT NULL UNIQUE,
  \`tag_slug\` VARCHAR(100) NOT NULL UNIQUE,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Blog tags';

-- 181. blog_post_tags
CREATE TABLE \`blog_post_tags\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`post_id\` BIGINT UNSIGNED NOT NULL,
  \`tag_id\` INT UNSIGNED NOT NULL,
  FOREIGN KEY (\`post_id\`) REFERENCES \`blog_posts\`(\`id\`) ON DELETE CASCADE,
  FOREIGN KEY (\`tag_id\`) REFERENCES \`blog_tags\`(\`id\`) ON DELETE CASCADE,
  UNIQUE KEY \`idx_post_tag\` (\`post_id\`, \`tag_id\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Blog post tags mapping';

-- 182. blog_comments
CREATE TABLE \`blog_comments\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`post_id\` BIGINT UNSIGNED NOT NULL,
  \`parent_id\` BIGINT UNSIGNED NULL COMMENT 'For nested comments',
  \`author_name\` VARCHAR(255) NOT NULL,
  \`author_email\` VARCHAR(255) NOT NULL,
  \`author_url\` VARCHAR(255),
  \`comment_content\` TEXT NOT NULL,
  \`is_approved\` BOOLEAN DEFAULT FALSE,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (\`post_id\`) REFERENCES \`blog_posts\`(\`id\`) ON DELETE CASCADE,
  FOREIGN KEY (\`parent_id\`) REFERENCES \`blog_comments\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_post_approved\` (\`post_id\`, \`is_approved\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Blog comments';

-- 183. faqs
CREATE TABLE \`faqs\` (
  \`id\` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`category_id\` INT UNSIGNED NULL,
  \`question\` TEXT NOT NULL,
  \`answer\` TEXT NOT NULL,
  \`display_order\` INT UNSIGNED DEFAULT 0,
  \`view_count\` INT UNSIGNED DEFAULT 0,
  \`is_published\` BOOLEAN DEFAULT TRUE,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`updated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX \`idx_category_order\` (\`category_id\`, \`display_order\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='FAQs';

-- 184. faq_categories
CREATE TABLE \`faq_categories\` (
  \`id\` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`category_name\` VARCHAR(100) NOT NULL UNIQUE,
  \`category_slug\` VARCHAR(100) NOT NULL UNIQUE,
  \`display_order\` INT UNSIGNED DEFAULT 0,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='FAQ categories';

-- 185. media_library
CREATE TABLE \`media_library\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`file_name\` VARCHAR(255) NOT NULL,
  \`file_path\` VARCHAR(255) NOT NULL,
  \`file_type\` VARCHAR(100),
  \`file_size\` INT UNSIGNED,
  \`mime_type\` VARCHAR(100),
  \`uploaded_by\` BIGINT UNSIGNED,
  \`alt_text\` VARCHAR(255),
  \`caption\` TEXT,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX \`idx_type\` (\`file_type\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Media library';

-- 186. banners
CREATE TABLE \`banners\` (
  \`id\` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`banner_title\` VARCHAR(255) NOT NULL,
  \`banner_image\` VARCHAR(255) NOT NULL,
  \`banner_url\` VARCHAR(255),
  \`banner_position\` VARCHAR(100) COMMENT 'header, sidebar, footer, etc',
  \`display_order\` INT UNSIGNED DEFAULT 0,
  \`start_date\` DATE,
  \`end_date\` DATE,
  \`is_active\` BOOLEAN DEFAULT TRUE,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX \`idx_position_active\` (\`banner_position\`, \`is_active\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Promotional banners';

-- 187. announcements
CREATE TABLE \`announcements\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`announcement_title\` VARCHAR(255) NOT NULL,
  \`announcement_content\` TEXT NOT NULL,
  \`announcement_type\` ENUM('info', 'warning', 'success', 'danger') DEFAULT 'info',
  \`target_roles\` JSON COMMENT 'Which roles can see this',
  \`is_published\` BOOLEAN DEFAULT FALSE,
  \`published_at\` TIMESTAMP NULL,
  \`expires_at\` TIMESTAMP NULL,
  \`created_by\` BIGINT UNSIGNED,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX \`idx_published\` (\`is_published\`, \`published_at\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Site-wide announcements';

-- 188. redirects
CREATE TABLE \`redirects\` (
  \`id\` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`old_url\` VARCHAR(255) NOT NULL UNIQUE,
  \`new_url\` VARCHAR(255) NOT NULL,
  \`redirect_type\` ENUM('301', '302', '307') DEFAULT '301',
  \`is_active\` BOOLEAN DEFAULT TRUE,
  \`hit_count\` INT UNSIGNED DEFAULT 0,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX \`idx_old_url\` (\`old_url\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='URL redirects';

-- ==============================================================================
-- CATEGORY M: ANALYTICS & TRACKING (10 TABLES) - Tables 189-198
-- ==============================================================================

-- 189. website_analytics
CREATE TABLE \`website_analytics\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`page_url\` VARCHAR(255) NOT NULL,
  \`visitor_ip\` VARCHAR(45),
  \`user_agent\` TEXT,
  \`referrer\` VARCHAR(255),
  \`session_id\` VARCHAR(255),
  \`visit_duration\` INT UNSIGNED DEFAULT 0 COMMENT 'Seconds',
  \`visited_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX \`idx_page\` (\`page_url\`),
  INDEX \`idx_visited\` (\`visited_at\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Website traffic analytics';

-- 190. conversion_tracking
CREATE TABLE \`conversion_tracking\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`conversion_type\` VARCHAR(100) NOT NULL,
  \`conversion_source\` VARCHAR(100),
  \`user_id\` BIGINT UNSIGNED NULL,
  \`conversion_value\` DECIMAL(15,2) DEFAULT 0,
  \`conversion_data\` JSON,
  \`converted_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX \`idx_type\` (\`conversion_type\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Conversion tracking';

-- 191. user_behavior_tracking
CREATE TABLE \`user_behavior_tracking\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`user_id\` BIGINT UNSIGNED NULL,
  \`session_id\` VARCHAR(255),
  \`event_type\` VARCHAR(100) NOT NULL,
  \`event_category\` VARCHAR(100),
  \`event_action\` VARCHAR(100),
  \`event_label\` VARCHAR(255),
  \`event_value\` VARCHAR(255),
  \`page_url\` VARCHAR(255),
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX \`idx_user_event\` (\`user_id\`, \`event_type\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='User behavior events';

-- 192. search_queries
CREATE TABLE \`search_queries\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`user_id\` BIGINT UNSIGNED NULL,
  \`search_term\` VARCHAR(255) NOT NULL,
  \`search_category\` VARCHAR(100),
  \`results_count\` INT UNSIGNED DEFAULT 0,
  \`clicked_result\` VARCHAR(255),
  \`searched_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX \`idx_term\` (\`search_term\`),
  INDEX \`idx_searched\` (\`searched_at\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Search queries tracking';

-- 193. ab_tests
CREATE TABLE \`ab_tests\` (
  \`id\` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`test_name\` VARCHAR(255) NOT NULL,
  \`test_description\` TEXT,
  \`variant_a\` JSON NOT NULL,
  \`variant_b\` JSON NOT NULL,
  \`traffic_split\` INT UNSIGNED DEFAULT 50 COMMENT 'Percentage to variant B',
  \`start_date\` DATE NOT NULL,
  \`end_date\` DATE,
  \`is_active\` BOOLEAN DEFAULT TRUE,
  \`winner\` ENUM('a', 'b', 'none') DEFAULT 'none',
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX \`idx_active\` (\`is_active\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='A/B tests';

-- 194. ab_test_results
CREATE TABLE \`ab_test_results\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`test_id\` INT UNSIGNED NOT NULL,
  \`variant\` ENUM('a', 'b') NOT NULL,
  \`user_id\` BIGINT UNSIGNED NULL,
  \`session_id\` VARCHAR(255),
  \`converted\` BOOLEAN DEFAULT FALSE,
  \`conversion_value\` DECIMAL(10,2) DEFAULT 0,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (\`test_id\`) REFERENCES \`ab_tests\`(\`id\`) ON DELETE CASCADE,
  INDEX \`idx_test_variant\` (\`test_id\`, \`variant\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='A/B test results';

-- 195. heatmap_data
CREATE TABLE \`heatmap_data\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`page_url\` VARCHAR(255) NOT NULL,
  \`click_x\` INT UNSIGNED NOT NULL,
  \`click_y\` INT UNSIGNED NOT NULL,
  \`viewport_width\` INT UNSIGNED,
  \`viewport_height\` INT UNSIGNED,
  \`clicked_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX \`idx_page\` (\`page_url\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Heatmap click data';

-- 196. performance_metrics
CREATE TABLE \`performance_metrics\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`metric_date\` DATE NOT NULL,
  \`page_url\` VARCHAR(255),
  \`load_time\` INT UNSIGNED COMMENT 'Milliseconds',
  \`ttfb\` INT UNSIGNED COMMENT 'Time to first byte',
  \`fcp\` INT UNSIGNED COMMENT 'First contentful paint',
  \`lcp\` INT UNSIGNED COMMENT 'Largest contentful paint',
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX \`idx_date_page\` (\`metric_date\`, \`page_url\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Performance metrics';

-- 197. error_logs
CREATE TABLE \`error_logs\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`error_type\` VARCHAR(100) NOT NULL,
  \`error_message\` TEXT NOT NULL,
  \`error_file\` VARCHAR(255),
  \`error_line\` INT UNSIGNED,
  \`error_context\` JSON,
  \`user_id\` BIGINT UNSIGNED NULL,
  \`ip_address\` VARCHAR(45),
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX \`idx_type_created\` (\`error_type\`, \`created_at\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Application error logs';

-- 198. api_request_logs
CREATE TABLE \`api_request_logs\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`endpoint\` VARCHAR(255) NOT NULL,
  \`method\` VARCHAR(10) NOT NULL,
  \`request_headers\` JSON,
  \`request_body\` TEXT,
  \`response_status\` INT UNSIGNED,
  \`response_time\` INT UNSIGNED COMMENT 'Milliseconds',
  \`user_id\` BIGINT UNSIGNED NULL,
  \`ip_address\` VARCHAR(45),
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX \`idx_endpoint\` (\`endpoint\`),
  INDEX \`idx_created\` (\`created_at\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='API request logs';

-- ==============================================================================
-- CATEGORY N: SYSTEM & CONFIGURATION (10 TABLES) - Tables 199-208
-- ==============================================================================

-- 199. migrations
CREATE TABLE \`migrations\` (
  \`id\` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`migration_name\` VARCHAR(255) NOT NULL UNIQUE,
  \`batch\` INT UNSIGNED NOT NULL,
  \`executed_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Database migrations';

-- 200. sessions
CREATE TABLE \`sessions\` (
  \`id\` VARCHAR(255) PRIMARY KEY,
  \`user_id\` BIGINT UNSIGNED NULL,
  \`ip_address\` VARCHAR(45),
  \`user_agent\` TEXT,
  \`payload\` TEXT NOT NULL,
  \`last_activity\` INT UNSIGNED NOT NULL,
  INDEX \`idx_user\` (\`user_id\`),
  INDEX \`idx_last_activity\` (\`last_activity\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Session storage';

-- 201. cache
CREATE TABLE \`cache\` (
  \`key\` VARCHAR(255) PRIMARY KEY,
  \`value\` TEXT NOT NULL,
  \`expiration\` INT UNSIGNED NOT NULL,
  INDEX \`idx_expiration\` (\`expiration\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Application cache';

-- 202. jobs
CREATE TABLE \`jobs\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`queue\` VARCHAR(255) NOT NULL,
  \`payload\` TEXT NOT NULL,
  \`attempts\` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  \`reserved_at\` INT UNSIGNED NULL,
  \`available_at\` INT UNSIGNED NOT NULL,
  \`created_at\` INT UNSIGNED NOT NULL,
  INDEX \`idx_queue_reserved\` (\`queue\`, \`reserved_at\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Background jobs queue';

-- 203. failed_jobs
CREATE TABLE \`failed_jobs\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`connection\` TEXT NOT NULL,
  \`queue\` TEXT NOT NULL,
  \`payload\` TEXT NOT NULL,
  \`exception\` LONGTEXT NOT NULL,
  \`failed_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Failed background jobs';

-- 204. notifications
CREATE TABLE \`notifications\` (
  \`id\` CHAR(36) PRIMARY KEY,
  \`type\` VARCHAR(255) NOT NULL,
  \`notifiable_type\` VARCHAR(255) NOT NULL,
  \`notifiable_id\` BIGINT UNSIGNED NOT NULL,
  \`data\` TEXT NOT NULL,
  \`read_at\` TIMESTAMP NULL,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX \`idx_notifiable\` (\`notifiable_type\`, \`notifiable_id\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='System notifications';

-- 205. backups
CREATE TABLE \`backups\` (
  \`id\` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`backup_name\` VARCHAR(255) NOT NULL,
  \`backup_path\` VARCHAR(255) NOT NULL,
  \`backup_type\` ENUM('full', 'database', 'files') NOT NULL,
  \`backup_size\` BIGINT UNSIGNED,
  \`backup_status\` ENUM('in_progress', 'completed', 'failed') DEFAULT 'in_progress',
  \`created_by\` BIGINT UNSIGNED,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX \`idx_created\` (\`created_at\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Backup records';

-- 206. cron_jobs
CREATE TABLE \`cron_jobs\` (
  \`id\` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`job_name\` VARCHAR(255) NOT NULL UNIQUE,
  \`job_command\` VARCHAR(255) NOT NULL,
  \`job_schedule\` VARCHAR(100) NOT NULL COMMENT 'Cron expression',
  \`last_run_at\` TIMESTAMP NULL,
  \`next_run_at\` TIMESTAMP NULL,
  \`is_active\` BOOLEAN DEFAULT TRUE,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`updated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX \`idx_next_run\` (\`next_run_at\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Scheduled cron jobs';

-- 207. audit_trails
CREATE TABLE \`audit_trails\` (
  \`id\` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`user_id\` BIGINT UNSIGNED NULL,
  \`action\` VARCHAR(100) NOT NULL,
  \`model_type\` VARCHAR(100),
  \`model_id\` BIGINT UNSIGNED,
  \`old_values\` JSON,
  \`new_values\` JSON,
  \`ip_address\` VARCHAR(45),
  \`user_agent\` TEXT,
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX \`idx_user_action\` (\`user_id\`, \`action\`),
  INDEX \`idx_model\` (\`model_type\`, \`model_id\`),
  INDEX \`idx_created\` (\`created_at\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='System audit trail';

-- 208. feature_flags
CREATE TABLE \`feature_flags\` (
  \`id\` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  \`flag_name\` VARCHAR(100) NOT NULL UNIQUE,
  \`flag_description\` TEXT,
  \`is_enabled\` BOOLEAN DEFAULT FALSE,
  \`rollout_percentage\` INT UNSIGNED DEFAULT 0 COMMENT '0-100',
  \`target_roles\` JSON COMMENT 'Which roles have access',
  \`created_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  \`updated_at\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX \`idx_enabled\` (\`is_enabled\`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Feature flag toggles';

-- ==============================================================================
-- FINAL SETTINGS
-- ==============================================================================

SET FOREIGN_KEY_CHECKS=1;
COMMIT;

-- ============================================
-- DATABASE COMPLETE!
-- ALL 208 TABLES CREATED SUCCESSFULLY
-- ============================================
```

**🎉 CONGRATULATIONS! All 208 tables created successfully!**

### 4.3 Insert Sample Data

Sekarang kita insert sample data untuk testing:

```sql
-- ============================================
-- SAMPLE DATA FOR TESTING
-- ============================================

-- Insert default Super Admin
INSERT INTO \`users\` (\`id\`, \`role_id\`, \`email\`, \`password\`, \`first_name\`, \`last_name\`, \`phone\`, \`status\`, \`email_verified_at\`) VALUES
(1, 1, 'admin@situneo.my.id', '$2y$12$LQv3c1yYqBW/XC9gQx7WCe92pso/czJQjNGg.hKNE9K8F7kVJlO4W', 'Super', 'Admin', '081234567890', 'active', NOW());
-- Password: Admin123!

-- Insert admin profile
INSERT INTO \`user_profiles\` (\`user_id\`, \`city\`, \`province\`, \`country\`) VALUES
(1, 'Jakarta', 'DKI Jakarta', 'Indonesia');

-- Insert admin record
INSERT INTO \`admins\` (\`user_id\`, \`admin_level\`, \`employee_id\`, \`hire_date\`) VALUES
(1, 'super_admin', 'EMP-001', CURDATE());

-- Insert sample service categories (10 divisions)
INSERT INTO \`service_categories\` (\`category_name\`, \`category_slug\`, \`description\`, \`display_order\`) VALUES
('Website & Development', 'website-development', 'Website dan aplikasi web development', 1),
('Mobile Apps', 'mobile-apps', 'Android dan iOS mobile apps', 2),
('Digital Marketing', 'digital-marketing', 'SEO, SEM, Social Media Marketing', 3),
('Design & Multimedia', 'design-multimedia', 'Graphic design, video editing, animation', 4),
('Cloud & DevOps', 'cloud-devops', 'Cloud hosting, server management, CI/CD', 5),
('AI & Machine Learning', 'ai-ml', 'AI integration, chatbots, ML models', 6),
('Blockchain', 'blockchain', 'Smart contracts, DApps, NFT', 7),
('IoT', 'iot', 'Internet of Things solutions', 8),
('Cybersecurity', 'cybersecurity', 'Security audits, penetration testing', 9),
('Consulting', 'consulting', 'IT consulting dan strategy', 10);

-- Insert sample email templates
INSERT INTO \`email_templates\` (\`template_name\`, \`template_slug\`, \`template_subject\`, \`template_body\`, \`template_category\`) VALUES
('Welcome Email', 'welcome-email', 'Selamat Datang di SITUNEO DIGITAL', 'Halo {{name}}, terima kasih telah bergabung!', 'onboarding'),
('Email Verification', 'email-verification', 'Verifikasi Email Anda', 'Klik link berikut: {{verification_link}}', 'authentication'),
('Password Reset', 'password-reset', 'Reset Password Anda', 'Gunakan kode: {{reset_code}}', 'authentication'),
('Order Confirmation', 'order-confirmation', 'Pesanan #{{order_number}} Dikonfirmasi', 'Terima kasih atas pesanan Anda!', 'orders'),
('Payment Received', 'payment-received', 'Pembayaran Diterima', 'Pembayaran Anda telah dikonfirmasi.', 'payments');
```

**Verify Installation:**

```bash
# Check table count
mysql -u root -p situneo_digital -e "SELECT COUNT(*) as total_tables FROM information_schema.tables WHERE table_schema = 'situneo_digital';"

# Should show: 208 tables
```

---

## 5. CONFIGURATION FILES

### 5.1 Create .env File

**File:** \`.env\` (di root project)

```bash
# Application
APP_NAME="SITUNEO DIGITAL"
APP_URL=http://localhost/situneo-digital
APP_ENV=development
APP_DEBUG=true

# Database
DB_HOST=localhost
DB_PORT=3306
DB_DATABASE=situneo_digital
DB_USERNAME=root
DB_PASSWORD=

# Email (SMTP)
MAIL_DRIVER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=your-email@gmail.com
MAIL_PASSWORD=your-app-password
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=noreply@situneo.my.id
MAIL_FROM_NAME="SITUNEO DIGITAL"

# Security
SESSION_LIFETIME=120
CSRF_TOKEN_NAME=csrf_token
ENCRYPTION_KEY=base64:your-32-character-encryption-key-here

# Upload Settings
MAX_UPLOAD_SIZE=10485760
ALLOWED_EXTENSIONS=jpg,jpeg,png,pdf,doc,docx,zip

# Timezone
TIMEZONE=Asia/Jakarta

# Company Info
COMPANY_NAME="PT SITUNEO DIGITAL SOLUSI INDONESIA"
COMPANY_NIB=1401250064281
COMPANY_EMAIL=info@situneo.my.id
COMPANY_PHONE=+6281234567890
COMPANY_ADDRESS="Jakarta, Indonesia"
```

### 5.2 Create config.php

**File:** \`config/config.php\`

```php
<?php
/**
 * Configuration utama aplikasi
 * PT SITUNEO DIGITAL SOLUSI INDONESIA
 * NIB: 1401250064281
 */

// Load environment variables
if (file_exists(__DIR__ . '/../.env')) {
    $lines = file(__DIR__ . '/../.env', FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    foreach ($lines as $line) {
        if (strpos(trim($line), '#') === 0) continue; // Skip comments
        list($name, $value) = explode('=', $line, 2);
        $_ENV[trim($name)] = trim($value);
    }
}

// Helper function untuk get env value
function env($key, $default = null) {
    return isset($_ENV[$key]) ? $_ENV[$key] : $default;
}

// Define constants
define('APP_NAME', env('APP_NAME', 'SITUNEO DIGITAL'));
define('APP_URL', env('APP_URL', 'http://localhost'));
define('APP_ENV', env('APP_ENV', 'production'));
define('APP_DEBUG', env('APP_DEBUG', 'false') === 'true');

// Path constants
define('ROOT_PATH', dirname(__DIR__));
define('APP_PATH', ROOT_PATH . '/app');
define('PUBLIC_PATH', ROOT_PATH . '/public');
define('STORAGE_PATH', ROOT_PATH . '/storage');
define('CONFIG_PATH', ROOT_PATH . '/config');
define('UPLOAD_PATH', PUBLIC_PATH . '/uploads');

// Database config
define('DB_HOST', env('DB_HOST', 'localhost'));
define('DB_PORT', env('DB_PORT', '3306'));
define('DB_DATABASE', env('DB_DATABASE', 'situneo_digital'));
define('DB_USERNAME', env('DB_USERNAME', 'root'));
define('DB_PASSWORD', env('DB_PASSWORD', ''));

// Email config
define('MAIL_HOST', env('MAIL_HOST', 'smtp.gmail.com'));
define('MAIL_PORT', env('MAIL_PORT', '587'));
define('MAIL_USERNAME', env('MAIL_USERNAME', ''));
define('MAIL_PASSWORD', env('MAIL_PASSWORD', ''));
define('MAIL_ENCRYPTION', env('MAIL_ENCRYPTION', 'tls'));
define('MAIL_FROM_ADDRESS', env('MAIL_FROM_ADDRESS', 'noreply@situneo.my.id'));
define('MAIL_FROM_NAME', env('MAIL_FROM_NAME', 'SITUNEO DIGITAL'));

// Security
define('SESSION_LIFETIME', (int)env('SESSION_LIFETIME', 120)); // minutes
define('CSRF_TOKEN_NAME', env('CSRF_TOKEN_NAME', 'csrf_token'));
define('ENCRYPTION_KEY', env('ENCRYPTION_KEY', ''));

// Upload settings
define('MAX_UPLOAD_SIZE', (int)env('MAX_UPLOAD_SIZE', 10485760)); // 10MB default
define('ALLOWED_EXTENSIONS', env('ALLOWED_EXTENSIONS', 'jpg,jpeg,png,pdf,doc,docx,zip'));

// Timezone
date_default_timezone_set(env('TIMEZONE', 'Asia/Jakarta'));

// Company info
define('COMPANY_NAME', env('COMPANY_NAME', 'PT SITUNEO DIGITAL SOLUSI INDONESIA'));
define('COMPANY_NIB', env('COMPANY_NIB', '1401250064281'));
define('COMPANY_EMAIL', env('COMPANY_EMAIL', 'info@situneo.my.id'));
define('COMPANY_PHONE', env('COMPANY_PHONE', '+6281234567890'));
define('COMPANY_ADDRESS', env('COMPANY_ADDRESS', 'Jakarta, Indonesia'));

// Commission rates (sesuai specs)
define('COMMISSION_PARTNER_MIN', 30.00);
define('COMMISSION_PARTNER_MAX', 55.00);
define('COMMISSION_SPV', 10.00);
define('COMMISSION_MANAGER', 5.00);

// Pricing (sesuai specs)
define('PRICE_BELI_PER_PAGE', 350000); // Rp 350K per halaman
define('PRICE_SEWA_MONTHLY', 150000);  // Rp 150K per bulan
define('SEWA_MINIMUM_MONTHS', 3);      // Minimum 3 bulan

// Error reporting
if (APP_DEBUG) {
    error_reporting(E_ALL);
    ini_set('display_errors', 1);
} else {
    error_reporting(0);
    ini_set('display_errors', 0);
}

// Session configuration
ini_set('session.gc_maxlifetime', SESSION_LIFETIME * 60);
ini_set('session.cookie_httponly', 1);
ini_set('session.use_only_cookies', 1);

// Start session
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

return [
    'app' => [
        'name' => APP_NAME,
        'url' => APP_URL,
        'env' => APP_ENV,
        'debug' => APP_DEBUG
    ],
    'database' => [
        'host' => DB_HOST,
        'port' => DB_PORT,
        'database' => DB_DATABASE,
        'username' => DB_USERNAME,
        'password' => DB_PASSWORD
    ],
    'mail' => [
        'host' => MAIL_HOST,
        'port' => MAIL_PORT,
        'username' => MAIL_USERNAME,
        'password' => MAIL_PASSWORD,
        'encryption' => MAIL_ENCRYPTION,
        'from' => [
            'address' => MAIL_FROM_ADDRESS,
            'name' => MAIL_FROM_NAME
        ]
    ],
    'company' => [
        'name' => COMPANY_NAME,
        'nib' => COMPANY_NIB,
        'email' => COMPANY_EMAIL,
        'phone' => COMPANY_PHONE,
        'address' => COMPANY_ADDRESS
    ]
];
?>
```

---

## 6. HELPER CLASSES

### 6.1 Database Helper

**File:** \`app/helpers/Database.php\`

```php
<?php
/**
 * Database Helper Class
 * PDO Wrapper dengan connection pooling
 * 
 * @package SITUNEO
 * @author PT SITUNEO DIGITAL SOLUSI INDONESIA
 */

class Database {
    private static $instance = null;
    private $pdo;
    private $stmt;
    
    /**
     * Constructor - Private untuk Singleton pattern
     */
    private function __construct() {
        try {
            $dsn = "mysql:host=" . DB_HOST . ";port=" . DB_PORT . ";dbname=" . DB_DATABASE . ";charset=utf8mb4";
            
            $options = [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, // Throw exceptions on errors
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC, // Fetch sebagai associative array
                PDO::ATTR_EMULATE_PREPARES => false, // Use native prepared statements
                PDO::ATTR_PERSISTENT => true, // Connection pooling
                PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci"
            ];
            
            $this->pdo = new PDO($dsn, DB_USERNAME, DB_PASSWORD, $options);
            
        } catch (PDOException $e) {
            // Log error ke file
            $this->logError('Database Connection Error: ' . $e->getMessage());
            
            if (APP_DEBUG) {
                die('Database Connection Failed: ' . $e->getMessage());
            } else {
                die('Terjadi kesalahan koneksi database. Silakan coba lagi nanti.');
            }
        }
    }
    
    /**
     * Get singleton instance
     * 
     * @return Database
     */
    public static function getInstance() {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }
    
    /**
     * Prepare SQL query
     * 
     * @param string $sql SQL query dengan placeholders
     * @return void
     */
    public function query($sql) {
        $this->stmt = $this->pdo->prepare($sql);
    }
    
    /**
     * Bind parameter ke prepared statement
     * 
     * @param string|int $param Parameter name atau index
     * @param mixed $value Nilai parameter
     * @param int|null $type PDO parameter type
     * @return void
     */
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
    }
    
    /**
     * Execute prepared statement
     * 
     * @return bool
     */
    public function execute() {
        try {
            return $this->stmt->execute();
        } catch (PDOException $e) {
            $this->logError('Query Execution Error: ' . $e->getMessage());
            
            if (APP_DEBUG) {
                throw $e;
            }
            return false;
        }
    }
    
    /**
     * Fetch multiple rows
     * 
     * @return array
     */
    public function resultSet() {
        $this->execute();
        return $this->stmt->fetchAll();
    }
    
    /**
     * Fetch single row
     * 
     * @return array|false
     */
    public function single() {
        $this->execute();
        return $this->stmt->fetch();
    }
    
    /**
     * Get row count
     * 
     * @return int
     */
    public function rowCount() {
        return $this->stmt->rowCount();
    }
    
    /**
     * Get last insert ID
     * 
     * @return string
     */
    public function lastInsertId() {
        return $this->pdo->lastInsertId();
    }
    
    /**
     * Begin transaction
     * 
     * @return bool
     */
    public function beginTransaction() {
        return $this->pdo->beginTransaction();
    }
    
    /**
     * Commit transaction
     * 
     * @return bool
     */
    public function commit() {
        return $this->pdo->commit();
    }
    
    /**
     * Rollback transaction
     * 
     * @return bool
     */
    public function rollback() {
        return $this->pdo->rollBack();
    }
    
    /**
     * Log error ke file
     * 
     * @param string $message Error message
     * @return void
     */
    private function logError($message) {
        $logFile = STORAGE_PATH . '/logs/database.log';
        $logMessage = '[' . date('Y-m-d H:i:s') . '] ' . $message . PHP_EOL;
        file_put_contents($logFile, $logMessage, FILE_APPEND);
    }
    
    /**
     * Prevent cloning
     */
    private function __clone() {}
    
    /**
     * Prevent unserializing
     */
    public function __wakeup() {
        throw new Exception("Cannot unserialize singleton");
    }
}
?>
```

**Progress: 3,863 → 4,200+ lines!** Lanjut dengan Validator, Mailer, Session, CSRF, dan sections lainnya...

Apakah saya lanjutkan dengan **Helper classes sisanya + Models + Controllers + Views**? (Estimasi akan jadi ~8,000-10,000 lines total)
