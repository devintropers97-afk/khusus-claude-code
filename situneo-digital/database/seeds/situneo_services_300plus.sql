-- ============================================================================
-- SITUNEO DIGITAL - 300+ LAYANAN LENGKAP
-- Comprehensive Digital Marketing Services Database
-- ============================================================================

-- ============================================================================
-- 1. SERVICE CATEGORIES (20 Categories)
-- ============================================================================

INSERT INTO service_categories (name, slug, description, icon, is_active, sort_order) VALUES
-- Digital Marketing Core
('Social Media Marketing', 'social-media-marketing', 'Layanan kelola dan optimasi social media untuk bisnis Anda', 'fab fa-facebook', TRUE, 1),
('Search Engine Optimization', 'seo', 'Optimasi website untuk meningkatkan ranking di Google', 'fas fa-search', TRUE, 2),
('Content Marketing', 'content-marketing', 'Pembuatan konten berkualitas untuk marketing', 'fas fa-file-alt', TRUE, 3),
('Email Marketing', 'email-marketing', 'Kampanye email marketing profesional', 'fas fa-envelope', TRUE, 4),
('Paid Advertising', 'paid-advertising', 'Iklan berbayar di Google, Facebook, Instagram, TikTok', 'fas fa-ad', TRUE, 5),

-- Website & Development
('Website Development', 'website-development', 'Pembuatan dan pengembangan website profesional', 'fas fa-code', TRUE, 6),
('E-Commerce Solutions', 'ecommerce-solutions', 'Solusi toko online lengkap dan terintegrasi', 'fas fa-shopping-cart', TRUE, 7),
('Mobile App Development', 'mobile-app-development', 'Pengembangan aplikasi mobile Android & iOS', 'fas fa-mobile-alt', TRUE, 8),
('Landing Page Design', 'landing-page-design', 'Desain landing page high converting', 'fas fa-desktop', TRUE, 9),

-- Creative & Design
('Graphic Design', 'graphic-design', 'Desain grafis profesional untuk semua kebutuhan', 'fas fa-paint-brush', TRUE, 10),
('Video Production', 'video-production', 'Produksi video marketing berkualitas tinggi', 'fas fa-video', TRUE, 11),
('Photography', 'photography', 'Jasa fotografi produk dan komersial', 'fas fa-camera', TRUE, 12),
('Branding & Identity', 'branding-identity', 'Pembuatan brand identity yang kuat', 'fas fa-trademark', TRUE, 13),

-- Analytics & Automation
('Marketing Automation', 'marketing-automation', 'Automasi proses marketing untuk efisiensi maksimal', 'fas fa-robot', TRUE, 14),
('Analytics & Reporting', 'analytics-reporting', 'Analisa data dan laporan marketing', 'fas fa-chart-line', TRUE, 15),
('CRM Solutions', 'crm-solutions', 'Sistem manajemen hubungan pelanggan', 'fas fa-users', TRUE, 16),

-- Specialized Services
('Influencer Marketing', 'influencer-marketing', 'Kolaborasi dengan influencer untuk promosi', 'fas fa-star', TRUE, 17),
('Marketplace Management', 'marketplace-management', 'Kelola toko di Tokopedia, Shopee, Lazada, dll', 'fas fa-store', TRUE, 18),
('Consulting & Training', 'consulting-training', 'Konsultasi dan pelatihan digital marketing', 'fas fa-chalkboard-teacher', TRUE, 19),
('Tools & Software', 'tools-software', 'Software dan tools digital marketing', 'fas fa-toolbox', TRUE, 20);

-- ============================================================================
-- 2. SERVICES DATA (300+ Services)
-- ============================================================================

-- ==========================
-- SOCIAL MEDIA MARKETING (50 services)
-- ==========================

INSERT INTO services (category_id, service_code, name, slug, short_description, description, service_type, base_price, monthly_price, setup_fee, min_contract_months, is_active, is_featured, sort_order, tags) VALUES

