-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 15, 2025 at 08:09 PM
-- Server version: 10.6.23-MariaDB-cll-lve
-- PHP Version: 8.4.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nrrskfvk_situneo_digital`
--

-- --------------------------------------------------------

--
-- Table structure for table `achievements`
--

CREATE TABLE `achievements` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `achievement_type` varchar(50) NOT NULL,
  `achievement_name` varchar(255) NOT NULL,
  `achievement_description` text DEFAULT NULL,
  `badge_icon` varchar(255) DEFAULT NULL,
  `earned_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admin_actions`
--

CREATE TABLE `admin_actions` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `action_type` varchar(50) NOT NULL,
  `action_description` text NOT NULL,
  `target_type` varchar(50) DEFAULT NULL,
  `target_id` int(11) DEFAULT NULL,
  `action_data` longtext DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE `announcements` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `target_role` varchar(50) DEFAULT NULL,
  `is_important` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `api_keys`
--

CREATE TABLE `api_keys` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `api_key` varchar(64) NOT NULL,
  `api_secret` varchar(64) DEFAULT NULL,
  `key_name` varchar(100) DEFAULT NULL,
  `permissions` text DEFAULT NULL,
  `last_used_at` datetime DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(50) NOT NULL,
  `table_name` varchar(100) DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  `old_values` longtext DEFAULT NULL,
  `new_values` longtext DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `banners`
--

CREATE TABLE `banners` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `subtitle` varchar(255) DEFAULT NULL,
  `image` varchar(255) NOT NULL,
  `link_url` varchar(255) DEFAULT NULL,
  `button_text` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `order_index` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blog_categories`
--

CREATE TABLE `blog_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blog_posts`
--

CREATE TABLE `blog_posts` (
  `id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `excerpt` text DEFAULT NULL,
  `content` longtext NOT NULL,
  `featured_image` varchar(255) DEFAULT NULL,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL,
  `is_published` tinyint(1) DEFAULT 0,
  `published_at` datetime DEFAULT NULL,
  `view_count` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blog_tags`
--

CREATE TABLE `blog_tags` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `business_categories`
--

CREATE TABLE `business_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `icon` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `order_index` int(11) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `careers`
--

CREATE TABLE `careers` (
  `id` int(11) NOT NULL,
  `job_title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `department` varchar(100) DEFAULT NULL,
  `job_type` enum('full_time','part_time','contract','internship') DEFAULT 'full_time',
  `location` varchar(100) DEFAULT NULL,
  `description` longtext NOT NULL,
  `requirements` longtext DEFAULT NULL,
  `benefits` longtext DEFAULT NULL,
  `salary_range` varchar(100) DEFAULT NULL,
  `application_deadline` date DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_code` varchar(20) NOT NULL,
  `business_name` varchar(200) DEFAULT NULL,
  `business_type` varchar(100) DEFAULT NULL,
  `tax_id` varchar(50) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `total_orders` int(11) DEFAULT 0,
  `total_spent` decimal(15,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `client_addresses`
--

CREATE TABLE `client_addresses` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `address` text NOT NULL,
  `city` varchar(100) NOT NULL,
  `province` varchar(100) NOT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `client_documents`
--

CREATE TABLE `client_documents` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `document_type` varchar(50) NOT NULL,
  `document_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_size` int(11) DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `client_notes`
--

CREATE TABLE `client_notes` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `note` text NOT NULL,
  `is_important` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `client_subscriptions`
--

CREATE TABLE `client_subscriptions` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `website_id` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `monthly_amount` decimal(10,2) NOT NULL,
  `status` enum('active','cancelled','suspended','expired') DEFAULT 'active',
  `auto_renew` tinyint(1) DEFAULT 1,
  `next_billing_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `client_websites`
--

CREATE TABLE `client_websites` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `domain` varchar(255) NOT NULL,
  `website_type` varchar(100) DEFAULT NULL,
  `status` enum('active','inactive','suspended','development') DEFAULT 'development',
  `launch_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `is_rental` tinyint(1) DEFAULT 0,
  `monthly_fee` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `commissions`
--

CREATE TABLE `commissions` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `partner_id` int(11) DEFAULT NULL,
  `spv_id` int(11) DEFAULT NULL,
  `manager_id` int(11) DEFAULT NULL,
  `commission_type` enum('partner','spv','manager','bonus') NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `percentage` decimal(5,2) DEFAULT NULL,
  `status` enum('pending','approved','paid','cancelled') DEFAULT 'pending',
  `approved_at` datetime DEFAULT NULL,
  `paid_at` datetime DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `commission_calculations`
--

CREATE TABLE `commission_calculations` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `base_amount` decimal(15,2) NOT NULL,
  `partner_rate` decimal(5,2) DEFAULT NULL,
  `partner_commission` decimal(15,2) DEFAULT 0.00,
  `spv_rate` decimal(5,2) DEFAULT NULL,
  `spv_commission` decimal(15,2) DEFAULT 0.00,
  `manager_rate` decimal(5,2) DEFAULT NULL,
  `manager_commission` decimal(15,2) DEFAULT 0.00,
  `total_commission` decimal(15,2) DEFAULT 0.00,
  `situneo_revenue` decimal(15,2) DEFAULT 0.00,
  `calculated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contact_messages`
--

CREATE TABLE `contact_messages` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` text NOT NULL,
  `status` enum('new','read','replied') DEFAULT 'new',
  `replied_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `conversion_tracking`
--

CREATE TABLE `conversion_tracking` (
  `id` int(11) NOT NULL,
  `conversion_type` varchar(50) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `session_id` varchar(255) DEFAULT NULL,
  `referrer` varchar(255) DEFAULT NULL,
  `utm_source` varchar(100) DEFAULT NULL,
  `utm_medium` varchar(100) DEFAULT NULL,
  `utm_campaign` varchar(100) DEFAULT NULL,
  `conversion_value` decimal(15,2) DEFAULT 0.00,
  `converted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cron_jobs`
--

CREATE TABLE `cron_jobs` (
  `id` int(11) NOT NULL,
  `job_name` varchar(100) NOT NULL,
  `job_description` text DEFAULT NULL,
  `schedule` varchar(50) NOT NULL,
  `last_run_at` datetime DEFAULT NULL,
  `next_run_at` datetime DEFAULT NULL,
  `status` enum('active','paused','failed') DEFAULT 'active',
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` int(11) NOT NULL,
  `code` varchar(3) NOT NULL,
  `name` varchar(50) NOT NULL,
  `symbol` varchar(10) NOT NULL,
  `exchange_rate` decimal(10,4) DEFAULT 1.0000,
  `is_default` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `code`, `name`, `symbol`, `exchange_rate`, `is_default`, `is_active`, `updated_at`) VALUES
(1, 'IDR', 'Indonesian Rupiah', 'Rp', 1.0000, 1, 1, '2025-11-13 02:38:43');

-- --------------------------------------------------------

--
-- Table structure for table `daily_stats`
--

