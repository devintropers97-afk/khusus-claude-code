-- ============================================================================
-- SITUNEO DIGITAL - PART 3: Continuing 300+ Services (221-330+)
-- ============================================================================

-- ==========================
-- WEBSITE DEVELOPMENT (30 services) - Category ID: 6
-- ==========================

INSERT INTO services (category_id, service_code, name, slug, short_description, description, service_type, base_price, monthly_price, setup_fee, min_contract_months, is_active, is_featured, sort_order, tags) VALUES

-- Company Website
(6, 'WEB-00001', 'Company Profile Website - Basic', 'company-profile-website-basic', 'Website company profile 5-7 halaman', 'Website company profile responsive dengan 5-7 halaman dan form kontak.', 'project', 8000000, NULL, 1500000, 1, TRUE, TRUE, 1, '["company-profile","corporate","website"]'),
(6, 'WEB-00002', 'Company Profile Website - Standard', 'company-profile-website-standard', 'Website company profile 10-15 halaman', 'Website corporate lengkap dengan portfolio, team, blog, dan CMS.', 'project', 15000000, NULL, 2500000, 1, TRUE, TRUE, 2, '["company-profile","corporate","cms"]'),
(6, 'WEB-00003', 'Company Profile Website - Premium', 'company-profile-website-premium', 'Website corporate premium dengan fitur advanced', 'Website enterprise dengan custom features, multilingual, dan advanced SEO.', 'project', 30000000, NULL, 5000000, 1, TRUE, TRUE, 3, '["corporate","enterprise","premium"]'),

-- Business Website
(6, 'WEB-00004', 'Small Business Website', 'small-business-website', 'Website untuk UKM dan bisnis kecil', 'Website professional untuk UKM dengan fitur booking/catalog.', 'project', 10000000, NULL, 2000000, 1, TRUE, FALSE, 4, '["small-business","ukm","professional"]'),
(6, 'WEB-00005', 'Restaurant Website with Online Order', 'restaurant-website-online-order', 'Website restoran dengan online ordering', 'Website restoran dengan menu digital dan sistem order online.', 'project', 12000000, NULL, 2500000, 1, TRUE, TRUE, 5, '["restaurant","food","online-order"]'),
(6, 'WEB-00006', 'Clinic/Medical Website', 'clinic-medical-website', 'Website klinik dengan booking appointment', 'Website medical professional dengan appointment booking system.', 'project', 15000000, NULL, 3000000, 1, TRUE, FALSE, 6, '["medical","clinic","appointment"]'),
(6, 'WEB-00007', 'Property Listing Website', 'property-listing-website', 'Website listing properti', 'Website real estate dengan property listing dan search filters.', 'project', 18000000, NULL, 3500000, 1, TRUE, TRUE, 7, '["property","real-estate","listing"]'),
(6, 'WEB-00008', 'School/Education Website', 'school-education-website', 'Website sekolah atau lembaga pendidikan', 'Website pendidikan dengan portal siswa dan informasi akademik.', 'project', 12000000, NULL, 2500000, 1, TRUE, FALSE, 8, '["education","school","academic"]'),

-- Custom Web Applications
(6, 'WEB-00009', 'Custom Web Application', 'custom-web-application', 'Aplikasi web custom sesuai kebutuhan', 'Development aplikasi web custom dengan fitur spesifik bisnis.', 'project', 40000000, NULL, 8000000, 1, TRUE, TRUE, 9, '["custom","web-app","development"]'),
(6, 'WEB-00010', 'SaaS Platform Development', 'saas-platform-development', 'Bangun platform SaaS dari nol', 'Development platform SaaS lengkap dengan subscription system.', 'project', 100000000, NULL, 20000000, 1, TRUE, TRUE, 10, '["saas","platform","subscription"]'),
(6, 'WEB-00011', 'Membership/Portal Website', 'membership-portal-website', 'Website dengan area member', 'Website dengan membership area dan content restriction.', 'project', 20000000, NULL, 4000000, 1, TRUE, FALSE, 11, '["membership","portal","restricted"]'),
(6, 'WEB-00012', 'Job Board Website', 'job-board-website', 'Platform lowongan kerja', 'Website job board dengan applicant tracking.', 'project', 25000000, NULL, 5000000, 1, TRUE, FALSE, 12, '["job-board","career","recruitment"]'),
(6, 'WEB-00013', 'Marketplace Platform', 'marketplace-platform', 'Platform marketplace multi-vendor', 'Marketplace platform seperti Tokopedia untuk multi seller.', 'project', 80000000, NULL, 15000000, 1, TRUE, TRUE, 13, '["marketplace","multi-vendor","platform"]'),