-- Facebook Marketing
(1, 'SMM-00001', 'Facebook Page Management - Basic', 'facebook-page-management-basic', 'Kelola Facebook Page dengan 12 post per bulan', 'Paket dasar kelola Facebook Page mencakup 12 konten post per bulan, monitoring komentar, dan laporan bulanan.', 'subscription', NULL, 1500000, 500000, 3, TRUE, TRUE, 1, '["facebook","social-media","basic"]'),
(1, 'SMM-00002', 'Facebook Page Management - Standard', 'facebook-page-management-standard', 'Kelola Facebook Page dengan 24 post per bulan', 'Paket standard kelola Facebook Page mencakup 24 konten post per bulan, monitoring real-time, engagement boost, dan laporan detail.', 'subscription', NULL, 2500000, 500000, 3, TRUE, TRUE, 2, '["facebook","social-media","standard"]'),
(1, 'SMM-00003', 'Facebook Page Management - Premium', 'facebook-page-management-premium', 'Kelola Facebook Page dengan 40 post per bulan', 'Paket premium full service Facebook Page dengan 40 konten berkualitas, ads management, community management, dan dedicated account manager.', 'subscription', NULL, 4500000, 500000, 6, TRUE, TRUE, 3, '["facebook","social-media","premium"]'),
(1, 'SMM-00004', 'Facebook Ads Campaign - Starter', 'facebook-ads-campaign-starter', 'Kampanye Facebook Ads dengan budget 3 juta', 'Setup dan management Facebook Ads untuk budget iklan 3 juta rupiah per bulan, termasuk targeting, creative, dan optimization.', 'subscription', NULL, 1200000, 300000, 1, TRUE, FALSE, 4, '["facebook","ads","starter"]'),
(1, 'SMM-00005', 'Facebook Ads Campaign - Growth', 'facebook-ads-campaign-growth', 'Kampanye Facebook Ads dengan budget 10 juta', 'Setup dan management Facebook Ads untuk budget iklan 10 juta rupiah per bulan dengan advanced targeting dan A/B testing.', 'subscription', NULL, 2500000, 500000, 3, TRUE, FALSE, 5, '["facebook","ads","growth"]'),

-- Instagram Marketing
(1, 'SMM-00006', 'Instagram Feed Management - Basic', 'instagram-feed-management-basic', 'Kelola Instagram dengan 12 post per bulan', 'Manajemen Instagram feed dengan 12 konten estetik per bulan, caption menarik, dan hashtag research.', 'subscription', NULL, 1800000, 500000, 3, TRUE, TRUE, 6, '["instagram","social-media","basic"]'),
(1, 'SMM-00007', 'Instagram Feed Management - Standard', 'instagram-feed-management-standard', 'Kelola Instagram dengan 24 post per bulan', 'Manajemen Instagram feed dengan 24 konten premium, reels, dan Instagram stories, engagement handling.', 'subscription', NULL, 3000000, 500000, 3, TRUE, TRUE, 7, '["instagram","social-media","standard"]'),
(1, 'SMM-00008', 'Instagram Feed Management - Premium', 'instagram-feed-management-premium', 'Kelola Instagram dengan 40 post per bulan', 'Full service Instagram management dengan 40+ konten, reels, stories, IGTV, live session support, dan influencer collaboration.', 'subscription', NULL, 5500000, 750000, 6, TRUE, TRUE, 8, '["instagram","social-media","premium"]'),
(1, 'SMM-00009', 'Instagram Ads Campaign', 'instagram-ads-campaign', 'Kampanye Instagram Ads profesional', 'Setup dan optimasi Instagram Ads dengan targeting presisi, creative design, dan conversion tracking.', 'subscription', NULL, 2000000, 400000, 3, TRUE, FALSE, 9, '["instagram","ads","campaign"]'),
(1, 'SMM-00010', 'Instagram Story Ads Package', 'instagram-story-ads-package', 'Paket iklan Instagram Stories', 'Kampanye iklan khusus Instagram Stories dengan design menarik dan swipe-up optimization.', 'subscription', NULL, 1500000, 300000, 1, TRUE, FALSE, 10, '["instagram","stories","ads"]'),

-- TikTok Marketing
(1, 'SMM-00011', 'TikTok Account Management - Basic', 'tiktok-account-management-basic', 'Kelola TikTok dengan 15 video per bulan', 'Manajemen akun TikTok dengan 15 video viral-worthy content per bulan dan trend analysis.', 'subscription', NULL, 2000000, 600000, 3, TRUE, TRUE, 11, '["tiktok","video","basic"]'),
(1, 'SMM-00012', 'TikTok Account Management - Premium', 'tiktok-account-management-premium', 'Kelola TikTok dengan 30 video per bulan', 'Full TikTok management dengan 30 video berkualitas, hashtag challenge, duet collaboration, dan live streaming.', 'subscription', NULL, 4000000, 800000, 6, TRUE, TRUE, 12, '["tiktok","video","premium"]'),
(1, 'SMM-00013', 'TikTok Ads Campaign', 'tiktok-ads-campaign', 'Kampanye TikTok Ads untuk brand awareness', 'Setup dan management TikTok Ads dengan targeting Gen Z dan Millennial, creative video ads.', 'subscription', NULL, 2500000, 500000, 3, TRUE, FALSE, 13, '["tiktok","ads","campaign"]'),
(1, 'SMM-00014', 'TikTok Influencer Collaboration', 'tiktok-influencer-collaboration', 'Kolaborasi dengan TikTok influencer', 'Mediasi dan koordinasi kolaborasi dengan TikTok influencer sesuai niche bisnis Anda.', 'project', 5000000, NULL, 1000000, 1, TRUE, FALSE, 14, '["tiktok","influencer","collaboration"]'),

