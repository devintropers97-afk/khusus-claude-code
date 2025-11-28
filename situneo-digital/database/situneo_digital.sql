-- ==============================================
-- SITUNEO DIGITAL - Database Schema
-- PT SITUNEO DIGITAL SOLUSI INDONESIA
-- NIB: 1401250064281
--
-- Database untuk sistem lengkap dengan 208 tables
-- MySQL 8.0+ / MariaDB 10.5+
-- Charset: utf8mb4_unicode_ci
-- ==============================================

-- Drop database if exists (HATI-HATI: Hapus jika sudah ada data!)
-- DROP DATABASE IF EXISTS situneo_digital;

-- Create database
CREATE DATABASE IF NOT EXISTS situneo_digital
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE situneo_digital;

-- ==============================================
-- CATEGORY A: USER MANAGEMENT (18 tables)
-- ==============================================

-- 1. Roles Table
CREATE TABLE `roles` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(50) NOT NULL UNIQUE COMMENT 'Role name',
  `display_name` VARCHAR(100) NOT NULL,
  `description` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='User roles';

-- Insert default roles
INSERT INTO `roles` (`id`, `name`, `display_name`, `description`) VALUES
(1, 'super_admin', 'Super Admin', 'Full system access'),
(2, 'manager', 'Manager', 'Manager level access'),
(3, 'spv', 'Supervisor', 'Supervisor level access'),
(4, 'partner', 'Partner', 'Partner/Reseller access'),
(5, 'client', 'Client', 'End client access');

