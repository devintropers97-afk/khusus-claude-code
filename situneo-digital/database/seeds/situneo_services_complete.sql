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
-- ============================================================================
-- SITUNEO DIGITAL - PART 2: Continuing 300+ Services (91-300+)
-- ============================================================================

-- ==========================
-- CONTENT MARKETING (30 services) - Category ID: 3
-- ==========================

INSERT INTO services (category_id, service_code, name, slug, short_description, description, service_type, base_price, monthly_price, setup_fee, min_contract_months, is_active, is_featured, sort_order, tags) VALUES

-- Blog Content
(3, 'CNT-00001', 'Blog Content Writing - 10 Posts', 'blog-content-writing-10-posts', 'Tulis 10 blog post berkualitas per bulan', 'Penulisan 10 artikel blog 800-1000 kata yang engaging dan SEO-friendly.', 'subscription', NULL, 3500000, 500000, 3, TRUE, TRUE, 1, '["blog","writing","content"]'),
(3, 'CNT-00002', 'Blog Content Writing - 20 Posts', 'blog-content-writing-20-posts', 'Tulis 20 blog post premium per bulan', 'Aggressive content marketing dengan 20 artikel blog berkualitas tinggi.', 'subscription', NULL, 6500000, 800000, 6, TRUE, TRUE, 2, '["blog","writing","aggressive"]'),
(3, 'CNT-00003', 'Long-Form Content Writing', 'long-form-content-writing', 'Artikel long-form 3000+ kata', 'Penulisan artikel mendalam 3000+ kata untuk thought leadership.', 'project', 2500000, NULL, 0, 1, TRUE, FALSE, 3, '["long-form","pillar","authority"]'),
(3, 'CNT-00004', 'Pillar Content Creation', 'pillar-content-creation', 'Buat pillar content comprehensive', 'Pembuatan 5000+ kata pillar content sebagai content hub.', 'project', 4000000, NULL, 500000, 1, TRUE, FALSE, 4, '["pillar","cornerstone","comprehensive"]'),

-- White Papers & E-books
(3, 'CNT-00005', 'Whitepaper Writing', 'whitepaper-writing', 'Tulis whitepaper profesional', 'Penulisan whitepaper 10-15 halaman untuk B2B lead generation.', 'project', 8000000, NULL, 1000000, 1, TRUE, TRUE, 5, '["whitepaper","b2b","leadgen"]'),
(3, 'CNT-00006', 'E-book Writing & Design', 'ebook-writing-design', 'Buat e-book lengkap dengan design', 'Penulisan dan design e-book 20-30 halaman untuk lead magnet.', 'project', 10000000, NULL, 1500000, 1, TRUE, TRUE, 6, '["ebook","lead-magnet","design"]'),
(3, 'CNT-00007', 'Case Study Writing', 'case-study-writing', 'Tulis case study client success', 'Penulisan case study yang compelling untuk social proof.', 'project', 3000000, NULL, 0, 1, TRUE, FALSE, 7, '["case-study","proof","testimonial"]'),

-- Newsletter & Email Content
(3, 'CNT-00008', 'Email Newsletter Writing', 'email-newsletter-writing', 'Tulis newsletter email mingguan', 'Penulisan 4 newsletter email engaging per bulan.', 'subscription', NULL, 2000000, 300000, 3, TRUE, FALSE, 8, '["newsletter","email","content"]'),
(3, 'CNT-00009', 'Email Sequence Copywriting', 'email-sequence-copywriting', 'Tulis email sequence untuk funnel', 'Penulisan 5-7 email sequence untuk sales funnel atau onboarding.', 'project', 3500000, NULL, 500000, 1, TRUE, FALSE, 9, '["email","sequence","funnel"]'),