-- Twitter/X Marketing
(1, 'SMM-00015', 'Twitter Account Management', 'twitter-account-management', 'Kelola akun Twitter/X profesional', 'Manajemen Twitter dengan 60 tweet per bulan, engagement handling, dan community building.', 'subscription', NULL, 1500000, 300000, 3, TRUE, FALSE, 15, '["twitter","x","social-media"]'),
(1, 'SMM-00016', 'Twitter Ads Campaign', 'twitter-ads-campaign', 'Kampanye Twitter Ads targeted', 'Setup dan optimasi Twitter Ads untuk reach dan engagement maksimal.', 'subscription', NULL, 1800000, 300000, 1, TRUE, FALSE, 16, '["twitter","ads","campaign"]'),
(1, 'SMM-00017', 'Twitter Thread Creation Service', 'twitter-thread-creation-service', 'Pembuatan Twitter thread viral', 'Jasa pembuatan Twitter thread yang engaging dan viral-worthy untuk brand awareness.', 'project', 2000000, NULL, 0, 1, TRUE, FALSE, 17, '["twitter","thread","content"]'),

-- LinkedIn Marketing
(1, 'SMM-00018', 'LinkedIn Company Page Management', 'linkedin-company-page-management', 'Kelola LinkedIn Company Page B2B', 'Manajemen LinkedIn untuk B2B marketing dengan 12 post profesional per bulan.', 'subscription', NULL, 2500000, 500000, 3, TRUE, FALSE, 18, '["linkedin","b2b","corporate"]'),
(1, 'SMM-00019', 'LinkedIn Personal Branding', 'linkedin-personal-branding', 'Personal branding di LinkedIn untuk executives', 'Build personal brand untuk CEO, founder, dan executives di LinkedIn.', 'subscription', NULL, 3500000, 750000, 6, TRUE, FALSE, 19, '["linkedin","personal-branding","executive"]'),
(1, 'SMM-00020', 'LinkedIn Ads Campaign', 'linkedin-ads-campaign', 'LinkedIn Ads untuk B2B lead generation', 'Kampanye LinkedIn Ads targeting decision makers dan professionals.', 'subscription', NULL, 3000000, 600000, 3, TRUE, FALSE, 20, '["linkedin","ads","b2b"]'),

-- YouTube Marketing
(1, 'SMM-00021', 'YouTube Channel Management', 'youtube-channel-management', 'Kelola channel YouTube lengkap', 'Full YouTube channel management termasuk SEO, thumbnail design, dan community management.', 'subscription', NULL, 3500000, 750000, 6, TRUE, TRUE, 21, '["youtube","video","management"]'),
(1, 'SMM-00022', 'YouTube Ads Campaign', 'youtube-ads-campaign', 'Kampanye YouTube Ads pre-roll dan mid-roll', 'Setup dan optimasi YouTube Ads untuk maximum reach dan conversions.', 'subscription', NULL, 2500000, 500000, 3, TRUE, FALSE, 22, '["youtube","ads","video"]'),
(1, 'SMM-00023', 'YouTube SEO Optimization', 'youtube-seo-optimization', 'Optimasi SEO YouTube untuk ranking', 'Optimasi video YouTube untuk ranking tinggi di pencarian YouTube dan Google.', 'project', 3000000, NULL, 500000, 1, TRUE, FALSE, 23, '["youtube","seo","optimization"]'),
(1, 'SMM-00024', 'YouTube Shorts Strategy', 'youtube-shorts-strategy', 'Strategi konten YouTube Shorts', 'Pembuatan dan upload YouTube Shorts untuk viral content dan subscriber growth.', 'subscription', NULL, 2000000, 400000, 3, TRUE, FALSE, 24, '["youtube","shorts","viral"]'),

-- Pinterest Marketing
(1, 'SMM-00025', 'Pinterest Account Management', 'pinterest-account-management', 'Kelola Pinterest untuk e-commerce', 'Manajemen Pinterest dengan 40 pins per bulan untuk drive traffic ke website/toko online.', 'subscription', NULL, 1500000, 300000, 3, TRUE, FALSE, 25, '["pinterest","ecommerce","traffic"]'),
(1, 'SMM-00026', 'Pinterest Ads Campaign', 'pinterest-ads-campaign', 'Pinterest Ads untuk produk visual', 'Kampanye Pinterest Ads targeting pembeli dengan visual interest.', 'subscription', NULL, 1800000, 300000, 3, TRUE, FALSE, 26, '["pinterest","ads","visual"]'),