CREATE TABLE `daily_stats` (
  `id` int(11) NOT NULL,
  `stat_date` date NOT NULL,
  `total_visitors` int(11) DEFAULT 0,
  `total_page_views` int(11) DEFAULT 0,
  `total_registrations` int(11) DEFAULT 0,
  `total_orders` int(11) DEFAULT 0,
  `total_revenue` decimal(15,2) DEFAULT 0.00,
  `total_commission_paid` decimal(15,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `database_backups`
--

CREATE TABLE `database_backups` (
  `id` int(11) NOT NULL,
  `backup_name` varchar(255) NOT NULL,
  `backup_path` varchar(255) NOT NULL,
  `backup_size` bigint(20) DEFAULT NULL,
  `backup_type` enum('manual','automatic') DEFAULT 'manual',
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `demo_analytics`
--

CREATE TABLE `demo_analytics` (
  `id` int(11) NOT NULL,
  `demo_id` int(11) NOT NULL,
  `metric_date` date NOT NULL,
  `views` int(11) DEFAULT 0,
  `clicks` int(11) DEFAULT 0,
  `inquiries` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `demo_pages`
--

CREATE TABLE `demo_pages` (
  `id` int(11) NOT NULL,
  `demo_id` int(11) NOT NULL,
  `page_name` varchar(100) NOT NULL,
  `page_url` varchar(255) NOT NULL,
  `page_description` text DEFAULT NULL,
  `order_index` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `demo_requests`
--

CREATE TABLE `demo_requests` (
  `id` int(11) NOT NULL,
  `request_code` varchar(30) NOT NULL,
  `client_id` int(11) NOT NULL,
  `business_name` varchar(200) NOT NULL,
  `business_type` varchar(100) NOT NULL,
  `industry` varchar(100) DEFAULT NULL,
  `website_purpose` text NOT NULL,
  `target_audience` text DEFAULT NULL,
  `preferred_colors` varchar(255) DEFAULT NULL,
  `preferred_style` varchar(100) DEFAULT NULL,
  `reference_websites` text DEFAULT NULL,
  `must_have_features` text DEFAULT NULL,
  `nice_to_have_features` text DEFAULT NULL,
  `content_ready` enum('yes','no','partial') DEFAULT 'no',
  `logo_available` enum('yes','no','need_design') DEFAULT 'no',
  `images_available` enum('yes','no','need_stock') DEFAULT 'no',
  `domain_name` varchar(255) DEFAULT NULL,
  `hosting_preference` enum('situneo','own','undecided') DEFAULT 'undecided',
  `budget_range` varchar(50) DEFAULT NULL,
  `timeline_expectation` varchar(50) DEFAULT NULL,
  `contact_name` varchar(100) NOT NULL,
  `contact_email` varchar(100) NOT NULL,
  `contact_phone` varchar(20) NOT NULL,
  `contact_whatsapp` varchar(20) DEFAULT NULL,
  `preferred_contact_method` enum('email','phone','whatsapp') DEFAULT 'whatsapp',
  `additional_notes` text DEFAULT NULL,
  `competitor_websites` text DEFAULT NULL,
  `special_requirements` text DEFAULT NULL,
  `status` enum('pending','reviewed','demo_created','approved','rejected') DEFAULT 'pending',
  `reviewed_by` int(11) DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `demo_url` varchar(255) DEFAULT NULL,
  `admin_notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `demo_websites`
--

CREATE TABLE `demo_websites` (
  `id` int(11) NOT NULL,
  `demo_code` varchar(20) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `business_type` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `demo_url` varchar(255) NOT NULL,
  `preview_image` varchar(255) DEFAULT NULL,
  `features` longtext DEFAULT NULL,
  `technologies_used` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `view_count` int(11) DEFAULT 0,
  `order_index` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discounts`
--

CREATE TABLE `discounts` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `discount_type` enum('percentage','fixed') NOT NULL,
  `discount_value` decimal(10,2) NOT NULL,
  `min_purchase` decimal(10,2) DEFAULT 0.00,
  `max_usage` int(11) DEFAULT NULL,
  `usage_count` int(11) DEFAULT 0,
  `valid_from` datetime DEFAULT NULL,
  `valid_until` datetime DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `email_queue`
--

CREATE TABLE `email_queue` (
  `id` int(11) NOT NULL,
  `to_email` varchar(100) NOT NULL,
  `to_name` varchar(100) DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `body` longtext NOT NULL,
  `template_code` varchar(50) DEFAULT NULL,
  `status` enum('pending','sent','failed') DEFAULT 'pending',
  `attempts` int(11) DEFAULT 0,
  `last_attempt_at` datetime DEFAULT NULL,
  `sent_at` datetime DEFAULT NULL,
  `error_message` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `email_templates`
--

CREATE TABLE `email_templates` (
  `id` int(11) NOT NULL,
  `template_code` varchar(50) NOT NULL,
  `template_name` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `body` longtext NOT NULL,
  `variables` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `email_templates`
--

INSERT INTO `email_templates` (`id`, `template_code`, `template_name`, `subject`, `body`, `variables`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'welcome', 'Welcome Email', 'Selamat Datang di SITUNEO Digital!', '<p>Halo {{name}},</p><p>Terima kasih telah bergabung dengan SITUNEO Digital!</p>', 'name, email', 1, '2025-11-13 02:38:43', '2025-11-13 02:38:43'),
(2, 'order_confirmation', 'Order Confirmation', 'Konfirmasi Order #{{order_number}}', '<p>Halo {{name}},</p><p>Order Anda #{{order_number}} telah kami terima.</p>', 'name, order_number, total_amount', 1, '2025-11-13 02:38:43', '2025-11-13 02:38:43'),
(3, 'payment_received', 'Payment Received', 'Pembayaran Diterima #{{order_number}}', '<p>Halo {{name}},</p><p>Pembayaran untuk order #{{order_number}} telah kami terima.</p>', 'name, order_number, amount', 1, '2025-11-13 02:38:43', '2025-11-13 02:38:43'),
(4, 'withdrawal_approved', 'Withdrawal Approved', 'Penarikan Komisi Disetujui', '<p>Halo {{name}},</p><p>Penarikan komisi sebesar {{amount}} telah disetujui.</p>', 'name, amount, withdrawal_code', 1, '2025-11-13 02:38:43', '2025-11-13 02:38:43');

-- --------------------------------------------------------

--
-- Table structure for table `email_verifications`
--

CREATE TABLE `email_verifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expires_at` datetime NOT NULL,
  `verified_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `error_logs`
--

CREATE TABLE `error_logs` (
  `id` int(11) NOT NULL,
  `error_type` varchar(100) NOT NULL,
  `error_message` text NOT NULL,
  `error_file` varchar(255) DEFAULT NULL,
  `error_line` int(11) DEFAULT NULL,
  `error_trace` longtext DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `request_uri` varchar(255) DEFAULT NULL,
  `request_method` varchar(10) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faqs`
--

CREATE TABLE `faqs` (
  `id` int(11) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `question` text NOT NULL,
  `answer` text NOT NULL,
  `order_index` int(11) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `id` int(11) NOT NULL,
  `invoice_number` varchar(50) NOT NULL,
  `order_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `invoice_date` date NOT NULL,
  `due_date` date NOT NULL,
  `subtotal` decimal(15,2) NOT NULL,
  `tax_amount` decimal(15,2) DEFAULT 0.00,
  `discount_amount` decimal(15,2) DEFAULT 0.00,
  `total_amount` decimal(15,2) NOT NULL,
  `paid_amount` decimal(15,2) DEFAULT 0.00,
  `status` enum('draft','sent','paid','overdue','cancelled') DEFAULT 'draft',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_applications`
--

CREATE TABLE `job_applications` (
  `id` int(11) NOT NULL,
  `career_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `resume_path` varchar(255) NOT NULL,
  `cover_letter` text DEFAULT NULL,
  `portfolio_url` varchar(255) DEFAULT NULL,
  `linkedin_url` varchar(255) DEFAULT NULL,
  `status` enum('new','reviewed','shortlisted','interview','rejected','hired') DEFAULT 'new',
  `reviewed_by` int(11) DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` int(11) NOT NULL,
  `code` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `native_name` varchar(50) DEFAULT NULL,
  `flag_icon` varchar(50) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `code`, `name`, `native_name`, `flag_icon`, `is_default`, `is_active`, `created_at`) VALUES
(1, 'id', 'Indonesian', 'Bahasa Indonesia', '🇮🇩', 1, 1, '2025-11-13 02:38:43'),
(2, 'en', 'English', 'English', '🇺🇸', 0, 1, '2025-11-13 02:38:43');

-- --------------------------------------------------------

--
-- Table structure for table `leaderboard_managers`
--

CREATE TABLE `leaderboard_managers` (
  `id` int(11) NOT NULL,
  `manager_id` int(11) NOT NULL,
  `period_type` enum('monthly','quarterly','yearly','all_time') NOT NULL,
  `period_year` int(4) DEFAULT NULL,
  `period_month` int(2) DEFAULT NULL,
  `rank` int(11) NOT NULL,
  `total_area_orders` int(11) DEFAULT 0,
  `total_area_revenue` decimal(15,2) DEFAULT 0.00,
  `total_commission` decimal(15,2) DEFAULT 0.00,
  `team_size` int(11) DEFAULT 0,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `leaderboard_partners`
--

CREATE TABLE `leaderboard_partners` (
  `id` int(11) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `period_type` enum('monthly','quarterly','yearly','all_time') NOT NULL,
  `period_year` int(4) DEFAULT NULL,
  `period_month` int(2) DEFAULT NULL,
  `rank` int(11) NOT NULL,
  `total_orders` int(11) DEFAULT 0,
  `total_revenue` decimal(15,2) DEFAULT 0.00,
  `total_commission` decimal(15,2) DEFAULT 0.00,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `leaderboard_spv`
--

CREATE TABLE `leaderboard_spv` (
  `id` int(11) NOT NULL,
  `spv_id` int(11) NOT NULL,
  `period_type` enum('monthly','quarterly','yearly','all_time') NOT NULL,
  `period_year` int(4) DEFAULT NULL,
  `period_month` int(2) DEFAULT NULL,
  `rank` int(11) NOT NULL,
  `total_team_orders` int(11) DEFAULT 0,
  `total_team_revenue` decimal(15,2) DEFAULT 0.00,
  `total_commission` decimal(15,2) DEFAULT 0.00,
  `team_size` int(11) DEFAULT 0,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `login_attempts`
--

CREATE TABLE `login_attempts` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `user_agent` text DEFAULT NULL,
  `success` tinyint(1) DEFAULT 0,
  `attempted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `managers`
--

CREATE TABLE `managers` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `manager_code` varchar(20) NOT NULL,
  `referral_code` varchar(20) NOT NULL,
  `area_name` varchar(100) DEFAULT NULL,
  `commission_rate` decimal(5,2) DEFAULT 5.00,
  `total_spv` int(11) DEFAULT 0,
  `total_partners` int(11) DEFAULT 0,
  `total_earnings` decimal(15,2) DEFAULT 0.00,
  `available_balance` decimal(15,2) DEFAULT 0.00,
  `withdrawn_balance` decimal(15,2) DEFAULT 0.00,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `manager_area_performance`
--

CREATE TABLE `manager_area_performance` (
  `id` int(11) NOT NULL,
  `manager_id` int(11) NOT NULL,
  `metric_date` date NOT NULL,
  `total_spv` int(11) DEFAULT 0,
  `total_partners` int(11) DEFAULT 0,
  `total_area_orders` int(11) DEFAULT 0,
  `total_area_revenue` decimal(15,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `manager_bonuses`
--

CREATE TABLE `manager_bonuses` (
  `id` int(11) NOT NULL,
  `manager_id` int(11) NOT NULL,
  `bonus_type` varchar(50) NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `arpu_amount` decimal(15,2) NOT NULL,
  `bonus_tier` varchar(20) NOT NULL,
  `period_month` int(2) NOT NULL,
  `period_year` int(4) NOT NULL,
  `status` enum('pending','approved','paid') DEFAULT 'pending',
  `approved_at` datetime DEFAULT NULL,
  `paid_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `manager_monthly_arpu`
--

CREATE TABLE `manager_monthly_arpu` (
  `id` int(11) NOT NULL,
  `manager_id` int(11) NOT NULL,
  `year` int(4) NOT NULL,
  `month` int(2) NOT NULL,
  `total_revenue` decimal(15,2) DEFAULT 0.00,
  `total_commission` decimal(15,2) DEFAULT 0.00,
  `bonus_earned` decimal(15,2) DEFAULT 0.00,
  `bonus_tier` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `manager_reports`
--

CREATE TABLE `manager_reports` (
  `id` int(11) NOT NULL,
  `manager_id` int(11) NOT NULL,
  `report_type` varchar(50) NOT NULL,
  `report_period` varchar(20) NOT NULL,
  `report_data` longtext DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `manager_spv`
--

CREATE TABLE `manager_spv` (
  `id` int(11) NOT NULL,
  `manager_id` int(11) NOT NULL,
  `spv_id` int(11) NOT NULL,
  `assigned_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `manager_strategies`
--

CREATE TABLE `manager_strategies` (
  `id` int(11) NOT NULL,
  `manager_id` int(11) NOT NULL,
  `strategy_title` varchar(255) NOT NULL,
  `strategy_description` text NOT NULL,
  `implementation_date` date DEFAULT NULL,
  `status` enum('draft','active','completed','cancelled') DEFAULT 'draft',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `manager_targets`
--

CREATE TABLE `manager_targets` (
  `id` int(11) NOT NULL,
  `manager_id` int(11) NOT NULL,
  `year` int(4) NOT NULL,
  `month` int(2) NOT NULL,
  `target_revenue` decimal(15,2) DEFAULT NULL,
  `target_spv` int(11) DEFAULT NULL,
  `target_partners` int(11) DEFAULT NULL,
  `achievement_revenue` decimal(15,2) DEFAULT 0.00,
  `achievement_spv` int(11) DEFAULT 0,
  `achievement_partners` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE `media` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_type` varchar(50) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `mime_type` varchar(100) DEFAULT NULL,
  `alt_text` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `folder_id` int(11) DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `media_folders`
--

CREATE TABLE `media_folders` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `monthly_stats`
--

CREATE TABLE `monthly_stats` (
  `id` int(11) NOT NULL,
  `stat_year` int(4) NOT NULL,
  `stat_month` int(2) NOT NULL,
  `total_visitors` int(11) DEFAULT 0,
  `total_registrations` int(11) DEFAULT 0,
  `total_orders` int(11) DEFAULT 0,
  `total_revenue` decimal(15,2) DEFAULT 0.00,
  `total_commission_paid` decimal(15,2) DEFAULT 0.00,
  `active_clients` int(11) DEFAULT 0,
  `active_partners` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `newsletters`
--

CREATE TABLE `newsletters` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `status` enum('active','unsubscribed') DEFAULT 'active',
  `subscribed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `unsubscribed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `link_url` varchar(255) DEFAULT NULL,
  `icon` varchar(50) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `read_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `order_number` varchar(50) NOT NULL,
  `client_id` int(11) NOT NULL,
  `partner_id` int(11) DEFAULT NULL,
  `order_type` enum('one_time','monthly') NOT NULL,
  `total_amount` decimal(15,2) NOT NULL,
  `discount_amount` decimal(15,2) DEFAULT 0.00,
  `final_amount` decimal(15,2) NOT NULL,
  `payment_status` enum('pending','partial','paid','cancelled','refunded') DEFAULT 'pending',
  `order_status` enum('pending','confirmed','in_progress','completed','cancelled') DEFAULT 'pending',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_cancellations`
--

CREATE TABLE `order_cancellations` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `cancelled_by` int(11) NOT NULL,
  `cancellation_reason` text NOT NULL,
  `refund_status` enum('no_refund','partial_refund','full_refund') DEFAULT 'no_refund',
  `refund_amount` decimal(15,2) DEFAULT 0.00,
  `cancelled_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_communications`
--

CREATE TABLE `order_communications` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `recipient_id` int(11) DEFAULT NULL,
  `message` text NOT NULL,
  `is_internal` tinyint(1) DEFAULT 0,
  `is_read` tinyint(1) DEFAULT 0,
  `read_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_files`
--

CREATE TABLE `order_files` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `file_type` varchar(50) DEFAULT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_size` int(11) DEFAULT NULL,
  `uploaded_by` int(11) DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `service_id` int(11) DEFAULT NULL,
  `package_id` int(11) DEFAULT NULL,
  `item_type` enum('service','package','addon') NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `quantity` int(11) DEFAULT 1,
  `unit_price` decimal(10,2) NOT NULL,
  `subtotal` decimal(15,2) NOT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_milestones`
--

CREATE TABLE `order_milestones` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `milestone_name` varchar(255) NOT NULL,
  `milestone_description` text DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `completed_date` date DEFAULT NULL,
  `status` enum('pending','in_progress','completed','skipped') DEFAULT 'pending',
  `order_index` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_reviews`
--

CREATE TABLE `order_reviews` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `rating` int(1) NOT NULL,
  `review_text` text DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_status_history`
--

CREATE TABLE `order_status_history` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `old_status` varchar(20) DEFAULT NULL,
  `new_status` varchar(20) NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `packages`
--

CREATE TABLE `packages` (
  `id` int(11) NOT NULL,
  `package_code` varchar(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `included_services` longtext DEFAULT NULL,
  `original_price` decimal(10,2) NOT NULL,
  `package_price` decimal(10,2) NOT NULL,
  `discount_percentage` decimal(5,2) DEFAULT 0.00,
  `is_featured` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `package_services`
--

CREATE TABLE `package_services` (
  `id` int(11) NOT NULL,
  `package_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `content` longtext DEFAULT NULL,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL,
  `is_published` tinyint(1) DEFAULT 0,
  `published_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `page_views`
--

CREATE TABLE `page_views` (
  `id` int(11) NOT NULL,
  `page_url` varchar(255) NOT NULL,
  `page_title` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `session_id` varchar(255) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `referrer` varchar(255) DEFAULT NULL,
  `viewed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `partners`
--

CREATE TABLE `partners` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `partner_code` varchar(20) NOT NULL,
  `referral_code` varchar(20) NOT NULL,
  `tier` enum('tier1','tier2','tier3','tier_max') DEFAULT 'tier1',
  `commission_rate` decimal(5,2) DEFAULT 30.00,
  `spv_id` int(11) DEFAULT NULL,
  `manager_id` int(11) DEFAULT NULL,
  `ktp_path` varchar(255) DEFAULT NULL,
  `cv_path` varchar(255) DEFAULT NULL,
  `bank_name` varchar(100) DEFAULT NULL,
  `bank_account_number` varchar(50) DEFAULT NULL,
  `bank_account_name` varchar(100) DEFAULT NULL,
  `total_referrals` int(11) DEFAULT 0,
  `total_orders` int(11) DEFAULT 0,
  `total_earnings` decimal(15,2) DEFAULT 0.00,
  `available_balance` decimal(15,2) DEFAULT 0.00,
  `withdrawn_balance` decimal(15,2) DEFAULT 0.00,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `partner_monthly_stats`
--

CREATE TABLE `partner_monthly_stats` (
  `id` int(11) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `year` int(4) NOT NULL,
  `month` int(2) NOT NULL,
  `total_orders` int(11) DEFAULT 0,
  `total_revenue` decimal(15,2) DEFAULT 0.00,
  `total_commission` decimal(15,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `partner_performance`
--

CREATE TABLE `partner_performance` (
  `id` int(11) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `metric_date` date NOT NULL,
  `total_orders` int(11) DEFAULT 0,
  `total_revenue` decimal(15,2) DEFAULT 0.00,
  `total_commission` decimal(15,2) DEFAULT 0.00,
  `conversion_rate` decimal(5,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `partner_tasks`
--

CREATE TABLE `partner_tasks` (
  `id` int(11) NOT NULL,
  `task_code` varchar(30) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `task_type` varchar(50) DEFAULT NULL,
  `commission_amount` decimal(15,2) NOT NULL,
  `deadline` datetime DEFAULT NULL,
  `status` enum('open','assigned','in_progress','submitted','completed','cancelled') DEFAULT 'open',
  `assigned_to` int(11) DEFAULT NULL,
  `submitted_at` datetime DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `partner_tier_history`
--

CREATE TABLE `partner_tier_history` (
  `id` int(11) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `old_tier` varchar(20) DEFAULT NULL,
  `new_tier` varchar(20) NOT NULL,
  `old_rate` decimal(5,2) DEFAULT NULL,
  `new_rate` decimal(5,2) NOT NULL,
  `reason` text DEFAULT NULL,
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expires_at` datetime NOT NULL,
  `used` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `payment_number` varchar(50) NOT NULL,
  `order_id` int(11) NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `payment_proof` varchar(255) DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `status` enum('pending','verified','rejected') DEFAULT 'pending',
  `verified_by` int(11) DEFAULT NULL,
  `verified_at` datetime DEFAULT NULL,
  `rejection_reason` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_methods`
--

CREATE TABLE `payment_methods` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `type` enum('bank_transfer','ewallet','qris','cod') NOT NULL,
  `details` text DEFAULT NULL,
  `account_number` varchar(100) DEFAULT NULL,
  `account_name` varchar(100) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `order_index` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_methods`
--

INSERT INTO `payment_methods` (`id`, `name`, `type`, `details`, `account_number`, `account_name`, `icon`, `is_active`, `order_index`, `created_at`) VALUES
(1, 'BCA', 'bank_transfer', 'Transfer ke rekening BCA', '2750424018', 'Devin Prasetyo Hermawan', NULL, 1, 1, '2025-11-13 02:38:43'),
(2, 'QRIS', 'qris', 'Scan QRIS untuk pembayaran', NULL, 'SITUNEO DIGITAL', NULL, 1, 2, '2025-11-13 02:38:43');

-- --------------------------------------------------------

--
-- Table structure for table `portfolios`
--

CREATE TABLE `portfolios` (
  `id` int(11) NOT NULL,
  `client_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `project_name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `client_name` varchar(200) DEFAULT NULL,
  `project_url` varchar(255) DEFAULT NULL,
  `featured_image` varchar(255) DEFAULT NULL,
  `completion_date` date DEFAULT NULL,
  `is_featured` tinyint(1) DEFAULT 0,
  `is_public` tinyint(1) DEFAULT 1,
  `view_count` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `portfolio_images`
--

CREATE TABLE `portfolio_images` (
  `id` int(11) NOT NULL,
  `portfolio_id` int(11) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `caption` varchar(255) DEFAULT NULL,
  `order_index` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `post_tags`
--

CREATE TABLE `post_tags` (
  `id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pricing_tiers`
--

CREATE TABLE `pricing_tiers` (
  `id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `tier_name` varchar(100) NOT NULL,
  `min_value` int(11) DEFAULT NULL,
  `max_value` int(11) DEFAULT NULL,
  `price_modifier` decimal(10,2) NOT NULL,
  `modifier_type` enum('fixed','percentage') DEFAULT 'fixed',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `redirects`
--

CREATE TABLE `redirects` (
  `id` int(11) NOT NULL,
  `old_url` varchar(255) NOT NULL,
  `new_url` varchar(255) NOT NULL,
  `redirect_type` enum('301','302','307') DEFAULT '301',
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `referrals`
--

CREATE TABLE `referrals` (
  `id` int(11) NOT NULL,
  `referrer_id` int(11) NOT NULL,
  `referred_user_id` int(11) NOT NULL,
  `referral_type` enum('client','partner','spv') NOT NULL,
  `status` enum('pending','active','inactive') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `refunds`
--

CREATE TABLE `refunds` (
  `id` int(11) NOT NULL,
  `refund_number` varchar(50) NOT NULL,
  `order_id` int(11) NOT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `amount` decimal(15,2) NOT NULL,
  `reason` text NOT NULL,
  `status` enum('pending','approved','processing','completed','rejected') DEFAULT 'pending',
  `approved_by` int(11) DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `processed_at` datetime DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `rejection_reason` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `seo_meta`
--

CREATE TABLE `seo_meta` (
  `id` int(11) NOT NULL,
  `page_type` varchar(50) NOT NULL,
  `page_id` int(11) DEFAULT NULL,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL,
  `og_title` varchar(255) DEFAULT NULL,
  `og_description` text DEFAULT NULL,
  `og_image` varchar(255) DEFAULT NULL,
  `canonical_url` varchar(255) DEFAULT NULL,
  `robots` varchar(50) DEFAULT 'index,follow',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `service_code` varchar(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `short_description` text DEFAULT NULL,
  `full_description` longtext DEFAULT NULL,
  `features` longtext DEFAULT NULL,
  `price_type` enum('one_time','monthly','custom') DEFAULT 'one_time',
  `base_price_one_time` decimal(10,2) DEFAULT NULL,
  `base_price_monthly` decimal(10,2) DEFAULT NULL,
  `price_per_page` decimal(10,2) DEFAULT 350000.00,
  `setup_fee` decimal(10,2) DEFAULT 0.00,
  `icon` varchar(50) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `demo_url` varchar(255) DEFAULT NULL,
  `is_featured` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `order_index` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `service_addons`
--

CREATE TABLE `service_addons` (
  `id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `service_analytics`
--

CREATE TABLE `service_analytics` (
  `id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `metric_date` date NOT NULL,
  `views` int(11) DEFAULT 0,
  `inquiries` int(11) DEFAULT 0,
  `orders` int(11) DEFAULT 0,
  `revenue` decimal(15,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `service_faqs`
--

CREATE TABLE `service_faqs` (
  `id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `question` text NOT NULL,
  `answer` text NOT NULL,
  `order_index` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `service_reviews`
--

CREATE TABLE `service_reviews` (
  `id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `rating` int(1) NOT NULL,
  `review_text` text DEFAULT NULL,
  `is_approved` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` longtext DEFAULT NULL,
  `setting_type` enum('text','number','boolean','json','html') DEFAULT 'text',
  `setting_group` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `setting_key`, `setting_value`, `setting_type`, `setting_group`, `description`, `updated_at`) VALUES
(1, 'company_name', 'SITUNEO DIGITAL', 'text', 'company', 'Nama perusahaan', '2025-11-13 02:38:43'),
(2, 'company_tagline', 'Build Your Future, Today', 'text', 'company', 'Tagline perusahaan', '2025-11-13 02:38:43'),
(3, 'company_email', 'vins@situneo.my.id', 'text', 'company', 'Email utama', '2025-11-13 02:38:43'),
(4, 'company_phone', '021-8880-7229', 'text', 'company', 'Telepon perusahaan', '2025-11-13 02:38:43'),
(5, 'company_whatsapp', '6283173868915', 'text', 'company', 'WhatsApp number', '2025-11-13 02:38:43'),
(6, 'company_address', 'Jl. Bekasi Timur IX Dalam No. 27, Jakarta Timur', 'text', 'company', 'Alamat lengkap', '2025-11-13 02:38:43'),
(7, 'company_nib', '20250-9261-4570-4515-5453', 'text', 'company', 'NIB perusahaan', '2025-11-13 02:38:43'),
(8, 'company_npwp', '90.296.264.6-002.000', 'text', 'company', 'NPWP perusahaan', '2025-11-13 02:38:43'),
(9, 'price_per_page_one_time', '350000', 'number', 'pricing', 'Harga per halaman beli putus', '2025-11-13 02:38:43'),
(10, 'price_per_page_monthly', '150000', 'number', 'pricing', 'Harga per halaman sewa bulanan', '2025-11-13 02:38:43'),
(11, 'min_withdrawal_amount', '50000', 'number', 'commission', 'Minimum penarikan komisi', '2025-11-13 02:38:43'),
(12, 'partner_tier1_rate', '30.00', 'number', 'commission', 'Komisi tier 1 (%)', '2025-11-13 02:38:43'),
(13, 'partner_tier2_rate', '40.00', 'number', 'commission', 'Komisi tier 2 (%)', '2025-11-13 02:38:43'),
(14, 'partner_tier3_rate', '50.00', 'number', 'commission', 'Komisi tier 3 (%)', '2025-11-13 02:38:43'),
(15, 'partner_tiermax_rate', '55.00', 'number', 'commission', 'Komisi tier max (%)', '2025-11-13 02:38:43'),
(16, 'spv_commission_rate', '10.00', 'number', 'commission', 'Komisi SPV (%)', '2025-11-13 02:38:43'),
(17, 'manager_commission_rate', '5.00', 'number', 'commission', 'Komisi Manager (%)', '2025-11-13 02:38:43'),
(18, 'default_language', 'id', 'text', 'localization', 'Bahasa default', '2025-11-13 02:38:43'),
(19, 'timezone', 'Asia/Jakarta', 'text', 'localization', 'Timezone default', '2025-11-13 02:38:43'),
(20, 'currency_code', 'IDR', 'text', 'localization', 'Kode mata uang', '2025-11-13 02:38:43'),
(21, 'currency_symbol', 'Rp', 'text', 'localization', 'Symbol mata uang', '2025-11-13 02:38:43'),
(22, 'maintenance_mode', '0', 'boolean', 'system', 'Mode maintenance', '2025-11-13 02:38:43'),
(23, 'google_analytics_id', 'G-RPW3MZ3RPY', 'text', 'tracking', 'Google Analytics ID', '2025-11-13 02:38:43');

-- --------------------------------------------------------

--
-- Table structure for table `site_maintenance`
--

CREATE TABLE `site_maintenance` (
  `id` int(11) NOT NULL,
  `is_maintenance` tinyint(1) DEFAULT 0,
  `maintenance_message` text DEFAULT NULL,
  `allowed_ips` text DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `site_maintenance`
--

INSERT INTO `site_maintenance` (`id`, `is_maintenance`, `maintenance_message`, `allowed_ips`, `start_time`, `end_time`, `updated_at`) VALUES
(1, 0, 'Website sedang dalam maintenance. Kami akan kembali sebentar lagi.', NULL, NULL, NULL, '2025-11-13 02:38:43');

-- --------------------------------------------------------

--
-- Table structure for table `spv`
--

CREATE TABLE `spv` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `spv_code` varchar(20) NOT NULL,
  `referral_code` varchar(20) NOT NULL,
  `manager_id` int(11) DEFAULT NULL,
  `commission_rate` decimal(5,2) DEFAULT 10.00,
  `area_coverage` varchar(255) DEFAULT NULL,
  `total_partners` int(11) DEFAULT 0,
  `total_earnings` decimal(15,2) DEFAULT 0.00,
  `available_balance` decimal(15,2) DEFAULT 0.00,
  `withdrawn_balance` decimal(15,2) DEFAULT 0.00,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `spv_bonuses`
--

CREATE TABLE `spv_bonuses` (
  `id` int(11) NOT NULL,
  `spv_id` int(11) NOT NULL,
  `bonus_type` varchar(50) NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `arpu_amount` decimal(15,2) NOT NULL,
  `bonus_tier` varchar(20) NOT NULL,
  `period_month` int(2) NOT NULL,
  `period_year` int(4) NOT NULL,
  `status` enum('pending','approved','paid') DEFAULT 'pending',
  `approved_at` datetime DEFAULT NULL,
  `paid_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `spv_communications`
--

CREATE TABLE `spv_communications` (
  `id` int(11) NOT NULL,
  `spv_id` int(11) NOT NULL,
  `partner_id` int(11) DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `communication_type` enum('announcement','coaching','feedback','warning') DEFAULT 'announcement',
  `is_read` tinyint(1) DEFAULT 0,
  `read_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `spv_monthly_arpu`
--

CREATE TABLE `spv_monthly_arpu` (
  `id` int(11) NOT NULL,
  `spv_id` int(11) NOT NULL,
  `year` int(4) NOT NULL,
  `month` int(2) NOT NULL,
  `total_revenue` decimal(15,2) DEFAULT 0.00,
  `total_commission` decimal(15,2) DEFAULT 0.00,
  `bonus_earned` decimal(15,2) DEFAULT 0.00,
  `bonus_tier` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `spv_partners`
--

CREATE TABLE `spv_partners` (
  `id` int(11) NOT NULL,
  `spv_id` int(11) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `assigned_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `spv_reports`
--

CREATE TABLE `spv_reports` (
  `id` int(11) NOT NULL,
  `spv_id` int(11) NOT NULL,
  `report_type` varchar(50) NOT NULL,
  `report_period` varchar(20) NOT NULL,
  `report_data` longtext DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `spv_targets`
--

CREATE TABLE `spv_targets` (
  `id` int(11) NOT NULL,
  `spv_id` int(11) NOT NULL,
  `year` int(4) NOT NULL,
  `month` int(2) NOT NULL,
  `target_revenue` decimal(15,2) DEFAULT NULL,
  `target_partners` int(11) DEFAULT NULL,
  `target_orders` int(11) DEFAULT NULL,
  `achievement_revenue` decimal(15,2) DEFAULT 0.00,
  `achievement_partners` int(11) DEFAULT 0,
  `achievement_orders` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `spv_team_performance`
--

CREATE TABLE `spv_team_performance` (
  `id` int(11) NOT NULL,
  `spv_id` int(11) NOT NULL,
  `metric_date` date NOT NULL,
  `total_partners` int(11) DEFAULT 0,
  `active_partners` int(11) DEFAULT 0,
  `total_team_orders` int(11) DEFAULT 0,
  `total_team_revenue` decimal(15,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscription_payments`
--

CREATE TABLE `subscription_payments` (
  `id` int(11) NOT NULL,
  `subscription_id` int(11) NOT NULL,
  `payment_number` varchar(50) NOT NULL,
  `period_month` int(2) NOT NULL,
  `period_year` int(4) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `due_date` date NOT NULL,
  `paid_date` date DEFAULT NULL,
  `status` enum('pending','paid','overdue','cancelled') DEFAULT 'pending',
  `payment_proof` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_tickets`
--

CREATE TABLE `support_tickets` (
  `id` int(11) NOT NULL,
  `ticket_number` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `priority` enum('low','medium','high','urgent') DEFAULT 'medium',
  `status` enum('open','in_progress','waiting_response','resolved','closed') DEFAULT 'open',
  `assigned_to` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `system_logs`
--

CREATE TABLE `system_logs` (
  `id` int(11) NOT NULL,
  `log_level` enum('debug','info','warning','error','critical') NOT NULL,
  `log_message` text NOT NULL,
  `log_context` longtext DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `task_applications`
--

CREATE TABLE `task_applications` (
  `id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `message` text DEFAULT NULL,
  `status` enum('pending','accepted','rejected') DEFAULT 'pending',
  `applied_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `task_reviews`
--

CREATE TABLE `task_reviews` (
  `id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `submission_id` int(11) NOT NULL,
  `reviewed_by` int(11) NOT NULL,
  `rating` int(1) DEFAULT NULL,
  `review_notes` text DEFAULT NULL,
  `status` enum('approved','revision_needed','rejected') NOT NULL,
  `reviewed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `task_submissions`
--

CREATE TABLE `task_submissions` (
  `id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `submission_notes` text DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `taxes`
--

CREATE TABLE `taxes` (
  `id` int(11) NOT NULL,
  `tax_name` varchar(100) NOT NULL,
  `tax_rate` decimal(5,2) NOT NULL,
  `tax_type` enum('percentage','fixed') DEFAULT 'percentage',
  `is_default` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `testimonials`
--

CREATE TABLE `testimonials` (
  `id` int(11) NOT NULL,
  `client_id` int(11) DEFAULT NULL,
  `client_name` varchar(100) NOT NULL,
  `client_company` varchar(200) DEFAULT NULL,
  `client_position` varchar(100) DEFAULT NULL,
  `client_photo` varchar(255) DEFAULT NULL,
  `rating` int(1) DEFAULT 5,
  `testimonial_text` text NOT NULL,
  `order_number` varchar(50) DEFAULT NULL,
  `is_featured` tinyint(1) DEFAULT 0,
  `is_approved` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_messages`
--

CREATE TABLE `ticket_messages` (
  `id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `attachments` text DEFAULT NULL,
  `is_internal` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `transaction_number` varchar(50) NOT NULL,
  `transaction_type` enum('order_payment','commission_payout','withdrawal','refund','bonus') NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `amount` decimal(15,2) NOT NULL,
  `balance_before` decimal(15,2) DEFAULT 0.00,
  `balance_after` decimal(15,2) DEFAULT 0.00,
  `description` text DEFAULT NULL,
  `status` enum('pending','completed','failed','cancelled') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `translations`
--

CREATE TABLE `translations` (
  `id` int(11) NOT NULL,
  `language_code` varchar(10) NOT NULL,
  `translation_key` varchar(255) NOT NULL,
  `translation_value` text NOT NULL,
  `translation_group` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `role` enum('admin','manager','spv','partner','client') NOT NULL,
  `status` enum('active','inactive','suspended','pending') DEFAULT 'pending',
  `email_verified` tinyint(1) DEFAULT 0,
  `avatar` varchar(255) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `full_name`, `phone`, `role`, `status`, `email_verified`, `avatar`, `last_login`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin@situneo.my.id', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Administrator SITUNEO', '6283173868915', 'admin', 'active', 1, NULL, NULL, '2025-11-13 02:38:43', '2025-11-13 02:38:43');

-- --------------------------------------------------------

--
-- Table structure for table `user_preferences`
--

CREATE TABLE `user_preferences` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `language` varchar(10) DEFAULT 'id',
  `timezone` varchar(50) DEFAULT 'Asia/Jakarta',
  `email_notifications` tinyint(1) DEFAULT 1,
  `sms_notifications` tinyint(1) DEFAULT 0,
  `theme` enum('light','dark') DEFAULT 'light',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_profiles`
--

CREATE TABLE `user_profiles` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `address` text DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `province` varchar(100) DEFAULT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `country` varchar(50) DEFAULT 'Indonesia',
  `gender` enum('male','female','other') DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `company_name` varchar(200) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_sessions`
--

CREATE TABLE `user_sessions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `session_token` varchar(255) NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `last_activity` datetime DEFAULT current_timestamp(),
  `expires_at` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `utm_tracking`
--

CREATE TABLE `utm_tracking` (
  `id` int(11) NOT NULL,
  `session_id` varchar(255) NOT NULL,
  `utm_source` varchar(100) DEFAULT NULL,
  `utm_medium` varchar(100) DEFAULT NULL,
  `utm_campaign` varchar(100) DEFAULT NULL,
  `utm_term` varchar(100) DEFAULT NULL,
  `utm_content` varchar(100) DEFAULT NULL,
  `landing_page` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `visitor_logs`
--

CREATE TABLE `visitor_logs` (
  `id` int(11) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `user_agent` text DEFAULT NULL,
  `referrer` varchar(255) DEFAULT NULL,
  `landing_page` varchar(255) DEFAULT NULL,
  `session_id` varchar(255) DEFAULT NULL,
  `visited_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `webhooks`
--

CREATE TABLE `webhooks` (
  `id` int(11) NOT NULL,
  `webhook_name` varchar(100) NOT NULL,
  `webhook_url` varchar(255) NOT NULL,
  `webhook_events` text DEFAULT NULL,
  `secret_key` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `last_triggered_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `website_types`
--

CREATE TABLE `website_types` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `type_name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `base_price_one_time` decimal(10,2) DEFAULT NULL,
  `base_price_monthly` decimal(10,2) DEFAULT NULL,
  `features` longtext DEFAULT NULL,
  `demo_url` varchar(255) DEFAULT NULL,
  `is_auto_generated` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `withdrawals`
--

CREATE TABLE `withdrawals` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `withdrawal_code` varchar(30) NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `bank_name` varchar(100) NOT NULL,
  `bank_account_number` varchar(50) NOT NULL,
  `bank_account_name` varchar(100) NOT NULL,
  `status` enum('pending','approved','processing','completed','rejected') DEFAULT 'pending',
  `approved_by` int(11) DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `processed_at` datetime DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `rejection_reason` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `withdrawal_history`
--

CREATE TABLE `withdrawal_history` (
  `id` int(11) NOT NULL,
  `withdrawal_id` int(11) NOT NULL,
  `action` varchar(50) NOT NULL,
  `old_status` varchar(20) DEFAULT NULL,
  `new_status` varchar(20) NOT NULL,
  `action_by` int(11) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `achievements`
--
ALTER TABLE `achievements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_action` (`action`);

--
-- Indexes for table `admin_actions`
--
ALTER TABLE `admin_actions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_admin_id` (`admin_id`);

--
-- Indexes for table `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `api_keys`
--
ALTER TABLE `api_keys`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `api_key` (`api_key`),
  ADD KEY `idx_api_key` (`api_key`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_action` (`action`);

--
-- Indexes for table `banners`
--
ALTER TABLE `banners`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_categories`
--
ALTER TABLE `blog_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `idx_slug` (`slug`);

--
-- Indexes for table `blog_posts`
--
ALTER TABLE `blog_posts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `idx_slug` (`slug`),
  ADD KEY `idx_author_id` (`author_id`),
  ADD KEY `idx_category_id` (`category_id`);

--
-- Indexes for table `blog_tags`
--
ALTER TABLE `blog_tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `idx_slug` (`slug`);

--
-- Indexes for table `business_categories`
--
ALTER TABLE `business_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `idx_slug` (`slug`),
  ADD KEY `idx_parent_id` (`parent_id`);

--
-- Indexes for table `careers`
--
ALTER TABLE `careers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `idx_slug` (`slug`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `client_code` (`client_code`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_client_code` (`client_code`);

--
-- Indexes for table `client_addresses`
--
ALTER TABLE `client_addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_client_id` (`client_id`);

--
-- Indexes for table `client_documents`
--
ALTER TABLE `client_documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_client_id` (`client_id`);

--
-- Indexes for table `client_notes`
--
ALTER TABLE `client_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_client_id` (`client_id`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- Indexes for table `client_subscriptions`
--
ALTER TABLE `client_subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_client_id` (`client_id`),
  ADD KEY `idx_website_id` (`website_id`);

--
-- Indexes for table `client_websites`
--
ALTER TABLE `client_websites`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_client_id` (`client_id`),
  ADD KEY `idx_order_id` (`order_id`);

--
-- Indexes for table `commissions`
--
ALTER TABLE `commissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_order_id` (`order_id`),
  ADD KEY `idx_partner_id` (`partner_id`),
  ADD KEY `idx_spv_id` (`spv_id`),
  ADD KEY `idx_manager_id` (`manager_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_partner_status` (`partner_id`,`status`),
  ADD KEY `idx_order_partner` (`order_id`,`partner_id`);

--
-- Indexes for table `commission_calculations`
--
ALTER TABLE `commission_calculations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_order_id` (`order_id`);

--
-- Indexes for table `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `conversion_tracking`
--
ALTER TABLE `conversion_tracking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_conversion_type` (`conversion_type`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- Indexes for table `cron_jobs`
--
ALTER TABLE `cron_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `idx_code` (`code`);

--
-- Indexes for table `daily_stats`
--
ALTER TABLE `daily_stats`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_date` (`stat_date`);

--
-- Indexes for table `database_backups`
--
ALTER TABLE `database_backups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `demo_analytics`
--
ALTER TABLE `demo_analytics`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_demo_date` (`demo_id`,`metric_date`),
  ADD KEY `idx_demo_id` (`demo_id`);

--
-- Indexes for table `demo_pages`
--
ALTER TABLE `demo_pages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_demo_id` (`demo_id`);

--
-- Indexes for table `demo_requests`
--
ALTER TABLE `demo_requests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `request_code` (`request_code`),
  ADD KEY `idx_request_code` (`request_code`),
  ADD KEY `idx_client_id` (`client_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `demo_websites`
--
ALTER TABLE `demo_websites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `demo_code` (`demo_code`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `idx_demo_code` (`demo_code`),
  ADD KEY `idx_slug` (`slug`),
  ADD KEY `idx_category_id` (`category_id`);

--
-- Indexes for table `discounts`
--
ALTER TABLE `discounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `idx_code` (`code`);

--
-- Indexes for table `email_queue`
--
ALTER TABLE `email_queue`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `email_templates`
--
ALTER TABLE `email_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `template_code` (`template_code`),
  ADD KEY `idx_template_code` (`template_code`);

--
-- Indexes for table `email_verifications`
--
ALTER TABLE `email_verifications`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_token` (`token`);

--
-- Indexes for table `error_logs`
--
ALTER TABLE `error_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `faqs`
--
ALTER TABLE `faqs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `invoice_number` (`invoice_number`),
  ADD KEY `idx_invoice_number` (`invoice_number`),
  ADD KEY `idx_order_id` (`order_id`),
  ADD KEY `idx_client_id` (`client_id`);

--
-- Indexes for table `job_applications`
--
ALTER TABLE `job_applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_career_id` (`career_id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `idx_code` (`code`);

--
-- Indexes for table `leaderboard_managers`
--
ALTER TABLE `leaderboard_managers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_manager_id` (`manager_id`),
  ADD KEY `idx_period` (`period_type`,`period_year`,`period_month`);

--
-- Indexes for table `leaderboard_partners`
--
ALTER TABLE `leaderboard_partners`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_partner_id` (`partner_id`),
  ADD KEY `idx_period` (`period_type`,`period_year`,`period_month`);

--
-- Indexes for table `leaderboard_spv`
--
ALTER TABLE `leaderboard_spv`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_spv_id` (`spv_id`),
  ADD KEY `idx_period` (`period_type`,`period_year`,`period_month`);

--
-- Indexes for table `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_ip_address` (`ip_address`);

--
-- Indexes for table `managers`
--
ALTER TABLE `managers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `manager_code` (`manager_code`),
  ADD UNIQUE KEY `referral_code` (`referral_code`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_manager_code` (`manager_code`),
  ADD KEY `idx_referral_code` (`referral_code`);

--
-- Indexes for table `manager_area_performance`
--
ALTER TABLE `manager_area_performance`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_manager_date` (`manager_id`,`metric_date`),
  ADD KEY `idx_manager_id` (`manager_id`);

--
-- Indexes for table `manager_bonuses`
--
ALTER TABLE `manager_bonuses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_manager_id` (`manager_id`);

--
-- Indexes for table `manager_monthly_arpu`
--
ALTER TABLE `manager_monthly_arpu`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_manager_month` (`manager_id`,`year`,`month`),
  ADD KEY `idx_manager_id` (`manager_id`);

--
-- Indexes for table `manager_reports`
--
ALTER TABLE `manager_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_manager_id` (`manager_id`);

--
-- Indexes for table `manager_spv`
--
ALTER TABLE `manager_spv`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_manager_id` (`manager_id`),
  ADD KEY `idx_spv_id` (`spv_id`);

--
-- Indexes for table `manager_strategies`
--
ALTER TABLE `manager_strategies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_manager_id` (`manager_id`);

--
-- Indexes for table `manager_targets`
--
ALTER TABLE `manager_targets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_manager_target` (`manager_id`,`year`,`month`),
  ADD KEY `idx_manager_id` (`manager_id`);

--
-- Indexes for table `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_folder_id` (`folder_id`);

--
-- Indexes for table `media_folders`
--
ALTER TABLE `media_folders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_parent_id` (`parent_id`);

--
-- Indexes for table `monthly_stats`
--
ALTER TABLE `monthly_stats`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_month` (`stat_year`,`stat_month`);

--
-- Indexes for table `newsletters`
--
ALTER TABLE `newsletters`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_email` (`email`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_is_read` (`is_read`),
  ADD KEY `idx_user_read` (`user_id`,`is_read`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_number` (`order_number`),
  ADD KEY `idx_order_number` (`order_number`),
  ADD KEY `idx_client_id` (`client_id`),
  ADD KEY `idx_partner_id` (`partner_id`),
  ADD KEY `idx_order_status` (`order_status`),
  ADD KEY `idx_client_status` (`client_id`,`order_status`),
  ADD KEY `idx_partner_status` (`partner_id`,`order_status`);

--
-- Indexes for table `order_cancellations`
--
ALTER TABLE `order_cancellations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_order_id` (`order_id`),
  ADD KEY `cancelled_by` (`cancelled_by`);

--
-- Indexes for table `order_communications`
--
ALTER TABLE `order_communications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_order_id` (`order_id`),
  ADD KEY `idx_sender_id` (`sender_id`),
  ADD KEY `idx_recipient_id` (`recipient_id`);

--
-- Indexes for table `order_files`
--
ALTER TABLE `order_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_order_id` (`order_id`),
  ADD KEY `uploaded_by` (`uploaded_by`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_order_id` (`order_id`),
  ADD KEY `idx_service_id` (`service_id`),
  ADD KEY `idx_package_id` (`package_id`);

--
-- Indexes for table `order_milestones`
--
ALTER TABLE `order_milestones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_order_id` (`order_id`);

--
-- Indexes for table `order_reviews`
--
ALTER TABLE `order_reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_order_id` (`order_id`),
  ADD KEY `idx_client_id` (`client_id`);

--
-- Indexes for table `order_status_history`
--
ALTER TABLE `order_status_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_order_id` (`order_id`),
  ADD KEY `changed_by` (`changed_by`);

--
-- Indexes for table `packages`
--
ALTER TABLE `packages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `package_code` (`package_code`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `idx_slug` (`slug`),
  ADD KEY `idx_package_code` (`package_code`);

--
-- Indexes for table `package_services`
--
ALTER TABLE `package_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_package_id` (`package_id`),
  ADD KEY `idx_service_id` (`service_id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `idx_slug` (`slug`);

--
-- Indexes for table `page_views`
--
ALTER TABLE `page_views`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_page_url` (`page_url`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- Indexes for table `partners`
--
ALTER TABLE `partners`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `partner_code` (`partner_code`),
  ADD UNIQUE KEY `referral_code` (`referral_code`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_partner_code` (`partner_code`),
  ADD KEY `idx_referral_code` (`referral_code`),
  ADD KEY `idx_spv_id` (`spv_id`),
  ADD KEY `idx_manager_id` (`manager_id`),
  ADD KEY `idx_tier` (`tier`);

--
-- Indexes for table `partner_monthly_stats`
--
ALTER TABLE `partner_monthly_stats`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_partner_month` (`partner_id`,`year`,`month`),
  ADD KEY `idx_partner_id` (`partner_id`);

--
-- Indexes for table `partner_performance`
--
ALTER TABLE `partner_performance`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_partner_date` (`partner_id`,`metric_date`),
  ADD KEY `idx_partner_id` (`partner_id`);

--
-- Indexes for table `partner_tasks`
--
ALTER TABLE `partner_tasks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `task_code` (`task_code`),
  ADD KEY `idx_task_code` (`task_code`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_assigned_to` (`assigned_to`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `partner_tier_history`
--
ALTER TABLE `partner_tier_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_partner_id` (`partner_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_token` (`token`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `payment_number` (`payment_number`),
  ADD KEY `idx_payment_number` (`payment_number`),
  ADD KEY `idx_order_id` (`order_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `verified_by` (`verified_by`);

--
-- Indexes for table `payment_methods`
--
ALTER TABLE `payment_methods`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `portfolios`
--
ALTER TABLE `portfolios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `idx_slug` (`slug`),
  ADD KEY `idx_client_id` (`client_id`),
  ADD KEY `idx_order_id` (`order_id`);

--
-- Indexes for table `portfolio_images`
--
ALTER TABLE `portfolio_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_portfolio_id` (`portfolio_id`);

--
-- Indexes for table `post_tags`
--
ALTER TABLE `post_tags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_post_id` (`post_id`),
  ADD KEY `idx_tag_id` (`tag_id`);

--
-- Indexes for table `pricing_tiers`
--
ALTER TABLE `pricing_tiers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_service_id` (`service_id`);

--
-- Indexes for table `redirects`
--
ALTER TABLE `redirects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_old_url` (`old_url`);

--
-- Indexes for table `referrals`
--
ALTER TABLE `referrals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_referrer_id` (`referrer_id`),
  ADD KEY `idx_referred_user_id` (`referred_user_id`);

--
-- Indexes for table `refunds`
--
ALTER TABLE `refunds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `refund_number` (`refund_number`),
  ADD KEY `idx_refund_number` (`refund_number`),
  ADD KEY `idx_order_id` (`order_id`),
  ADD KEY `payment_id` (`payment_id`);

--
-- Indexes for table `seo_meta`
--
ALTER TABLE `seo_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_page_type_id` (`page_type`,`page_id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `service_code` (`service_code`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `idx_category_id` (`category_id`),
  ADD KEY `idx_slug` (`slug`),
  ADD KEY `idx_service_code` (`service_code`);

--
-- Indexes for table `service_addons`
--
ALTER TABLE `service_addons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_service_id` (`service_id`);

--
-- Indexes for table `service_analytics`
--
ALTER TABLE `service_analytics`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_service_date` (`service_id`,`metric_date`),
  ADD KEY `idx_service_id` (`service_id`);

--
-- Indexes for table `service_faqs`
--
ALTER TABLE `service_faqs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_service_id` (`service_id`);

--
-- Indexes for table `service_reviews`
--
ALTER TABLE `service_reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_service_id` (`service_id`),
  ADD KEY `idx_client_id` (`client_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`),
  ADD KEY `idx_setting_key` (`setting_key`);

--
-- Indexes for table `site_maintenance`
--
ALTER TABLE `site_maintenance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `spv`
--
ALTER TABLE `spv`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `spv_code` (`spv_code`),
  ADD UNIQUE KEY `referral_code` (`referral_code`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_spv_code` (`spv_code`),
  ADD KEY `idx_referral_code` (`referral_code`),
  ADD KEY `idx_manager_id` (`manager_id`);

--
-- Indexes for table `spv_bonuses`
--
ALTER TABLE `spv_bonuses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_spv_id` (`spv_id`);

--
-- Indexes for table `spv_communications`
--
ALTER TABLE `spv_communications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_spv_id` (`spv_id`),
  ADD KEY `idx_partner_id` (`partner_id`);

--
-- Indexes for table `spv_monthly_arpu`
--
ALTER TABLE `spv_monthly_arpu`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_spv_month` (`spv_id`,`year`,`month`),
  ADD KEY `idx_spv_id` (`spv_id`);

--
-- Indexes for table `spv_partners`
--
ALTER TABLE `spv_partners`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_spv_id` (`spv_id`),
  ADD KEY `idx_partner_id` (`partner_id`);

--
-- Indexes for table `spv_reports`
--
ALTER TABLE `spv_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_spv_id` (`spv_id`);

--
-- Indexes for table `spv_targets`
--
ALTER TABLE `spv_targets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_spv_target` (`spv_id`,`year`,`month`),
  ADD KEY `idx_spv_id` (`spv_id`);

--
-- Indexes for table `spv_team_performance`
--
ALTER TABLE `spv_team_performance`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_spv_date` (`spv_id`,`metric_date`),
  ADD KEY `idx_spv_id` (`spv_id`);

--
-- Indexes for table `subscription_payments`
--
ALTER TABLE `subscription_payments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `payment_number` (`payment_number`),
  ADD KEY `idx_subscription_id` (`subscription_id`),
  ADD KEY `idx_payment_number` (`payment_number`);

--
-- Indexes for table `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ticket_number` (`ticket_number`),
  ADD KEY `idx_ticket_number` (`ticket_number`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `assigned_to` (`assigned_to`),
  ADD KEY `idx_user_status` (`user_id`,`status`);

--
-- Indexes for table `system_logs`
--
ALTER TABLE `system_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_log_level` (`log_level`);

--
-- Indexes for table `task_applications`
--
ALTER TABLE `task_applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_task_id` (`task_id`),
  ADD KEY `idx_partner_id` (`partner_id`);

--
-- Indexes for table `task_reviews`
--
ALTER TABLE `task_reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_task_id` (`task_id`),
  ADD KEY `idx_submission_id` (`submission_id`),
  ADD KEY `reviewed_by` (`reviewed_by`);

--
-- Indexes for table `task_submissions`
--
ALTER TABLE `task_submissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_task_id` (`task_id`),
  ADD KEY `idx_partner_id` (`partner_id`);

--
-- Indexes for table `taxes`
--
ALTER TABLE `taxes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `testimonials`
--
ALTER TABLE `testimonials`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_client_id` (`client_id`);

--
-- Indexes for table `ticket_messages`
--
ALTER TABLE `ticket_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ticket_id` (`ticket_id`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transaction_number` (`transaction_number`),
  ADD KEY `idx_transaction_number` (`transaction_number`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_order_id` (`order_id`);

--
-- Indexes for table `translations`
--
ALTER TABLE `translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_key_lang` (`language_code`,`translation_key`),
  ADD KEY `idx_language_code` (`language_code`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_role` (`role`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `user_preferences`
--
ALTER TABLE `user_preferences`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- Indexes for table `user_profiles`
--
ALTER TABLE `user_profiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- Indexes for table `user_sessions`
--
ALTER TABLE `user_sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `session_token` (`session_token`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_session_token` (`session_token`);

--
-- Indexes for table `utm_tracking`
--
ALTER TABLE `utm_tracking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_session_id` (`session_id`);

--
-- Indexes for table `visitor_logs`
--
ALTER TABLE `visitor_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ip_address` (`ip_address`),
  ADD KEY `idx_session_id` (`session_id`);

--
-- Indexes for table `webhooks`
--
ALTER TABLE `webhooks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `website_types`
--
ALTER TABLE `website_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `idx_category_id` (`category_id`),
  ADD KEY `idx_slug` (`slug`);

--
-- Indexes for table `withdrawals`
--
ALTER TABLE `withdrawals`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `withdrawal_code` (`withdrawal_code`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_withdrawal_code` (`withdrawal_code`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_user_status` (`user_id`,`status`);

--
-- Indexes for table `withdrawal_history`
--
ALTER TABLE `withdrawal_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_withdrawal_id` (`withdrawal_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `achievements`
--
ALTER TABLE `achievements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_actions`
--
ALTER TABLE `admin_actions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `announcements`
--
ALTER TABLE `announcements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `api_keys`
--
ALTER TABLE `api_keys`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `banners`
--
ALTER TABLE `banners`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blog_categories`
--
ALTER TABLE `blog_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blog_posts`
--
ALTER TABLE `blog_posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blog_tags`
--
ALTER TABLE `blog_tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `business_categories`
--
ALTER TABLE `business_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `careers`
--
ALTER TABLE `careers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `client_addresses`
--
ALTER TABLE `client_addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `client_documents`
--
ALTER TABLE `client_documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `client_notes`
--
ALTER TABLE `client_notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `client_subscriptions`
--
ALTER TABLE `client_subscriptions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `client_websites`
--
ALTER TABLE `client_websites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commissions`
--
ALTER TABLE `commissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commission_calculations`
--
ALTER TABLE `commission_calculations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `conversion_tracking`
--
ALTER TABLE `conversion_tracking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cron_jobs`
--
ALTER TABLE `cron_jobs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `daily_stats`
--
ALTER TABLE `daily_stats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `database_backups`
--
ALTER TABLE `database_backups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `demo_analytics`
--
ALTER TABLE `demo_analytics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `demo_pages`
--
ALTER TABLE `demo_pages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `demo_requests`
--
ALTER TABLE `demo_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `demo_websites`
--
ALTER TABLE `demo_websites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discounts`
--
ALTER TABLE `discounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `email_queue`
--
ALTER TABLE `email_queue`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `email_templates`
--
ALTER TABLE `email_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `email_verifications`
--
ALTER TABLE `email_verifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `error_logs`
--
ALTER TABLE `error_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `faqs`
--
ALTER TABLE `faqs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `job_applications`
--
ALTER TABLE `job_applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `leaderboard_managers`
--
ALTER TABLE `leaderboard_managers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `leaderboard_partners`
--
ALTER TABLE `leaderboard_partners`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `leaderboard_spv`
--
ALTER TABLE `leaderboard_spv`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `login_attempts`
--
ALTER TABLE `login_attempts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `managers`
--
ALTER TABLE `managers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `manager_area_performance`
--
ALTER TABLE `manager_area_performance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `manager_bonuses`
--
ALTER TABLE `manager_bonuses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `manager_monthly_arpu`
--
ALTER TABLE `manager_monthly_arpu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `manager_reports`
--
ALTER TABLE `manager_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `manager_spv`
--
ALTER TABLE `manager_spv`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `manager_strategies`
--
ALTER TABLE `manager_strategies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `manager_targets`
--
ALTER TABLE `manager_targets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `media`
--
ALTER TABLE `media`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `media_folders`
--
ALTER TABLE `media_folders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `monthly_stats`
--
ALTER TABLE `monthly_stats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `newsletters`
--
ALTER TABLE `newsletters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_cancellations`
--
ALTER TABLE `order_cancellations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_communications`
--
ALTER TABLE `order_communications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_files`
--
ALTER TABLE `order_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_milestones`
--
ALTER TABLE `order_milestones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_reviews`
--
ALTER TABLE `order_reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_status_history`
--
ALTER TABLE `order_status_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `packages`
--
ALTER TABLE `packages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `package_services`
--
ALTER TABLE `package_services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `page_views`
--
ALTER TABLE `page_views`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `partners`
--
ALTER TABLE `partners`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `partner_monthly_stats`
--
ALTER TABLE `partner_monthly_stats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `partner_performance`
--
ALTER TABLE `partner_performance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `partner_tasks`
--
ALTER TABLE `partner_tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `partner_tier_history`
--
ALTER TABLE `partner_tier_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_methods`
--
ALTER TABLE `payment_methods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `portfolios`
--
ALTER TABLE `portfolios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `portfolio_images`
--
ALTER TABLE `portfolio_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `post_tags`
--
ALTER TABLE `post_tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pricing_tiers`
--
ALTER TABLE `pricing_tiers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `redirects`
--
ALTER TABLE `redirects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `referrals`
--
ALTER TABLE `referrals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `refunds`
--
ALTER TABLE `refunds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `seo_meta`
--
ALTER TABLE `seo_meta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `service_addons`
--
ALTER TABLE `service_addons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `service_analytics`
--
ALTER TABLE `service_analytics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `service_faqs`
--
ALTER TABLE `service_faqs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `service_reviews`
--
ALTER TABLE `service_reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `site_maintenance`
--
ALTER TABLE `site_maintenance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `spv`
--
ALTER TABLE `spv`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `spv_bonuses`
--
ALTER TABLE `spv_bonuses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `spv_communications`
--
ALTER TABLE `spv_communications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `spv_monthly_arpu`
--
ALTER TABLE `spv_monthly_arpu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `spv_partners`
--
ALTER TABLE `spv_partners`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `spv_reports`
--
ALTER TABLE `spv_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `spv_targets`
--
ALTER TABLE `spv_targets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `spv_team_performance`
--
ALTER TABLE `spv_team_performance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscription_payments`
--
ALTER TABLE `subscription_payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `support_tickets`
--
ALTER TABLE `support_tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `system_logs`
--
ALTER TABLE `system_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `task_applications`
--
ALTER TABLE `task_applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `task_reviews`
--
ALTER TABLE `task_reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `task_submissions`
--
ALTER TABLE `task_submissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `taxes`
--
ALTER TABLE `taxes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `testimonials`
--
ALTER TABLE `testimonials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ticket_messages`
--
ALTER TABLE `ticket_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `translations`
--
ALTER TABLE `translations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_preferences`
--
ALTER TABLE `user_preferences`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_profiles`
--
ALTER TABLE `user_profiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_sessions`
--
ALTER TABLE `user_sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `utm_tracking`
--
ALTER TABLE `utm_tracking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `visitor_logs`
--
ALTER TABLE `visitor_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `webhooks`
--
ALTER TABLE `webhooks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `website_types`
--
ALTER TABLE `website_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `withdrawals`
--
ALTER TABLE `withdrawals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `withdrawal_history`
--
ALTER TABLE `withdrawal_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `achievements`
--
ALTER TABLE `achievements`
  ADD CONSTRAINT `achievements_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `activity_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `admin_actions`
--
ALTER TABLE `admin_actions`
  ADD CONSTRAINT `admin_actions_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `api_keys`
--
ALTER TABLE `api_keys`
  ADD CONSTRAINT `api_keys_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `blog_posts`
--
ALTER TABLE `blog_posts`
  ADD CONSTRAINT `blog_posts_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `clients`
--
ALTER TABLE `clients`
  ADD CONSTRAINT `clients_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `client_addresses`
--
ALTER TABLE `client_addresses`
  ADD CONSTRAINT `client_addresses_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `client_documents`
--
ALTER TABLE `client_documents`
  ADD CONSTRAINT `client_documents_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `client_notes`
--
ALTER TABLE `client_notes`
  ADD CONSTRAINT `client_notes_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `client_notes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `client_subscriptions`
--
ALTER TABLE `client_subscriptions`
  ADD CONSTRAINT `client_subscriptions_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `client_subscriptions_ibfk_2` FOREIGN KEY (`website_id`) REFERENCES `client_websites` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `client_websites`
--
ALTER TABLE `client_websites`
  ADD CONSTRAINT `client_websites_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `commission_calculations`
--
ALTER TABLE `commission_calculations`
  ADD CONSTRAINT `commission_calculations_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `database_backups`
--
ALTER TABLE `database_backups`
  ADD CONSTRAINT `database_backups_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `demo_analytics`
--
ALTER TABLE `demo_analytics`
  ADD CONSTRAINT `demo_analytics_ibfk_1` FOREIGN KEY (`demo_id`) REFERENCES `demo_websites` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `demo_pages`
--
ALTER TABLE `demo_pages`
  ADD CONSTRAINT `demo_pages_ibfk_1` FOREIGN KEY (`demo_id`) REFERENCES `demo_websites` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `demo_requests`
--
ALTER TABLE `demo_requests`
  ADD CONSTRAINT `demo_requests_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `demo_websites`
--
ALTER TABLE `demo_websites`
  ADD CONSTRAINT `demo_websites_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `business_categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `email_verifications`
--
ALTER TABLE `email_verifications`
  ADD CONSTRAINT `email_verifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `invoices_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `invoices_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `job_applications`
--
ALTER TABLE `job_applications`
  ADD CONSTRAINT `job_applications_ibfk_1` FOREIGN KEY (`career_id`) REFERENCES `careers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `leaderboard_managers`
--
ALTER TABLE `leaderboard_managers`
  ADD CONSTRAINT `leaderboard_managers_ibfk_1` FOREIGN KEY (`manager_id`) REFERENCES `managers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `leaderboard_partners`
--
ALTER TABLE `leaderboard_partners`
  ADD CONSTRAINT `leaderboard_partners_ibfk_1` FOREIGN KEY (`partner_id`) REFERENCES `partners` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `leaderboard_spv`
--
ALTER TABLE `leaderboard_spv`
  ADD CONSTRAINT `leaderboard_spv_ibfk_1` FOREIGN KEY (`spv_id`) REFERENCES `spv` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `managers`
--
ALTER TABLE `managers`
  ADD CONSTRAINT `managers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `manager_area_performance`
--
ALTER TABLE `manager_area_performance`
  ADD CONSTRAINT `manager_area_performance_ibfk_1` FOREIGN KEY (`manager_id`) REFERENCES `managers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `manager_bonuses`
--
ALTER TABLE `manager_bonuses`
  ADD CONSTRAINT `manager_bonuses_ibfk_1` FOREIGN KEY (`manager_id`) REFERENCES `managers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `manager_monthly_arpu`
--
ALTER TABLE `manager_monthly_arpu`
  ADD CONSTRAINT `manager_monthly_arpu_ibfk_1` FOREIGN KEY (`manager_id`) REFERENCES `managers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `manager_reports`
--
ALTER TABLE `manager_reports`
  ADD CONSTRAINT `manager_reports_ibfk_1` FOREIGN KEY (`manager_id`) REFERENCES `managers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `manager_spv`
--
ALTER TABLE `manager_spv`
  ADD CONSTRAINT `manager_spv_ibfk_1` FOREIGN KEY (`manager_id`) REFERENCES `managers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `manager_spv_ibfk_2` FOREIGN KEY (`spv_id`) REFERENCES `spv` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `manager_strategies`
--
ALTER TABLE `manager_strategies`
  ADD CONSTRAINT `manager_strategies_ibfk_1` FOREIGN KEY (`manager_id`) REFERENCES `managers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `manager_targets`
--
ALTER TABLE `manager_targets`
  ADD CONSTRAINT `manager_targets_ibfk_1` FOREIGN KEY (`manager_id`) REFERENCES `managers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `media`
--
ALTER TABLE `media`
  ADD CONSTRAINT `media_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`partner_id`) REFERENCES `partners` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `order_cancellations`
--
ALTER TABLE `order_cancellations`
  ADD CONSTRAINT `order_cancellations_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_cancellations_ibfk_2` FOREIGN KEY (`cancelled_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_communications`
--
ALTER TABLE `order_communications`
  ADD CONSTRAINT `order_communications_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_communications_ibfk_2` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_communications_ibfk_3` FOREIGN KEY (`recipient_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `order_files`
--
ALTER TABLE `order_files`
  ADD CONSTRAINT `order_files_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_files_ibfk_2` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `order_items_ibfk_3` FOREIGN KEY (`package_id`) REFERENCES `packages` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `order_milestones`
--
ALTER TABLE `order_milestones`
  ADD CONSTRAINT `order_milestones_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_reviews`
--
ALTER TABLE `order_reviews`
  ADD CONSTRAINT `order_reviews_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_reviews_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_status_history`
--
ALTER TABLE `order_status_history`
  ADD CONSTRAINT `order_status_history_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_status_history_ibfk_2` FOREIGN KEY (`changed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `package_services`
--
ALTER TABLE `package_services`
  ADD CONSTRAINT `package_services_ibfk_1` FOREIGN KEY (`package_id`) REFERENCES `packages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `package_services_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `partners`
--
ALTER TABLE `partners`
  ADD CONSTRAINT `partners_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `partner_monthly_stats`
--
ALTER TABLE `partner_monthly_stats`
  ADD CONSTRAINT `partner_monthly_stats_ibfk_1` FOREIGN KEY (`partner_id`) REFERENCES `partners` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `partner_performance`
--
ALTER TABLE `partner_performance`
  ADD CONSTRAINT `partner_performance_ibfk_1` FOREIGN KEY (`partner_id`) REFERENCES `partners` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `partner_tasks`
--
ALTER TABLE `partner_tasks`
  ADD CONSTRAINT `partner_tasks_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `partner_tier_history`
--
ALTER TABLE `partner_tier_history`
  ADD CONSTRAINT `partner_tier_history_ibfk_1` FOREIGN KEY (`partner_id`) REFERENCES `partners` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`verified_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `portfolios`
--
ALTER TABLE `portfolios`
  ADD CONSTRAINT `portfolios_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `portfolios_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `portfolio_images`
--
ALTER TABLE `portfolio_images`
  ADD CONSTRAINT `portfolio_images_ibfk_1` FOREIGN KEY (`portfolio_id`) REFERENCES `portfolios` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `post_tags`
--
ALTER TABLE `post_tags`
  ADD CONSTRAINT `post_tags_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `blog_posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `post_tags_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `blog_tags` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `pricing_tiers`
--
ALTER TABLE `pricing_tiers`
  ADD CONSTRAINT `pricing_tiers_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `referrals`
--
ALTER TABLE `referrals`
  ADD CONSTRAINT `referrals_ibfk_1` FOREIGN KEY (`referrer_id`) REFERENCES `partners` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `referrals_ibfk_2` FOREIGN KEY (`referred_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `refunds`
--
ALTER TABLE `refunds`
  ADD CONSTRAINT `refunds_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `refunds_ibfk_2` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `services`
--
ALTER TABLE `services`
  ADD CONSTRAINT `services_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `business_categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `service_addons`
--
ALTER TABLE `service_addons`
  ADD CONSTRAINT `service_addons_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `service_analytics`
--
ALTER TABLE `service_analytics`
  ADD CONSTRAINT `service_analytics_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `service_faqs`
--
ALTER TABLE `service_faqs`
  ADD CONSTRAINT `service_faqs_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `service_reviews`
--
ALTER TABLE `service_reviews`
  ADD CONSTRAINT `service_reviews_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `service_reviews_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `spv`
--
ALTER TABLE `spv`
  ADD CONSTRAINT `spv_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `spv_bonuses`
--
ALTER TABLE `spv_bonuses`
  ADD CONSTRAINT `spv_bonuses_ibfk_1` FOREIGN KEY (`spv_id`) REFERENCES `spv` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `spv_communications`
--
ALTER TABLE `spv_communications`
  ADD CONSTRAINT `spv_communications_ibfk_1` FOREIGN KEY (`spv_id`) REFERENCES `spv` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `spv_communications_ibfk_2` FOREIGN KEY (`partner_id`) REFERENCES `partners` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `spv_monthly_arpu`
--
ALTER TABLE `spv_monthly_arpu`
  ADD CONSTRAINT `spv_monthly_arpu_ibfk_1` FOREIGN KEY (`spv_id`) REFERENCES `spv` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `spv_partners`
--
ALTER TABLE `spv_partners`
  ADD CONSTRAINT `spv_partners_ibfk_1` FOREIGN KEY (`spv_id`) REFERENCES `spv` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `spv_partners_ibfk_2` FOREIGN KEY (`partner_id`) REFERENCES `partners` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `spv_reports`
--
ALTER TABLE `spv_reports`
  ADD CONSTRAINT `spv_reports_ibfk_1` FOREIGN KEY (`spv_id`) REFERENCES `spv` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `spv_targets`
--
ALTER TABLE `spv_targets`
  ADD CONSTRAINT `spv_targets_ibfk_1` FOREIGN KEY (`spv_id`) REFERENCES `spv` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `spv_team_performance`
--
ALTER TABLE `spv_team_performance`
  ADD CONSTRAINT `spv_team_performance_ibfk_1` FOREIGN KEY (`spv_id`) REFERENCES `spv` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `subscription_payments`
--
ALTER TABLE `subscription_payments`
  ADD CONSTRAINT `subscription_payments_ibfk_1` FOREIGN KEY (`subscription_id`) REFERENCES `client_subscriptions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD CONSTRAINT `support_tickets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `support_tickets_ibfk_2` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `task_applications`
--
ALTER TABLE `task_applications`
  ADD CONSTRAINT `task_applications_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `partner_tasks` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `task_applications_ibfk_2` FOREIGN KEY (`partner_id`) REFERENCES `partners` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `task_reviews`
--
ALTER TABLE `task_reviews`
  ADD CONSTRAINT `task_reviews_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `partner_tasks` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `task_reviews_ibfk_2` FOREIGN KEY (`submission_id`) REFERENCES `task_submissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `task_reviews_ibfk_3` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `task_submissions`
--
ALTER TABLE `task_submissions`
  ADD CONSTRAINT `task_submissions_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `partner_tasks` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `task_submissions_ibfk_2` FOREIGN KEY (`partner_id`) REFERENCES `partners` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `testimonials`
--
ALTER TABLE `testimonials`
  ADD CONSTRAINT `testimonials_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `ticket_messages`
--
ALTER TABLE `ticket_messages`
  ADD CONSTRAINT `ticket_messages_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `support_tickets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ticket_messages_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `user_preferences`
--
ALTER TABLE `user_preferences`
  ADD CONSTRAINT `user_preferences_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_profiles`
--
ALTER TABLE `user_profiles`
  ADD CONSTRAINT `user_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_sessions`
--
ALTER TABLE `user_sessions`
  ADD CONSTRAINT `user_sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `website_types`
--
ALTER TABLE `website_types`
  ADD CONSTRAINT `website_types_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `business_categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `withdrawals`
--
ALTER TABLE `withdrawals`
  ADD CONSTRAINT `withdrawals_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `withdrawal_history`
--
ALTER TABLE `withdrawal_history`
  ADD CONSTRAINT `withdrawal_history_ibfk_1` FOREIGN KEY (`withdrawal_id`) REFERENCES `withdrawals` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