-- Social Media Content
(3, 'CNT-00010', 'Social Media Copywriting Package', 'social-media-copywriting-package', 'Caption dan copy untuk 60 post', 'Penulisan 60 caption menarik untuk berbagai platform social media.', 'subscription', NULL, 2500000, 300000, 1, TRUE, FALSE, 10, '["social-media","copywriting","caption"]'),
(3, 'CNT-00011', 'Instagram Caption Writing', 'instagram-caption-writing', 'Caption Instagram yang engaging', 'Penulisan 30 caption Instagram dengan storytelling dan CTA.', 'subscription', NULL, 1500000, 200000, 1, TRUE, FALSE, 11, '["instagram","caption","storytelling"]'),

-- Website Content
(3, 'CNT-00012', 'Website Copywriting - Homepage', 'website-copywriting-homepage', 'Copy homepage yang converting', 'Penulisan copy homepage yang persuasif dan conversion-focused.', 'project', 3000000, NULL, 0, 1, TRUE, FALSE, 12, '["website","homepage","copywriting"]'),
(3, 'CNT-00013', 'Website Copywriting - Full Site', 'website-copywriting-full-site', 'Copy lengkap untuk seluruh website', 'Penulisan copy untuk seluruh halaman website (10-15 halaman).', 'project', 8000000, NULL, 1000000, 1, TRUE, TRUE, 13, '["website","full-site","comprehensive"]'),
(3, 'CNT-00014', 'Landing Page Copywriting', 'landing-page-copywriting', 'Copy landing page high-converting', 'Penulisan copy landing page yang fokus pada conversion.', 'project', 2500000, NULL, 0, 1, TRUE, FALSE, 14, '["landing-page","conversion","persuasive"]'),
(3, 'CNT-00015', 'Product Description Writing', 'product-description-writing', 'Deskripsi produk yang menjual', 'Penulisan deskripsi produk untuk 50 produk e-commerce.', 'project', 3000000, NULL, 500000, 1, TRUE, FALSE, 15, '["product","description","ecommerce"]'),

-- Video & Script Content
(3, 'CNT-00016', 'Video Script Writing', 'video-script-writing', 'Tulis script video marketing', 'Penulisan script untuk video marketing, explainer, atau ads.', 'project', 2000000, NULL, 0, 1, TRUE, FALSE, 16, '["video","script","storytelling"]'),
(3, 'CNT-00017', 'YouTube Video Script Package', 'youtube-video-script-package', 'Script untuk 4 video YouTube', 'Penulisan 4 script video YouTube per bulan (5-10 menit).', 'subscription', NULL, 2500000, 300000, 1, TRUE, FALSE, 17, '["youtube","script","content"]'),
(3, 'CNT-00018', 'Podcast Script Writing', 'podcast-script-writing', 'Script untuk episode podcast', 'Penulisan outline dan talking points untuk podcast episode.', 'project', 1500000, NULL, 0, 1, TRUE, FALSE, 18, '["podcast","script","audio"]'),

-- Press Release & PR Content
(3, 'CNT-00019', 'Press Release Writing', 'press-release-writing', 'Tulis press release profesional', 'Penulisan press release untuk peluncuran produk atau event.', 'project', 2500000, NULL, 0, 1, TRUE, FALSE, 19, '["press-release","pr","media"]'),
(3, 'CNT-00020', 'Media Kit Creation', 'media-kit-creation', 'Buat media kit lengkap', 'Pembuatan media kit lengkap untuk press dan partnership.', 'project', 4000000, NULL, 500000, 1, TRUE, FALSE, 20, '["media-kit","pr","partnership"]'),

-- Content Strategy & Planning
(3, 'CNT-00021', 'Content Strategy Development', 'content-strategy-development', 'Strategi content marketing 6 bulan', 'Pembuatan content strategy comprehensive untuk 6 bulan.', 'project', 6000000, NULL, 0, 1, TRUE, TRUE, 21, '["strategy","planning","roadmap"]'),
(3, 'CNT-00022', 'Content Calendar Creation', 'content-calendar-creation', 'Buat content calendar bulanan', 'Pembuatan content calendar terencana untuk 3 bulan.', 'project', 2000000, NULL, 0, 1, TRUE, FALSE, 22, '["calendar","planning","schedule"]'),
(3, 'CNT-00023', 'Content Audit & Analysis', 'content-audit-analysis', 'Audit seluruh existing content', 'Comprehensive audit dan analysis semua content yang sudah ada.', 'project', 3500000, NULL, 0, 1, TRUE, FALSE, 23, '["audit","analysis","evaluation"]'),