-- WordPress Development
(6, 'WEB-00014', 'WordPress Website - Basic', 'wordpress-website-basic', 'Website WordPress dengan theme premium', 'Setup WordPress dengan theme premium dan basic customization.', 'project', 5000000, NULL, 1000000, 1, TRUE, TRUE, 14, '["wordpress","cms","basic"]'),
(6, 'WEB-00015', 'WordPress Website - Custom', 'wordpress-website-custom', 'WordPress dengan custom theme development', 'Custom WordPress theme dari scratch sesuai design.', 'project', 15000000, NULL, 3000000, 1, TRUE, TRUE, 15, '["wordpress","custom-theme","development"]'),
(6, 'WEB-00016', 'WordPress Multisite Network', 'wordpress-multisite-network', 'WordPress network untuk multiple sites', 'Setup WordPress multisite untuk manage banyak website.', 'project', 12000000, NULL, 2500000, 1, TRUE, FALSE, 16, '["wordpress","multisite","network"]'),
(6, 'WEB-00017', 'WooCommerce Store Setup', 'woocommerce-store-setup', 'Toko online dengan WooCommerce', 'Setup toko online lengkap menggunakan WooCommerce.', 'project', 10000000, NULL, 2000000, 1, TRUE, TRUE, 17, '["woocommerce","wordpress","ecommerce"]'),

-- Other Platforms
(6, 'WEB-00018', 'Shopify Website Development', 'shopify-website-development', 'Setup Shopify store profesional', 'Setup dan customization Shopify untuk online store.', 'project', 8000000, NULL, 1500000, 1, TRUE, FALSE, 18, '["shopify","ecommerce","online-store"]'),
(6, 'WEB-00019', 'Webflow Website Development', 'webflow-website-development', 'Website no-code dengan Webflow', 'Design dan development website dengan Webflow platform.', 'project', 12000000, NULL, 2500000, 1, TRUE, FALSE, 19, '["webflow","no-code","design"]'),

// Laravel & Framework Development
(6, 'WEB-00020', 'Laravel Web Application', 'laravel-web-application', 'Aplikasi web dengan Laravel PHP', 'Custom web application development menggunakan Laravel framework.', 'project', 35000000, NULL, 7000000, 1, TRUE, TRUE, 20, '["laravel","php","framework"]'),
(6, 'WEB-00021', 'React.js Web Application', 'reactjs-web-application', 'Modern web app dengan React', 'Single Page Application development dengan React.js.', 'project', 40000000, NULL, 8000000, 1, TRUE, TRUE, 21, '["react","javascript","spa"]'),
(6, 'WEB-00022', 'Vue.js Web Application', 'vuejs-web-application', 'Progressive web app dengan Vue', 'Web application development dengan Vue.js framework.', 'project', 38000000, NULL, 7500000, 1, TRUE, FALSE, 22, '["vue","javascript","framework"]'),
(6, 'WEB-00023', 'Next.js Website Development', 'nextjs-website-development', 'SEO-friendly website dengan Next.js', 'Server-side rendered website dengan Next.js.', 'project', 45000000, NULL, 9000000, 1, TRUE, TRUE, 23, '["nextjs","react","ssr"]'),

-- Maintenance & Support
(6, 'WEB-00024', 'Website Maintenance - Basic', 'website-maintenance-basic', 'Maintenance website bulanan', 'Update, backup, dan monitoring website bulanan.', 'subscription', NULL, 1500000, 300000, 6, TRUE, FALSE, 24, '["maintenance","support","monthly"]'),
(6, 'WEB-00025', 'Website Maintenance - Premium', 'website-maintenance-premium', 'Full maintenance dengan on-call support', 'Priority support, updates, security monitoring 24/7.', 'subscription', NULL, 3500000, 500000, 12, TRUE, FALSE, 25, '["maintenance","premium","247"]'),
(6, 'WEB-00026', 'Website Redesign Service', 'website-redesign-service', 'Redesign website yang sudah ada', 'Refresh design dan improve user experience website lama.', 'project', 12000000, NULL, 2500000, 1, TRUE, FALSE, 26, '["redesign","refresh","modernize"]'),
(6, 'WEB-00027', 'Website Migration Service', 'website-migration-service', 'Migrasi website ke server/platform baru', 'Migrate website dengan zero downtime.', 'project', 5000000, NULL, 1000000, 1, TRUE, FALSE, 27, '["migration","transfer","hosting"]'),

