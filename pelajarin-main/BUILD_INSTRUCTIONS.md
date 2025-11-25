# SITUNEO DIGITAL - COMPLETE BUILD SPECIFICATION

**Target:** Website Paling Bagus & Paling Mahal Se-Indonesia! 🏆  
**Output:** 400+ Files + 85 Tables + 50 Demos  
**Quality:** Production-Ready, Secure, Fast, Beautiful  

---

# 🎯 PROJECT SCOPE

## A. FILES TO GENERATE (400+ Total)

### Core Files (~50 files)
```
/config/
  - database.php (MySQL connection)
  - constants.php (company info, paths, settings)
  - email.php (SMTP settings, PHPMailer)
  - session.php (session config)
  - security.php (CSRF, XSS prevention)
  
/core/
  - Database.php (PDO wrapper)
  - Auth.php (authentication)
  - Session.php (session manager)
  - Validator.php (form validation)
  - Mailer.php (email sending)
  - Uploader.php (file upload handler)
  - Router.php (URL routing)
  
/helpers/
  - common.php (utility functions)
  - validation.php (validation rules)
  - formatting.php (format currency, date, etc)
  - security.php (sanitize, hash, etc)
```

### Authentication (~10 files)
```
/auth/
  - login.php
  - register-client.php
  - register-partner.php (dengan upload KTP/CV)
  - logout.php
  - forgot-password.php
  - reset-password.php
  - verify-email.php
```

### Public Pages (~15 files)
```
/
  - index.php (homepage - PREMIUM design)
  - about.php (company profile)
  - services.php (232+ layanan preview)
  - pricing.php (pricing calculator)
  - portfolio.php (50 demos showcase)
  - contact.php (contact form)
  - leaderboard.php (PUBLIC - top partners/spv/managers)
```

### Client Dashboard (~20 files)
```
/client/
  - index.php (dashboard overview)
  - orders/index.php (list orders)
  - orders/create.php (order baru)
  - orders/detail.php (order detail)
  - demo-request/form.php (26 FIELDS!)
  - payments/index.php (payment history)
  - payments/upload.php (upload bukti transfer)
  - invoices/index.php (invoice list)
  - invoices/download.php (generate PDF)
  - support/tickets.php
  - profile/edit.php
```

### Partner Dashboard (~30 files)
```
/partner/
  - index.php (dashboard)
  - earnings/index.php (overview)
  - earnings/history.php
  - earnings/breakdown.php
  - referral/link.php (generate link + QR)
  - referral/clients.php (client list)
  - withdrawal/request.php
  - withdrawal/history.php
  - tier/progression.php (tier tracking)
  - tasks/index.php (job board dari admin)
  - tasks/detail.php
  - stats/performance.php
  - leaderboard/public.php
  - profile/edit.php
```

### SPV Dashboard (~35 files)
```
/spv/
  - index.php (dashboard)
  - team/index.php (partner list)
  - team/performance.php
  - team/detail.php (per partner)
  - earnings/index.php
  - earnings/base-commission.php (10%)
  - earnings/bonus-tier.php (ARPU bonus)
  - arpu-tracking.php (real-time ARPU)
  - referral/link.php (SPV→Partner)
  - referral/recruits.php
  - withdrawal/request.php
  - withdrawal/history.php
  - leaderboard/team.php
  - profile/edit.php
```

### Manager Dashboard (~35 files)
```
/manager/
  - index.php (dashboard)
  - area-management/overview.php
  - area-management/spv-list.php
  - area-management/partner-list.php
  - area-management/hierarchy.php (tree view)
  - earnings/index.php
  - earnings/base-commission.php (5%)
  - earnings/bonus-tier.php (ARPU bonus)
  - arpu-tracking.php (real-time ARPU area)
  - referral/link.php (Manager→SPV)
  - withdrawal/request.php
  - withdrawal/history.php
  - reports/area-performance.php
  - profile/edit.php
```