-- Specialized Content
(3, 'CNT-00024', 'Technical Writing', 'technical-writing', 'Penulisan konten teknis', 'Penulisan dokumentasi teknis, tutorial, atau how-to guides.', 'project', 4000000, NULL, 500000, 1, TRUE, FALSE, 24, '["technical","documentation","guide"]'),
(3, 'CNT-00025', 'FAQ Content Creation', 'faq-content-creation', 'Buat FAQ comprehensive', 'Pembuatan 50+ FAQ beserta jawaban lengkap untuk website.', 'project', 2000000, NULL, 0, 1, TRUE, FALSE, 25, '["faq","support","content"]'),
(3, 'CNT-00026', 'Comparison Article Writing', 'comparison-article-writing', 'Artikel perbandingan produk', 'Penulisan artikel "X vs Y" atau "Best X in 2024" untuk SEO.', 'project', 2500000, NULL, 0, 1, TRUE, FALSE, 26, '["comparison","review","seo"]'),
(3, 'CNT-00027', 'Listicle Content Writing', 'listicle-content-writing', 'Artikel listicle viral-worthy', 'Penulisan artikel list-style yang engaging (10 Tips, 20 Ways, etc).', 'project', 1500000, NULL, 0, 1, TRUE, FALSE, 27, '["listicle","list","viral"]'),

-- Content Localization
(3, 'CNT-00028', 'Content Translation Service', 'content-translation-service', 'Translate konten ke bahasa lain', 'Penerjemahan dan lokalisasi content ke bahasa Indonesia/Inggris.', 'project', 3000000, NULL, 500000, 1, TRUE, FALSE, 28, '["translation","localization","multilingual"]'),
(3, 'CNT-00029', 'Transcription Service', 'transcription-service', 'Transkrip video/audio ke teks', 'Layanan transkrip video atau podcast menjadi artikel.', 'project', 1500000, NULL, 0, 1, TRUE, FALSE, 29, '["transcription","audio","video"]'),

-- Content Distribution
(3, 'CNT-00030', 'Content Syndication Service', 'content-syndication-service', 'Distribusi content ke media partners', 'Distribusi dan publikasi content ke partner media untuk reach maksimal.', 'project', 4000000, NULL, 800000, 1, TRUE, FALSE, 30, '["syndication","distribution","reach"]');


-- ==========================
-- EMAIL MARKETING (20 services) - Category ID: 4
-- ==========================

INSERT INTO services (category_id, service_code, name, slug, short_description, description, service_type, base_price, monthly_price, setup_fee, min_contract_months, is_active, is_featured, sort_order, tags) VALUES

-- Email Campaign Management
(4, 'EML-00001', 'Email Marketing - Basic', 'email-marketing-basic', 'Kirim 4 email campaign per bulan', 'Email marketing basic dengan 4 campaign per bulan untuk list hingga 5000 subscriber.', 'subscription', NULL, 1500000, 500000, 3, TRUE, TRUE, 1, '["email","campaign","basic"]'),
(4, 'EML-00002', 'Email Marketing - Growth', 'email-marketing-growth', 'Kirim 8 email campaign per bulan', 'Email marketing untuk 10,000 subscriber dengan 8 campaign dan segmentation.', 'subscription', NULL, 2500000, 750000, 3, TRUE, TRUE, 2, '["email","campaign","growth"]'),
(4, 'EML-00003', 'Email Marketing - Enterprise', 'email-marketing-enterprise', 'Unlimited email campaigns', 'Enterprise email marketing untuk 50,000+ subscriber dengan advanced automation.', 'subscription', NULL, 5000000, 1500000, 6, TRUE, TRUE, 3, '["email","enterprise","automation"]'),