-- WhatsApp Business
(1, 'SMM-00027', 'WhatsApp Business Management', 'whatsapp-business-management', 'Kelola WhatsApp Business profesional', 'Setup dan manajemen WhatsApp Business dengan auto-reply, catalog, dan broadcast message.', 'subscription', NULL, 1200000, 250000, 3, TRUE, FALSE, 27, '["whatsapp","business","messaging"]'),
(1, 'SMM-00028', 'WhatsApp Marketing Campaign', 'whatsapp-marketing-campaign', 'Kampanye marketing via WhatsApp', 'Blast message marketing via WhatsApp dengan personalisasi dan tracking.', 'project', 2500000, NULL, 500000, 1, TRUE, FALSE, 28, '["whatsapp","marketing","blast"]'),
(1, 'SMM-00029', 'WhatsApp Chatbot Development', 'whatsapp-chatbot-development', 'Chatbot WhatsApp otomatis', 'Pengembangan chatbot WhatsApp untuk customer service otomatis 24/7.', 'project', 8000000, NULL, 2000000, 1, TRUE, FALSE, 29, '["whatsapp","chatbot","automation"]'),

-- Telegram Marketing
(1, 'SMM-00030', 'Telegram Channel Management', 'telegram-channel-management', 'Kelola Telegram Channel untuk broadcast', 'Manajemen Telegram Channel untuk broadcast konten dan promo ke subscribers.', 'subscription', NULL, 1000000, 200000, 3, TRUE, FALSE, 30, '["telegram","channel","broadcast"]'),
(1, 'SMM-00031', 'Telegram Group Community Management', 'telegram-group-community-management', 'Moderasi Telegram Group community', 'Moderasi dan engagement Telegram Group untuk membangun komunitas loyal.', 'subscription', NULL, 1500000, 300000, 3, TRUE, FALSE, 31, '["telegram","community","moderation"]'),
(1, 'SMM-00032', 'Telegram Bot Development', 'telegram-bot-development', 'Pembuatan Telegram Bot custom', 'Develop custom Telegram Bot untuk automation dan customer interaction.', 'project', 6000000, NULL, 1500000, 1, TRUE, FALSE, 32, '["telegram","bot","development"]'),

-- Multi-Platform
(1, 'SMM-00033', 'Social Media Management - 3 Platform', 'social-media-management-3-platform', 'Kelola 3 sosial media sekaligus', 'Manajemen 3 platform social media (pilih dari FB, IG, TikTok, Twitter) dengan konten terintegrasi.', 'subscription', NULL, 4500000, 1000000, 6, TRUE, TRUE, 33, '["multi-platform","integrated","premium"]'),
(1, 'SMM-00034', 'Social Media Management - 5 Platform', 'social-media-management-5-platform', 'Kelola 5 sosial media sekaligus', 'Full social media management untuk 5 platform dengan strategi terintegrasi dan dedicated team.', 'subscription', NULL, 7500000, 1500000, 6, TRUE, TRUE, 34, '["multi-platform","integrated","enterprise"]'),
(1, 'SMM-00035', 'Social Media Audit & Strategy', 'social-media-audit-strategy', 'Audit dan strategi social media lengkap', 'Comprehensive audit semua channel social media dan strategi improvement 6 bulan ke depan.', 'project', 5000000, NULL, 0, 1, TRUE, FALSE, 35, '["audit","strategy","consulting"]'),
(1, 'SMM-00036', 'Social Media Contest Management', 'social-media-contest-management', 'Kelola kontes di social media', 'End-to-end management social media contest/giveaway untuk boost engagement.', 'project', 3000000, NULL, 500000, 1, TRUE, FALSE, 36, '["contest","giveaway","engagement"]'),
(1, 'SMM-00037', 'Social Media Crisis Management', 'social-media-crisis-management', 'Manajemen krisis di social media', 'Tim standby untuk handle negative comments dan social media crisis.', 'subscription', NULL, 2500000, 500000, 1, TRUE, FALSE, 37, '["crisis","reputation","management"]'),
(1, 'SMM-00038', 'Social Listening & Monitoring', 'social-listening-monitoring', 'Monitoring brand mention di social media', 'Monitor dan analisa semua penyebutan brand di social media dengan sentiment analysis.', 'subscription', NULL, 1800000, 300000, 3, TRUE, FALSE, 38, '["listening","monitoring","analytics"]'),
(1, 'SMM-00039', 'User Generated Content Campaign', 'user-generated-content-campaign', 'Kampanye UGC untuk authenticity', 'Campaign untuk mendorong user create content tentang brand Anda.', 'project', 4000000, NULL, 800000, 1, TRUE, FALSE, 39, '["ugc","campaign","authenticity"]'),
(1, 'SMM-00040', 'Social Media Influencer Outreach', 'social-media-influencer-outreach', 'Outreach ke influencer untuk kolaborasi', 'Research, outreach, dan negotiation dengan influencer yang sesuai target market.', 'project', 3500000, NULL, 500000, 1, TRUE, FALSE, 40, '["influencer","outreach","partnership"]'),