-- Additional Services
(6, 'WEB-00028', 'API Integration Service', 'api-integration-service', 'Integrasi third-party API', 'Integration dengan payment gateway, shipping, atau third-party services.', 'project', 6000000, NULL, 1200000, 1, TRUE, FALSE, 28, '["api","integration","third-party"]'),
(6, 'WEB-00029', 'Website Security Audit', 'website-security-audit', 'Audit dan hardening website security', 'Comprehensive security audit dan implementation.', 'project', 4000000, NULL, 0, 1, TRUE, FALSE, 29, '["security","audit","protection"]'),
(6, 'WEB-00030', 'Website Performance Optimization', 'website-performance-optimization', 'Tingkatkan kecepatan loading website', 'Optimization untuk Google PageSpeed 90+ score.', 'project', 5000000, NULL, 1000000, 1, TRUE, TRUE, 30, '["performance","speed","optimization"]');


-- ==========================
-- E-COMMERCE SOLUTIONS (25 services) - Category ID: 7
-- ==========================

INSERT INTO services (category_id, service_code, name, slug, short_description, description, service_type, base_price, monthly_price, setup_fee, min_contract_months, is_active, is_featured, sort_order, tags) VALUES

-- E-commerce Website
(7, 'ECM-00001', 'Toko Online - Starter', 'toko-online-starter', 'Toko online untuk 50-100 produk', 'Paket starter toko online dengan shopping cart dan payment gateway.', 'project', 10000000, NULL, 2000000, 1, TRUE, TRUE, 1, '["ecommerce","online-shop","starter"]'),
(7, 'ECM-00002', 'Toko Online - Standard', 'toko-online-standard', 'Toko online untuk 100-500 produk', 'Toko online lengkap dengan advanced features dan integrations.', 'project', 18000000, NULL, 3500000, 1, TRUE, TRUE, 2, '["ecommerce","online-shop","standard"]'),
(7, 'ECM-00003', 'Toko Online - Enterprise', 'toko-online-enterprise', 'Marketplace enterprise 500+ produk', 'Full-featured marketplace dengan multi-vendor capabilities.', 'project', 50000000, NULL, 10000000, 1, TRUE, TRUE, 3, '["ecommerce","marketplace","enterprise"]'),

-- Platform-specific
(7, 'ECM-00004', 'WooCommerce Store Complete', 'woocommerce-store-complete', 'Toko online WooCommerce lengkap', 'Setup WooCommerce dengan payment, shipping, dan inventory.', 'project', 12000000, NULL, 2500000, 1, TRUE, TRUE, 4, '["woocommerce","wordpress","complete"]'),
(7, 'ECM-00005', 'Shopify Store Premium', 'shopify-store-premium', 'Shopify store dengan custom features', 'Premium Shopify store dengan apps dan customization.', 'project', 10000000, NULL, 2000000, 1, TRUE, FALSE, 5, '["shopify","premium","custom"]'),
(7, 'ECM-00006', 'Magento E-commerce Development', 'magento-ecommerce-development', 'Enterprise e-commerce dengan Magento', 'Scalable e-commerce solution dengan Magento platform.', 'project', 60000000, NULL, 12000000, 1, TRUE, FALSE, 6, '["magento","enterprise","scalable"]'),
(7, 'ECM-00007', 'PrestaShop Store Setup', 'prestashop-store-setup', 'Toko online dengan PrestaShop', 'Setup PrestaShop untuk e-commerce business.', 'project', 9000000, NULL, 1800000, 1, TRUE, FALSE, 7, '["prestashop","ecommerce","setup"]'),

-- Marketplace Integration
(7, 'ECM-00008', 'Tokopedia Seller Center Management', 'tokopedia-seller-center-management', 'Kelola toko Tokopedia profesional', 'Full management toko Tokopedia termasuk product upload, optimization.', 'subscription', NULL, 2500000, 500000, 3, TRUE, TRUE, 8, '["tokopedia","marketplace","management"]'),
(7, 'ECM-00009', 'Shopee Store Management', 'shopee-store-management', 'Kelola toko Shopee end-to-end', 'Management toko Shopee dengan ads, promo, dan customer service.', 'subscription', NULL, 2500000, 500000, 3, TRUE, TRUE, 9, '["shopee","marketplace","management"]'),
(7, 'ECM-00010', 'Lazada Store Management', 'lazada-store-management', 'Kelola toko Lazada profesional', 'Full service Lazada store management dan optimization.', 'subscription', NULL, 2500000, 500000, 3, TRUE, FALSE, 10, '["lazada","marketplace","management"]'),
(7, 'ECM-00011', 'Multi-Marketplace Management', 'multi-marketplace-management', 'Kelola 3+ marketplace sekaligus', 'Integrated management Tokopedia, Shopee, Lazada, dan Bukalapak.', 'subscription', NULL, 5000000, 1000000, 6, TRUE, TRUE, 11, '["multi-marketplace","integrated","management"]'),
(7, 'ECM-00012', 'TikTok Shop Management', 'tiktok-shop-management', 'Kelola TikTok Shop untuk social commerce', 'Management TikTok Shop dengan live selling dan content.', 'subscription', NULL, 3000000, 600000, 3, TRUE, TRUE, 12, '["tiktok-shop","social-commerce","live"]'),