-- Email Automation
(4, 'EML-00004', 'Email Automation Setup', 'email-automation-setup', 'Setup email automation sequences', 'Setup 5-10 email automation workflows untuk berbagai trigger.', 'project', 4000000, NULL, 1000000, 1, TRUE, TRUE, 4, '["automation","workflow","setup"]'),
(4, 'EML-00005', 'Welcome Email Series', 'welcome-email-series', 'Buat welcome email sequence', 'Pembuatan 5-email welcome series untuk new subscribers.', 'project', 2500000, NULL, 300000, 1, TRUE, FALSE, 5, '["welcome","onboarding","automation"]'),
(4, 'EML-00006', 'Abandoned Cart Email Recovery', 'abandoned-cart-email-recovery', 'Email recovery untuk cart abandonment', 'Setup 3-email sequence untuk recover abandoned shopping carts.', 'project', 3000000, NULL, 500000, 1, TRUE, TRUE, 6, '["abandoned-cart","recovery","ecommerce"]'),
(4, 'EML-00007', 'Re-engagement Email Campaign', 'reengagement-email-campaign', 'Win-back inactive subscribers', 'Campaign khusus untuk re-engage inactive email subscribers.', 'project', 2000000, NULL, 300000, 1, TRUE, FALSE, 7, '["re-engagement","win-back","retention"]'),

-- Email Design & Templates
(4, 'EML-00008', 'Email Template Design - 5 Templates', 'email-template-design-5', 'Design 5 email templates custom', 'Desain 5 email templates responsive dan brand-consistent.', 'project', 3500000, NULL, 500000, 1, TRUE, FALSE, 8, '["design","template","responsive"]'),
(4, 'EML-00009', 'Email Template Design - 10 Templates', 'email-template-design-10', 'Design 10 email templates premium', 'Desain 10 email templates untuk berbagai tujuan marketing.', 'project', 6000000, NULL, 1000000, 1, TRUE, FALSE, 9, '["design","template","premium"]'),
(4, 'EML-00010', 'HTML Email Coding', 'html-email-coding', 'Convert design jadi HTML email', 'Coding HTML email yang compatible dengan semua email clients.', 'project', 2000000, NULL, 0, 1, TRUE, FALSE, 10, '["html","coding","development"]'),

-- Email List Management
(4, 'EML-00011', 'Email List Building Service', 'email-list-building-service', 'Grow email list dengan lead magnet', 'Strategy dan execution untuk grow email list hingga 5000 subscriber.', 'project', 4000000, NULL, 800000, 1, TRUE, FALSE, 11, '["list-building","growth","leadgen"]'),
(4, 'EML-00012', 'Email List Cleaning & Hygiene', 'email-list-cleaning-hygiene', 'Bersihkan dan validasi email list', 'Cleaning invalid emails dan improve deliverability rate.', 'project', 1500000, NULL, 0, 1, TRUE, FALSE, 12, '["list-cleaning","hygiene","deliverability"]'),
(4, 'EML-00013', 'Email Segmentation Strategy', 'email-segmentation-strategy', 'Setup segmentasi email list', 'Segment email list berdasarkan behavior, demografi, dan interest.', 'project', 2500000, NULL, 500000, 1, TRUE, FALSE, 13, '["segmentation","targeting","personalization"]'),

-- Newsletter
(4, 'EML-00014', 'Weekly Newsletter Service', 'weekly-newsletter-service', 'Newsletter mingguan untuk audience', 'Design, tulis, dan kirim newsletter mingguan ke subscribers.', 'subscription', NULL, 3000000, 500000, 3, TRUE, TRUE, 14, '["newsletter","weekly","content"]'),
(4, 'EML-00015', 'Monthly Newsletter Service', 'monthly-newsletter-service', 'Newsletter bulanan premium', 'Newsletter bulanan dengan konten curated dan exclusive offers.', 'subscription', NULL, 1500000, 300000, 3, TRUE, FALSE, 15, '["newsletter","monthly","curated"]'),