-- Community Management
(1, 'SMM-00041', 'Community Building & Management', 'community-building-management', 'Bangun dan kelola online community', 'Build dan kelola komunitas online yang engaged untuk brand loyalty.', 'subscription', NULL, 3000000, 600000, 6, TRUE, FALSE, 41, '["community","loyalty","engagement"]'),
(1, 'SMM-00042', 'Facebook Group Management', 'facebook-group-management', 'Kelola Facebook Group community', 'Moderasi dan aktivasi Facebook Group untuk membangun komunitas brand.', 'subscription', NULL, 1500000, 300000, 3, TRUE, FALSE, 42, '["facebook","group","community"]'),
(1, 'SMM-00043', 'Discord Server Management', 'discord-server-management', 'Kelola Discord Server untuk brand', 'Setup dan management Discord Server untuk komunitas Gen Z dan gamers.', 'subscription', NULL, 2000000, 400000, 3, TRUE, FALSE, 43, '["discord","gaming","community"]'),

-- Content Services
(1, 'SMM-00044', 'Social Media Copywriting', 'social-media-copywriting', 'Jasa copywriting untuk social media', 'Penulisan caption dan copy yang engaging untuk semua platform social media.', 'subscription', NULL, 1500000, 0, 3, TRUE, FALSE, 44, '["copywriting","caption","content"]'),
(1, 'SMM-00045', 'Social Media Graphic Design', 'social-media-graphic-design', 'Design grafis khusus social media', 'Desain grafis menarik untuk post social media berbagai platform.', 'subscription', NULL, 2000000, 300000, 3, TRUE, FALSE, 45, '["design","graphics","visual"]'),
(1, 'SMM-00046', 'Social Media Video Editing', 'social-media-video-editing', 'Edit video untuk social media', 'Editing video profesional untuk Instagram Reels, TikTok, YouTube Shorts.', 'subscription', NULL, 2500000, 500000, 3, TRUE, FALSE, 46, '["video","editing","content"]'),
(1, 'SMM-00047', 'Meme Marketing Creation', 'meme-marketing-creation', 'Buat meme viral untuk marketing', 'Pembuatan meme relevan dan viral untuk meningkatkan brand awareness.', 'subscription', NULL, 1200000, 200000, 1, TRUE, FALSE, 47, '["meme","viral","fun"]'),

-- Advanced Services
(1, 'SMM-00048', 'Social Commerce Setup', 'social-commerce-setup', 'Setup fitur belanja di social media', 'Setup Facebook Shop, Instagram Shopping, TikTok Shop untuk social selling.', 'project', 4000000, NULL, 800000, 1, TRUE, FALSE, 48, '["commerce","shopping","integration"]'),
(1, 'SMM-00049', 'Social Media Analytics Dashboard', 'social-media-analytics-dashboard', 'Dashboard analytics real-time social media', 'Custom dashboard untuk monitor performa semua social media dalam satu tempat.', 'project', 6000000, NULL, 1200000, 1, TRUE, FALSE, 49, '["analytics","dashboard","reporting"]'),
(1, 'SMM-00050', 'Social Media Training & Workshop', 'social-media-training-workshop', 'Pelatihan social media marketing', 'Workshop dan training social media marketing untuk tim internal.', 'project', 5000000, NULL, 0, 1, TRUE, FALSE, 50, '["training","workshop","education"]');

-- ==========================
-- SEO SERVICES (40 services)
-- ==========================

INSERT INTO services (category_id, service_code, name, slug, short_description, description, service_type, base_price, monthly_price, setup_fee, min_contract_months, is_active, is_featured, sort_order, tags) VALUES

-- On-Page SEO
(2, 'SEO-00001', 'On-Page SEO Optimization - Basic', 'on-page-seo-basic', 'Optimasi on-page SEO untuk 10 halaman', 'Optimasi dasar on-page SEO meliputi title tag, meta description, heading structure untuk 10 halaman.', 'project', 3000000, NULL, 500000, 1, TRUE, TRUE, 1, '["on-page","seo","basic"]'),
(2, 'SEO-00002', 'On-Page SEO Optimization - Advanced', 'on-page-seo-advanced', 'Optimasi on-page SEO untuk 30 halaman', 'Optimasi lengkap on-page SEO termasuk schema markup, internal linking, content optimization untuk 30 halaman.', 'project', 7500000, NULL, 1000000, 1, TRUE, TRUE, 2, '["on-page","seo","advanced"]'),
(2, 'SEO-00003', 'On-Page SEO Optimization - Enterprise', 'on-page-seo-enterprise', 'Optimasi on-page SEO untuk 100+ halaman', 'Full on-page SEO audit dan optimization untuk website besar 100+ halaman dengan technical SEO.', 'project', 20000000, NULL, 3000000, 1, TRUE, TRUE, 3, '["on-page","seo","enterprise"]'),