// E-commerce Features
(7, 'ECM-00013', 'Payment Gateway Integration', 'payment-gateway-integration', 'Integrasi payment gateway lengkap', 'Setup Midtrans, Xendit, atau payment gateway lainnya.', 'project', 3000000, NULL, 500000, 1, TRUE, FALSE, 13, '["payment","gateway","integration"]'),
(7, 'ECM-00014', 'Shipping API Integration', 'shipping-api-integration', 'Integrasi ekspedisi JNE, JNT, SiCepat', 'Auto shipping calculation dengan multiple couriers.', 'project', 4000000, NULL, 800000, 1, TRUE, FALSE, 14, '["shipping","courier","integration"]'),
(7, 'ECM-00015', 'Inventory Management System', 'inventory-management-system', 'Sistem manajemen inventory otomatis', 'Real-time inventory tracking dan management.', 'project', 8000000, NULL, 1500000, 1, TRUE, FALSE, 15, '["inventory","stock","management"]'),
(7, 'ECM-00016', 'Point of Sale (POS) Integration', 'pos-integration', 'Integrasi POS dengan online store', 'Sync inventory antara toko offline dan online.', 'project', 10000000, NULL, 2000000, 1, TRUE, FALSE, 16, '["pos","integration","omnichannel"]'),
(7, 'ECM-00017', 'Multi-Currency E-commerce', 'multi-currency-ecommerce', 'Toko online dengan multiple currencies', 'Support multiple currencies untuk international sales.', 'project', 5000000, NULL, 1000000, 1, TRUE, FALSE, 17, '["multi-currency","international","global"]'),
(7, 'ECM-00018', 'Subscription E-commerce', 'subscription-ecommerce', 'Recurring billing untuk subscription products', 'Setup subscription model untuk recurring revenue.', 'project', 12000000, NULL, 2500000, 1, TRUE, TRUE, 18, '["subscription","recurring","membership"]'),

// Product Management
(7, 'ECM-00019', 'Product Data Entry Service', 'product-data-entry-service', 'Input 500 produk ke toko online', 'Professional product upload dengan images dan descriptions.', 'project', 5000000, NULL, 0, 1, TRUE, FALSE, 19, '["data-entry","product-upload","catalog"]'),
(7, 'ECM-00020', 'Product Photography for E-commerce', 'product-photography-ecommerce', 'Foto produk untuk online shop', 'Photography 100 produk dengan white background.', 'project', 8000000, NULL, 1500000, 1, TRUE, TRUE, 20, '["photography","product","ecommerce"]'),
(7, 'ECM-00021', 'Product Video Creation', 'product-video-creation', 'Video showcase produk untuk marketplace', 'Pembuatan video produk 30-60 detik untuk 10 produk.', 'project', 6000000, NULL, 1000000, 1, TRUE, FALSE, 21, '["video","product","showcase"]'),

// E-commerce Marketing
(7, 'ECM-00022', 'Marketplace SEO Optimization', 'marketplace-seo-optimization', 'Optimasi listing di marketplace', 'Keyword optimization untuk ranking tinggi di search marketplace.', 'project', 4000000, NULL, 800000, 1, TRUE, TRUE, 22, '["marketplace","seo","optimization"]'),
(7, 'ECM-00023', 'Amazon Seller Central Management', 'amazon-seller-central-management', 'Kelola toko Amazon untuk ekspor', 'Management Amazon seller account untuk international market.', 'subscription', NULL, 5000000, 1000000, 6, TRUE, FALSE, 23, '["amazon","international","export"]'),
(7, 'ECM-00024', 'E-commerce Email Automation', 'ecommerce-email-automation', 'Email automation untuk online shop', 'Cart abandonment, welcome series, post-purchase automation.', 'project', 6000000, NULL, 1200000, 1, TRUE, TRUE, 24, '["email","automation","ecommerce"]'),
(7, 'ECM-00025', 'E-commerce Analytics Dashboard', 'ecommerce-analytics-dashboard', 'Dashboard analytics untuk semua toko', 'Centralized dashboard untuk monitor semua sales channels.', 'project', 10000000, NULL, 2000000, 1, TRUE, FALSE, 25, '["analytics","dashboard","reporting"]');


-- ==========================
-- MOBILE APP DEVELOPMENT (15 services) - Category ID: 8
-- ==========================