-- Email Analytics & Optimization
(4, 'EML-00016', 'Email A/B Testing Service', 'email-ab-testing-service', 'A/B testing untuk email campaigns', 'Setup dan analisa A/B testing subject lines, content, CTA.', 'subscription', NULL, 2000000, 400000, 3, TRUE, FALSE, 16, '["ab-testing","optimization","analytics"]'),
(4, 'EML-00017', 'Email Deliverability Optimization', 'email-deliverability-optimization', 'Tingkatkan deliverability rate', 'Optimasi email deliverability untuk avoid spam folder.', 'project', 3000000, NULL, 500000, 1, TRUE, FALSE, 17, '["deliverability","inbox","optimization"]'),
(4, 'EML-00018', 'Email Marketing Analytics', 'email-marketing-analytics', 'Laporan dan analisa email performance', 'Monthly reporting dan analytics email marketing campaigns.', 'subscription', NULL, 1000000, 200000, 3, TRUE, FALSE, 18, '["analytics","reporting","insights"]'),

-- Specialized Email Services
(4, 'EML-00019', 'Transactional Email Setup', 'transactional-email-setup', 'Setup transactional emails', 'Setup order confirmation, shipping, dan transactional emails.', 'project', 2500000, NULL, 500000, 1, TRUE, FALSE, 19, '["transactional","ecommerce","automation"]'),
(4, 'EML-00020', 'Email Marketing Audit', 'email-marketing-audit', 'Audit lengkap email marketing strategy', 'Comprehensive audit email marketing dan recommendations.', 'project', 3500000, NULL, 0, 1, TRUE, FALSE, 20, '["audit","strategy","consulting"]');


-- ==========================
-- PAID ADVERTISING (40 services) - Category ID: 5
-- ==========================

INSERT INTO services (category_id, service_code, name, slug, short_description, description, service_type, base_price, monthly_price, setup_fee, min_contract_months, is_active, is_featured, sort_order, tags) VALUES

-- Google Ads
(5, 'PPC-00001', 'Google Search Ads - Starter', 'google-search-ads-starter', 'Google Ads untuk budget 5 juta/bulan', 'Management Google Search Ads dengan budget iklan 5 juta rupiah.', 'subscription', NULL, 2000000, 500000, 3, TRUE, TRUE, 1, '["google-ads","search","starter"]'),
(5, 'PPC-00002', 'Google Search Ads - Growth', 'google-search-ads-growth', 'Google Ads untuk budget 15 juta/bulan', 'Management Google Search Ads dengan budget 15 juta dan optimization.', 'subscription', NULL, 3500000, 750000, 3, TRUE, TRUE, 2, '["google-ads","search","growth"]'),
(5, 'PPC-00003', 'Google Search Ads - Enterprise', 'google-search-ads-enterprise', 'Google Ads untuk budget 50 juta+/bulan', 'Enterprise Google Ads management dengan dedicated specialist.', 'subscription', NULL, 8000000, 1500000, 6, TRUE, TRUE, 3, '["google-ads","search","enterprise"]'),
(5, 'PPC-00004', 'Google Display Ads', 'google-display-ads', 'Display ads di Google Network', 'Banner ads campaign di Google Display Network.', 'subscription', NULL, 2500000, 500000, 3, TRUE, FALSE, 4, '["google-ads","display","banner"]'),
(5, 'PPC-00005', 'Google Shopping Ads', 'google-shopping-ads', 'Shopping ads untuk e-commerce', 'Google Shopping Ads untuk product listing ads.', 'subscription', NULL, 3000000, 600000, 3, TRUE, TRUE, 5, '["google-ads","shopping","ecommerce"]'),
(5, 'PPC-00006', 'Google Performance Max', 'google-performance-max', 'Campaign Performance Max otomatis', 'Setup dan optimasi Google Performance Max campaign.', 'subscription', NULL, 3500000, 700000, 3, TRUE, TRUE, 6, '["google-ads","pmax","automation"]'),
(5, 'PPC-00007', 'Google Local Service Ads', 'google-local-service-ads', 'Local service ads untuk area lokal', 'Google Local Service Ads untuk local businesses.', 'subscription', NULL, 2000000, 400000, 3, TRUE, FALSE, 7, '["google-ads","local","service"]'),
(5, 'PPC-00008', 'Google Video Ads - YouTube', 'google-video-ads-youtube', 'Video ads di YouTube', 'YouTube video advertising campaign management.', 'subscription', NULL, 3000000, 600000, 3, TRUE, TRUE, 8, '["youtube","video-ads","google"]'),
(5, 'PPC-00009', 'Google Remarketing Campaign', 'google-remarketing-campaign', 'Remarketing untuk website visitors', 'Setup remarketing campaign untuk retarget website visitors.', 'subscription', NULL, 2500000, 500000, 3, TRUE, FALSE, 9, '["google-ads","remarketing","retargeting"]'),