### Admin Panel (~100 files)
```
/admin/
  - index.php (dashboard GOD MODE)
  
  - users/index.php (all users)
  - users/clients.php
  - users/partners.php
  - users/spv.php
  - users/managers.php
  - users/detail.php
  - users/edit.php
  
  - hierarchy/overview.php (tree view SEMUA)
  - hierarchy/assign-spv.php
  - hierarchy/assign-manager.php
  - hierarchy/reassign.php
  
  - services/index.php (232+ layanan)
  - services/create.php
  - services/edit.php
  - services/categories.php
  
  - orders/index.php (all orders)
  - orders/detail.php
  - orders/assign-partner.php
  - orders/update-status.php
  
  - payments/pending-verification.php
  - payments/approve.php
  - payments/reject.php
  - payments/history.php
  
  - partners/applications.php (pending approval)
  - partners/approve.php
  - partners/reject.php
  - partners/manage-tier.php
  
  - commissions/overview.php
  - commissions/partner.php
  - commissions/spv.php
  - commissions/manager.php
  - commissions/manual-adjust.php
  
  - demo-requests/index.php (list 26 fields)
  - demo-requests/detail.php (dengan "Salin Data" button!)
  
  - withdrawals/pending.php
  - withdrawals/approve.php
  - withdrawals/history.php
  
  - tasks/create.php (post tugas)
  - tasks/applications.php
  - tasks/assign.php
  - tasks/review.php
  
  - website/homepage.php (edit content)
  - website/services.php
  - website/pricing.php
  - website/portfolio.php
  - website/about.php
  - website/contact.php
  
  - reports/revenue.php
  - reports/orders.php
  - reports/partners.php
  - reports/conversion.php
  
  - settings/company.php
  - settings/email.php
  - settings/backup.php
  - settings/tiers.php
```

### Demo Websites (50 × ~5-8 files = 250-400 files)
```
/demos/toko-baju-modis-jakarta/
  - index.php (homepage)
  - about.php
  - products.php
  - gallery.php
  - contact.php
  - assets/ (CSS, JS, images)

/demos/restoran-nusantara-enak/
  - index.php
  - menu.php
  - about.php
  - gallery.php
  - contact.php
  - assets/

... (48 demos lainnya dengan struktur similar)
```

### Components & Includes (~30 files)
```
/includes/
  - header.php
  - footer.php
  - navigation.php (dynamic per role)
  - sidebar-client.php
  - sidebar-partner.php
  - sidebar-spv.php
  - sidebar-manager.php
  - sidebar-admin.php
  - loading-screen.php (dinamis per page)
  - network-particle.php (canvas animation)
  - nib-badge.php (footer)
  - whatsapp-button.php
  - demo-banner.php (floating)
  - demo-popup.php (homepage 10 detik)
```

### Assets
```
/assets/
  - css/
    - style.css (global)
    - admin.css
    - dashboard.css
    - animations.css
  - js/
    - main.js
    - network-particle.js (30-40 particles LOW)
    - loading-screen.js
    - dashboard.js
    - charts.js (ARPU tracking, commission charts)
  - images/
    - logo.png
    - favicon.ico
    - placeholders/
```

---

## B. DATABASE SCHEMA (85 TABLES)

### Users & Auth (10 tables)
```sql
1. users (id, username, email, password_hash, role, status, created_at)
2. user_sessions (session tracking)
3. user_activity_logs (activity monitoring)
4. user_permissions (role permissions)
5. password_resets (forgot password tokens)
6. email_verifications (email confirmation)
7. login_attempts (rate limiting)
```

### Clients (6 tables)
```sql
8. clients (user_id, company_name, phone, address, referral_partner_id)
9. client_orders
10. client_payments
11. client_invoices
12. client_demo_requests (26 FIELDS!)
13. client_notifications
```

### Partners (10 tables)
```sql
14. partners (user_id, tier, monthly_orders, spv_id, manager_id, ktp_file, cv_file)
15. partner_tiers (tier tracking)
16. partner_tier_history (tier changes log)
17. partner_referral_codes (custom username, QR code)
18. partner_commissions (order-based earnings)
19. partner_withdrawals (payout requests)
20. partner_applications (pending approval dengan KTP/CV)
21. partner_documents (uploaded files)
22. partner_tasks (job board assignments)
23. partner_task_applications
```

### SPV (8 tables)
```sql
24. spv_profiles (area_name, target_arpu)
25. spv_teams (partner assignments)
26. spv_base_commissions (10% earnings)
27. spv_bonus_tiers (ARPU-based: 15M/35M/75M/200M)
28. spv_arpu_monthly (monthly ARPU calculation)
29. spv_performance_stats
30. spv_referral_codes (SPV→Partner link)
31. spv_leaderboard_stats
```

### Managers (8 tables)
```sql
32. manager_profiles (area_name, target_arpu)
33. manager_areas (coverage area)
34. manager_spv_teams (SPV assignments)
35. manager_base_commissions (5% earnings)
36. manager_bonus_tiers (ARPU-based: 45M/105M/225M/600M)
37. manager_arpu_monthly (monthly ARPU calculation)
38. manager_performance_stats
39. manager_referral_codes (Manager→SPV link)
```