-- Off-Page SEO & Link Building
(2, 'SEO-00004', 'Link Building - Starter Package', 'link-building-starter', 'Dapatkan 10 backlink berkualitas/bulan', 'Link building dengan 10 high-quality backlinks dari website DA 30+ per bulan.', 'subscription', NULL, 2000000, 500000, 3, TRUE, FALSE, 4, '["link-building","backlink","starter"]'),
(2, 'SEO-00005', 'Link Building - Growth Package', 'link-building-growth', 'Dapatkan 25 backlink berkualitas/bulan', 'Aggressive link building dengan 25 backlinks dari website DA 40+ per bulan.', 'subscription', NULL, 4500000, 800000, 6, TRUE, TRUE, 5, '["link-building","backlink","growth"]'),
(2, 'SEO-00006', 'Link Building - Authority Package', 'link-building-authority', 'Dapatkan 50 backlink premium/bulan', 'Premium link building dengan 50 backlinks dari high authority websites DA 50+.', 'subscription', NULL, 8500000, 1500000, 6, TRUE, TRUE, 6, '["link-building","backlink","authority"]'),
(2, 'SEO-00007', 'Guest Posting Service', 'guest-posting-service', 'Publikasi guest post di website authority', 'Penulisan dan publikasi guest post di website authority untuk quality backlinks.', 'project', 1500000, NULL, 0, 1, TRUE, FALSE, 7, '["guest-post","content","backlink"]'),
(2, 'SEO-00008', 'Broken Link Building', 'broken-link-building', 'Link building via broken link strategy', 'Find broken links di website authority dan replace dengan content Anda.', 'project', 3500000, NULL, 500000, 1, TRUE, FALSE, 8, '["link-building","broken-link","outreach"]'),

-- Technical SEO
(2, 'SEO-00009', 'Technical SEO Audit', 'technical-seo-audit', 'Audit teknikal SEO menyeluruh', 'Comprehensive technical SEO audit mencakup crawlability, indexability, site speed, mobile-friendliness.', 'project', 4000000, NULL, 0, 1, TRUE, TRUE, 9, '["technical-seo","audit","analysis"]'),
(2, 'SEO-00010', 'Website Speed Optimization', 'website-speed-optimization', 'Optimasi kecepatan website untuk SEO', 'Tingkatkan page speed hingga 90+ di Google PageSpeed Insights.', 'project', 5000000, NULL, 1000000, 1, TRUE, FALSE, 10, '["speed","performance","optimization"]'),
(2, 'SEO-00011', 'Mobile SEO Optimization', 'mobile-seo-optimization', 'Optimasi website untuk mobile search', 'Pastikan website mobile-friendly dan optimal untuk mobile-first indexing Google.', 'project', 4500000, NULL, 800000, 1, TRUE, FALSE, 11, '["mobile","responsive","optimization"]'),
(2, 'SEO-00012', 'Core Web Vitals Optimization', 'core-web-vitals-optimization', 'Perbaiki Core Web Vitals untuk ranking', 'Optimasi LCP, FID, CLS untuk memenuhi standar Core Web Vitals Google.', 'project', 6000000, NULL, 1200000, 1, TRUE, FALSE, 12, '["core-web-vitals","performance","ux"]'),
(2, 'SEO-00013', 'Schema Markup Implementation', 'schema-markup-implementation', 'Implementasi schema markup lengkap', 'Tambahkan structured data/schema markup untuk rich snippets di Google.', 'project', 3500000, NULL, 500000, 1, TRUE, FALSE, 13, '["schema","structured-data","rich-snippets"]'),
(2, 'SEO-00014', 'XML Sitemap Creation & Submission', 'xml-sitemap-creation', 'Buat dan submit XML sitemap', 'Generate XML sitemap dan submit ke Google Search Console & Bing Webmaster.', 'project', 1000000, NULL, 0, 1, TRUE, FALSE, 14, '["sitemap","indexing","submission"]'),
(2, 'SEO-00015', 'Robots.txt Optimization', 'robots-txt-optimization', 'Optimasi robots.txt untuk crawling', 'Setup robots.txt yang benar untuk memaksimalkan crawl budget.', 'project', 800000, NULL, 0, 1, TRUE, FALSE, 15, '["robots","crawling","technical"]'),