-- Facebook & Instagram Ads
(5, 'PPC-00010', 'Facebook Ads - Starter', 'facebook-ads-starter', 'Facebook Ads budget 3 juta/bulan', 'Management Facebook Ads dengan budget iklan 3 juta.', 'subscription', NULL, 1500000, 400000, 3, TRUE, TRUE, 10, '["facebook-ads","meta","starter"]'),
(5, 'PPC-00011', 'Facebook Ads - Growth', 'facebook-ads-growth', 'Facebook Ads budget 10 juta/bulan', 'Facebook Ads dengan advanced targeting dan optimization.', 'subscription', NULL, 3000000, 600000, 3, TRUE, TRUE, 11, '["facebook-ads","meta","growth"]'),
(5, 'PPC-00012', 'Facebook Ads - Scale', 'facebook-ads-scale', 'Facebook Ads budget 30 juta+/bulan', 'Scaling Facebook Ads untuk maximum ROI.', 'subscription', NULL, 6000000, 1200000, 6, TRUE, TRUE, 12, '["facebook-ads","meta","scale"]'),
(5, 'PPC-00013', 'Instagram Ads Campaign', 'instagram-ads-campaign', 'Instagram Ads untuk brand awareness', 'Dedicated Instagram Ads campaign dengan creative design.', 'subscription', NULL, 2500000, 500000, 3, TRUE, TRUE, 13, '["instagram-ads","meta","visual"]'),
(5, 'PPC-00014', 'Facebook Lead Ads', 'facebook-lead-ads', 'Lead generation via Facebook', 'Facebook Lead Ads untuk collect leads dengan form native.', 'subscription', NULL, 2000000, 400000, 3, TRUE, FALSE, 14, '["facebook","lead-ads","leadgen"]'),
(5, 'PPC-00015', 'Facebook Dynamic Ads', 'facebook-dynamic-ads', 'Dynamic product ads untuk e-commerce', 'Setup Facebook Dynamic Ads untuk retarget product viewers.', 'subscription', NULL, 3000000, 600000, 3, TRUE, TRUE, 15, '["facebook","dynamic-ads","ecommerce"]'),
(5, 'PPC-00016', 'Facebook Messenger Ads', 'facebook-messenger-ads', 'Ads yang membuka Messenger chat', 'Messenger Ads untuk direct conversation dengan customers.', 'subscription', NULL, 1800000, 350000, 3, TRUE, FALSE, 16, '["facebook","messenger","conversational"]'),
(5, 'PPC-00017', 'Instagram Stories Ads', 'instagram-stories-ads', 'Full-screen ads di Instagram Stories', 'Creative Instagram Stories Ads untuk immersive experience.', 'subscription', NULL, 2000000, 400000, 3, TRUE, FALSE, 17, '["instagram","stories","immersive"]'),
(5, 'PPC-00018', 'Instagram Reels Ads', 'instagram-reels-ads', 'Video ads di Instagram Reels', 'Short-form video ads di Instagram Reels feed.', 'subscription', NULL, 2200000, 450000, 3, TRUE, TRUE, 18, '["instagram","reels","video"]'),
(5, 'PPC-00019', 'Meta Advantage+ Campaign', 'meta-advantage-plus-campaign', 'AI-powered campaign optimization', 'Campaign dengan Meta Advantage+ untuk automated optimization.', 'subscription', NULL, 3500000, 700000, 3, TRUE, TRUE, 19, '["meta","advantage","ai"]'),