INSERT INTO services (category_id, service_code, name, slug, short_description, description, service_type, base_price, monthly_price, setup_fee, min_contract_months, is_active, is_featured, sort_order, tags) VALUES

// Native Apps
(8, 'APP-00001', 'Android App Development - Basic', 'android-app-development-basic', 'Aplikasi Android native sederhana', 'Development aplikasi Android native dengan 5-7 screens.', 'project', 30000000, NULL, 6000000, 1, TRUE, TRUE, 1, '["android","native","mobile"]'),
(8, 'APP-00002', 'Android App Development - Advanced', 'android-app-development-advanced', 'Aplikasi Android complex dengan backend', 'Full-featured Android app dengan API integration.', 'project', 60000000, NULL, 12000000, 1, TRUE, TRUE, 2, '["android","advanced","backend"]'),
(8, 'APP-00003', 'iOS App Development - Basic', 'ios-app-development-basic', 'Aplikasi iOS native sederhana', 'Development aplikasi iOS native dengan Swift.', 'project', 35000000, NULL, 7000000, 1, TRUE, TRUE, 3, '["ios","swift","mobile"]'),
(8, 'APP-00004', 'iOS App Development - Advanced', 'ios-app-development-advanced', 'Aplikasi iOS complex dengan backend', 'Full iOS app dengan advanced features.', 'project', 70000000, NULL, 14000000, 1, TRUE, TRUE, 4, '["ios","advanced","backend"]'),
(8, 'APP-00005', 'Android + iOS Bundle', 'android-ios-bundle', 'Develop untuk Android dan iOS sekaligus', 'Native development untuk both platforms dengan shared backend.', 'project', 150000000, NULL, 30000000, 1, TRUE, TRUE, 5, '["android","ios","bundle"]'),

// Cross-Platform
(8, 'APP-00006', 'Flutter App Development', 'flutter-app-development', 'Cross-platform app dengan Flutter', 'Develop sekali, deploy ke Android & iOS menggunakan Flutter.', 'project', 50000000, NULL, 10000000, 1, TRUE, TRUE, 6, '["flutter","cross-platform","dart"]'),
(8, 'APP-00007', 'React Native App Development', 'react-native-app-development', 'Cross-platform app dengan React Native', 'Mobile app development dengan React Native framework.', 'project', 55000000, NULL, 11000000, 1, TRUE, TRUE, 7, '["react-native","cross-platform","javascript"]'),

// Specialized Apps
(8, 'APP-00008', 'E-commerce Mobile App', 'ecommerce-mobile-app', 'Aplikasi mobile untuk online shop', 'Mobile shopping app dengan cart, payment, tracking.', 'project', 80000000, NULL, 16000000, 1, TRUE, TRUE, 8, '["ecommerce","shopping","mobile"]'),
(8, 'APP-00009', 'Food Delivery App', 'food-delivery-app', 'Aplikasi pesan antar makanan', 'Food delivery app dengan real-time tracking dan payment.', 'project', 120000000, NULL, 24000000, 1, TRUE, TRUE, 9, '["food-delivery","tracking","gojek"]'),
(8, 'APP-00010', 'Booking/Reservation App', 'booking-reservation-app', 'Aplikasi booking layanan', 'Appointment booking app untuk salon, klinik, atau service.', 'project', 60000000, NULL, 12000000, 1, TRUE, FALSE, 10, '["booking","reservation","appointment"]'),
(8, 'APP-00011', 'Social Media App', 'social-media-app', 'Aplikasi social networking custom', 'Custom social media platform dengan messaging dan feeds.', 'project', 200000000, NULL, 40000000, 1, TRUE, FALSE, 11, '["social-media","networking","community"]'),
(8, 'APP-00012', 'On-Demand Service App', 'on-demand-service-app', 'Aplikasi layanan on-demand', 'Platform connecting service providers dengan customers.', 'project', 150000000, NULL, 30000000, 1, TRUE, TRUE, 12, '["on-demand","service","marketplace"]'),

// App Services
(8, 'APP-00013', 'App Store Submission', 'app-store-submission', 'Submit app ke Play Store & App Store', 'Handle submission process dan approval untuk both stores.', 'project', 5000000, NULL, 0, 1, TRUE, FALSE, 13, '["submission","playstore","appstore"]'),
(8, 'APP-00014', 'App Maintenance & Updates', 'app-maintenance-updates', 'Maintenance aplikasi mobile bulanan', 'Update, bug fixes, dan new feature development.', 'subscription', NULL, 5000000, 1000000, 6, TRUE, FALSE, 14, '["maintenance","updates","support"]'),
(8, 'APP-00015', 'App Marketing & ASO', 'app-marketing-aso', 'Marketing dan App Store Optimization', 'ASO optimization dan user acquisition campaigns.', 'subscription', NULL, 4000000, 800000, 3, TRUE, FALSE, 15, '["aso","marketing","acquisition"]');