### Hierarchy (4 tables)
```sql
40. hierarchy_structures (partner→spv→manager mapping)
41. hierarchy_history (reassignment logs)
42. hierarchy_commissions (cascade breakdown per order)
43. hierarchy_reassignments (admin changes)
```

### Services (7 tables)
```sql
44. services (232+ layanan)
45. service_categories (10 divisi)
46. service_subcategories
47. service_pricing (one-time & monthly)
48. business_categories (53 kategori)
49. website_types (1500+ auto-generated)
50. service_images
```

### Orders (5 tables)
```sql
51. orders (order tracking)
52. order_items (line items)
53. order_status_history (status changes)
54. order_files (deliverables)
55. order_assignments (partner assignments)
```

### Payments (5 tables)
```sql
56. payments (payment tracking)
57. payment_methods (bank accounts, QRIS)
58. payment_proofs (uploaded images)
59. invoices (INV-SITUNEO-DD-MMM-YYYY format)
60. invoice_items
```

### Demos (3 tables)
```sql
61. demo_requests (26 fields dari client)
62. demo_websites (50 showcase demos)
63. demo_categories
```

### Commissions (6 tables)
```sql
64. commissions (all commission records)
65. commission_splits (cascade breakdown)
66. commission_history (transaction log)
67. arpu_calculations (real-time ARPU)
68. bonus_payouts (SPV/Manager bonuses)
69. commission_adjustments (admin manual adjustments)
```

### Withdrawals (4 tables)
```sql
70. withdrawals (payout requests min 50K)
71. withdrawal_history
72. withdrawal_bank_accounts
73. withdrawal_approvals
```

### Admin Tasks (5 tables)
```sql
74. admin_tasks (job postings)
75. task_applications (partner applies)
76. task_assignments (admin assigns)
77. task_submissions (partner submits work)
78. task_payments (commission payouts)
```

### Website Content (6 tables)
```sql
79. homepage_content (editable sections)
80. services_content
81. pricing_content
82. portfolio_content
83. about_content
84. contact_content
```

### Leaderboard (4 tables)
```sql
85. leaderboard_partners (public rankings)
86. leaderboard_spv
87. leaderboard_managers
88. leaderboard_history
```

**PLUS 2-5 tables optional untuk extend:**
```sql
89. admin_settings
90. email_templates
91. smtp_settings
92. notifications
93. support_tickets
```

---

## C. AUTOMATION REQUIREMENTS

### 1. Commission Calculation (Real-Time)
```php
// Trigger: Admin approve order + serah terima
// Calculate:
// - Partner: (amount × tier %)
// - SPV: (amount × 10%) if partner has SPV
// - Manager: (amount × 5%) if SPV has Manager
// - Update balances instantly
```

### 2. ARPU Tracking (Real-Time)
```php
// For SPV:
// ARPU = Total revenue from all partners / 1 month
// Update every order approved
// Check bonus tier: 15M/35M/75M/200M

// For Manager:
// ARPU = Total revenue from all SPV+Partners in area / 1 month
// Update every order approved
// Check bonus tier: 45M/105M/225M/600M
```

### 3. Tier Progression (Automatic)
```php
// Partner tiers:
// Count monthly orders (reset every month)
// Tier 1: 0-10 → 30%
// Tier 2: 10-25 → 40%
// Tier 3: 50+ → 50%
// Tier MAX: 75+ → 55%
// MAINTENANCE: Tidak pernah turun! (kriteria maintenance)
// Auto upgrade jika reach target
```

### 4. Email Notifications (11 Types Auto)
```php
1. Registration confirmation (client/partner)
2. Partner application submitted (to admin)
3. Partner approved/rejected (to partner)
4. Order notification (to client, admin, assigned partner)
5. Payment uploaded (to admin)
6. Payment verified (to client)
7. Order completed (to client)
8. Commission earned (to partner/spv/manager)
9. Withdrawal requested (to admin)
10. Withdrawal approved (to requester)
11. Demo request submitted (to admin)

// Use PHPMailer
// SMTP or sendmail
// Template-based (HTML email)
```

### 5. Invoice Generation
```php
// Format: INV-SITUNEO-DD-MMM-YYYY
// Example: INV-SITUNEO-12-NOV-2025
// PDF generation (FPDF or TCPDF)
// Email auto to client
```