-- 2. Users Table
CREATE TABLE `users` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `role_id` INT UNSIGNED NOT NULL DEFAULT 5,
  `email` VARCHAR(255) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL COMMENT 'bcrypt hashed, cost 12',
  `first_name` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(20),
  `avatar` VARCHAR(255),
  `status` ENUM('active', 'inactive', 'suspended') DEFAULT 'active',
  `email_verified_at` TIMESTAMP NULL,
  `last_login_at` TIMESTAMP NULL,
  `last_login_ip` VARCHAR(45),
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL,
  INDEX `idx_role_status` (`role_id`, `status`),
  INDEX `idx_email` (`email`),
  INDEX `idx_deleted` (`deleted_at`),
  FOREIGN KEY (`role_id`) REFERENCES `roles`(`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Main users table';

-- 3. User Profiles
CREATE TABLE `user_profiles` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL UNIQUE,
  `address` TEXT,
  `city` VARCHAR(100),
  `province` VARCHAR(100),
  `postal_code` VARCHAR(10),
  `country` VARCHAR(100) DEFAULT 'Indonesia',
  `bio` TEXT,
  `website` VARCHAR(255),
  `facebook` VARCHAR(255),
  `instagram` VARCHAR(255),
  `linkedin` VARCHAR(255),
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Extended user profile information';

-- 4. Verification Tokens
CREATE TABLE `verification_tokens` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `token` VARCHAR(255) NOT NULL UNIQUE,
  `type` ENUM('email_verification', 'password_reset', 'phone_verification') NOT NULL,
  `expires_at` TIMESTAMP NOT NULL,
  `used_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX `idx_token` (`token`),
  INDEX `idx_user_type` (`user_id`, `type`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Email/password verification tokens';

-- 5. Remember Tokens
CREATE TABLE `remember_tokens` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `token` VARCHAR(255) NOT NULL,
  `expires_at` TIMESTAMP NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `unique_user` (`user_id`),
  INDEX `idx_token` (`token`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Remember me tokens';

-- 6. Activity Logs
CREATE TABLE `activity_logs` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED,
  `action` VARCHAR(100) NOT NULL,
  `description` TEXT,
  `ip_address` VARCHAR(45),
  `user_agent` TEXT,
  `metadata` JSON,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX `idx_user_action` (`user_id`, `action`),
  INDEX `idx_created` (`created_at`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='User activity tracking';

-- 7. Permissions
CREATE TABLE `permissions` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(100) NOT NULL UNIQUE,
  `display_name` VARCHAR(100) NOT NULL,
  `description` TEXT,
  `module` VARCHAR(50),
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='System permissions';

-- 8. Role Permissions
CREATE TABLE `role_permissions` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `role_id` INT UNSIGNED NOT NULL,
  `permission_id` INT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `unique_role_permission` (`role_id`, `permission_id`),
  FOREIGN KEY (`role_id`) REFERENCES `roles`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`permission_id`) REFERENCES `permissions`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Permissions assigned to roles';

-- 9-18. Additional User Management Tables
CREATE TABLE `user_sessions` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `session_id` VARCHAR(255) NOT NULL,
  `ip_address` VARCHAR(45),
  `user_agent` TEXT,
  `last_activity` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX `idx_user` (`user_id`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `user_settings` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL UNIQUE,
  `theme` ENUM('light', 'dark') DEFAULT 'light',
  `language` VARCHAR(10) DEFAULT 'id',
  `timezone` VARCHAR(50) DEFAULT 'Asia/Jakarta',
  `notifications_email` BOOLEAN DEFAULT TRUE,
  `notifications_sms` BOOLEAN DEFAULT FALSE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `user_devices` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `device_type` VARCHAR(50),
  `device_name` VARCHAR(100),
  `device_token` VARCHAR(255),
  `is_active` BOOLEAN DEFAULT TRUE,
  `last_used_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX `idx_user` (`user_id`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `user_notifications` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `type` VARCHAR(50),
  `title` VARCHAR(255),
  `message` TEXT,
  `link` VARCHAR(255),
  `is_read` BOOLEAN DEFAULT FALSE,
  `read_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX `idx_user_read` (`user_id`, `is_read`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `user_addresses` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `label` VARCHAR(50),
  `recipient_name` VARCHAR(100),
  `phone` VARCHAR(20),
  `address` TEXT,
  `city` VARCHAR(100),
  `province` VARCHAR(100),
  `postal_code` VARCHAR(10),
  `is_default` BOOLEAN DEFAULT FALSE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `idx_user` (`user_id`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `user_documents` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `document_type` ENUM('ktp', 'npwp', 'siup', 'nib', 'other'),
  `document_number` VARCHAR(100),
  `document_file` VARCHAR(255),
  `verified_at` TIMESTAMP NULL,
  `verified_by` BIGINT UNSIGNED,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX `idx_user` (`user_id`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `user_bank_accounts` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `bank_name` VARCHAR(100),
  `account_number` VARCHAR(50),
  `account_holder_name` VARCHAR(100),
  `branch` VARCHAR(100),
  `is_verified` BOOLEAN DEFAULT FALSE,
  `is_default` BOOLEAN DEFAULT FALSE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `idx_user` (`user_id`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `user_referrals` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `referrer_id` BIGINT UNSIGNED NOT NULL COMMENT 'User who referred',
  `referred_id` BIGINT UNSIGNED NOT NULL COMMENT 'User who was referred',
  `referral_code` VARCHAR(50),
  `status` ENUM('pending', 'completed') DEFAULT 'pending',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `unique_referral` (`referrer_id`, `referred_id`),
  FOREIGN KEY (`referrer_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`referred_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `user_kyc` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL UNIQUE,
  `status` ENUM('pending', 'verified', 'rejected') DEFAULT 'pending',
  `verified_at` TIMESTAMP NULL,
  `verified_by` BIGINT UNSIGNED,
  `rejection_reason` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ==============================================
-- CATEGORY B: ADMIN SYSTEM (12 tables)
-- ==============================================

CREATE TABLE `admin_dashboard_widgets` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `role_id` INT UNSIGNED NOT NULL,
  `widget_name` VARCHAR(100),
  `widget_config` JSON,
  `position` INT DEFAULT 0,
  `is_active` BOOLEAN DEFAULT TRUE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`role_id`) REFERENCES `roles`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `admin_settings` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `key` VARCHAR(100) NOT NULL UNIQUE,
  `value` TEXT,
  `type` ENUM('string', 'number', 'boolean', 'json') DEFAULT 'string',
  `category` VARCHAR(50),
  `description` TEXT,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `admin_announcements` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `title` VARCHAR(255),
  `content` TEXT,
  `type` ENUM('info', 'warning', 'success', 'danger') DEFAULT 'info',
  `target_roles` JSON COMMENT 'Array of role IDs',
  `is_active` BOOLEAN DEFAULT TRUE,
  `start_date` TIMESTAMP NULL,
  `end_date` TIMESTAMP NULL,
  `created_by` BIGINT UNSIGNED,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`created_by`) REFERENCES `users`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `admin_menu_items` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `parent_id` INT UNSIGNED,
  `title` VARCHAR(100),
  `icon` VARCHAR(50),
  `url` VARCHAR(255),
  `permission` VARCHAR(100),
  `order` INT DEFAULT 0,
  `is_active` BOOLEAN DEFAULT TRUE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `admin_audit_logs` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED,
  `action` VARCHAR(100),
  `table_name` VARCHAR(100),
  `record_id` BIGINT UNSIGNED,
  `old_values` JSON,
  `new_values` JSON,
  `ip_address` VARCHAR(45),
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX `idx_user_action` (`user_id`, `action`),
  INDEX `idx_table_record` (`table_name`, `record_id`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `admin_reports` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `report_type` VARCHAR(100),
  `title` VARCHAR(255),
  `description` TEXT,
  `file_path` VARCHAR(255),
  `status` ENUM('pending', 'completed', 'failed') DEFAULT 'pending',
  `generated_by` BIGINT UNSIGNED,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`generated_by`) REFERENCES `users`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `admin_backups` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `backup_name` VARCHAR(255),
  `backup_type` ENUM('database', 'files', 'full') DEFAULT 'database',
  `file_path` VARCHAR(255),
  `file_size` BIGINT,
  `status` ENUM('completed', 'failed') DEFAULT 'completed',
  `created_by` BIGINT UNSIGNED,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`created_by`) REFERENCES `users`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `admin_system_logs` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `level` ENUM('debug', 'info', 'warning', 'error', 'critical'),
  `message` TEXT,
  `context` JSON,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX `idx_level_created` (`level`, `created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `admin_scheduled_tasks` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `task_name` VARCHAR(100),
  `command` VARCHAR(255),
  `schedule` VARCHAR(100) COMMENT 'Cron expression',
  `last_run_at` TIMESTAMP NULL,
  `next_run_at` TIMESTAMP NULL,
  `is_active` BOOLEAN DEFAULT TRUE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `admin_email_queue` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `to` VARCHAR(255),
  `subject` VARCHAR(255),
  `body` TEXT,
  `attachments` JSON,
  `status` ENUM('pending', 'sent', 'failed') DEFAULT 'pending',
  `attempts` INT DEFAULT 0,
  `sent_at` TIMESTAMP NULL,
  `error` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `admin_cache` (
  `key` VARCHAR(255) PRIMARY KEY,
  `value` LONGTEXT,
  `expires_at` TIMESTAMP NULL,
  INDEX `idx_expires` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `admin_failed_jobs` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `queue` VARCHAR(100),
  `payload` LONGTEXT,
  `exception` LONGTEXT,
  `failed_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ==============================================
-- CATEGORY C: PARTNER SYSTEM (28 tables)
-- ==============================================

-- 1. Partner Profiles
CREATE TABLE `partner_profiles` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL UNIQUE,
  `partner_code` VARCHAR(50) NOT NULL UNIQUE COMMENT 'Unique partner code',
  `company_name` VARCHAR(255),
  `company_type` ENUM('individual', 'pt', 'cv', 'ud', 'other'),
  `tier` ENUM('tier1', 'tier2', 'tier3', 'tier4') DEFAULT 'tier1',
  `commission_rate` DECIMAL(5,2) DEFAULT 30.00 COMMENT 'Commission percentage',
  `spv_id` BIGINT UNSIGNED COMMENT 'Assigned SPV',
  `manager_id` BIGINT UNSIGNED COMMENT 'Assigned Manager',
  `status` ENUM('pending', 'active', 'suspended', 'terminated') DEFAULT 'pending',
  `approved_at` TIMESTAMP NULL,
  `approved_by` BIGINT UNSIGNED,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `idx_code` (`partner_code`),
  INDEX `idx_spv` (`spv_id`),
  INDEX `idx_manager` (`manager_id`),
  INDEX `idx_tier` (`tier`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`spv_id`) REFERENCES `users`(`id`) ON DELETE SET NULL,
  FOREIGN KEY (`manager_id`) REFERENCES `users`(`id`) ON DELETE SET NULL,
  FOREIGN KEY (`approved_by`) REFERENCES `users`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Partner extended profiles';

-- 2. Partner Commission Tiers
CREATE TABLE `partner_commission_tiers` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `tier_name` VARCHAR(50) NOT NULL,
  `tier_level` INT NOT NULL,
  `min_sales` DECIMAL(15,2) DEFAULT 0,
  `max_sales` DECIMAL(15,2),
  `commission_rate` DECIMAL(5,2) NOT NULL COMMENT 'Percentage',
  `description` TEXT,
  `is_active` BOOLEAN DEFAULT TRUE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `unique_tier` (`tier_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert default commission tiers
INSERT INTO `partner_commission_tiers` (`tier_name`, `tier_level`, `min_sales`, `max_sales`, `commission_rate`, `description`) VALUES
('Tier 1 - Bronze', 1, 0, 10000000, 30.00, 'New partners, 0-10 Juta/bulan'),
('Tier 2 - Silver', 2, 10000000, 25000000, 40.00, 'Growing partners, 10-25 Juta/bulan'),
('Tier 3 - Gold', 3, 25000000, 50000000, 50.00, 'Established partners, 25-50 Juta/bulan'),
('Tier 4 - Platinum', 4, 50000000, NULL, 55.00, 'Top partners, 50+ Juta/bulan');

-- 3. Partner Sales Targets
CREATE TABLE `partner_sales_targets` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `year` INT NOT NULL,
  `month` INT NOT NULL,
  `target_amount` DECIMAL(15,2) NOT NULL,
  `achieved_amount` DECIMAL(15,2) DEFAULT 0,
  `achievement_percentage` DECIMAL(5,2) DEFAULT 0,
  `status` ENUM('pending', 'in_progress', 'achieved', 'failed') DEFAULT 'pending',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `unique_target` (`partner_id`, `year`, `month`),
  FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4. Partner Commissions
CREATE TABLE `partner_commissions` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `order_id` BIGINT UNSIGNED,
  `commission_type` ENUM('direct_sale', 'recurring', 'bonus', 'arpu') DEFAULT 'direct_sale',
  `base_amount` DECIMAL(15,2) NOT NULL COMMENT 'Base order amount',
  `commission_rate` DECIMAL(5,2) NOT NULL,
  `commission_amount` DECIMAL(15,2) NOT NULL,
  `status` ENUM('pending', 'approved', 'paid', 'cancelled') DEFAULT 'pending',
  `approved_at` TIMESTAMP NULL,
  `approved_by` BIGINT UNSIGNED,
  `paid_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `idx_partner_status` (`partner_id`, `status`),
  INDEX `idx_order` (`order_id`),
  FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`approved_by`) REFERENCES `users`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 5. Partner Withdrawals
CREATE TABLE `partner_withdrawals` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `amount` DECIMAL(15,2) NOT NULL,
  `bank_account_id` BIGINT UNSIGNED,
  `status` ENUM('pending', 'approved', 'processing', 'completed', 'rejected') DEFAULT 'pending',
  `proof_of_payment` VARCHAR(255),
  `notes` TEXT,
  `approved_at` TIMESTAMP NULL,
  `approved_by` BIGINT UNSIGNED,
  `completed_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `idx_partner_status` (`partner_id`, `status`),
  FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`bank_account_id`) REFERENCES `user_bank_accounts`(`id`) ON DELETE SET NULL,
  FOREIGN KEY (`approved_by`) REFERENCES `users`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 6-28. Additional Partner Tables
CREATE TABLE `partner_clients` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `client_id` BIGINT UNSIGNED NOT NULL,
  `acquisition_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `status` ENUM('active', 'inactive', 'churned') DEFAULT 'active',
  `lifetime_value` DECIMAL(15,2) DEFAULT 0,
  `total_orders` INT DEFAULT 0,
  `last_order_at` TIMESTAMP NULL,
  UNIQUE KEY `unique_partner_client` (`partner_id`, `client_id`),
  FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`client_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `partner_performance` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `year` INT NOT NULL,
  `month` INT NOT NULL,
  `total_sales` DECIMAL(15,2) DEFAULT 0,
  `total_orders` INT DEFAULT 0,
  `new_clients` INT DEFAULT 0,
  `active_clients` INT DEFAULT 0,
  `total_commission` DECIMAL(15,2) DEFAULT 0,
  `tier_achieved` ENUM('tier1', 'tier2', 'tier3', 'tier4'),
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `unique_performance` (`partner_id`, `year`, `month`),
  FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `partner_marketing_materials` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `title` VARCHAR(255),
  `description` TEXT,
  `file_type` ENUM('image', 'video', 'pdf', 'link'),
  `file_url` VARCHAR(255),
  `category` VARCHAR(50),
  `is_active` BOOLEAN DEFAULT TRUE,
  `created_by` BIGINT UNSIGNED,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`created_by`) REFERENCES `users`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `partner_training_modules` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `title` VARCHAR(255),
  `description` TEXT,
  `content` LONGTEXT,
  `video_url` VARCHAR(255),
  `duration_minutes` INT,
  `order` INT DEFAULT 0,
  `is_mandatory` BOOLEAN DEFAULT FALSE,
  `is_active` BOOLEAN DEFAULT TRUE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `partner_training_progress` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `module_id` INT UNSIGNED NOT NULL,
  `status` ENUM('not_started', 'in_progress', 'completed') DEFAULT 'not_started',
  `progress_percentage` INT DEFAULT 0,
  `completed_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `unique_progress` (`partner_id`, `module_id`),
  FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`module_id`) REFERENCES `partner_training_modules`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `partner_referrals` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `referrer_partner_id` BIGINT UNSIGNED NOT NULL,
  `referred_partner_id` BIGINT UNSIGNED NOT NULL,
  `referral_code` VARCHAR(50),
  `bonus_amount` DECIMAL(15,2) DEFAULT 0,
  `bonus_paid` BOOLEAN DEFAULT FALSE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`referrer_partner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`referred_partner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `partner_territories` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `province` VARCHAR(100),
  `city` VARCHAR(100),
  `is_exclusive` BOOLEAN DEFAULT FALSE,
  `assigned_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `partner_contracts` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `contract_number` VARCHAR(100) UNIQUE,
  `contract_type` ENUM('standard', 'exclusive', 'trial'),
  `start_date` DATE NOT NULL,
  `end_date` DATE,
  `terms` LONGTEXT,
  `contract_file` VARCHAR(255),
  `status` ENUM('draft', 'active', 'expired', 'terminated') DEFAULT 'draft',
  `signed_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `partner_meetings` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `spv_id` BIGINT UNSIGNED,
  `meeting_type` ENUM('onboarding', 'review', 'training', 'support'),
  `meeting_date` TIMESTAMP,
  `duration_minutes` INT,
  `location` VARCHAR(255),
  `notes` TEXT,
  `status` ENUM('scheduled', 'completed', 'cancelled') DEFAULT 'scheduled',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`spv_id`) REFERENCES `users`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `partner_support_tickets` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `ticket_number` VARCHAR(50) UNIQUE,
  `subject` VARCHAR(255),
  `message` TEXT,
  `category` VARCHAR(50),
  `priority` ENUM('low', 'medium', 'high', 'urgent') DEFAULT 'medium',
  `status` ENUM('open', 'in_progress', 'resolved', 'closed') DEFAULT 'open',
  `assigned_to` BIGINT UNSIGNED,
  `resolved_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`assigned_to`) REFERENCES `users`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `partner_ticket_replies` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `ticket_id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `message` TEXT,
  `attachments` JSON,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`ticket_id`) REFERENCES `partner_support_tickets`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `partner_incentives` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `incentive_type` ENUM('performance_bonus', 'tier_upgrade', 'special_promo', 'referral_bonus'),
  `amount` DECIMAL(15,2),
  `description` TEXT,
  `eligibility_criteria` JSON,
  `status` ENUM('pending', 'approved', 'paid') DEFAULT 'pending',
  `valid_from` DATE,
  `valid_until` DATE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `partner_ratings` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `client_id` BIGINT UNSIGNED NOT NULL,
  `rating` INT CHECK (`rating` BETWEEN 1 AND 5),
  `review` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`client_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `partner_documents` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `document_type` VARCHAR(50),
  `document_name` VARCHAR(255),
  `file_path` VARCHAR(255),
  `uploaded_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `partner_activity_logs` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `activity_type` VARCHAR(50),
  `description` TEXT,
  `metadata` JSON,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `partner_price_lists` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED,
  `tier` ENUM('tier1', 'tier2', 'tier3', 'tier4'),
  `service_category` VARCHAR(100),
  `markup_percentage` DECIMAL(5,2) DEFAULT 0,
  `is_custom` BOOLEAN DEFAULT FALSE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `partner_payment_methods` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `method_type` ENUM('bank_transfer', 'e_wallet', 'crypto'),
  `method_details` JSON,
  `is_default` BOOLEAN DEFAULT FALSE,
  `is_verified` BOOLEAN DEFAULT FALSE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `partner_notifications` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `notification_type` VARCHAR(50),
  `title` VARCHAR(255),
  `message` TEXT,
  `is_read` BOOLEAN DEFAULT FALSE,
  `read_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `partner_settings` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL UNIQUE,
  `auto_approve_orders` BOOLEAN DEFAULT FALSE,
  `email_notifications` BOOLEAN DEFAULT TRUE,
  `sms_notifications` BOOLEAN DEFAULT FALSE,
  `commission_notification` BOOLEAN DEFAULT TRUE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `partner_arpu_tracking` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `year` INT NOT NULL,
  `month` INT NOT NULL,
  `total_revenue` DECIMAL(15,2) DEFAULT 0,
  `active_clients` INT DEFAULT 0,
  `arpu` DECIMAL(15,2) DEFAULT 0 COMMENT 'Average Revenue Per User',
  `bonus_earned` DECIMAL(15,2) DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `unique_arpu` (`partner_id`, `year`, `month`),
  FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `partner_tier_history` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `previous_tier` ENUM('tier1', 'tier2', 'tier3', 'tier4'),
  `new_tier` ENUM('tier1', 'tier2', 'tier3', 'tier4'),
  `previous_rate` DECIMAL(5,2),
  `new_rate` DECIMAL(5,2),
  `reason` TEXT,
  `effective_date` DATE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `partner_leaderboard` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `year` INT NOT NULL,
  `month` INT NOT NULL,
  `total_sales` DECIMAL(15,2),
  `rank` INT,
  `prize_amount` DECIMAL(15,2) DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `unique_leaderboard` (`partner_id`, `year`, `month`),
  FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ==============================================
-- CATEGORY D: SPV SYSTEM (15 tables)
-- ==============================================

-- 1. SPV Profiles
CREATE TABLE `spv_profiles` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL UNIQUE,
  `employee_id` VARCHAR(50) UNIQUE,
  `manager_id` BIGINT UNSIGNED,
  `territory` VARCHAR(100),
  `target_partners` INT DEFAULT 0,
  `current_partners` INT DEFAULT 0,
  `commission_rate` DECIMAL(5,2) DEFAULT 10.00 COMMENT 'SPV commission percentage',
  `status` ENUM('active', 'inactive', 'on_leave') DEFAULT 'active',
  `hired_date` DATE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`manager_id`) REFERENCES `users`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2-15. Additional SPV Tables
CREATE TABLE `spv_partner_assignments` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `assigned_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `status` ENUM('active', 'inactive', 'transferred') DEFAULT 'active',
  UNIQUE KEY `unique_assignment` (`spv_id`, `partner_id`),
  FOREIGN KEY (`spv_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `spv_performance` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `year` INT NOT NULL,
  `month` INT NOT NULL,
  `total_partners` INT DEFAULT 0,
  `active_partners` INT DEFAULT 0,
  `total_sales` DECIMAL(15,2) DEFAULT 0,
  `total_commission` DECIMAL(15,2) DEFAULT 0,
  `target_achievement` DECIMAL(5,2) DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `unique_performance` (`spv_id`, `year`, `month`),
  FOREIGN KEY (`spv_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `spv_commissions` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `partner_id` BIGINT UNSIGNED,
  `order_id` BIGINT UNSIGNED,
  `base_amount` DECIMAL(15,2),
  `commission_rate` DECIMAL(5,2),
  `commission_amount` DECIMAL(15,2),
  `status` ENUM('pending', 'approved', 'paid') DEFAULT 'pending',
  `paid_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`spv_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `spv_targets` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `year` INT NOT NULL,
  `month` INT NOT NULL,
  `partner_recruitment_target` INT,
  `sales_target` DECIMAL(15,2),
  `achieved_partners` INT DEFAULT 0,
  `achieved_sales` DECIMAL(15,2) DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `unique_target` (`spv_id`, `year`, `month`),
  FOREIGN KEY (`spv_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `spv_partner_reviews` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `partner_id` BIGINT UNSIGNED NOT NULL,
  `review_date` DATE,
  `performance_rating` INT CHECK (`performance_rating` BETWEEN 1 AND 5),
  `comments` TEXT,
  `action_items` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`spv_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `spv_tasks` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `task_type` VARCHAR(50),
  `title` VARCHAR(255),
  `description` TEXT,
  `priority` ENUM('low', 'medium', 'high') DEFAULT 'medium',
  `status` ENUM('pending', 'in_progress', 'completed') DEFAULT 'pending',
  `due_date` DATE,
  `completed_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`spv_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `spv_reports` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `report_type` VARCHAR(50),
  `report_period` VARCHAR(50),
  `report_data` JSON,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`spv_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `spv_activities` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `activity_type` VARCHAR(50),
  `partner_id` BIGINT UNSIGNED,
  `description` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`spv_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `spv_training_completed` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `training_name` VARCHAR(255),
  `completed_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `certificate_url` VARCHAR(255),
  FOREIGN KEY (`spv_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `spv_attendance` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `date` DATE NOT NULL,
  `check_in` TIME,
  `check_out` TIME,
  `status` ENUM('present', 'absent', 'leave', 'sick') DEFAULT 'present',
  `notes` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `unique_attendance` (`spv_id`, `date`),
  FOREIGN KEY (`spv_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `spv_leaves` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `leave_type` ENUM('annual', 'sick', 'emergency', 'unpaid'),
  `start_date` DATE,
  `end_date` DATE,
  `reason` TEXT,
  `status` ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
  `approved_by` BIGINT UNSIGNED,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`spv_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`approved_by`) REFERENCES `users`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `spv_incentives` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `incentive_type` VARCHAR(50),
  `amount` DECIMAL(15,2),
  `description` TEXT,
  `period` VARCHAR(50),
  `status` ENUM('pending', 'approved', 'paid') DEFAULT 'pending',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`spv_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `spv_notifications` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `notification_type` VARCHAR(50),
  `title` VARCHAR(255),
  `message` TEXT,
  `is_read` BOOLEAN DEFAULT FALSE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`spv_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `spv_escalations` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `partner_id` BIGINT UNSIGNED,
  `issue_type` VARCHAR(50),
  `description` TEXT,
  `priority` ENUM('low', 'medium', 'high', 'critical') DEFAULT 'medium',
  `status` ENUM('open', 'in_progress', 'resolved') DEFAULT 'open',
  `resolved_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`spv_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ==============================================
-- CATEGORY E: MANAGER SYSTEM (15 tables)
-- ==============================================

-- 1. Manager Profiles
CREATE TABLE `manager_profiles` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL UNIQUE,
  `employee_id` VARCHAR(50) UNIQUE,
  `department` VARCHAR(100),
  `region` VARCHAR(100),
  `commission_rate` DECIMAL(5,2) DEFAULT 5.00 COMMENT 'Manager commission percentage',
  `status` ENUM('active', 'inactive', 'on_leave') DEFAULT 'active',
  `hired_date` DATE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2-15. Additional Manager Tables
CREATE TABLE `manager_spv_assignments` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `assigned_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `status` ENUM('active', 'inactive') DEFAULT 'active',
  UNIQUE KEY `unique_assignment` (`manager_id`, `spv_id`),
  FOREIGN KEY (`manager_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`spv_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `manager_performance` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `year` INT NOT NULL,
  `month` INT NOT NULL,
  `total_spvs` INT DEFAULT 0,
  `total_partners` INT DEFAULT 0,
  `total_sales` DECIMAL(15,2) DEFAULT 0,
  `total_commission` DECIMAL(15,2) DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `unique_performance` (`manager_id`, `year`, `month`),
  FOREIGN KEY (`manager_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `manager_commissions` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `spv_id` BIGINT UNSIGNED,
  `partner_id` BIGINT UNSIGNED,
  `order_id` BIGINT UNSIGNED,
  `base_amount` DECIMAL(15,2),
  `commission_rate` DECIMAL(5,2),
  `commission_amount` DECIMAL(15,2),
  `status` ENUM('pending', 'approved', 'paid') DEFAULT 'pending',
  `paid_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`manager_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `manager_targets` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `year` INT NOT NULL,
  `month` INT NOT NULL,
  `sales_target` DECIMAL(15,2),
  `team_target` INT,
  `achieved_sales` DECIMAL(15,2) DEFAULT 0,
  `achieved_team` INT DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `unique_target` (`manager_id`, `year`, `month`),
  FOREIGN KEY (`manager_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `manager_reports` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `report_type` VARCHAR(50),
  `report_period` VARCHAR(50),
  `report_data` JSON,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`manager_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `manager_meetings` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `meeting_type` VARCHAR(50),
  `meeting_date` TIMESTAMP,
  `attendees` JSON,
  `agenda` TEXT,
  `notes` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`manager_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `manager_decisions` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `decision_type` VARCHAR(50),
  `subject` VARCHAR(255),
  `decision` TEXT,
  `impact` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`manager_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `manager_approvals` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `approval_type` VARCHAR(50),
  `reference_id` BIGINT UNSIGNED,
  `reference_table` VARCHAR(100),
  `status` ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
  `notes` TEXT,
  `decided_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`manager_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `manager_kpis` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `kpi_name` VARCHAR(100),
  `target_value` DECIMAL(15,2),
  `actual_value` DECIMAL(15,2),
  `unit` VARCHAR(50),
  `year` INT,
  `month` INT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`manager_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `manager_team_reviews` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `spv_id` BIGINT UNSIGNED NOT NULL,
  `review_date` DATE,
  `performance_rating` INT CHECK (`performance_rating` BETWEEN 1 AND 5),
  `strengths` TEXT,
  `improvements` TEXT,
  `action_plan` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`manager_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`spv_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `manager_budgets` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `budget_category` VARCHAR(100),
  `allocated_amount` DECIMAL(15,2),
  `spent_amount` DECIMAL(15,2) DEFAULT 0,
  `year` INT,
  `quarter` INT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`manager_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `manager_initiatives` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `initiative_name` VARCHAR(255),
  `description` TEXT,
  `start_date` DATE,
  `end_date` DATE,
  `budget` DECIMAL(15,2),
  `status` ENUM('planning', 'in_progress', 'completed', 'cancelled') DEFAULT 'planning',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`manager_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `manager_notifications` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `notification_type` VARCHAR(50),
  `title` VARCHAR(255),
  `message` TEXT,
  `is_read` BOOLEAN DEFAULT FALSE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`manager_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `manager_dashboards` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `dashboard_config` JSON,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`manager_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `manager_strategic_plans` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `manager_id` BIGINT UNSIGNED NOT NULL,
  `plan_name` VARCHAR(255),
  `objectives` TEXT,
  `strategies` TEXT,
  `timeline` VARCHAR(100),
  `kpis` JSON,
  `status` ENUM('draft', 'active', 'completed') DEFAULT 'draft',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`manager_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ==============================================
-- BATCH 2 SUMMARY
-- ==============================================
-- Added Categories C, D, E:
-- - Partner System: 28 tables
-- - SPV System: 15 tables
-- - Manager System: 15 tables
-- Total new tables in BATCH 2: 58 tables
-- Total tables so far: 88 tables (30 from BATCH 1 + 58 from BATCH 2)
--
-- Remaining for future batches:
-- F: Client System (25 tables)
-- G: Services & Orders (20 tables)
-- H: Portfolio & Showcase (10 tables)
-- I: Job Board System (10 tables)
-- J: Commission & Financials (15 tables)
-- K: Email Automation (8 tables)
-- L: Content Management (12 tables)
-- M: Analytics & Tracking (10 tables)
-- N: System & Configuration (10 tables)
--
-- Total planned: 208 tables
-- Completed: 88 tables
-- Remaining: 120 tables

-- ==============================================
-- BATCH 3: CLIENT SYSTEM & SERVICES/ORDERS
-- ==============================================
-- CATEGORY F: CLIENT SYSTEM (25 tables)
-- CATEGORY G: SERVICES & ORDERS (20 tables)
-- Total new tables in BATCH 3: 45 tables
-- ==============================================

-- ==============================================
-- CATEGORY F: CLIENT SYSTEM (25 tables)
-- ==============================================

-- 1. Client Profiles
CREATE TABLE `client_profiles` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL UNIQUE,
  `client_code` VARCHAR(50) NOT NULL UNIQUE COMMENT 'CLT-YYYYMMDD-XXXX',
  `company_name` VARCHAR(255),
  `industry` VARCHAR(100),
  `company_size` ENUM('individual', '1-10', '11-50', '51-200', '201-500', '500+'),
  `tax_id` VARCHAR(50) COMMENT 'NPWP',
  `billing_address` TEXT,
  `shipping_address` TEXT,
  `preferred_payment_method` ENUM('bank_transfer', 'credit_card', 'e-wallet', 'cod'),
  `credit_limit` DECIMAL(15,2) DEFAULT 0,
  `current_balance` DECIMAL(15,2) DEFAULT 0,
  `partner_id` BIGINT UNSIGNED COMMENT 'Acquired by which partner',
  `acquisition_date` DATE,
  `acquisition_source` VARCHAR(100) COMMENT 'Referral, ads, organic, etc',
  `status` ENUM('active', 'inactive', 'suspended', 'blacklist') DEFAULT 'active',
  `vip_status` BOOLEAN DEFAULT FALSE,
  `loyalty_points` INT DEFAULT 0,
  `notes` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `idx_client_code` (`client_code`),
  INDEX `idx_partner` (`partner_id`),
  INDEX `idx_status` (`status`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Client Contacts
CREATE TABLE `client_contacts` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `client_id` BIGINT UNSIGNED NOT NULL,
  `contact_type` ENUM('primary', 'billing', 'technical', 'other') DEFAULT 'other',
  `name` VARCHAR(255) NOT NULL,
  `position` VARCHAR(100),
  `email` VARCHAR(255),
  `phone` VARCHAR(20),
  `is_primary` BOOLEAN DEFAULT FALSE,
  `notes` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`client_id`) REFERENCES `client_profiles`(`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Client Subscriptions
CREATE TABLE `client_subscriptions` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `client_id` BIGINT UNSIGNED NOT NULL,
  `service_id` BIGINT UNSIGNED NOT NULL,
  `subscription_plan` ENUM('monthly', 'quarterly', 'annually', 'one-time'),
  `start_date` DATE NOT NULL,
  `end_date` DATE,
  `billing_cycle` INT DEFAULT 1 COMMENT 'Every N months',
  `monthly_fee` DECIMAL(15,2) NOT NULL,
  `setup_fee` DECIMAL(15,2) DEFAULT 0,
  `status` ENUM('active', 'paused', 'cancelled', 'expired') DEFAULT 'active',
  `auto_renew` BOOLEAN DEFAULT TRUE,
  `next_billing_date` DATE,
  `last_billing_date` DATE,
  `cancellation_reason` TEXT,
  `cancelled_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX `idx_client_service` (`client_id`, `service_id`),
  INDEX `idx_status` (`status`),
  FOREIGN KEY (`client_id`) REFERENCES `client_profiles`(`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Client Support Tickets
CREATE TABLE `client_support_tickets` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `ticket_number` VARCHAR(50) NOT NULL UNIQUE,
  `client_id` BIGINT UNSIGNED NOT NULL,
  `assigned_to` BIGINT UNSIGNED COMMENT 'Support staff user_id',
  `category` ENUM('technical', 'billing', 'general', 'complaint', 'feature_request'),
  `priority` ENUM('low', 'medium', 'high', 'urgent') DEFAULT 'medium',
  `subject` VARCHAR(255) NOT NULL,
  `description` TEXT NOT NULL,
  `status` ENUM('open', 'in_progress', 'waiting_client', 'resolved', 'closed') DEFAULT 'open',
  `resolution` TEXT,
  `opened_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `closed_at` TIMESTAMP NULL,
  `first_response_at` TIMESTAMP NULL,
  `resolved_at` TIMESTAMP NULL,
  INDEX `idx_client` (`client_id`),
  INDEX `idx_status` (`status`),
  INDEX `idx_priority` (`priority`),
  FOREIGN KEY (`client_id`) REFERENCES `client_profiles`(`user_id`) ON DELETE CASCADE,
  FOREIGN KEY (`assigned_to`) REFERENCES `users`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- (Continue with the remaining 22 Client System tables and 20 Services/Orders tables...)
-- Due to message length limitations, this is a simplified version.
-- The actual implementation will include all 45 tables.

-- ==============================================
-- CATEGORY G: SERVICES & ORDERS (20 tables)
-- ==============================================

-- Service Categories
CREATE TABLE `service_categories` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(100) NOT NULL,
  `slug` VARCHAR(100) NOT NULL UNIQUE,
  `description` TEXT,
  `icon` VARCHAR(100),
  `sort_order` INT DEFAULT 0,
  `is_active` BOOLEAN DEFAULT TRUE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Services
CREATE TABLE `services` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `category_id` INT UNSIGNED,
  `service_code` VARCHAR(50) NOT NULL UNIQUE,
  `name` VARCHAR(255) NOT NULL,
  `slug` VARCHAR(255) NOT NULL UNIQUE,
  `short_description` TEXT,
  `description` TEXT,
  `features` JSON,
  `service_type` ENUM('beli', 'sewa', 'custom'),
  `base_price` DECIMAL(15,2),
  `monthly_price` DECIMAL(15,2),
  `setup_fee` DECIMAL(15,2) DEFAULT 0,
  `currency` VARCHAR(3) DEFAULT 'IDR',
  `is_active` BOOLEAN DEFAULT TRUE,
  `is_featured` BOOLEAN DEFAULT FALSE,
  `sort_order` INT DEFAULT 0,
  `min_contract_months` INT DEFAULT 1,
  `tags` JSON,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `idx_category` (`category_id`),
  INDEX `idx_active` (`is_active`),
  FOREIGN KEY (`category_id`) REFERENCES `service_categories`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Orders
CREATE TABLE `orders` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `order_number` VARCHAR(50) NOT NULL UNIQUE,
  `client_id` BIGINT UNSIGNED NOT NULL,
  `partner_id` BIGINT UNSIGNED,
  `order_type` ENUM('beli', 'sewa', 'custom'),
  `status` ENUM('pending', 'confirmed', 'processing', 'completed', 'cancelled') DEFAULT 'pending',
  `subtotal` DECIMAL(15,2) NOT NULL,
  `tax_amount` DECIMAL(15,2) DEFAULT 0,
  `discount_amount` DECIMAL(15,2) DEFAULT 0,
  `total_amount` DECIMAL(15,2) NOT NULL,
  `payment_status` ENUM('unpaid', 'partial', 'paid', 'refunded') DEFAULT 'unpaid',
  `notes` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `idx_client` (`client_id`),
  INDEX `idx_partner` (`partner_id`),
  INDEX `idx_status` (`status`),
  FOREIGN KEY (`client_id`) REFERENCES `client_profiles`(`user_id`) ON DELETE CASCADE,
  FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Order Items
CREATE TABLE `order_items` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `order_id` BIGINT UNSIGNED NOT NULL,
  `service_id` BIGINT UNSIGNED NOT NULL,
  `item_name` VARCHAR(255) NOT NULL,
  `quantity` INT DEFAULT 1,
  `unit_price` DECIMAL(15,2) NOT NULL,
  `total_price` DECIMAL(15,2) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`service_id`) REFERENCES `services`(`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Order Status History
CREATE TABLE `order_status_history` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `order_id` BIGINT UNSIGNED NOT NULL,
  `status` VARCHAR(50) NOT NULL,
  `notes` TEXT,
  `changed_by` BIGINT UNSIGNED,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`changed_by`) REFERENCES `users`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
-- ============================================================================
-- BATCH 3 - COMPLETION: 35 Additional Tables
-- Client System (20 tables) + Services & Orders (15 tables)
-- ============================================================================

-- ============================================================================
-- CLIENT SYSTEM - ADDITIONAL TABLES (20 tables)
-- ============================================================================

-- 1. Client Preferences (already referenced in code but table missing)
CREATE TABLE `client_preferences` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `client_id` BIGINT UNSIGNED NOT NULL,
    `language` VARCHAR(10) DEFAULT 'id',
    `currency` VARCHAR(5) DEFAULT 'IDR',
    `timezone` VARCHAR(50) DEFAULT 'Asia/Jakarta',
    `notification_email` BOOLEAN DEFAULT TRUE,
    `notification_sms` BOOLEAN DEFAULT FALSE,
    `notification_whatsapp` BOOLEAN DEFAULT TRUE,
    `newsletter_subscribed` BOOLEAN DEFAULT TRUE,
    `marketing_emails` BOOLEAN DEFAULT TRUE,
    `two_factor_enabled` BOOLEAN DEFAULT FALSE,
    `auto_renew_subscriptions` BOOLEAN DEFAULT TRUE,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`client_id`) REFERENCES `client_profiles`(`user_id`) ON DELETE CASCADE,
    INDEX `idx_client_preferences_client` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2. Client Invoices
CREATE TABLE `client_invoices` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `invoice_number` VARCHAR(50) UNIQUE NOT NULL,
    `client_id` BIGINT UNSIGNED NOT NULL,
    `order_id` BIGINT UNSIGNED NULL,
    `subscription_id` BIGINT UNSIGNED NULL,
    `invoice_date` DATE NOT NULL,
    `due_date` DATE NOT NULL,
    `subtotal` DECIMAL(15,2) NOT NULL DEFAULT 0,
    `tax_amount` DECIMAL(15,2) NOT NULL DEFAULT 0,
    `discount_amount` DECIMAL(15,2) NOT NULL DEFAULT 0,
    `total_amount` DECIMAL(15,2) NOT NULL DEFAULT 0,
    `paid_amount` DECIMAL(15,2) NOT NULL DEFAULT 0,
    `balance` DECIMAL(15,2) NOT NULL DEFAULT 0,
    `status` ENUM('draft', 'sent', 'partial', 'paid', 'overdue', 'cancelled') DEFAULT 'draft',
    `notes` TEXT NULL,
    `terms` TEXT NULL,
    `sent_at` TIMESTAMP NULL,
    `paid_at` TIMESTAMP NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`client_id`) REFERENCES `client_profiles`(`user_id`) ON DELETE CASCADE,
    FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE SET NULL,
    INDEX `idx_invoices_client` (`client_id`),
    INDEX `idx_invoices_status` (`status`),
    INDEX `idx_invoices_due_date` (`due_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3. Client Invoice Items
CREATE TABLE `client_invoice_items` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `invoice_id` BIGINT UNSIGNED NOT NULL,
    `description` VARCHAR(500) NOT NULL,
    `quantity` INT NOT NULL DEFAULT 1,
    `unit_price` DECIMAL(15,2) NOT NULL,
    `tax_rate` DECIMAL(5,2) DEFAULT 0,
    `discount_percent` DECIMAL(5,2) DEFAULT 0,
    `total` DECIMAL(15,2) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`invoice_id`) REFERENCES `client_invoices`(`id`) ON DELETE CASCADE,
    INDEX `idx_invoice_items_invoice` (`invoice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4. Client Payments
CREATE TABLE `client_payments` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `payment_number` VARCHAR(50) UNIQUE NOT NULL,
    `client_id` BIGINT UNSIGNED NOT NULL,
    `invoice_id` BIGINT UNSIGNED NULL,
    `order_id` BIGINT UNSIGNED NULL,
    `amount` DECIMAL(15,2) NOT NULL,
    `payment_method` ENUM('transfer', 'ewallet', 'credit_card', 'cash', 'other') NOT NULL,
    `payment_date` DATE NOT NULL,
    `reference_number` VARCHAR(100) NULL,
    `proof_file` VARCHAR(255) NULL,
    `status` ENUM('pending', 'verified', 'rejected', 'refunded') DEFAULT 'pending',
    `verified_by` BIGINT UNSIGNED NULL,
    `verified_at` TIMESTAMP NULL,
    `notes` TEXT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`client_id`) REFERENCES `client_profiles`(`user_id`) ON DELETE CASCADE,
    FOREIGN KEY (`invoice_id`) REFERENCES `client_invoices`(`id`) ON DELETE SET NULL,
    FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE SET NULL,
    FOREIGN KEY (`verified_by`) REFERENCES `users`(`id`) ON DELETE SET NULL,
    INDEX `idx_payments_client` (`client_id`),
    INDEX `idx_payments_status` (`status`),
    INDEX `idx_payments_date` (`payment_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 5. Client Payment Methods (saved payment methods)
CREATE TABLE `client_payment_methods` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `client_id` BIGINT UNSIGNED NOT NULL,
    `type` ENUM('credit_card', 'bank_account', 'ewallet') NOT NULL,
    `provider` VARCHAR(50) NULL,
    `account_number` VARCHAR(100) NULL,
    `account_name` VARCHAR(100) NULL,
    `expiry_month` INT NULL,
    `expiry_year` INT NULL,
    `is_default` BOOLEAN DEFAULT FALSE,
    `is_verified` BOOLEAN DEFAULT FALSE,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`client_id`) REFERENCES `client_profiles`(`user_id`) ON DELETE CASCADE,
    INDEX `idx_payment_methods_client` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 6. Client Contracts
CREATE TABLE `client_contracts` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `contract_number` VARCHAR(50) UNIQUE NOT NULL,
    `client_id` BIGINT UNSIGNED NOT NULL,
    `partner_id` BIGINT UNSIGNED NULL,
    `title` VARCHAR(255) NOT NULL,
    `description` TEXT NULL,
    `start_date` DATE NOT NULL,
    `end_date` DATE NOT NULL,
    `auto_renew` BOOLEAN DEFAULT FALSE,
    `renewal_period` INT NULL COMMENT 'in months',
    `contract_value` DECIMAL(15,2) NOT NULL,
    `payment_terms` VARCHAR(100) NULL,
    `status` ENUM('draft', 'active', 'expired', 'cancelled', 'renewed') DEFAULT 'draft',
    `signed_date` DATE NULL,
    `cancelled_date` DATE NULL,
    `cancellation_reason` TEXT NULL,
    `contract_file` VARCHAR(255) NULL,
    `created_by` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`client_id`) REFERENCES `client_profiles`(`user_id`) ON DELETE CASCADE,
    FOREIGN KEY (`partner_id`) REFERENCES `users`(`id`) ON DELETE SET NULL,
    FOREIGN KEY (`created_by`) REFERENCES `users`(`id`) ON DELETE SET NULL,
    INDEX `idx_contracts_client` (`client_id`),
    INDEX `idx_contracts_status` (`status`),
    INDEX `idx_contracts_dates` (`start_date`, `end_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 7. Client Contract Items
CREATE TABLE `client_contract_items` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `contract_id` BIGINT UNSIGNED NOT NULL,
    `service_id` BIGINT UNSIGNED NULL,
    `description` VARCHAR(500) NOT NULL,
    `quantity` INT NOT NULL DEFAULT 1,
    `unit_price` DECIMAL(15,2) NOT NULL,
    `billing_cycle` ENUM('one-time', 'monthly', 'quarterly', 'annually') DEFAULT 'monthly',
    `total` DECIMAL(15,2) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`contract_id`) REFERENCES `client_contracts`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`service_id`) REFERENCES `services`(`id`) ON DELETE SET NULL,
    INDEX `idx_contract_items_contract` (`contract_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 8. Client Contract Renewals
CREATE TABLE `client_contract_renewals` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `original_contract_id` BIGINT UNSIGNED NOT NULL,
    `new_contract_id` BIGINT UNSIGNED NOT NULL,
    `renewed_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `renewed_by` BIGINT UNSIGNED NULL,
    `price_adjustment` DECIMAL(15,2) DEFAULT 0,
    `notes` TEXT NULL,
    FOREIGN KEY (`original_contract_id`) REFERENCES `client_contracts`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`new_contract_id`) REFERENCES `client_contracts`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`renewed_by`) REFERENCES `users`(`id`) ON DELETE SET NULL,
    INDEX `idx_renewals_original` (`original_contract_id`),
    INDEX `idx_renewals_new` (`new_contract_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 9. Client Loyalty Transactions
CREATE TABLE `client_loyalty_transactions` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `client_id` BIGINT UNSIGNED NOT NULL,
    `transaction_type` ENUM('earned', 'redeemed', 'expired', 'adjusted') NOT NULL,
    `points` INT NOT NULL,
    `order_id` BIGINT UNSIGNED NULL,
    `invoice_id` BIGINT UNSIGNED NULL,
    `reason` VARCHAR(255) NULL,
    `expires_at` TIMESTAMP NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`client_id`) REFERENCES `client_profiles`(`user_id`) ON DELETE CASCADE,
    FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE SET NULL,
    FOREIGN KEY (`invoice_id`) REFERENCES `client_invoices`(`id`) ON DELETE SET NULL,
    INDEX `idx_loyalty_client` (`client_id`),
    INDEX `idx_loyalty_type` (`transaction_type`),
    INDEX `idx_loyalty_expires` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 10. Client Loyalty Rewards
CREATE TABLE `client_loyalty_rewards` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT NULL,
    `points_required` INT NOT NULL,
    `reward_type` ENUM('discount', 'free_service', 'voucher', 'cashback', 'other') NOT NULL,
    `reward_value` DECIMAL(15,2) NULL,
    `is_active` BOOLEAN DEFAULT TRUE,
    `valid_from` DATE NULL,
    `valid_until` DATE NULL,
    `max_redemptions` INT NULL,
    `times_redeemed` INT DEFAULT 0,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_rewards_active` (`is_active`),
    INDEX `idx_rewards_points` (`points_required`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 11. Client Feedback
CREATE TABLE `client_feedback` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `client_id` BIGINT UNSIGNED NOT NULL,
    `order_id` BIGINT UNSIGNED NULL,
    `category` ENUM('product', 'service', 'support', 'website', 'general') NOT NULL,
    `rating` TINYINT NULL CHECK (`rating` BETWEEN 1 AND 5),
    `subject` VARCHAR(255) NOT NULL,
    `message` TEXT NOT NULL,
    `status` ENUM('new', 'reviewed', 'responded', 'closed') DEFAULT 'new',
    `responded_by` BIGINT UNSIGNED NULL,
    `response` TEXT NULL,
    `responded_at` TIMESTAMP NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`client_id`) REFERENCES `client_profiles`(`user_id`) ON DELETE CASCADE,
    FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE SET NULL,
    FOREIGN KEY (`responded_by`) REFERENCES `users`(`id`) ON DELETE SET NULL,
    INDEX `idx_feedback_client` (`client_id`),
    INDEX `idx_feedback_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 12. Client Reviews
CREATE TABLE `client_reviews` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `client_id` BIGINT UNSIGNED NOT NULL,
    `service_id` BIGINT UNSIGNED NULL,
    `order_id` BIGINT UNSIGNED NULL,
    `rating` TINYINT NOT NULL CHECK (`rating` BETWEEN 1 AND 5),
    `title` VARCHAR(255) NULL,
    `review` TEXT NOT NULL,
    `pros` TEXT NULL,
    `cons` TEXT NULL,
    `is_verified_purchase` BOOLEAN DEFAULT FALSE,
    `is_approved` BOOLEAN DEFAULT FALSE,
    `is_featured` BOOLEAN DEFAULT FALSE,
    `helpful_count` INT DEFAULT 0,
    `not_helpful_count` INT DEFAULT 0,
    `approved_by` BIGINT UNSIGNED NULL,
    `approved_at` TIMESTAMP NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`client_id`) REFERENCES `client_profiles`(`user_id`) ON DELETE CASCADE,
    FOREIGN KEY (`service_id`) REFERENCES `services`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE SET NULL,
    FOREIGN KEY (`approved_by`) REFERENCES `users`(`id`) ON DELETE SET NULL,
    INDEX `idx_reviews_client` (`client_id`),
    INDEX `idx_reviews_service` (`service_id`),
    INDEX `idx_reviews_approved` (`is_approved`),
    INDEX `idx_reviews_featured` (`is_featured`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 13. Client Communications
CREATE TABLE `client_communications` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `client_id` BIGINT UNSIGNED NOT NULL,
    `type` ENUM('email', 'sms', 'whatsapp', 'call', 'meeting', 'other') NOT NULL,
    `direction` ENUM('inbound', 'outbound') NOT NULL,
    `subject` VARCHAR(255) NULL,
    `message` TEXT NULL,
    `sent_by` BIGINT UNSIGNED NULL,
    `status` ENUM('sent', 'delivered', 'failed', 'opened', 'clicked') DEFAULT 'sent',
    `scheduled_at` TIMESTAMP NULL,
    `sent_at` TIMESTAMP NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`client_id`) REFERENCES `client_profiles`(`user_id`) ON DELETE CASCADE,
    FOREIGN KEY (`sent_by`) REFERENCES `users`(`id`) ON DELETE SET NULL,
    INDEX `idx_communications_client` (`client_id`),
    INDEX `idx_communications_type` (`type`),
    INDEX `idx_communications_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 14. Client Assets (digital assets)
CREATE TABLE `client_assets` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `client_id` BIGINT UNSIGNED NOT NULL,
    `service_id` BIGINT UNSIGNED NULL,
    `order_id` BIGINT UNSIGNED NULL,
    `asset_type` ENUM('logo', 'website', 'app', 'social_media', 'content', 'other') NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT NULL,
    `file_path` VARCHAR(500) NULL,
    `file_url` VARCHAR(500) NULL,
    `credentials_username` VARCHAR(255) NULL,
    `credentials_password` TEXT NULL,
    `access_url` VARCHAR(500) NULL,
    `expires_at` DATE NULL,
    `status` ENUM('active', 'inactive', 'expired') DEFAULT 'active',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`client_id`) REFERENCES `client_profiles`(`user_id`) ON DELETE CASCADE,
    FOREIGN KEY (`service_id`) REFERENCES `services`(`id`) ON DELETE SET NULL,
    FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE SET NULL,
    INDEX `idx_assets_client` (`client_id`),
    INDEX `idx_assets_type` (`asset_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 15. Client Projects
CREATE TABLE `client_projects` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `project_code` VARCHAR(50) UNIQUE NOT NULL,
    `client_id` BIGINT UNSIGNED NOT NULL,
    `service_id` BIGINT UNSIGNED NULL,
    `order_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT NULL,
    `start_date` DATE NOT NULL,
    `deadline` DATE NOT NULL,
    `completed_date` DATE NULL,
    `status` ENUM('planning', 'in_progress', 'review', 'completed', 'on_hold', 'cancelled') DEFAULT 'planning',
    `priority` ENUM('low', 'medium', 'high', 'urgent') DEFAULT 'medium',
    `assigned_to` BIGINT UNSIGNED NULL,
    `progress_percent` TINYINT DEFAULT 0 CHECK (`progress_percent` BETWEEN 0 AND 100),
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`client_id`) REFERENCES `client_profiles`(`user_id`) ON DELETE CASCADE,
    FOREIGN KEY (`service_id`) REFERENCES `services`(`id`) ON DELETE SET NULL,
    FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`assigned_to`) REFERENCES `users`(`id`) ON DELETE SET NULL,
    INDEX `idx_projects_client` (`client_id`),
    INDEX `idx_projects_status` (`status`),
    INDEX `idx_projects_deadline` (`deadline`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 16. Client Project Tasks
CREATE TABLE `client_project_tasks` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `project_id` BIGINT UNSIGNED NOT NULL,
    `task_name` VARCHAR(255) NOT NULL,
    `description` TEXT NULL,
    `assigned_to` BIGINT UNSIGNED NULL,
    `status` ENUM('pending', 'in_progress', 'completed', 'cancelled') DEFAULT 'pending',
    `priority` ENUM('low', 'medium', 'high') DEFAULT 'medium',
    `due_date` DATE NULL,
    `completed_at` TIMESTAMP NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`project_id`) REFERENCES `client_projects`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`assigned_to`) REFERENCES `users`(`id`) ON DELETE SET NULL,
    INDEX `idx_tasks_project` (`project_id`),
    INDEX `idx_tasks_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 17. Client Project Milestones
CREATE TABLE `client_project_milestones` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `project_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT NULL,
    `due_date` DATE NOT NULL,
    `payment_percentage` DECIMAL(5,2) DEFAULT 0,
    `status` ENUM('pending', 'in_progress', 'completed', 'missed') DEFAULT 'pending',
    `completed_at` TIMESTAMP NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`project_id`) REFERENCES `client_projects`(`id`) ON DELETE CASCADE,
    INDEX `idx_milestones_project` (`project_id`),
    INDEX `idx_milestones_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 18. Client Files
CREATE TABLE `client_files` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `client_id` BIGINT UNSIGNED NOT NULL,
    `project_id` BIGINT UNSIGNED NULL,
    `order_id` BIGINT UNSIGNED NULL,
    `file_name` VARCHAR(255) NOT NULL,
    `file_path` VARCHAR(500) NOT NULL,
    `file_type` VARCHAR(50) NULL,
    `file_size` BIGINT NULL,
    `category` ENUM('document', 'image', 'video', 'contract', 'invoice', 'other') DEFAULT 'document',
    `uploaded_by` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`client_id`) REFERENCES `client_profiles`(`user_id`) ON DELETE CASCADE,
    FOREIGN KEY (`project_id`) REFERENCES `client_projects`(`id`) ON DELETE SET NULL,
    FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE SET NULL,
    FOREIGN KEY (`uploaded_by`) REFERENCES `users`(`id`) ON DELETE SET NULL,
    INDEX `idx_files_client` (`client_id`),
    INDEX `idx_files_project` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 19. Client Tags
CREATE TABLE `client_tags` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL UNIQUE,
    `color` VARCHAR(7) DEFAULT '#808080',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `client_tag_relations` (
    `client_id` BIGINT UNSIGNED NOT NULL,
    `tag_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`client_id`, `tag_id`),
    FOREIGN KEY (`client_id`) REFERENCES `client_profiles`(`user_id`) ON DELETE CASCADE,
    FOREIGN KEY (`tag_id`) REFERENCES `client_tags`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 20. Client Custom Fields
CREATE TABLE `client_custom_fields` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `client_id` BIGINT UNSIGNED NOT NULL,
    `field_name` VARCHAR(100) NOT NULL,
    `field_value` TEXT NULL,
    `field_type` ENUM('text', 'number', 'date', 'boolean', 'json') DEFAULT 'text',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`client_id`) REFERENCES `client_profiles`(`user_id`) ON DELETE CASCADE,
    INDEX `idx_custom_fields_client` (`client_id`),
    INDEX `idx_custom_fields_name` (`field_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ============================================================================
-- SERVICES & ORDERS - ADDITIONAL TABLES (15 tables)
-- ============================================================================

-- 1. Service Pricing Tiers
CREATE TABLE `service_pricing_tiers` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `service_id` BIGINT UNSIGNED NOT NULL,
    `tier_name` VARCHAR(100) NOT NULL,
    `min_quantity` INT DEFAULT 1,
    `max_quantity` INT NULL,
    `price` DECIMAL(15,2) NOT NULL,
    `discount_percent` DECIMAL(5,2) DEFAULT 0,
    `is_active` BOOLEAN DEFAULT TRUE,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`service_id`) REFERENCES `services`(`id`) ON DELETE CASCADE,
    INDEX `idx_pricing_tiers_service` (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2. Service Addons
CREATE TABLE `service_addons` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `service_id` BIGINT UNSIGNED NOT NULL,
    `addon_name` VARCHAR(255) NOT NULL,
    `description` TEXT NULL,
    `price` DECIMAL(15,2) NOT NULL,
    `is_optional` BOOLEAN DEFAULT TRUE,
    `is_active` BOOLEAN DEFAULT TRUE,
    `sort_order` INT DEFAULT 0,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`service_id`) REFERENCES `services`(`id`) ON DELETE CASCADE,
    INDEX `idx_addons_service` (`service_id`),
    INDEX `idx_addons_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3. Service Bundles
CREATE TABLE `service_bundles` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `bundle_name` VARCHAR(255) NOT NULL,
    `slug` VARCHAR(255) UNIQUE NOT NULL,
    `description` TEXT NULL,
    `regular_price` DECIMAL(15,2) NOT NULL,
    `bundle_price` DECIMAL(15,2) NOT NULL,
    `discount_percent` DECIMAL(5,2) NULL,
    `is_active` BOOLEAN DEFAULT TRUE,
    `is_featured` BOOLEAN DEFAULT FALSE,
    `valid_from` DATE NULL,
    `valid_until` DATE NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_bundles_active` (`is_active`),
    INDEX `idx_bundles_featured` (`is_featured`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `service_bundle_items` (
    `bundle_id` BIGINT UNSIGNED NOT NULL,
    `service_id` BIGINT UNSIGNED NOT NULL,
    `quantity` INT DEFAULT 1,
    PRIMARY KEY (`bundle_id`, `service_id`),
    FOREIGN KEY (`bundle_id`) REFERENCES `service_bundles`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`service_id`) REFERENCES `services`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4. Service Reviews
CREATE TABLE `service_reviews` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `service_id` BIGINT UNSIGNED NOT NULL,
    `client_id` BIGINT UNSIGNED NOT NULL,
    `order_id` BIGINT UNSIGNED NULL,
    `rating` TINYINT NOT NULL CHECK (`rating` BETWEEN 1 AND 5),
    `title` VARCHAR(255) NULL,
    `review` TEXT NOT NULL,
    `is_approved` BOOLEAN DEFAULT FALSE,
    `is_featured` BOOLEAN DEFAULT FALSE,
    `helpful_count` INT DEFAULT 0,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`service_id`) REFERENCES `services`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`client_id`) REFERENCES `client_profiles`(`user_id`) ON DELETE CASCADE,
    FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE SET NULL,
    INDEX `idx_service_reviews_service` (`service_id`),
    INDEX `idx_service_reviews_approved` (`is_approved`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 5. Service FAQs
CREATE TABLE `service_faqs` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `service_id` BIGINT UNSIGNED NULL,
    `category` VARCHAR(100) NULL,
    `question` TEXT NOT NULL,
    `answer` TEXT NOT NULL,
    `sort_order` INT DEFAULT 0,
    `is_active` BOOLEAN DEFAULT TRUE,
    `views` INT DEFAULT 0,
    `helpful_count` INT DEFAULT 0,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`service_id`) REFERENCES `services`(`id`) ON DELETE CASCADE,
    INDEX `idx_faqs_service` (`service_id`),
    INDEX `idx_faqs_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 6. Order Payments
CREATE TABLE `order_payments` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `order_id` BIGINT UNSIGNED NOT NULL,
    `payment_id` BIGINT UNSIGNED NULL,
    `amount` DECIMAL(15,2) NOT NULL,
    `payment_method` ENUM('transfer', 'ewallet', 'credit_card', 'cash') NOT NULL,
    `transaction_id` VARCHAR(100) NULL,
    `status` ENUM('pending', 'processing', 'success', 'failed', 'refunded') DEFAULT 'pending',
    `paid_at` TIMESTAMP NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`payment_id`) REFERENCES `client_payments`(`id`) ON DELETE SET NULL,
    INDEX `idx_order_payments_order` (`order_id`),
    INDEX `idx_order_payments_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 7. Order Refunds
CREATE TABLE `order_refunds` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `refund_number` VARCHAR(50) UNIQUE NOT NULL,
    `order_id` BIGINT UNSIGNED NOT NULL,
    `payment_id` BIGINT UNSIGNED NULL,
    `amount` DECIMAL(15,2) NOT NULL,
    `reason` TEXT NOT NULL,
    `status` ENUM('requested', 'approved', 'processing', 'completed', 'rejected') DEFAULT 'requested',
    `requested_by` BIGINT UNSIGNED NULL,
    `approved_by` BIGINT UNSIGNED NULL,
    `processed_at` TIMESTAMP NULL,
    `completed_at` TIMESTAMP NULL,
    `notes` TEXT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`payment_id`) REFERENCES `order_payments`(`id`) ON DELETE SET NULL,
    FOREIGN KEY (`requested_by`) REFERENCES `users`(`id`) ON DELETE SET NULL,
    FOREIGN KEY (`approved_by`) REFERENCES `users`(`id`) ON DELETE SET NULL,
    INDEX `idx_refunds_order` (`order_id`),
    INDEX `idx_refunds_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 8. Order Shipments
CREATE TABLE `order_shipments` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `order_id` BIGINT UNSIGNED NOT NULL,
    `tracking_number` VARCHAR(100) NULL,
    `courier` VARCHAR(50) NULL,
    `shipping_method` VARCHAR(100) NULL,
    `shipping_address` TEXT NOT NULL,
    `status` ENUM('pending', 'picked_up', 'in_transit', 'delivered', 'failed') DEFAULT 'pending',
    `shipped_at` TIMESTAMP NULL,
    `estimated_delivery` DATE NULL,
    `delivered_at` TIMESTAMP NULL,
    `notes` TEXT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE CASCADE,
    INDEX `idx_shipments_order` (`order_id`),
    INDEX `idx_shipments_status` (`status`),
    INDEX `idx_shipments_tracking` (`tracking_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 9. Order Tracking
CREATE TABLE `order_tracking` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `order_id` BIGINT UNSIGNED NOT NULL,
    `shipment_id` BIGINT UNSIGNED NULL,
    `status` VARCHAR(100) NOT NULL,
    `location` VARCHAR(255) NULL,
    `description` TEXT NULL,
    `tracked_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`shipment_id`) REFERENCES `order_shipments`(`id`) ON DELETE CASCADE,
    INDEX `idx_tracking_order` (`order_id`),
    INDEX `idx_tracking_shipment` (`shipment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 10. Order Cancellations
CREATE TABLE `order_cancellations` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `order_id` BIGINT UNSIGNED NOT NULL,
    `cancelled_by` BIGINT UNSIGNED NOT NULL,
    `reason` TEXT NOT NULL,
    `cancellation_type` ENUM('client_request', 'payment_failed', 'out_of_stock', 'fraud', 'other') NOT NULL,
    `refund_amount` DECIMAL(15,2) DEFAULT 0,
    `refund_status` ENUM('not_applicable', 'pending', 'processed') DEFAULT 'not_applicable',
    `cancelled_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`cancelled_by`) REFERENCES `users`(`id`) ON DELETE CASCADE,
    INDEX `idx_cancellations_order` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 11. Order Reviews
CREATE TABLE `order_reviews` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `order_id` BIGINT UNSIGNED NOT NULL,
    `client_id` BIGINT UNSIGNED NOT NULL,
    `rating` TINYINT NOT NULL CHECK (`rating` BETWEEN 1 AND 5),
    `review` TEXT NULL,
    `delivery_rating` TINYINT NULL CHECK (`delivery_rating` BETWEEN 1 AND 5),
    `service_rating` TINYINT NULL CHECK (`service_rating` BETWEEN 1 AND 5),
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`client_id`) REFERENCES `client_profiles`(`user_id`) ON DELETE CASCADE,
    INDEX `idx_order_reviews_order` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 12. Order Attachments
CREATE TABLE `order_attachments` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `order_id` BIGINT UNSIGNED NOT NULL,
    `file_name` VARCHAR(255) NOT NULL,
    `file_path` VARCHAR(500) NOT NULL,
    `file_type` VARCHAR(50) NULL,
    `file_size` BIGINT NULL,
    `uploaded_by` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`uploaded_by`) REFERENCES `users`(`id`) ON DELETE SET NULL,
    INDEX `idx_attachments_order` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 13. Shopping Cart
CREATE TABLE `shopping_cart` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `user_id` BIGINT UNSIGNED NULL,
    `session_id` VARCHAR(100) NULL,
    `expires_at` TIMESTAMP NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
    INDEX `idx_cart_user` (`user_id`),
    INDEX `idx_cart_session` (`session_id`),
    INDEX `idx_cart_expires` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 14. Shopping Cart Items
CREATE TABLE `shopping_cart_items` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `cart_id` BIGINT UNSIGNED NOT NULL,
    `service_id` BIGINT UNSIGNED NOT NULL,
    `quantity` INT NOT NULL DEFAULT 1,
    `purchase_type` ENUM('beli', 'sewa') NOT NULL,
    `contract_months` INT DEFAULT 1,
    `unit_price` DECIMAL(15,2) NOT NULL,
    `total_price` DECIMAL(15,2) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`cart_id`) REFERENCES `shopping_cart`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`service_id`) REFERENCES `services`(`id`) ON DELETE CASCADE,
    INDEX `idx_cart_items_cart` (`cart_id`),
    INDEX `idx_cart_items_service` (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 15. Promo Codes
CREATE TABLE `promo_codes` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `code` VARCHAR(50) UNIQUE NOT NULL,
    `description` TEXT NULL,
    `discount_type` ENUM('percentage', 'fixed_amount', 'free_shipping') NOT NULL,
    `discount_value` DECIMAL(15,2) NOT NULL,
    `min_purchase` DECIMAL(15,2) DEFAULT 0,
    `max_discount` DECIMAL(15,2) NULL,
    `usage_limit` INT NULL,
    `usage_count` INT DEFAULT 0,
    `usage_per_user` INT DEFAULT 1,
    `valid_from` TIMESTAMP NOT NULL,
    `valid_until` TIMESTAMP NOT NULL,
    `is_active` BOOLEAN DEFAULT TRUE,
    `applicable_services` JSON NULL COMMENT 'Array of service IDs',
    `applicable_categories` JSON NULL COMMENT 'Array of category IDs',
    `created_by` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`created_by`) REFERENCES `users`(`id`) ON DELETE SET NULL,
    INDEX `idx_promo_code` (`code`),
    INDEX `idx_promo_active` (`is_active`),
    INDEX `idx_promo_validity` (`valid_from`, `valid_until`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `promo_code_usage` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `promo_code_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `order_id` BIGINT UNSIGNED NOT NULL,
    `discount_amount` DECIMAL(15,2) NOT NULL,
    `used_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`promo_code_id`) REFERENCES `promo_codes`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE CASCADE,
    INDEX `idx_promo_usage_code` (`promo_code_id`),
    INDEX `idx_promo_usage_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- END OF BATCH 3 COMPLETION
-- Total Additional Tables: 35
-- - Client System: 20 tables
-- - Services & Orders: 15 tables
-- New Total for BATCH 3: 45 tables (10 existing + 35 new)
-- Grand Total Database: 133 tables (88 + 45)
-- ============================================================================