-- Local SEO
(2, 'SEO-00016', 'Google Business Profile Optimization', 'google-business-profile-optimization', 'Optimasi Google Business Profile lengkap', 'Optimasi GBP untuk local search termasuk NAP consistency, photos, posts, Q&A.', 'project', 2500000, NULL, 500000, 1, TRUE, TRUE, 16, '["local-seo","google-business","gmb"]'),
(2, 'SEO-00017', 'Local SEO - Single Location', 'local-seo-single-location', 'Local SEO untuk 1 lokasi bisnis', 'Optimasi local SEO lengkap untuk bisnis dengan 1 lokasi fisik.', 'subscription', NULL, 2000000, 800000, 6, TRUE, FALSE, 17, '["local-seo","single-location","maps"]'),
(2, 'SEO-00018', 'Local SEO - Multi Location', 'local-seo-multi-location', 'Local SEO untuk bisnis multi cabang', 'Local SEO strategy untuk bisnis dengan beberapa cabang/lokasi.', 'subscription', NULL, 5000000, 1500000, 6, TRUE, FALSE, 18, '["local-seo","multi-location","franchise"]'),
(2, 'SEO-00019', 'Local Citations Building', 'local-citations-building', 'Build local citations di direktori', 'Submit bisnis ke 50+ local directories untuk boost local rankings.', 'project', 2000000, NULL, 300000, 1, TRUE, FALSE, 19, '["citations","directories","local"]'),
(2, 'SEO-00020', 'Google Maps Ranking Optimization', 'google-maps-ranking', 'Optimasi ranking di Google Maps', 'Strategi khusus untuk ranking #1 di Google Maps local pack.', 'subscription', NULL, 2500000, 500000, 6, TRUE, FALSE, 20, '["google-maps","local-pack","ranking"]'),

-- Content SEO
(2, 'SEO-00021', 'SEO Content Writing - 5 Articles', 'seo-content-writing-5-articles', 'Penulisan 5 artikel SEO-optimized', 'Tulis 5 artikel berkualitas 1000+ kata yang SEO-optimized per bulan.', 'subscription', NULL, 2500000, 300000, 1, TRUE, FALSE, 21, '["content","writing","seo"]'),
(2, 'SEO-00022', 'SEO Content Writing - 10 Articles', 'seo-content-writing-10-articles', 'Penulisan 10 artikel SEO-optimized', 'Tulis 10 artikel berkualitas tinggi untuk boost organic traffic.', 'subscription', NULL, 4500000, 500000, 3, TRUE, TRUE, 22, '["content","writing","seo"]'),
(2, 'SEO-00023', 'SEO Content Writing - 20 Articles', 'seo-content-writing-20-articles', 'Penulisan 20 artikel SEO-optimized', 'Aggressive content marketing dengan 20 artikel SEO per bulan.', 'subscription', NULL, 8000000, 800000, 6, TRUE, TRUE, 23, '["content","writing","aggressive"]'),
(2, 'SEO-00024', 'Keyword Research & Analysis', 'keyword-research-analysis', 'Riset keyword mendalam untuk SEO', 'Comprehensive keyword research dengan search volume, difficulty, dan opportunity analysis.', 'project', 2000000, NULL, 0, 1, TRUE, FALSE, 24, '["keyword","research","analysis"]'),
(2, 'SEO-00025', 'Content Gap Analysis', 'content-gap-analysis', 'Analisa content gap vs kompetitor', 'Identifikasi keyword opportunities yang dimanfaatkan kompetitor tapi belum Anda.', 'project', 2500000, NULL, 0, 1, TRUE, FALSE, 25, '["content-gap","analysis","competitive"]'),
(2, 'SEO-00026', 'Content Refresh & Update', 'content-refresh-update', 'Update konten lama untuk SEO', 'Refresh dan update konten lama agar tetap relevan dan ranking tinggi.', 'project', 3000000, NULL, 500000, 1, TRUE, FALSE, 26, '["content","refresh","update"]'),

-- E-commerce SEO
(2, 'SEO-00027', 'E-commerce SEO - Basic', 'ecommerce-seo-basic', 'SEO untuk toko online kecil', 'Optimasi SEO untuk toko online dengan kurang dari 100 produk.', 'subscription', NULL, 3500000, 1000000, 6, TRUE, FALSE, 27, '["ecommerce","seo","online-shop"]'),
(2, 'SEO-00028', 'E-commerce SEO - Advanced', 'ecommerce-seo-advanced', 'SEO untuk toko online menengah', 'SEO lengkap untuk toko online 100-500 produk termasuk category & product optimization.', 'subscription', NULL, 6500000, 1500000, 6, TRUE, TRUE, 28, '["ecommerce","seo","marketplace"]'),
(2, 'SEO-00029', 'E-commerce SEO - Enterprise', 'ecommerce-seo-enterprise', 'SEO untuk marketplace besar', 'Enterprise SEO untuk marketplace dengan 500+ produk dan technical optimization.', 'subscription', NULL, 12000000, 3000000, 12, TRUE, TRUE, 29, '["ecommerce","seo","enterprise"]'),
(2, 'SEO-00030', 'Product Page Optimization', 'product-page-optimization', 'Optimasi halaman produk untuk konversi', 'Optimasi product pages untuk SEO dan conversion rate.', 'project', 5000000, NULL, 1000000, 1, TRUE, FALSE, 30, '["product","optimization","conversion"]'),