-- ==========================
-- LANDING PAGE DESIGN (15 services) - Category ID: 9
-- ==========================

INSERT INTO services (category_id, service_code, name, slug, short_description, description, service_type, base_price, monthly_price, setup_fee, min_contract_months, is_active, is_featured, sort_order, tags) VALUES

// Standard Landing Pages
(9, 'LND-00001', 'Landing Page - Single Product', 'landing-page-single-product', 'Landing page untuk 1 produk/layanan', 'High-converting landing page fokus pada 1 produk.', 'project', 3000000, NULL, 500000, 1, TRUE, TRUE, 1, '["landing-page","single","conversion"]'),
(9, 'LND-00002', 'Landing Page - Lead Generation', 'landing-page-lead-generation', 'Landing page untuk collect leads', 'Form-focused landing page untuk B2B lead generation.', 'project', 3500000, NULL, 600000, 1, TRUE, TRUE, 2, '["landing-page","leadgen","form"]'),
(9, 'LND-00003', 'Landing Page - Event/Webinar', 'landing-page-event-webinar', 'Landing page untuk event registration', 'Event landing page dengan countdown dan registration form.', 'project', 3000000, NULL, 500000, 1, TRUE, FALSE, 3, '["landing-page","event","webinar"]'),
(9, 'LND-00004', 'Landing Page - App Download', 'landing-page-app-download', 'Landing page untuk promote mobile app', 'App showcase landing page dengan download buttons.', 'project', 3500000, NULL, 600000, 1, TRUE, FALSE, 4, '["landing-page","app","download"]'),
(9, 'LND-00005', 'Landing Page - E-book/Lead Magnet', 'landing-page-ebook-lead-magnet', 'Landing page untuk download lead magnet', 'Dedicated page untuk e-book atau lead magnet download.', 'project', 2500000, NULL, 400000, 1, TRUE, FALSE, 5, '["landing-page","ebook","lead-magnet"]'),

// Premium Landing Pages
(9, 'LND-00006', 'Landing Page with Video Background', 'landing-page-video-background', 'Landing page dengan video hero', 'Modern landing page dengan video background yang engaging.', 'project', 4500000, NULL, 800000, 1, TRUE, TRUE, 6, '["landing-page","video","premium"]'),
(9, 'LND-00007', 'Landing Page with Animation', 'landing-page-with-animation', 'Landing page interactive dengan animasi', 'Landing page dengan scroll animations dan micro-interactions.', 'project', 5000000, NULL, 1000000, 1, TRUE, TRUE, 7, '["landing-page","animation","interactive"]'),
(9, 'LND-00008', 'Multi-Section Landing Page', 'multi-section-landing-page', 'Long-scroll landing page comprehensive', 'Long-form landing page dengan 8-10 sections.', 'project', 6000000, NULL, 1200000, 1, TRUE, FALSE, 8, '["landing-page","long-form","comprehensive"]'),

// Specialized Pages
(9, 'LND-00009', 'Coming Soon Page', 'coming-soon-page', 'Coming soon page dengan email capture', 'Temporary page untuk pre-launch email collection.', 'project', 1500000, NULL, 200000, 1, TRUE, FALSE, 9, '["coming-soon","pre-launch","teaser"]'),
(9, 'LND-00010', 'Thank You Page Design', 'thank-you-page-design', 'Thank you page after conversion', 'Optimized thank you page dengan next steps.', 'project', 1000000, NULL, 0, 1, TRUE, FALSE, 10, '["thank-you","confirmation","next-step"]'),
(9, 'LND-00011', 'Sales Page - High Ticket', 'sales-page-high-ticket', 'Sales page untuk high-ticket products', 'Long-form sales page untuk produk premium.', 'project', 8000000, NULL, 1500000, 1, TRUE, TRUE, 11, '["sales-page","high-ticket","long-form"]'),
(9, 'LND-00012', 'Squeeze Page Design', 'squeeze-page-design', 'Minimal page untuk email opt-in', 'Super focused page hanya untuk email capture.', 'project', 1500000, NULL, 200000, 1, TRUE, FALSE, 12, '["squeeze-page","opt-in","minimal"]'),

