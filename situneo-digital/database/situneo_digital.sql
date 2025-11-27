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