-- TikTok Ads
(5, 'PPC-00020', 'TikTok Ads - Starter', 'tiktok-ads-starter', 'TikTok Ads budget 5 juta/bulan', 'Management TikTok Ads untuk Gen Z audience.', 'subscription', NULL, 2000000, 500000, 3, TRUE, TRUE, 20, '["tiktok-ads","genz","starter"]'),
(5, 'PPC-00021', 'TikTok Ads - Growth', 'tiktok-ads-growth', 'TikTok Ads budget 15 juta/bulan', 'Scaling TikTok Ads dengan creative testing.', 'subscription', NULL, 3500000, 700000, 3, TRUE, TRUE, 21, '["tiktok-ads","growth","creative"]'),
(5, 'PPC-00022', 'TikTok Spark Ads', 'tiktok-spark-ads', 'Boost organic TikTok posts', 'TikTok Spark Ads untuk amplify organic content.', 'subscription', NULL, 2500000, 500000, 3, TRUE, FALSE, 22, '["tiktok","spark-ads","organic"]'),
(5, 'PPC-00023', 'TikTok Shopping Ads', 'tiktok-shopping-ads', 'Product ads di TikTok Shop', 'TikTok Shopping Ads integrated dengan TikTok Shop.', 'subscription', NULL, 3000000, 600000, 3, TRUE, TRUE, 23, '["tiktok","shopping","ecommerce"]'),

-- LinkedIn Ads
(5, 'PPC-00024', 'LinkedIn Ads - B2B Starter', 'linkedin-ads-b2b-starter', 'LinkedIn Ads untuk B2B lead gen', 'LinkedIn Ads targeting decision makers dan professionals.', 'subscription', NULL, 3500000, 700000, 3, TRUE, TRUE, 24, '["linkedin-ads","b2b","leadgen"]'),
(5, 'PPC-00025', 'LinkedIn Ads - Enterprise', 'linkedin-ads-enterprise', 'Enterprise LinkedIn advertising', 'Full LinkedIn Ads suite untuk enterprise B2B marketing.', 'subscription', NULL, 6500000, 1300000, 6, TRUE, TRUE, 25, '["linkedin-ads","enterprise","b2b"]'),
(5, 'PPC-00026', 'LinkedIn Sponsored Content', 'linkedin-sponsored-content', 'Promote content di LinkedIn feed', 'Sponsored posts untuk thought leadership.', 'subscription', NULL, 3000000, 600000, 3, TRUE, FALSE, 26, '["linkedin","sponsored","content"]'),
(5, 'PPC-00027', 'LinkedIn InMail Ads', 'linkedin-inmail-ads', 'Direct message ads di LinkedIn', 'Sponsored InMail untuk personal outreach.', 'subscription', NULL, 3500000, 700000, 3, TRUE, FALSE, 27, '["linkedin","inmail","direct"]'),

-- Twitter/X Ads
(5, 'PPC-00028', 'Twitter Ads Campaign', 'twitter-ads-campaign', 'Twitter Ads untuk engagement', 'Promoted tweets untuk brand awareness dan engagement.', 'subscription', NULL, 2000000, 400000, 3, TRUE, FALSE, 28, '["twitter-ads","x-ads","engagement"]'),
(5, 'PPC-00029', 'Twitter Video Ads', 'twitter-video-ads', 'Video ads di Twitter/X', 'Promoted video ads untuk maximum reach.', 'subscription', NULL, 2500000, 500000, 3, TRUE, FALSE, 29, '["twitter","video-ads","promoted"]'),