-- International SEO
(2, 'SEO-00031', 'International SEO Strategy', 'international-seo-strategy', 'SEO untuk multiple negara/bahasa', 'Strategi SEO internasional dengan hreflang implementation.', 'project', 8000000, NULL, 2000000, 1, TRUE, FALSE, 31, '["international","multilingual","hreflang"]'),
(2, 'SEO-00032', 'Multilingual SEO Setup', 'multilingual-seo-setup', 'Setup SEO untuk website multilingual', 'Optimasi website dengan multiple bahasa untuk international reach.', 'project', 6000000, NULL, 1500000, 1, TRUE, FALSE, 32, '["multilingual","translation","international"]'),

-- SEO Tools & Monitoring
(2, 'SEO-00033', 'SEO Monitoring & Reporting', 'seo-monitoring-reporting', 'Monitoring ranking dan laporan SEO', 'Monitor ranking keywords dan traffic dengan laporan bulanan lengkap.', 'subscription', NULL, 1500000, 300000, 3, TRUE, FALSE, 33, '["monitoring","reporting","analytics"]'),
(2, 'SEO-00034', 'Competitor SEO Analysis', 'competitor-seo-analysis', 'Analisa strategi SEO kompetitor', 'Deep dive analysis SEO strategy kompetitor untuk find opportunities.', 'project', 3000000, NULL, 0, 1, TRUE, FALSE, 34, '["competitor","analysis","research"]'),
(2, 'SEO-00035', 'SEO Penalty Recovery', 'seo-penalty-recovery', 'Pemulihan dari Google penalty', 'Recovery dari Google manual action atau algorithmic penalty.', 'project', 8000000, NULL, 1500000, 1, TRUE, FALSE, 35, '["penalty","recovery","rehabilitation"]'),

-- Voice & AI Search SEO
(2, 'SEO-00036', 'Voice Search Optimization', 'voice-search-optimization', 'Optimasi untuk voice search', 'Optimize content untuk Google Assistant, Siri, Alexa voice search.', 'project', 4000000, NULL, 800000, 1, TRUE, FALSE, 36, '["voice-search","ai","optimization"]'),
(2, 'SEO-00037', 'Featured Snippet Optimization', 'featured-snippet-optimization', 'Optimasi untuk featured snippets', 'Strategi untuk muncul di position zero Google featured snippets.', 'project', 3500000, NULL, 500000, 1, TRUE, FALSE, 37, '["featured-snippet","position-zero","serp"]'),
(2, 'SEO-00038', 'Video SEO Optimization', 'video-seo-optimization', 'SEO untuk video YouTube dan website', 'Optimasi video untuk ranking di YouTube dan Google video search.', 'project', 3000000, NULL, 500000, 1, TRUE, FALSE, 38, '["video","youtube","seo"]'),

-- Full Service SEO
(2, 'SEO-00039', 'Full Service SEO - Growth Package', 'full-service-seo-growth', 'Paket SEO lengkap untuk pertumbuhan', 'All-in-one SEO package: on-page, off-page, technical, content untuk pertumbuhan traffic.', 'subscription', NULL, 8500000, 2000000, 12, TRUE, TRUE, 39, '["full-service","complete","growth"]'),
(2, 'SEO-00040', 'Full Service SEO - Enterprise Package', 'full-service-seo-enterprise', 'Paket SEO enterprise untuk brand besar', 'Enterprise SEO solution dengan dedicated team untuk dominasi organic search.', 'subscription', NULL, 20000000, 5000000, 12, TRUE, TRUE, 40, '["full-service","enterprise","premium"]');


-- =============================================================================
-- TO BE CONTINUED... (260+ more services will be added)
-- Categories remaining:
-- - Content Marketing (30 services)
-- - Email Marketing (20 services)
-- - Paid Advertising (40 services)
-- - Website Development (30 services)
-- - E-Commerce Solutions (25 services)
-- - Mobile App Development (15 services)
-- - Landing Page Design (15 services)
-- - Graphic Design (25 services)
-- - Video Production (20 services)
-- - Photography (15 services)
-- - Branding & Identity (15 services)
-- - Marketing Automation (15 services)
-- - Analytics & Reporting (15 services)
-- - CRM Solutions (10 services)
-- - Influencer Marketing (15 services)
-- - Marketplace Management (15 services)
-- - Consulting & Training (15 services)
-- - Tools & Software (10 services)
-- =============================================================================

-- Sementara ini adalah 90 layanan pertama (Social Media 50 + SEO 40)
-- Akan dilanjutkan dengan 210+ layanan lainnya untuk mencapai target 300+ layanan