### 6. Referral Link Tracking
```php
// Cookie: 30 days
// Track: clicks, registrations, conversions
// Auto-assign hierarchy when user registers
```

---

## D. DESIGN SPECIFICATIONS

### Colors (Consistent di SEMUA halaman!)
```css
:root {
  --primary-blue: #1E5C99;
  --dark-blue: #0F3057;
  --gold: #FFB400;
  --bright-gold: #FFD700;
  --white: #ffffff;
  --text-light: #e9ecef;
  
  --gradient-primary: linear-gradient(135deg, #1E5C99 0%, #0F3057 100%);
  --gradient-gold: linear-gradient(135deg, #FFD700 0%, #FFB400 100%);
}
```

### Typography
```css
body {
  font-family: 'Inter', sans-serif;
}

h1, h2, h3, h4, h5, h6 {
  font-family: 'Plus Jakarta Sans', sans-serif;
}
```

### Animations (SEMUA Halaman)
```javascript
// 1. Loading Screen
// - Logo fade in + scale up
// - Text dinamis: "Memuat Dashboard Client..." (sesuai halaman)
// - Duration: 1-2 detik

// 2. Network Particle (Canvas)
// - 30-40 particles (LOW intensity)
// - Gold color dengan glow
// - Connection lines <100px
// - Z-index: -2

// 3. Circuit Pattern Overlay
// - CSS grid pattern
// - Opacity: 0.05
// - Slow animation (60s loop)

// 4. NIB Badge (Footer)
// - Medium size
// - Pulse animation setiap 3 detik
// - Clickable (link to legalitas info)

// 5. WhatsApp Button
// - Fixed bottom right
// - Pulse animation setiap 2 detik
// - Link: wa.me/6283173868915

// 6. FREE DEMO Banner
// - Floating (always visible)
// - CTA: "Minta Demo Gratis"
// - Link to demo request (login required)

// 7. Demo Pop-up (Homepage Only)
// - Muncul 10 detik after load
// - Modal overlay
// - Easy close (X button)
// - Cookie: Show once per session
```

---

## E. SPECIAL FEATURES

### 1. Demo Request Form (26 FIELDS!)
```php
// Location: /client/demo-request/form.php

// Bagian 1: Tentang Usaha (3 fields)
1. Nama usaha/sekolah/organisasi
2. Ceritakan tentang usaha Anda
3. Tujuan website

// Bagian 2: Tampilan (3 fields)
4. Warna utama yang diinginkan
5. Gaya tampilan (dropdown: Modern/Classic/Minimalist/Bold)
6. Contoh website favorit (URL - optional)

// Bagian 3: Halaman (2 fields)
7. Halaman yang dibutuhkan (checkbox: Home/About/Services/Products/etc)
8. Isi tiap halaman (textarea per halaman)

// Bagian 4: Fitur (2 fields)
9. Fitur yang diinginkan (checkbox: Form/Chat/Booking/Payment/etc)
10. Website 2 bahasa? (Yes/No)

// Bagian 5: Gambar & Logo (2 fields)
11. Upload logo (optional, max 2MB)
12. Upload foto produk (multiple, optional, max 5MB total)

// Bagian 6: Isi & Kontak (6 fields)
13. Tagline/kalimat pembuka homepage
14. Deskripsi singkat usaha (2-3 paragraf)
15. Alamat lengkap
16. No. Telepon/WhatsApp
17. Email
18. Akun sosial media (IG, FB, dll)

// Bagian 7: Catatan (2 fields)
19. Target waktu selesai (dropdown: 7/14/30 hari/Fleksibel)
20. Catatan tambahan (textarea - optional)

// Tambahan (6 fields)
21. Budget range (dropdown: <1jt/1-3jt/3-5jt/>5jt)
22. Kompetitor website (URL - optional)
23. Target audience
24. Call to Action utama
25. Content: Sudah siap atau perlu bantuan?
26. Maintenance: Kelola sendiri atau full service?

// Submit:
// - Save to database
// - Email to admin
// - Email confirmation to client
// - Status: Pending Review
```

### 2. "Salin Data" Button (Admin Only)
```php
// Location: /admin/demo-requests/detail.php

// Button: "Salin Data" (BUKAN "Copy for AI")
// When clicked: Copy ALL 26 fields to clipboard

// Format:
===== DEMO REQUEST DETAILS =====
Nama Usaha: [value]
Deskripsi: [value]
Tujuan: [value]
Warna Utama: [value]
... (all 26 fields)
================================

// Biar AI langsung paham ketika admin paste ke ChatGPT/Claude
```

