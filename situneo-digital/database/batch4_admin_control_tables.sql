-- =====================================================
-- BATCH 4: ADMIN & MANAGER CONTROL SYSTEM
-- Total Tables: 42 tables
-- Purpose: Complete admin control panel and management system
-- =====================================================

-- =====================================================
-- SECTION 1: DASHBOARD & ANALYTICS (8 tables)
-- =====================================================

-- Dashboard widgets configuration
CREATE TABLE `dashboard_widgets` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `widget_type` VARCHAR(50) NOT NULL COMMENT 'revenue, orders, clients, commission, etc',
    `widget_title` VARCHAR(100) NOT NULL,
    `position` INT NOT NULL DEFAULT 0,
    `size` ENUM('small', 'medium', 'large', 'full') DEFAULT 'medium',
    `is_visible` BOOLEAN DEFAULT TRUE,
    `settings` JSON NULL COMMENT 'Widget-specific settings',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_user_id` (`user_id`),
    INDEX `idx_widget_type` (`widget_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Analytics metrics tracking
CREATE TABLE `analytics_metrics` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `metric_date` DATE NOT NULL,
    `metric_type` VARCHAR(50) NOT NULL COMMENT 'daily_revenue, new_clients, orders_count, etc',
    `metric_value` DECIMAL(15,2) NOT NULL DEFAULT 0,
    `metric_count` INT NOT NULL DEFAULT 0,
    `metadata` JSON NULL COMMENT 'Additional metric data',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY `unique_metric` (`metric_date`, `metric_type`),
    INDEX `idx_metric_date` (`metric_date`),
    INDEX `idx_metric_type` (`metric_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Analytics snapshots for quick dashboard loading
CREATE TABLE `analytics_snapshots` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `snapshot_date` DATE NOT NULL,
    `period_type` ENUM('daily', 'weekly', 'monthly', 'yearly') NOT NULL,
    `total_revenue` DECIMAL(15,2) DEFAULT 0,
    `total_orders` INT DEFAULT 0,
    `total_clients` INT DEFAULT 0,
    `new_clients` INT DEFAULT 0,
    `active_partners` INT DEFAULT 0,
    `commission_paid` DECIMAL(15,2) DEFAULT 0,
    `avg_order_value` DECIMAL(15,2) DEFAULT 0,
    `conversion_rate` DECIMAL(5,2) DEFAULT 0,
    `snapshot_data` JSON NULL COMMENT 'Complete snapshot data',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY `unique_snapshot` (`snapshot_date`, `period_type`),
    INDEX `idx_snapshot_date` (`snapshot_date`),
    INDEX `idx_period_type` (`period_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- System settings and configurations
CREATE TABLE `system_settings` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `setting_key` VARCHAR(100) NOT NULL UNIQUE,
    `setting_value` TEXT NULL,
    `setting_type` ENUM('string', 'integer', 'boolean', 'json', 'text') DEFAULT 'string',
    `setting_group` VARCHAR(50) NOT NULL COMMENT 'general, email, payment, commission, etc',
    `description` TEXT NULL,
    `is_public` BOOLEAN DEFAULT FALSE COMMENT 'Can be accessed by frontend',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_setting_group` (`setting_group`),
    INDEX `idx_is_public` (`is_public`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Detailed system logs
CREATE TABLE `system_logs` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `log_level` ENUM('debug', 'info', 'warning', 'error', 'critical') NOT NULL,
    `log_category` VARCHAR(50) NOT NULL COMMENT 'auth, payment, commission, api, etc',
    `log_message` TEXT NOT NULL,
    `log_context` JSON NULL COMMENT 'Additional context data',
    `user_id` BIGINT UNSIGNED NULL,
    `ip_address` VARCHAR(45) NULL,
    `user_agent` VARCHAR(255) NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_log_level` (`log_level`),
    INDEX `idx_log_category` (`log_category`),
    INDEX `idx_user_id` (`user_id`),
    INDEX `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Audit trails for compliance
CREATE TABLE `audit_trails` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `action` VARCHAR(100) NOT NULL COMMENT 'create, update, delete, approve, etc',
    `entity_type` VARCHAR(50) NOT NULL COMMENT 'user, order, commission, etc',
    `entity_id` BIGINT UNSIGNED NOT NULL,
    `old_values` JSON NULL COMMENT 'Values before change',
    `new_values` JSON NULL COMMENT 'Values after change',
    `ip_address` VARCHAR(45) NULL,
    `user_agent` VARCHAR(255) NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_user_id` (`user_id`),
    INDEX `idx_entity` (`entity_type`, `entity_id`),
    INDEX `idx_action` (`action`),
    INDEX `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exports management
CREATE TABLE `data_exports` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `export_type` VARCHAR(50) NOT NULL COMMENT 'orders, clients, commissions, analytics',
    `export_format` ENUM('csv', 'xlsx', 'pdf', 'json') NOT NULL,
    `filters` JSON NULL COMMENT 'Export filters applied',
    `file_path` VARCHAR(255) NULL,
    `file_size` BIGINT NULL COMMENT 'File size in bytes',
    `status` ENUM('pending', 'processing', 'completed', 'failed') DEFAULT 'pending',
    `row_count` INT NULL,
    `error_message` TEXT NULL,
    `expires_at` TIMESTAMP NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `completed_at` TIMESTAMP NULL,
    INDEX `idx_user_id` (`user_id`),
    INDEX `idx_status` (`status`),
    INDEX `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Scheduled reports configuration
CREATE TABLE `scheduled_reports` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `report_name` VARCHAR(100) NOT NULL,
    `report_type` VARCHAR(50) NOT NULL COMMENT 'revenue, commission, orders, etc',
    `recipient_emails` TEXT NOT NULL COMMENT 'Comma-separated emails',
    `schedule_frequency` ENUM('daily', 'weekly', 'monthly', 'quarterly') NOT NULL,
    `schedule_day` INT NULL COMMENT 'Day of week/month',
    `schedule_time` TIME DEFAULT '09:00:00',
    `report_filters` JSON NULL,
    `is_active` BOOLEAN DEFAULT TRUE,
    `last_sent_at` TIMESTAMP NULL,
    `next_send_at` TIMESTAMP NULL,
    `created_by` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_is_active` (`is_active`),
    INDEX `idx_next_send_at` (`next_send_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 2: USER MANAGEMENT EXTENDED (6 tables)
-- =====================================================

-- Granular permissions system
CREATE TABLE `user_permissions_extended` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `permission_key` VARCHAR(100) NOT NULL,
    `can_create` BOOLEAN DEFAULT FALSE,
    `can_read` BOOLEAN DEFAULT TRUE,
    `can_update` BOOLEAN DEFAULT FALSE,
    `can_delete` BOOLEAN DEFAULT FALSE,
    `can_approve` BOOLEAN DEFAULT FALSE,
    `custom_permissions` JSON NULL,
    `granted_by` BIGINT UNSIGNED NULL,
    `granted_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `expires_at` TIMESTAMP NULL,
    UNIQUE KEY `unique_user_permission` (`user_id`, `permission_key`),
    INDEX `idx_permission_key` (`permission_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- User groups for role-based management
CREATE TABLE `user_groups` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `group_name` VARCHAR(100) NOT NULL UNIQUE,
    `group_description` TEXT NULL,
    `permissions` JSON NOT NULL COMMENT 'Group permissions',
    `is_active` BOOLEAN DEFAULT TRUE,
    `created_by` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- User group assignments
CREATE TABLE `user_group_members` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `group_id` BIGINT UNSIGNED NOT NULL,
    `assigned_by` BIGINT UNSIGNED NOT NULL,
    `assigned_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY `unique_user_group` (`user_id`, `group_id`),
    INDEX `idx_group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Active user sessions tracking
CREATE TABLE `user_sessions_extended` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `session_token` VARCHAR(255) NOT NULL UNIQUE,
    `ip_address` VARCHAR(45) NOT NULL,
    `user_agent` VARCHAR(255) NULL,
    `device_type` VARCHAR(50) NULL COMMENT 'desktop, mobile, tablet',
    `browser` VARCHAR(50) NULL,
    `os` VARCHAR(50) NULL,
    `location_country` VARCHAR(100) NULL,
    `location_city` VARCHAR(100) NULL,
    `is_active` BOOLEAN DEFAULT TRUE,
    `last_activity` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `expires_at` TIMESTAMP NOT NULL,
    INDEX `idx_user_id` (`user_id`),
    INDEX `idx_is_active` (`is_active`),
    INDEX `idx_expires_at` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Login attempts and security tracking
CREATE TABLE `login_attempts` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `email` VARCHAR(255) NOT NULL,
    `ip_address` VARCHAR(45) NOT NULL,
    `user_agent` VARCHAR(255) NULL,
    `attempt_result` ENUM('success', 'failed', 'blocked') NOT NULL,
    `failure_reason` VARCHAR(100) NULL COMMENT 'invalid_password, account_locked, etc',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_email` (`email`),
    INDEX `idx_ip_address` (`ip_address`),
    INDEX `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Password reset tokens (enhanced)
CREATE TABLE `password_reset_tokens_extended` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `token` VARCHAR(255) NOT NULL UNIQUE,
    `ip_address` VARCHAR(45) NOT NULL,
    `is_used` BOOLEAN DEFAULT FALSE,
    `used_at` TIMESTAMP NULL,
    `expires_at` TIMESTAMP NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_user_id` (`user_id`),
    INDEX `idx_token` (`token`),
    INDEX `idx_expires_at` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 3: COMMISSION MANAGEMENT EXTENDED (7 tables)
-- =====================================================

-- Commission payout processing
CREATE TABLE `commission_payouts` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `payout_batch_id` BIGINT UNSIGNED NULL,
    `partner_id` BIGINT UNSIGNED NOT NULL,
    `payout_amount` DECIMAL(15,2) NOT NULL,
    `payout_method` VARCHAR(50) NOT NULL COMMENT 'bank_transfer, e_wallet, paypal',
    `bank_account_id` BIGINT UNSIGNED NULL,
    `payout_reference` VARCHAR(100) NULL,
    `payout_status` ENUM('pending', 'processing', 'completed', 'failed', 'cancelled') DEFAULT 'pending',
    `payout_notes` TEXT NULL,
    `processed_by` BIGINT UNSIGNED NULL,
    `processed_at` TIMESTAMP NULL,
    `failed_reason` TEXT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_partner_id` (`partner_id`),
    INDEX `idx_payout_status` (`payout_status`),
    INDEX `idx_payout_batch_id` (`payout_batch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Payout batch management
CREATE TABLE `payout_batches` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `batch_number` VARCHAR(50) NOT NULL UNIQUE,
    `batch_date` DATE NOT NULL,
    `total_amount` DECIMAL(15,2) DEFAULT 0,
    `total_partners` INT DEFAULT 0,
    `status` ENUM('draft', 'submitted', 'processing', 'completed', 'cancelled') DEFAULT 'draft',
    `payment_method` VARCHAR(50) NULL,
    `notes` TEXT NULL,
    `created_by` BIGINT UNSIGNED NOT NULL,
    `approved_by` BIGINT UNSIGNED NULL,
    `approved_at` TIMESTAMP NULL,
    `completed_at` TIMESTAMP NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_status` (`status`),
    INDEX `idx_batch_date` (`batch_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Commission disputes
CREATE TABLE `commission_disputes` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `commission_id` BIGINT UNSIGNED NOT NULL,
    `partner_id` BIGINT UNSIGNED NOT NULL,
    `dispute_type` VARCHAR(50) NOT NULL COMMENT 'amount, calculation, missing, other',
    `dispute_description` TEXT NOT NULL,
    `expected_amount` DECIMAL(15,2) NULL,
    `actual_amount` DECIMAL(15,2) NULL,
    `status` ENUM('open', 'investigating', 'resolved', 'rejected') DEFAULT 'open',
    `resolution_notes` TEXT NULL,
    `resolved_by` BIGINT UNSIGNED NULL,
    `resolved_at` TIMESTAMP NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_commission_id` (`commission_id`),
    INDEX `idx_partner_id` (`partner_id`),
    INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Manual commission adjustments
CREATE TABLE `commission_adjustments` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `commission_id` BIGINT UNSIGNED NOT NULL,
    `partner_id` BIGINT UNSIGNED NOT NULL,
    `adjustment_type` ENUM('increase', 'decrease', 'correction') NOT NULL,
    `adjustment_amount` DECIMAL(15,2) NOT NULL,
    `reason` TEXT NOT NULL,
    `old_amount` DECIMAL(15,2) NOT NULL,
    `new_amount` DECIMAL(15,2) NOT NULL,
    `adjusted_by` BIGINT UNSIGNED NOT NULL,
    `approved_by` BIGINT UNSIGNED NULL,
    `approved_at` TIMESTAMP NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_commission_id` (`commission_id`),
    INDEX `idx_partner_id` (`partner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Payment methods configuration
CREATE TABLE `payout_methods` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `method_name` VARCHAR(50) NOT NULL UNIQUE,
    `method_type` VARCHAR(50) NOT NULL COMMENT 'bank_transfer, e_wallet, paypal, crypto',
    `is_active` BOOLEAN DEFAULT TRUE,
    `min_amount` DECIMAL(15,2) DEFAULT 0,
    `max_amount` DECIMAL(15,2) NULL,
    `processing_fee` DECIMAL(15,2) DEFAULT 0,
    `processing_days` INT DEFAULT 0 COMMENT 'Estimated processing days',
    `configuration` JSON NULL COMMENT 'Method-specific config',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Commission reports
CREATE TABLE `commission_reports` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `report_period` VARCHAR(20) NOT NULL COMMENT 'YYYY-MM format',
    `total_commissions` DECIMAL(15,2) DEFAULT 0,
    `total_paid` DECIMAL(15,2) DEFAULT 0,
    `total_pending` DECIMAL(15,2) DEFAULT 0,
    `active_partners` INT DEFAULT 0,
    `report_data` JSON NULL COMMENT 'Detailed report data',
    `generated_by` BIGINT UNSIGNED NOT NULL,
    `generated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY `unique_period` (`report_period`),
    INDEX `idx_report_period` (`report_period`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Commission tiers history tracking
CREATE TABLE `commission_tiers_history` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `partner_id` BIGINT UNSIGNED NOT NULL,
    `old_tier` INT NOT NULL,
    `new_tier` INT NOT NULL,
    `old_rate` DECIMAL(5,2) NOT NULL,
    `new_rate` DECIMAL(5,2) NOT NULL,
    `change_reason` TEXT NULL,
    `changed_by` BIGINT UNSIGNED NULL,
    `changed_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_partner_id` (`partner_id`),
    INDEX `idx_changed_at` (`changed_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 4: CONTENT MANAGEMENT SYSTEM (8 tables)
-- =====================================================

-- Blog posts
CREATE TABLE `blog_posts` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(255) NOT NULL,
    `slug` VARCHAR(255) NOT NULL UNIQUE,
    `excerpt` TEXT NULL,
    `content` LONGTEXT NOT NULL,
    `featured_image` VARCHAR(255) NULL,
    `category_id` BIGINT UNSIGNED NULL,
    `author_id` BIGINT UNSIGNED NOT NULL,
    `status` ENUM('draft', 'published', 'scheduled', 'archived') DEFAULT 'draft',
    `published_at` TIMESTAMP NULL,
    `views` BIGINT UNSIGNED DEFAULT 0,
    `seo_title` VARCHAR(255) NULL,
    `seo_description` TEXT NULL,
    `seo_keywords` VARCHAR(255) NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_slug` (`slug`),
    INDEX `idx_status` (`status`),
    INDEX `idx_category_id` (`category_id`),
    INDEX `idx_author_id` (`author_id`),
    INDEX `idx_published_at` (`published_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Blog categories
CREATE TABLE `blog_categories` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
    `slug` VARCHAR(100) NOT NULL UNIQUE,
    `description` TEXT NULL,
    `parent_id` BIGINT UNSIGNED NULL,
    `display_order` INT DEFAULT 0,
    `is_active` BOOLEAN DEFAULT TRUE,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_parent_id` (`parent_id`),
    INDEX `idx_is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Portfolio/Case studies
CREATE TABLE `portfolio_items` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(255) NOT NULL,
    `slug` VARCHAR(255) NOT NULL UNIQUE,
    `client_name` VARCHAR(100) NULL,
    `project_type` VARCHAR(100) NULL,
    `description` TEXT NULL,
    `challenge` TEXT NULL,
    `solution` TEXT NULL,
    `results` TEXT NULL,
    `featured_image` VARCHAR(255) NULL,
    `gallery_images` JSON NULL,
    `project_url` VARCHAR(255) NULL,
    `completion_date` DATE NULL,
    `is_featured` BOOLEAN DEFAULT FALSE,
    `display_order` INT DEFAULT 0,
    `status` ENUM('draft', 'published', 'archived') DEFAULT 'draft',
    `views` BIGINT UNSIGNED DEFAULT 0,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_status` (`status`),
    INDEX `idx_is_featured` (`is_featured`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Client testimonials
CREATE TABLE `testimonials` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `client_name` VARCHAR(100) NOT NULL,
    `client_company` VARCHAR(100) NULL,
    `client_position` VARCHAR(100) NULL,
    `client_photo` VARCHAR(255) NULL,
    `testimonial_text` TEXT NOT NULL,
    `rating` TINYINT DEFAULT 5,
    `service_id` BIGINT UNSIGNED NULL,
    `is_featured` BOOLEAN DEFAULT FALSE,
    `display_order` INT DEFAULT 0,
    `status` ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
    `approved_by` BIGINT UNSIGNED NULL,
    `approved_at` TIMESTAMP NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_status` (`status`),
    INDEX `idx_is_featured` (`is_featured`),
    INDEX `idx_service_id` (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- FAQ management
CREATE TABLE `faqs` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `question` VARCHAR(255) NOT NULL,
    `answer` TEXT NOT NULL,
    `category` VARCHAR(50) NOT NULL COMMENT 'general, pricing, technical, support',
    `display_order` INT DEFAULT 0,
    `is_active` BOOLEAN DEFAULT TRUE,
    `views` BIGINT UNSIGNED DEFAULT 0,
    `helpful_count` INT DEFAULT 0,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_category` (`category`),
    INDEX `idx_is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dynamic pages
CREATE TABLE `pages` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(255) NOT NULL,
    `slug` VARCHAR(255) NOT NULL UNIQUE,
    `content` LONGTEXT NOT NULL,
    `template` VARCHAR(50) DEFAULT 'default',
    `parent_id` BIGINT UNSIGNED NULL,
    `display_order` INT DEFAULT 0,
    `is_active` BOOLEAN DEFAULT TRUE,
    `seo_title` VARCHAR(255) NULL,
    `seo_description` TEXT NULL,
    `seo_keywords` VARCHAR(255) NULL,
    `created_by` BIGINT UNSIGNED NOT NULL,
    `updated_by` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_slug` (`slug`),
    INDEX `idx_is_active` (`is_active`),
    INDEX `idx_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Media library
CREATE TABLE `media_library` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `file_name` VARCHAR(255) NOT NULL,
    `original_name` VARCHAR(255) NOT NULL,
    `file_path` VARCHAR(255) NOT NULL,
    `file_type` VARCHAR(50) NOT NULL COMMENT 'image, video, document, etc',
    `mime_type` VARCHAR(100) NOT NULL,
    `file_size` BIGINT NOT NULL COMMENT 'Size in bytes',
    `width` INT NULL COMMENT 'For images',
    `height` INT NULL COMMENT 'For images',
    `alt_text` VARCHAR(255) NULL,
    `title` VARCHAR(255) NULL,
    `description` TEXT NULL,
    `uploaded_by` BIGINT UNSIGNED NOT NULL,
    `folder` VARCHAR(100) NULL,
    `is_public` BOOLEAN DEFAULT TRUE,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_file_type` (`file_type`),
    INDEX `idx_uploaded_by` (`uploaded_by`),
    INDEX `idx_folder` (`folder`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- SEO metadata for pages
CREATE TABLE `page_seo` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `page_type` VARCHAR(50) NOT NULL COMMENT 'blog, service, portfolio, custom',
    `page_id` BIGINT UNSIGNED NOT NULL,
    `meta_title` VARCHAR(255) NULL,
    `meta_description` TEXT NULL,
    `meta_keywords` VARCHAR(255) NULL,
    `og_title` VARCHAR(255) NULL,
    `og_description` TEXT NULL,
    `og_image` VARCHAR(255) NULL,
    `twitter_title` VARCHAR(255) NULL,
    `twitter_description` TEXT NULL,
    `twitter_image` VARCHAR(255) NULL,
    `canonical_url` VARCHAR(255) NULL,
    `robots` VARCHAR(50) DEFAULT 'index,follow',
    `schema_markup` JSON NULL,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY `unique_page` (`page_type`, `page_id`),
    INDEX `idx_page_type` (`page_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 5: EMAIL MARKETING SYSTEM (6 tables)
-- =====================================================

-- Email campaigns
CREATE TABLE `email_campaigns` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `campaign_name` VARCHAR(100) NOT NULL,
    `campaign_type` ENUM('promotional', 'newsletter', 'transactional', 'announcement') NOT NULL,
    `subject` VARCHAR(255) NOT NULL,
    `from_name` VARCHAR(100) NOT NULL,
    `from_email` VARCHAR(255) NOT NULL,
    `reply_to` VARCHAR(255) NULL,
    `template_id` BIGINT UNSIGNED NULL,
    `email_content` LONGTEXT NOT NULL,
    `target_audience` JSON NULL COMMENT 'Recipient filters',
    `total_recipients` INT DEFAULT 0,
    `sent_count` INT DEFAULT 0,
    `opened_count` INT DEFAULT 0,
    `clicked_count` INT DEFAULT 0,
    `bounced_count` INT DEFAULT 0,
    `status` ENUM('draft', 'scheduled', 'sending', 'sent', 'cancelled') DEFAULT 'draft',
    `scheduled_at` TIMESTAMP NULL,
    `sent_at` TIMESTAMP NULL,
    `created_by` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_status` (`status`),
    INDEX `idx_scheduled_at` (`scheduled_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Email templates
CREATE TABLE `email_templates` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `template_name` VARCHAR(100) NOT NULL UNIQUE,
    `template_subject` VARCHAR(255) NULL,
    `template_category` VARCHAR(50) NOT NULL COMMENT 'marketing, transactional, system',
    `template_html` LONGTEXT NOT NULL,
    `template_variables` JSON NULL COMMENT 'Available variables',
    `is_active` BOOLEAN DEFAULT TRUE,
    `created_by` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_template_category` (`template_category`),
    INDEX `idx_is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Email queue
CREATE TABLE `email_queue` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `campaign_id` BIGINT UNSIGNED NULL,
    `recipient_email` VARCHAR(255) NOT NULL,
    `recipient_name` VARCHAR(100) NULL,
    `subject` VARCHAR(255) NOT NULL,
    `email_body` LONGTEXT NOT NULL,
    `from_email` VARCHAR(255) NOT NULL,
    `from_name` VARCHAR(100) NOT NULL,
    `reply_to` VARCHAR(255) NULL,
    `priority` TINYINT DEFAULT 5 COMMENT '1=highest, 10=lowest',
    `status` ENUM('pending', 'sending', 'sent', 'failed') DEFAULT 'pending',
    `attempts` TINYINT DEFAULT 0,
    `last_error` TEXT NULL,
    `sent_at` TIMESTAMP NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_status` (`status`),
    INDEX `idx_campaign_id` (`campaign_id`),
    INDEX `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Email logs
CREATE TABLE `email_logs` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `campaign_id` BIGINT UNSIGNED NULL,
    `queue_id` BIGINT UNSIGNED NULL,
    `recipient_email` VARCHAR(255) NOT NULL,
    `subject` VARCHAR(255) NOT NULL,
    `status` ENUM('sent', 'opened', 'clicked', 'bounced', 'complained', 'unsubscribed') NOT NULL,
    `event_data` JSON NULL COMMENT 'Additional event data',
    `ip_address` VARCHAR(45) NULL,
    `user_agent` VARCHAR(255) NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_campaign_id` (`campaign_id`),
    INDEX `idx_recipient_email` (`recipient_email`),
    INDEX `idx_status` (`status`),
    INDEX `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Newsletter subscribers
CREATE TABLE `newsletter_subscribers` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `email` VARCHAR(255) NOT NULL UNIQUE,
    `first_name` VARCHAR(100) NULL,
    `last_name` VARCHAR(100) NULL,
    `status` ENUM('subscribed', 'unsubscribed', 'bounced', 'complained') DEFAULT 'subscribed',
    `subscription_source` VARCHAR(50) NULL COMMENT 'website, popup, api, import',
    `tags` JSON NULL COMMENT 'Subscriber tags',
    `custom_fields` JSON NULL COMMENT 'Additional data',
    `subscribed_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `unsubscribed_at` TIMESTAMP NULL,
    `unsubscribe_reason` TEXT NULL,
    INDEX `idx_status` (`status`),
    INDEX `idx_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Lead sources tracking
CREATE TABLE `lead_sources` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `source_name` VARCHAR(100) NOT NULL UNIQUE,
    `source_type` VARCHAR(50) NOT NULL COMMENT 'organic, paid, referral, social, direct',
    `utm_source` VARCHAR(100) NULL,
    `utm_medium` VARCHAR(100) NULL,
    `utm_campaign` VARCHAR(100) NULL,
    `total_visits` INT DEFAULT 0,
    `total_leads` INT DEFAULT 0,
    `total_conversions` INT DEFAULT 0,
    `conversion_rate` DECIMAL(5,2) DEFAULT 0,
    `is_active` BOOLEAN DEFAULT TRUE,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_source_type` (`source_type`),
    INDEX `idx_is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 6: NOTIFICATION SYSTEM (7 tables)
-- =====================================================

-- User notifications center
CREATE TABLE `notifications_center` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `notification_type` VARCHAR(50) NOT NULL COMMENT 'order, payment, commission, system',
    `title` VARCHAR(255) NOT NULL,
    `message` TEXT NOT NULL,
    `icon` VARCHAR(50) NULL,
    `link_url` VARCHAR(255) NULL,
    `link_text` VARCHAR(100) NULL,
    `priority` ENUM('low', 'normal', 'high', 'urgent') DEFAULT 'normal',
    `is_read` BOOLEAN DEFAULT FALSE,
    `read_at` TIMESTAMP NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_user_id` (`user_id`),
    INDEX `idx_is_read` (`is_read`),
    INDEX `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Notification templates
CREATE TABLE `notification_templates` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `template_key` VARCHAR(100) NOT NULL UNIQUE,
    `template_name` VARCHAR(100) NOT NULL,
    `template_category` VARCHAR(50) NOT NULL,
    `title_template` VARCHAR(255) NOT NULL,
    `message_template` TEXT NOT NULL,
    `email_enabled` BOOLEAN DEFAULT FALSE,
    `push_enabled` BOOLEAN DEFAULT FALSE,
    `sms_enabled` BOOLEAN DEFAULT FALSE,
    `variables` JSON NULL COMMENT 'Template variables',
    `is_active` BOOLEAN DEFAULT TRUE,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_template_category` (`template_category`),
    INDEX `idx_is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Push notifications
CREATE TABLE `push_notifications` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `user_id` BIGINT UNSIGNED NULL COMMENT 'NULL for broadcast',
    `title` VARCHAR(255) NOT NULL,
    `body` TEXT NOT NULL,
    `icon` VARCHAR(255) NULL,
    `image` VARCHAR(255) NULL,
    `click_action` VARCHAR(255) NULL,
    `data` JSON NULL,
    `target_type` ENUM('user', 'role', 'all') DEFAULT 'user',
    `target_value` VARCHAR(100) NULL,
    `sent_count` INT DEFAULT 0,
    `clicked_count` INT DEFAULT 0,
    `status` ENUM('pending', 'sent', 'failed') DEFAULT 'pending',
    `sent_at` TIMESTAMP NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_user_id` (`user_id`),
    INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- SMS logs
CREATE TABLE `sms_logs` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `phone_number` VARCHAR(20) NOT NULL,
    `message` TEXT NOT NULL,
    `sms_type` VARCHAR(50) NOT NULL COMMENT 'otp, notification, marketing',
    `provider` VARCHAR(50) NOT NULL COMMENT 'twilio, nexmo, etc',
    `provider_message_id` VARCHAR(255) NULL,
    `status` ENUM('pending', 'sent', 'delivered', 'failed', 'expired') DEFAULT 'pending',
    `cost` DECIMAL(10,4) NULL,
    `error_message` TEXT NULL,
    `sent_at` TIMESTAMP NULL,
    `delivered_at` TIMESTAMP NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_phone_number` (`phone_number`),
    INDEX `idx_status` (`status`),
    INDEX `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- WhatsApp message logs
CREATE TABLE `whatsapp_logs` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `phone_number` VARCHAR(20) NOT NULL,
    `message_type` ENUM('text', 'image', 'video', 'document', 'template') NOT NULL,
    `message_content` TEXT NOT NULL,
    `template_name` VARCHAR(100) NULL,
    `template_variables` JSON NULL,
    `media_url` VARCHAR(255) NULL,
    `provider_message_id` VARCHAR(255) NULL,
    `status` ENUM('pending', 'sent', 'delivered', 'read', 'failed') DEFAULT 'pending',
    `error_message` TEXT NULL,
    `sent_at` TIMESTAMP NULL,
    `delivered_at` TIMESTAMP NULL,
    `read_at` TIMESTAMP NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_phone_number` (`phone_number`),
    INDEX `idx_status` (`status`),
    INDEX `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Notification preferences
CREATE TABLE `user_notification_preferences` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `user_id` BIGINT UNSIGNED NOT NULL UNIQUE,
    `email_orders` BOOLEAN DEFAULT TRUE,
    `email_payments` BOOLEAN DEFAULT TRUE,
    `email_commissions` BOOLEAN DEFAULT TRUE,
    `email_marketing` BOOLEAN DEFAULT TRUE,
    `email_system` BOOLEAN DEFAULT TRUE,
    `push_orders` BOOLEAN DEFAULT TRUE,
    `push_payments` BOOLEAN DEFAULT TRUE,
    `push_commissions` BOOLEAN DEFAULT TRUE,
    `push_marketing` BOOLEAN DEFAULT FALSE,
    `sms_orders` BOOLEAN DEFAULT FALSE,
    `sms_payments` BOOLEAN DEFAULT FALSE,
    `whatsapp_orders` BOOLEAN DEFAULT FALSE,
    `whatsapp_payments` BOOLEAN DEFAULT FALSE,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Notification delivery tracking
CREATE TABLE `notification_delivery` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `notification_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `channel` ENUM('email', 'push', 'sms', 'whatsapp', 'in_app') NOT NULL,
    `status` ENUM('pending', 'sent', 'delivered', 'failed', 'bounced') DEFAULT 'pending',
    `sent_at` TIMESTAMP NULL,
    `delivered_at` TIMESTAMP NULL,
    `opened_at` TIMESTAMP NULL,
    `clicked_at` TIMESTAMP NULL,
    `error_message` TEXT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_notification_id` (`notification_id`),
    INDEX `idx_user_id` (`user_id`),
    INDEX `idx_channel` (`channel`),
    INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