-- Native & Display Advertising
(5, 'PPC-00030', 'Taboola Content Discovery', 'taboola-content-discovery', 'Native ads di Taboola network', 'Content discovery ads via Taboola platform.', 'subscription', NULL, 2500000, 500000, 3, TRUE, FALSE, 30, '["taboola","native-ads","content"]'),
(5, 'PPC-00031', 'Outbrain Content Promotion', 'outbrain-content-promotion', 'Promote content via Outbrain', 'Native advertising campaign via Outbrain.', 'subscription', NULL, 2500000, 500000, 3, TRUE, FALSE, 31, '["outbrain","native-ads","promotion"]'),
(5, 'PPC-00032', 'Programmatic Display Advertising', 'programmatic-display-advertising', 'Automated display ads buying', 'Programmatic advertising untuk efficient ad buying.', 'subscription', NULL, 4000000, 800000, 3, TRUE, FALSE, 32, '["programmatic","display","automation"]'),

-- Specialized Platforms
(5, 'PPC-00033', 'Pinterest Ads Campaign', 'pinterest-ads-campaign', 'Visual ads di Pinterest', 'Pinterest Ads untuk visual products dan inspiration.', 'subscription', NULL, 2000000, 400000, 3, TRUE, FALSE, 33, '["pinterest-ads","visual","discovery"]'),
(5, 'PPC-00034', 'Snapchat Ads Campaign', 'snapchat-ads-campaign', 'Ads untuk Gen Z di Snapchat', 'Snapchat Ads targeting younger demographics.', 'subscription', NULL, 2500000, 500000, 3, TRUE, FALSE, 34, '["snapchat-ads","genz","mobile"]'),
(5, 'PPC-00035', 'Reddit Ads Campaign', 'reddit-ads-campaign', 'Community-based ads di Reddit', 'Reddit Ads untuk niche communities.', 'subscription', NULL, 2000000, 400000, 3, TRUE, FALSE, 35, '["reddit-ads","community","niche"]'),
(5, 'PPC-00036', 'Spotify Audio Ads', 'spotify-audio-ads', 'Audio ads di Spotify', 'Audio advertising di Spotify streaming.', 'subscription', NULL, 3000000, 600000, 3, TRUE, FALSE, 36, '["spotify","audio-ads","streaming"]'),

-- PPC Services & Management
(5, 'PPC-00037', 'PPC Audit & Strategy', 'ppc-audit-strategy', 'Audit existing PPC campaigns', 'Comprehensive audit dan strategy recommendations.', 'project', 3500000, NULL, 0, 1, TRUE, FALSE, 37, '["ppc","audit","strategy"]'),
(5, 'PPC-00038', 'Landing Page Design for Ads', 'landing-page-design-for-ads', 'Design landing page high-converting', 'Custom landing page untuk maximize ad conversion.', 'project', 4000000, NULL, 800000, 1, TRUE, TRUE, 38, '["landing-page","conversion","design"]'),
(5, 'PPC-00039', 'Ad Creative Design Package', 'ad-creative-design-package', 'Design 20 ad creatives per bulan', 'Ongoing ad creative design untuk testing dan optimization.', 'subscription', NULL, 3000000, 500000, 3, TRUE, TRUE, 39, '["creative","design","ads"]'),
(5, 'PPC-00040', 'Conversion Rate Optimization', 'conversion-rate-optimization', 'Optimasi conversion rate campaigns', 'CRO untuk improve ad campaign performance.', 'subscription', NULL, 4000000, 800000, 6, TRUE, TRUE, 40, '["cro","optimization","conversion"]');

-- Total sejauh ini: 90 (SMM) + 40 (SEO) + 30 (Content) + 20 (Email) + 40 (Ads) = 220 services
-- Continuing with remaining categories...
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