### 3. Public Leaderboard (No Login Required)
```php
// Location: /leaderboard.php

// Show:
// - Top 10 Partners (nama, total orders, total revenue - optional)
// - Top 10 SPV (nama, team size, total orders, ARPU)
// - Top 10 Managers (nama, area, total SPV, total partners, ARPU)

// Real-time ranking
// Update daily via cron job
// Transparent untuk motivasi kompetisi
```

### 4. Admin Task Posting
```php
// Location: /admin/tasks/create.php

// Admin post tugas:
// - Title
// - Description
// - Requirements
// - Deadline
// - Commission amount
// - Status: Open

// Broadcast ke semua partner dashboard
// Email notif ke all partners
// Partner apply: "Saya Minat!"
// Admin approve & assign
// Partner submit work
// Admin review & approve
// Commission masuk balance partner
```

---

## F. SECURITY REQUIREMENTS

### Mandatory Security Features
```php
// 1. Password Hashing
password_hash($password, PASSWORD_BCRYPT);

// 2. CSRF Protection
// Generate token per session
// Validate on all POST requests

// 3. SQL Injection Prevention
// Use PDO prepared statements
// NEVER use raw queries

// 4. XSS Protection
htmlspecialchars($input, ENT_QUOTES, 'UTF-8');

// 5. Session Security
ini_set('session.cookie_httponly', 1);
ini_set('session.cookie_secure', 1);
ini_set('session.cookie_samesite', 'Strict');

// 6. File Upload Validation
// - Check MIME type
// - Check file extension
// - Check file size (max 2-5MB)
// - Rename file (random name)
// - Store outside web root or protect with .htaccess

// 7. Rate Limiting
// Max 5 login attempts per 15 minutes
// Log IP address

// 8. .htaccess Rules
// - Disable directory listing
// - Block direct PHP execution in uploads
// - Force HTTPS
```

---

## G. PERFORMANCE OPTIMIZATION

### Requirements
```php
// 1. Image Optimization
// - Lazy loading
// - WebP format (fallback JPG/PNG)
// - Auto compress on upload
// - Max width: 1920px

// 2. CSS/JS
// - Minify production files
// - Combine multiple files
// - Use CDN for libraries (Bootstrap, jQuery, icons)

// 3. Database
// - Index frequently queried columns
// - Optimize queries (avoid N+1)
// - Use LIMIT for pagination

// 4. Caching
// - Browser caching (headers)
// - OPcache for PHP
// - Consider Redis for sessions (optional)

// 5. Target Performance
// - Page load: <3 seconds
// - TTFB: <500ms
// - Mobile-first optimization
```

---

## H. SEO CONFIGURATION

### Required SEO Features
```html
<!-- Meta Tags (Every Page) -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="[Page specific description]">
<meta name="keywords" content="[relevant keywords]">
<meta name="author" content="SITUNEO Digital">

<!-- Open Graph (Social Media) -->
<meta property="og:title" content="[Page title]">
<meta property="og:description" content="[Page description]">
<meta property="og:image" content="[Image URL]">
<meta property="og:url" content="[Page URL]">
<meta property="og:type" content="website">

<!-- Twitter Card -->
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="[Page title]">
<meta name="twitter:description" content="[Page description]">
<meta name="twitter:image" content="[Image URL]">

<!-- Schema Markup (JSON-LD) -->
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "SITUNEO Digital",
  "url": "https://situneo.my.id",
  "logo": "https://situneo.my.id/assets/images/logo.png",
  "contactPoint": {
    "@type": "ContactPoint",
    "telephone": "+62-831-7386-8915",
    "contactType": "Customer Service"
  }
}
</script>

<!-- Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-RPW3MZ3RPY"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-RPW3MZ3RPY');
</script>
```

### Files to Create
```
robots.txt
sitemap.xml (auto-generated)
.htaccess (security + SEO rules)
```

---

## I. DELIVERABLES

### Package Contents
```
situneo-digital.zip
├── /config/ (configuration files)
├── /core/ (core classes)
├── /helpers/ (utility functions)
├── /auth/ (authentication)
├── /client/ (client dashboard)
├── /partner/ (partner dashboard)
├── /spv/ (spv dashboard)
├── /manager/ (manager dashboard)
├── /admin/ (admin panel)
├── /demos/ (50 demo websites)
├── /leaderboard/ (public leaderboard)
├── /includes/ (components)
├── /assets/ (CSS, JS, images)
├── /database/
│   └── situneo_complete.sql (85+ tables)
├── index.php (homepage)
├── about.php
├── services.php
├── pricing.php
├── portfolio.php
├── contact.php
├── .htaccess
├── robots.txt
├── sitemap.xml
├── .env.example
└── README.md (installation guide)
```

