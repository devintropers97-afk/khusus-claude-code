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