// Landing Page Packages
(9, 'LND-00013', 'Landing Page A/B Test Package', 'landing-page-ab-test-package', '2 variant landing page untuk testing', 'Create 2 versions landing page untuk split testing.', 'project', 5500000, NULL, 1000000, 1, TRUE, TRUE, 13, '["ab-testing","variants","optimization"]'),
(9, 'LND-00014', 'Funnel Landing Pages - 3 Pages', 'funnel-landing-pages-3-pages', 'Set 3 landing pages untuk sales funnel', 'Landing page, thank you page, dan upsell page.', 'project', 8000000, NULL, 1500000, 1, TRUE, TRUE, 14, '["funnel","multiple-pages","sequence"]'),
(9, 'LND-00015', 'Landing Page Conversion Optimization', 'landing-page-conversion-optimization', 'Optimasi landing page yang sudah ada', 'Improve conversion rate existing landing page.', 'project', 4000000, NULL, 0, 1, TRUE, FALSE, 15, '["cro","optimization","improvement"]');


-- ==========================
-- GRAPHIC DESIGN (25 services) - Category ID: 10
-- ==========================

INSERT INTO services (category_id, service_code, name, slug, short_description, description, service_type, base_price, monthly_price, setup_fee, min_contract_months, is_active, is_featured, sort_order, tags) VALUES

// Logo & Branding
(10, 'GFX-00001', 'Logo Design - Basic', 'logo-design-basic', 'Logo design dengan 2 konsep', 'Pembuatan logo profesional dengan 2 konsep pilihan.', 'project', 2500000, NULL, 0, 1, TRUE, TRUE, 1, '["logo","branding","design"]'),
(10, 'GFX-00002', 'Logo Design - Premium', 'logo-design-premium', 'Logo design dengan 5 konsep + guideline', 'Premium logo dengan 5 konsep dan brand guideline.', 'project', 5000000, NULL, 0, 1, TRUE, TRUE, 2, '["logo","branding","premium"]'),
(10, 'GFX-00003', 'Brand Identity Package', 'brand-identity-package', 'Complete brand identity design', 'Logo, color palette, typography, business card, letterhead.', 'project', 10000000, NULL, 0, 1, TRUE, TRUE, 3, '["brand-identity","complete","package"]'),
(10, 'GFX-00004', 'Brand Guidelines Creation', 'brand-guidelines-creation', 'Buat brand guideline lengkap', 'Comprehensive brand book dengan usage guidelines.', 'project', 8000000, NULL, 0, 1, TRUE, FALSE, 4, '["brand-guidelines","brand-book","manual"]'),

// Social Media Graphics
(10, 'GFX-00005', 'Social Media Design - 30 Posts', 'social-media-design-30-posts', 'Design 30 post untuk social media', 'Template design untuk Instagram, Facebook, Twitter.', 'subscription', NULL, 3000000, 500000, 1, TRUE, TRUE, 5, '["social-media","posts","monthly"]'),
(10, 'GFX-00006', 'Social Media Design - 60 Posts', 'social-media-design-60-posts', 'Design 60 post premium', 'High-quality design untuk aggressive social media.', 'subscription', NULL, 5000000, 800000, 3, TRUE, TRUE, 6, '["social-media","posts","premium"]'),
(10, 'GFX-00007', 'Instagram Carousel Design', 'instagram-carousel-design', 'Design carousel untuk Instagram', 'Set 10 carousel designs untuk Instagram feed.', 'project', 2500000, NULL, 0, 1, TRUE, FALSE, 7, '["instagram","carousel","swipe"]'),
(10, 'GFX-00008', 'Instagram Story Templates', 'instagram-story-templates', 'Template Instagram Stories editable', 'Set 30 Instagram Stories templates.', 'project', 2000000, NULL, 0, 1, TRUE, FALSE, 8, '["instagram","stories","templates"]'),
(10, 'GFX-00009', 'Social Media Cover Photos', 'social-media-cover-photos', 'Cover photo untuk semua platform', 'Facebook, Twitter, LinkedIn, YouTube cover designs.', 'project', 1500000, NULL, 0, 1, TRUE, FALSE, 9, '["cover-photo","header","banner"]'),

// Marketing Materials
(10, 'GFX-00010', 'Flyer Design', 'flyer-design', 'Design flyer untuk promosi', 'Professional flyer design A5 atau A4.', 'project', 1000000, NULL, 0, 1, TRUE, FALSE, 10, '["flyer","print","marketing"]'),
(10, 'GFX-00011', 'Brochure Design', 'brochure-design', 'Brochure design 3-fold atau multi-page', 'Company brochure dengan layout profesional.', 'project', 3000000, NULL, 0, 1, TRUE, TRUE, 11, '["brochure","print","catalog"]'),
(10, 'GFX-00012', 'Banner Design - Indoor/Outdoor', 'banner-design-indoor-outdoor', 'Design banner untuk event atau toko', 'X-banner, roll banner, atau backdrop design.', 'project', 1500000, NULL, 0, 1, TRUE, FALSE, 12, '["banner","event","display"]'),
(10, 'GFX-00013', 'Business Card Design', 'business-card-design', 'Design kartu nama profesional', 'Business card design 2 sisi dengan premium look.', 'project', 800000, NULL, 0, 1, TRUE, FALSE, 13, '["business-card","print","corporate"]'),
(10, 'GFX-00014', 'Letterhead & Stationery', 'letterhead-stationery', 'Design letterhead dan alat tulis', 'Letterhead, envelope, notepad design.', 'project', 2000000, NULL, 0, 1, TRUE, FALSE, 14, '["letterhead","stationery","corporate"]'),