### Test Accounts (Create in SQL)
```sql
-- Admin
INSERT INTO users VALUES (1, 'admin', 'admin@situneo.my.id', '[hashed:admin123]', 'admin', 'active', NOW());

-- Client
INSERT INTO users VALUES (2, 'client', 'client@situneo.my.id', '[hashed:client123]', 'client', 'active', NOW());

-- Partner
INSERT INTO users VALUES (3, 'partner', 'partner@situneo.my.id', '[hashed:partner123]', 'partner', 'active', NOW());

-- SPV
INSERT INTO users VALUES (4, 'spv', 'spv@situneo.my.id', '[hashed:spv123]', 'spv', 'active', NOW());

-- Manager
INSERT INTO users VALUES (5, 'manager', 'manager@situneo.my.id', '[hashed:manager123]', 'manager', 'active', NOW());
```

---

## J. QUALITY CHECKLIST

Before delivery, verify:

### Code Quality
- [ ] All files use consistent coding style
- [ ] No hardcoded credentials (use .env)
- [ ] All functions documented
- [ ] No PHP warnings/errors
- [ ] Code follows PSR standards

### Functionality
- [ ] All 5 dashboards working
- [ ] Commission calculation accurate
- [ ] ARPU tracking real-time
- [ ] Tier progression automatic
- [ ] Email notifications sending
- [ ] File uploads working (KTP/CV)
- [ ] 26-field demo form working
- [ ] "Salin Data" button working
- [ ] Public leaderboard showing
- [ ] 50 demos accessible

### Security
- [ ] CSRF tokens on all forms
- [ ] SQL injection prevented
- [ ] XSS escaped on all output
- [ ] File uploads validated
- [ ] Sessions secure
- [ ] Passwords hashed
- [ ] Rate limiting active

### Performance
- [ ] Page load <3 seconds
- [ ] Images optimized
- [ ] CSS/JS minified
- [ ] Database indexed
- [ ] No N+1 queries

### SEO
- [ ] Meta tags on all pages
- [ ] Schema markup added
- [ ] Google Analytics working
- [ ] robots.txt present
- [ ] sitemap.xml generated

### Mobile Responsive
- [ ] All pages mobile-friendly
- [ ] Touch-friendly buttons
- [ ] Readable text (min 16px)
- [ ] No horizontal scroll
- [ ] Fast on mobile (<3s)

---

## K. CRITICAL NOTES

### 1. MODULAR Architecture
```
Every file = 1 purpose
Easy to find, easy to edit
Simple naming ("orang bodoh pun tahu")
```

### 2. NO Dummy Data
```
NO fake users
NO fake orders
NO fake partners
ONLY dummy for 50 demo websites
```

### 3. AUTOMATION First
```
Commission: Auto calculate
ARPU: Real-time update
Tier: Auto upgrade
Emails: Auto send
Invoice: Auto generate
```

### 4. MOBILE First
```
Design for mobile FIRST
Desktop is secondary
Perfect responsive
Touch-friendly
Fast loading
```

### 5. KONSISTEN Total
```
Brand colors EVERYWHERE
Design patterns consistent
UX flow sama
Navigation similar across roles
```

---

## L. SUCCESS CRITERIA

Website is successful when:
✅ 400+ files generated & organized
✅ 85 database tables created
✅ 50 demo websites production-ready
✅ 5 dashboards fully functional
✅ All automation working
✅ All security implemented
✅ Performance <3 seconds
✅ Mobile responsive perfect
✅ SEO complete
✅ Zero critical bugs
✅ Production-ready to deploy

---

## 🎯 TARGET QUALITY

**"Website Paling Bagus & Paling Mahal Se-Indonesia!"**

- Design: Premium, WOW factor
- Features: Lengkap & sophisticated
- Performance: Lightning fast
- Security: Fort Knox level
- UX: Intuitive & delightful
- Code: Clean & maintainable

---

## 🚀 BUILD IT NOW!

Generate EVERYTHING according to this specification.
No shortcuts. No compromises.
Production-ready quality only.

**LET'S GO!** 💪✨
