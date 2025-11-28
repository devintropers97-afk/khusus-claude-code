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