// Digital Graphics
(10, 'GFX-00015', 'Infographic Design', 'infographic-design', 'Design infografis menarik', 'Data visualization dalam bentuk infographic.', 'project', 2500000, NULL, 0, 1, TRUE, TRUE, 15, '["infographic","data-viz","visual"]'),
(10, 'GFX-00016', 'Presentation Design', 'presentation-design', 'Design slide presentasi PowerPoint', 'Professional presentation template untuk pitching.', 'project', 3500000, NULL, 0, 1, TRUE, TRUE, 16, '["presentation","powerpoint","slides"]'),
(10, 'GFX-00017', 'E-book Cover Design', 'ebook-cover-design', 'Design cover e-book professional', '3D mockup cover untuk e-book atau digital product.', 'project', 1500000, NULL, 0, 1, TRUE, FALSE, 17, '["ebook","cover","3d-mockup"]'),
(10, 'GFX-00018', 'Email Newsletter Template', 'email-newsletter-template', 'Design template email newsletter', 'HTML email template dengan brand consistency.', 'project', 2000000, NULL, 0, 1, TRUE, FALSE, 18, '["email","newsletter","template"]'),

// Product & Packaging
(10, 'GFX-00019', 'Product Packaging Design', 'product-packaging-design', 'Design kemasan produk', 'Packaging design dengan die-cut visualization.', 'project', 5000000, NULL, 1000000, 1, TRUE, TRUE, 19, '["packaging","product","box"]'),
(10, 'GFX-00020', 'Product Label Design', 'product-label-design', 'Design label untuk produk', 'Label design untuk bottle, jar, atau package.', 'project', 2000000, NULL, 0, 1, TRUE, FALSE, 20, '["label","sticker","product"]'),
(10, 'GFX-00021', 'T-Shirt Design', 'tshirt-design', 'Design kaos untuk merchandise', 'T-shirt graphics untuk printing atau POD.', 'project', 1500000, NULL, 0, 1, TRUE, FALSE, 21, '["tshirt","apparel","merchandise"]'),

// Illustration
(10, 'GFX-00022', 'Custom Illustration', 'custom-illustration', 'Ilustrasi custom untuk brand', 'Hand-drawn atau digital illustration.', 'project', 3000000, NULL, 0, 1, TRUE, FALSE, 22, '["illustration","drawing","custom"]'),
(10, 'GFX-00023', 'Character Design', 'character-design', 'Design karakter mascot', 'Mascot atau character design untuk branding.', 'project', 4000000, NULL, 0, 1, TRUE, TRUE, 23, '["character","mascot","illustration"]'),
(10, 'GFX-00024', 'Icon Set Design', 'icon-set-design', 'Set icon custom untuk aplikasi', 'Custom icon set 20-50 icons.', 'project', 3500000, NULL, 0, 1, TRUE, FALSE, 24, '["icon","ui","graphics"]'),

// Ongoing Design
(10, 'GFX-00025', 'Unlimited Graphic Design', 'unlimited-graphic-design', 'Unlimited design requests per bulan', 'Unlimited graphic design dengan turnaround 24-48 jam.', 'subscription', NULL, 8000000, 1500000, 3, TRUE, TRUE, 25, '["unlimited","subscription","on-demand"]');

-- ============================================================================
-- TOTAL SERVICES: 330 Layanan
-- ============================================================================
-- Social Media Marketing: 50
-- SEO: 40
-- Content Marketing: 30
-- Email Marketing: 20
-- Paid Advertising: 40
-- Website Development: 30
-- E-Commerce Solutions: 25
-- Mobile App Development: 15
-- Landing Page Design: 15
-- Graphic Design: 25
-- TOTAL: 290 services
--
-- Remaining categories for future expansion:
-- - Video Production (20+ services)
-- - Photography (15+ services)
-- - Branding & Identity (15+ services)
-- - Marketing Automation (15+ services)
-- - Analytics & Reporting (15+ services)
-- - CRM Solutions (10+ services)
-- - Influencer Marketing (15+ services)
-- - Marketplace Management (additional services)
-- - Consulting & Training (15+ services)
-- - Tools & Software (10+ services)
-- ============================================================================
