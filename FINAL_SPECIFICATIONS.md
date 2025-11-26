# 🚀 SITUNEO DIGITAL - FINAL COMPLETE SPECIFICATIONS
## PT SITUNEO DIGITAL SOLUSI INDONESIA

**Document Version:** 1.0 FINAL
**Date:** November 26, 2025
**Status:** ✅ READY FOR DEVELOPMENT

---

## ⚠️ CRITICAL: THIS IS THE DEFINITIVE SPECIFICATION

This document represents the **FINAL, COMPLETE, and AUTHORITATIVE** specifications for the SITUNEO DIGITAL platform. All development MUST follow these specifications exactly.

**Key Decisions Finalized:**
- ✅ Database: 120 tables (super lengkap)
- ✅ Commission: Tier-based + ARPU bonus
- ✅ Pricing: Rp 350K beli vs Rp 150K/month sewa
- ✅ Payment: Manual dulu (fase 2 gateway)
- ✅ Services: ALL 306 services implemented
- ✅ Dashboard: Full advanced dari awal
- ✅ Job Board: Included (admin-posted, partner claim)
- ✅ Tech Stack: Bootstrap + Vue.js/React
- ✅ Email: Full automation (14+ templates)
- ✅ Blog: Company blog + optional client blogs
- ✅ Hosting: Shared hosting (cPanel)

---

## 📋 TABLE OF CONTENTS

1. [Company Information](#company-information)
2. [System Architecture](#system-architecture)
3. [Role System (5 Roles + 5 Admin Types)](#role-system)
4. [Commission Structure](#commission-structure)
5. [Complete Service Catalog (306 Services)](#complete-service-catalog)
6. [Database Structure (120 Tables)](#database-structure)
7. [Job Board System](#job-board-system)
8. [Pricing Model](#pricing-model)
9. [Dashboard Specifications](#dashboard-specifications)
10. [Email System](#email-system)
11. [50 Demo Websites](#demo-websites)
12. [Tech Stack](#tech-stack)
13. [Development Roadmap](#development-roadmap)

---

## 1. COMPANY INFORMATION

### Official Business Details

**Legal Entity:**
- **Nama Resmi:** PT SITUNEO DIGITAL SOLUSI INDONESIA
- **NIB (Nomor Induk Berusaha):** 20250-9261-4570-4515-5453
- **NPWP:** 90.296.264.6-002.000
- **Direktur Utama:** Devin Prasetyo Hermawan
- **Tahun Berdiri:** 2020

### Contact Information

**Primary Contacts:**
- **Website:** https://situneo.my.id
- **Email Utama:** vins@situneo.my.id
- **Email Support:** support@situneo.my.id
- **WhatsApp:** +62 831-7386-8915 ✅ **CORRECT NUMBER**
- **Telepon Kantor:** 021-8880-7229

**Office Address:**
```
Jl. Bekasi Timur IX Dalam No. 27
RT 002/RW 003
Kelurahan Rawa Bunga
Kecamatan Jatinegara
Jakarta Timur 13450
DKI Jakarta, Indonesia
```

**Google Maps Coordinates:**
- Latitude: -6.2388
- Longitude: 106.8753

### Social Media

- **Instagram:** @situneodigital
- **Facebook:** @situneodigital
- **LinkedIn:** /company/situneodigital
- **TikTok:** @situneodigital
- **YouTube:** @situneo

### Operating Hours

- **Senin - Jumat:** 09:00 - 18:00 WIB
- **Sabtu:** 09:00 - 15:00 WIB
- **Minggu:** Tutup
- **WhatsApp Support:** 24/7 (response time < 2 jam during business hours)

### Bank Account

**Payment Recipients:**
- **BCA:** 2750424018 A/N Devin Prasetyo Hermawan
- **QRIS:** Semua bank (to be setup)
- **Payment Gateway:** Xendit/Midtrans (Fase 2)

### Brand Identity

**Tagline:** "Build Your Future, Today"
**Philosophy:** SITUNEO = SITU (Situs/Website) + NEO (New/Baru)
**Meaning:** New Generation Digital Platform

**Vision 2035:**
Menjadi platform pemberdayaan digital terbesar di Indonesia

**Mission:**
1. Menyediakan solusi digital berkualitas tinggi dengan harga terjangkau
2. Membantu bisnis lokal go digital
3. Memberikan training dan edukasi digital
4. Membangun ekosistem freelancer dengan sistem komisi adil
5. Menjaga kepuasan client melalui support 24/7

### Statistics (Target)

- **Clients:** 500+
- **Projects Completed:** 1200+
- **Satisfaction Rating:** 4.9/5.0 (98%)
- **Team Members:** 4 core + partners
- **Verified Reviews:** 450+

### Core Team (4 Members)

1. **Devin Prasetyo Hermawan**
   Position: CEO & Founder
   Expertise: 8+ years tech & digital marketing

2. **Budi Santoso**
   Position: Chief Technology Officer
   Expertise: Full-stack developer (PHP/Node.js)

3. **Sarah Wijaya**
   Position: Creative Director & Head of Design
   Expertise: 200+ project portfolio

4. **Maya Putri**
   Position: Head of Digital Marketing
   Expertise: SEO, Google Ads, Social Media

---

## 2. SYSTEM ARCHITECTURE

### Platform Overview

SITUNEO DIGITAL adalah platform digital agency dengan sistem multi-role yang memungkinkan:
- **Clients** memesan layanan digital
- **Partners** mencari client dan mendapat komisi
- **SPV** mengelola team partner
- **Manager Area** mengelola regional/area
- **Admin** mengontrol semua operasional

### Key Features

✅ **306 Digital Services** across 10 specialized divisions
✅ **5-Role Hierarchical System** dengan cascade commission
✅ **Job Board System** untuk tugas tambahan
✅ **50 Demo Websites** showcase
✅ **Free 24-Hour Demo** untuk prospective clients
✅ **26-Field Demo Request Form** super detail
✅ **Advanced Analytics Dashboard** dengan AI predictions
✅ **Full Email Automation** (14+ templates)
✅ **Multi-Admin Structure** (1 super admin + 4 specialized admins)
✅ **Blog System** untuk company dan client
✅ **Commission Auto-Calculation** on order completion

### System Flow

```
1. CLIENT registers atau request demo
2. CLIENT order service (dengan atau tanpa referral partner)
3. ADMIN 1 (Client Service) terima order, assign ke team internal
4. Team SITUNEO mengerjakan project
5. Client bayar (upload bukti transfer)
6. ADMIN approve payment → Komisi auto-calculate
7. Partner (jika ada referral) dapat komisi masuk saldo
8. Project selesai → client dapat hasil
9. Client bisa review & rating

PARALLEL FLOW - Job Board:
1. SUPER ADMIN post job/tugas tambahan ke dashboard
2. Partner/SPV/Manager bisa lihat & claim job
3. Yang duluan claim dapat job
4. Selesai → komisi ditentukan admin (bukan %), langsung masuk saldo
5. Bisa cancel tanpa penalty
```

### File Structure

**Total Files:** ~730 files (phased development)

```
/public_html/
├── index.php (homepage)
├── .htaccess
├── robots.txt
├── sitemap.xml
│
├── /config/ (8 files)
│   ├── database.php
│   ├── constants.php
│   ├── settings.php
│   └── routes.php
│
├── /includes/ (25 files)
│   ├── init.php
│   ├── session.php
│   ├── functions/
│   └── components/
│
├── /assets/
│   ├── /css/ (modular CSS files)
│   ├── /js/ (Vue.js components + vanilla JS)
│   ├── /images/
│   └── /fonts/
│
├── /pages/ (public pages - 15 files)
│   ├── about.php
│   ├── services.php
│   ├── portfolio.php
│   ├── pricing.php
│   ├── calculator.php
│   ├── contact.php
│   └── blog/ (company blog)
│
├── /auth/ (10 files)
│   ├── login.php
│   ├── register.php
│   ├── logout.php
│   ├── forgot-password.php
│   └── verify-email.php
│
├── /client/ (30 files)
│   ├── index.php (dashboard)
│   ├── demo-request.php (26 fields)
│   ├── orders/
│   ├── invoices/
│   ├── payments/
│   ├── profile/
│   └── support/
│
├── /partner/ (40 files)
│   ├── index.php (dashboard)
│   ├── earnings/
│   ├── referrals/
│   ├── withdrawals/
│   ├── job-board/
│   ├── performance/
│   └── marketing-materials/
│
├── /spv/ (35 files)
│   ├── index.php
│   ├── team/
│   ├── performance/
│   ├── arpu-tracking/
│   ├── job-board/
│   └── reports/
│
├── /manager/ (35 files)
│   ├── index.php
│   ├── area-overview/
│   ├── spv-management/
│   ├── regional-analytics/
│   ├── job-board/
│   └── hierarchy-tree/
│
├── /admin/ (GOD MODE - 150+ files)
│   ├── index.php (super dashboard)
│   │
│   ├── /super-admin/ (full control)
│   │   ├── all modules access
│   │   ├── job-board-management.php
│   │   └── system-settings.php
│   │
│   ├── /admin-client-service/ (Admin 1)
│   │   ├── clients/
│   │   ├── orders/
│   │   ├── payments/
│   │   ├── support-tickets/
│   │   └── demo-requests/
│   │
│   ├── /admin-partner/ (Admin 3)
│   │   ├── partners/
│   │   ├── commissions/
│   │   ├── withdrawals/
│   │   ├── tier-management/
│   │   └── job-assignments/
│   │
│   ├── /admin-spv/ (Admin 2)
│   │   ├── spv-management/
│   │   ├── team-performance/
│   │   ├── arpu-bonuses/
│   │   └── spv-reports/
│   │
│   ├── /admin-manager/ (Admin 4)
│   │   ├── manager-management/
│   │   ├── regional-control/
│   │   ├── area-analytics/
│   │   └── hierarchy-oversight/
│   │
│   ├── /shared-modules/ (accessible by relevant admins)
│   │   ├── services/
│   │   ├── packages/
│   │   ├── portfolio/
│   │   ├── reviews/
│   │   ├── blog/
│   │   ├── settings/
│   │   └── reports/
│   │
│   └── /job-board/ (Super Admin posts, all admins can see)
│       ├── create-job.php
│       ├── manage-jobs.php
│       ├── assign-jobs.php
│       └── job-completions.php
│
├── /demos/ (50 demo websites)
│   ├── /demo-01-fashion-store/
│   ├── /demo-02-restaurant/
│   ├── ... (48 more demos)
│   └── /demo-50-it-services/
│
├── /api/ (20 files)
│   ├── /v1/
│   │   ├── calculator.php
│   │   ├── orders.php
│   │   ├── payments.php
│   │   └── notifications.php
│   └── /webhooks/
│
├── /cron/ (10 files)
│   ├── tier-maintenance.php
│   ├── arpu-calculation.php
│   ├── email-reminders.php
│   ├── backup-database.php
│   └── cleanup-logs.php
│
├── /email-templates/ (14+ templates)
│   ├── welcome-client.php
│   ├── welcome-partner.php
│   ├── order-confirmation.php
│   ├── payment-received.php
│   ├── commission-earned.php
│   ├── withdrawal-approved.php
│   ├── job-assigned.php
│   └── ... (7 more)
│
└── /uploads/
    ├── /avatars/
    ├── /payments/
    ├── /projects/
    └── /documents/
```

---

## 3. ROLE SYSTEM (5 ROLES + 5 ADMIN TYPES)

### 5-Role Hierarchical System

```
┌─────────────────────────────────────────────┐
│         SUPER ADMIN (GOD MODE)              │
│  Full system control + Job Board posting    │
└──────────────────┬──────────────────────────┘
                   │
     ┌─────────────┴────────────┐
     ▼                          ▼
┌────────────────┐    ┌─────────────────────┐
│ ADMIN 1        │    │   ADMIN 2           │
│ Client Service │    │   SPV Management    │
└────────────────┘    └─────────────────────┘
     ▼                          ▼
┌────────────────┐    ┌─────────────────────┐
│ ADMIN 3        │    │   ADMIN 4           │
│ Partner Mgmt   │    │   Manager Area Mgmt │
└────────────────┘    └─────────────────────┘
                   │
     ┌─────────────┴────────────┐
     ▼                          ▼
┌────────────────┐    ┌─────────────────────┐
│ MANAGER AREA   │    │   CLIENT (BUYER)    │
│ 5% commission  │    │   Order & Pay       │
└────┬───────────┘    └─────────────────────┘
     │
     ▼
┌────────────────┐
│      SPV       │
│ 10% commission │
└────┬───────────┘
     │
     ▼
┌────────────────┐
│    PARTNER     │
│ 30-55% base    │
└────────────────┘
```

### Role 1: CLIENT (Customer/Buyer)

**Purpose:** Memesan layanan digital dari SITUNEO DIGITAL

**Access Level:** Limited (hanya dashboard pribadi)

**Capabilities:**
1. **Dashboard Overview**
   - Lihat statistik order (total, pending, completed)
   - Lihat invoice summary
   - Lihat payment status
   - Quick access ke semua fitur

2. **Demo Request**
   - Request demo gratis 24 jam
   - Form 26 fields super detail
   - Upload attachment (brief, logo, dll)
   - Track demo status

3. **Order Services**
   - Browse 306 layanan
   - Pilih service/package
   - Add to cart (multiple services)
   - Checkout dengan referral code (optional)
   - Input project details

4. **Payment Management**
   - Upload bukti transfer (bank/QRIS)
   - Track payment status (Pending/Verified/Rejected)
   - View payment history
   - Download payment receipt

5. **Order Tracking**
   - Real-time order status:
     * Pending Payment
     * Payment Verified
     * In Development
     * In Testing
     * Completed
   - Chat dengan admin
   - Download deliverables

6. **Invoices**
   - View all invoices
   - Download PDF invoice
   - Filter by status/date
   - Export invoice list

7. **Support System**
   - Create support ticket
   - Chat dengan support team
   - View ticket history
   - Rate support quality

8. **Reviews & Ratings**
   - Review completed projects
   - Rate 1-5 stars
   - Upload testimoni photo/video
   - Edit reviews

9. **Profile Management**
   - Edit personal info
   - Change password
   - Upload avatar
   - Manage business info

10. **Notifications**
    - Order updates
    - Payment status
    - Project milestones
    - Promo & offers

**Cannot Access:**
❌ Partner dashboard
❌ Admin panel
❌ Commission system
❌ User management
❌ Job board

---

### Role 2: PARTNER (Affiliate/Reseller)

**Purpose:** Mencari client, jual produk SITUNEO, dapat komisi

**Access Level:** Medium (dashboard partner + job board)

**Capabilities:**

1. **Dashboard Overview**
   - Total earnings (all-time, monthly)
   - Available balance (siap withdraw)
   - Pending commission
   - Current tier badge
   - Performance stats
   - Quick actions

2. **Commission Tracking**
   - Real-time commission updates
   - Detail per order:
     * Order ID
     * Client name
     * Service ordered
     * Order value
     * Commission rate
     * Commission earned
     * Status (Pending/Paid)
   - Filter by date, status, client
   - Export to Excel/PDF

3. **Tier Management**
   - Current tier display (TIER 1/2/3/MAX)
   - Tier progress bar
   - Orders this month
   - Orders needed for upgrade
   - Tier benefits comparison
   - Tier history

4. **Referral System**
   - Generate referral link unique: `https://situneo.my.id?ref=PARTNER_CODE`
   - Generate QR Code untuk referral
   - Copy referral link
   - Track link clicks
   - Track conversions
   - A/B test multiple links

5. **Client Management**
   - List semua client dari referral
   - Client details:
     * Name, email, phone
     * Registration date
     * Total orders
     * Total value
     * Commission generated
   - Client activity timeline
   - Export client list

6. **Withdrawal Management**
   - Request withdrawal (minimum Rp 50.000)
   - Input bank account details
   - Upload void cheque (optional)
   - Track withdrawal status:
     * Requested
     * Approved
     * Processed
     * Completed
   - Withdrawal history
   - Download withdrawal receipt

7. **Performance Analytics**
   - Monthly performance chart
   - Top-selling services
   - Conversion rate
   - Average order value
   - Client acquisition cost
   - Revenue forecast (AI-powered)

8. **Job Board Access**
   - View available jobs posted by Super Admin
   - Job details:
     * Title
     * Description
     * Commission amount (fixed, bukan %)
     * Deadline
     * Requirements
   - Claim job (first-come-first-serve)
   - Track claimed jobs
   - Submit completed work
   - Cancel job (no penalty)

9. **Marketing Materials**
   - Download promotional images
   - Download brochures (PDF)
   - Download price lists
   - Download demo links
   - Download testimonials
   - Customizable templates

10. **Transaction History**
    - All commission transactions
    - All withdrawals
    - All penalties (if any)
    - Filter & search
    - Export reports

11. **Profile Management**
    - Personal info
    - Bank account setup (mandatory for withdrawal)
    - KTP upload
    - Social media links
    - Change password
    - Email preferences

12. **Notifications**
    - New commission earned
    - Tier upgrade/downgrade
    - Withdrawal status
    - New job posted
    - Client order update
    - Monthly performance report

**Cannot Access:**
❌ Admin panel
❌ Other partners' data
❌ SPV dashboard
❌ Manager dashboard
❌ System settings
❌ Post jobs (hanya claim)

---

### Role 3: SPV (Supervisor)

**Purpose:** Mengelola team partner di bawahnya, dapat komisi 10% + ARPU bonus

**Access Level:** High (manage partners + job board + reports)

**Capabilities:**

1. **Dashboard Overview**
   - Total team partners
   - Team performance summary
   - Own commission (10% dari partner)
   - ARPU bonus earned
   - Top performers
   - Underperformers alert
   - Quick team actions

2. **Team Management**
   - List all partners dalam team
   - Partner details:
     * Name, email, phone
     * Current tier
     * Join date
     * Total orders this month
     * Total commission
     * Performance score
   - Add/remove partner dari team
   - Assign tasks ke partner
   - Send bulk messages

3. **Performance Tracking**
   - Individual partner performance
   - Team performance trends
   - Monthly comparison
   - Tier distribution (berapa di TIER 1/2/3/MAX)
   - Activity heatmap
   - Performance leaderboard

4. **ARPU Tracking**
   - Average Revenue Per User calculation
   - ARPU threshold monitoring
   - ARPU bonus progress bar
   - Monthly ARPU report
   - Historical ARPU trends
   - ARPU breakdown per partner

5. **Commission Management**
   - Own commission (10% dari semua partner orders)
   - Commission breakdown per partner
   - Pending vs paid commission
   - Commission history
   - Export commission report

6. **ARPU Bonus**
   - Track bonus qualification
   - Bonus tier progress
   - Monthly bonus earned
   - Bonus calculation details
   - Bonus history

7. **Withdrawal System**
   - Request withdrawal (minimum Rp 100.000)
   - Track withdrawal status
   - Withdrawal history
   - Download receipts

8. **Job Board Access**
   - View all available jobs
   - Claim jobs for self
   - Assign jobs ke team partner
   - Track team job completion
   - Job performance analytics

9. **Team Reports**
   - Daily/weekly/monthly reports
   - Revenue by partner
   - Orders by service type
   - Client acquisition report
   - Churn analysis
   - Export all reports

10. **Team Communication**
    - Broadcast message to team
    - Individual partner chat
    - Team announcements
    - Training materials distribution

11. **Training & Development**
    - Track partner training completion
    - Assign training modules
    - View training scores
    - Certification management

12. **Profile Management**
    - Personal info
    - Bank account
    - KTP verification
    - Change password

13. **Notifications**
    - Partner tier changes
    - Team performance alerts
    - ARPU bonus qualification
    - Withdrawal updates
    - Job assignments

**Cannot Access:**
❌ Admin panel (full)
❌ Other SPV's teams
❌ Manager dashboard
❌ System settings
❌ Service management
❌ Post jobs (hanya claim/assign)

---

### Role 4: MANAGER AREA (Regional Manager)

**Purpose:** Mengelola SPV dan regional area, dapat komisi 5% + ARPU bonus

**Access Level:** Higher (manage SPVs + regional control + analytics)

**Capabilities:**

1. **Dashboard Overview**
   - Total SPVs in area
   - Total partners (across all SPVs)
   - Regional performance summary
   - Own commission (5%)
   - ARPU bonus
   - Regional ranking
   - Area health score

2. **SPV Management**
   - List all SPVs dalam area
   - SPV details:
     * Name, email
     * Team size
     * Team performance
     * Total revenue generated
     * ARPU achieved
     * Performance score
   - Add/remove SPV
   - Assign territories
   - Performance reviews

3. **Area Overview**
   - Total revenue by area
   - Growth rate
   - Market penetration
   - Client concentration
   - Service popularity
   - Competitive analysis

4. **Hierarchy Tree View**
   - Visual tree: Manager → SPVs → Partners
   - Clickable nodes untuk drill-down
   - Performance color coding (green/yellow/red)
   - Team size indicators
   - Commission flow visualization

5. **Regional Analytics**
   - Revenue by city/province
   - Service demand by region
   - Client demographics
   - Seasonal trends
   - Opportunity mapping
   - Market gap analysis

6. **Commission Management**
   - Own commission (5% dari SPV orders)
   - Commission breakdown per SPV
   - Pending vs paid
   - Commission trends
   - Export reports

7. **ARPU Bonus**
   - Regional ARPU calculation
   - Bonus qualification tracking
   - Bonus tier progress
   - Monthly bonus earned
   - Historical bonus data

8. **Withdrawal System**
   - Request withdrawal (minimum Rp 150.000)
   - Track status
   - History
   - Receipts

9. **Job Board Access**
   - View all jobs
   - Claim jobs
   - Assign to SPV/partner
   - Track regional job completion
   - Job success rate

10. **Performance Reports**
    - Daily/weekly/monthly/quarterly
    - SPV performance ranking
    - Partner performance ranking
    - Revenue forecasting
    - Attrition analysis
    - Growth opportunities

11. **Team Communication**
    - Broadcast to all SPVs
    - Broadcast to entire area
    - Individual messaging
    - Regional announcements
    - Training coordination

12. **Territory Management**
    - Define coverage areas
    - Assign SPV territories
    - Territory performance
    - Expansion planning
    - Resource allocation

13. **Profile Management**
    - Personal info
    - Bank account
    - Change password

14. **Notifications**
    - SPV performance changes
    - Regional milestones
    - ARPU bonus updates
    - Withdrawal status
    - Critical alerts

**Cannot Access:**
❌ Admin panel (full)
❌ Other managers' areas
❌ System settings
❌ Service/package management
❌ Post jobs

---

### Role 5: ADMIN (5 Admin Types)

#### 5A. SUPER ADMIN (God Mode)

**Purpose:** Full system control + Job Board posting

**Access Level:** UNLIMITED

**Capabilities:**

1. **Full System Access**
   - Access ALL modules
   - Access ALL data
   - Override ALL permissions
   - System settings
   - Database backup/restore

2. **Job Board Management** (EXCLUSIVE)
   - Post new jobs
   - Edit/delete jobs
   - Set commission amounts (fixed)
   - Set deadlines
   - Approve job completions
   - Pay job commissions
   - View job analytics

3. **User Management (All Roles)**
   - CRUD clients
   - CRUD partners
   - CRUD SPVs
   - CRUD managers
   - CRUD admins
   - Suspend/activate users
   - Reset passwords
   - View activity logs

4. **Financial Control**
   - View all revenue
   - Approve all withdrawals
   - Set commission rates
   - Adjust ARPU bonuses
   - Financial reports
   - Profit margins

5. **System Settings**
   - Company info
   - Email settings (SMTP)
   - Payment gateway config
   - Security settings
   - Maintenance mode
   - Feature flags

6. **All Other Admin Functions**
   - Everything Admin 1-4 can do

**Special Permissions:**
✅ Delete any data
✅ Modify commission rates
✅ Override tier system
✅ Access raw database
✅ View all passwords (hashed)
✅ System logs
✅ Post job board jobs ⭐ EXCLUSIVE

---

#### 5B. ADMIN 1 - Client Service

**Purpose:** Layanin client, manage orders & payments

**Access Level:** Client-focused modules

**Capabilities:**

1. **Client Management**
   - View all clients
   - Client details
   - Client order history
   - Client support tickets
   - Edit client info
   - Suspend/activate client
   - Send email to client

2. **Order Management**
   - View all orders
   - Order details
   - Update order status
   - Assign to internal team
   - Upload deliverables
   - Set delivery date
   - Cancel order (with reason)

3. **Demo Request Management**
   - View all demo requests (26 fields)
   - Demo request details
   - **"Copy for AI" button** (copy all 26 fields formatted for AI)
   - Approve/reject demo
   - Assign demo creation
   - Track demo status
   - Contact requestor

4. **Payment Verification**
   - View payment proofs
   - Verify bank transfer
   - Approve/reject payment
   - Upload payment confirmation
   - Mark as paid
   - Send payment receipt

5. **Support Tickets**
   - View all tickets
   - Respond to tickets
   - Assign to team member
   - Close tickets
   - Ticket categories
   - Priority management
   - Response time tracking

6. **Invoice Management**
   - Generate invoices
   - Edit invoice details
   - Send invoice via email
   - Mark as paid/unpaid
   - Download invoice PDF
   - Invoice reports

7. **Communication**
   - Send email to clients
   - Bulk email campaigns
   - WhatsApp integration
   - SMS notifications (optional)

8. **Reports**
   - Client acquisition report
   - Order completion rate
   - Payment collection report
   - Support ticket metrics
   - Client satisfaction score

**Cannot Access:**
❌ Partner management
❌ SPV management
❌ Manager management
❌ Commission settings
❌ Job board posting
❌ System settings

---

#### 5C. ADMIN 2 - SPV Management

**Purpose:** Manage SPVs, team performance, ARPU bonuses

**Access Level:** SPV-focused modules

**Capabilities:**

1. **SPV Management**
   - View all SPVs
   - SPV details
   - Team composition
   - Edit SPV info
   - Suspend/activate SPV
   - Assign area/territory

2. **Team Performance Tracking**
   - SPV performance dashboard
   - Team size per SPV
   - Revenue per team
   - Orders per team
   - Tier distribution
   - Performance trends

3. **ARPU Calculation & Bonuses**
   - Calculate monthly ARPU per SPV
   - ARPU bonus qualification
   - Approve ARPU bonuses
   - Bonus payment processing
   - ARPU threshold management
   - Historical ARPU data

4. **Commission Management (SPV)**
   - View SPV commissions (10%)
   - Commission breakdown
   - Pending commissions
   - Paid commissions
   - Commission disputes

5. **Team Analytics**
   - Team growth rate
   - Partner recruitment by SPV
   - Team retention rate
   - Training completion rate
   - Performance leaderboard

6. **SPV Reports**
   - Monthly SPV performance
   - Team revenue report
   - ARPU achievement report
   - Bonus distribution report
   - Export all reports

7. **Communication**
   - Send messages to SPVs
   - Team announcements
   - Training materials

**Cannot Access:**
❌ Client management (full)
❌ Partner management (full)
❌ Manager management
❌ Job board posting
❌ System settings

---

#### 5D. ADMIN 3 - Partner Management

**Purpose:** Manage partners, tiers, withdrawals, commissions

**Access Level:** Partner-focused modules

**Capabilities:**

1. **Partner Management**
   - View all partners
   - Partner details
   - Referral history
   - Edit partner info
   - Suspend/activate partner
   - Manual tier adjustment

2. **Tier Management**
   - View tier distribution
   - Tier upgrade/downgrade processing
   - Override tier rules (with reason)
   - Tier history
   - Tier requirements management

3. **Commission Tracking**
   - All partner commissions
   - Commission by tier
   - Commission by service
   - Pending commissions
   - Paid commissions
   - Commission disputes

4. **Withdrawal Management**
   - View withdrawal requests
   - Approve/reject withdrawals
   - Process payments
   - Upload payment proof
   - Withdrawal history
   - Minimum withdrawal settings

5. **Referral Analytics**
   - Top referrers
   - Conversion rates
   - Referral sources
   - Campaign performance
   - Client lifetime value by referral

6. **Job Assignment** (for partners)
   - View claimed jobs by partners
   - Approve job completion
   - Pay job commissions
   - Job performance tracking

7. **Marketing Materials Management**
   - Upload promotional assets
   - Manage downloadable resources
   - Track material usage
   - Version control

8. **Partner Reports**
   - Partner acquisition report
   - Tier progression report
   - Commission payout report
   - Withdrawal processing report
   - Top performer report

**Cannot Access:**
❌ Client management (full)
❌ SPV management (full)
❌ Manager management
❌ Job board posting
❌ System settings

---

#### 5E. ADMIN 4 - Manager Area Management

**Purpose:** Manage regional managers, area performance, hierarchy

**Access Level:** Manager-focused modules

**Capabilities:**

1. **Manager Management**
   - View all managers
   - Manager details
   - Coverage area
   - Edit manager info
   - Suspend/activate manager
   - Assign territories

2. **Regional Control**
   - Area performance dashboard
   - Regional revenue
   - Market penetration
   - Growth metrics
   - Opportunity identification

3. **Hierarchy Oversight**
   - Visual hierarchy tree
   - Manager → SPV → Partner structure
   - Team sizes at each level
   - Performance color coding
   - Commission flow tracking

4. **Area Analytics**
   - Revenue by region
   - Client distribution map
   - Service demand by area
   - Competitive landscape
   - Expansion opportunities

5. **Commission Management (Manager)**
   - Manager commissions (5%)
   - Commission breakdown
   - Pending vs paid
   - Commission reports

6. **ARPU Bonus (Manager Level)**
   - Regional ARPU tracking
   - Manager bonus qualification
   - Approve manager bonuses
   - Bonus payment processing

7. **Territory Management**
   - Define coverage areas
   - Assign manager territories
   - Territory performance
   - Resource allocation

8. **Manager Reports**
   - Regional performance report
   - Manager ranking report
   - Area growth report
   - Hierarchy health report

**Cannot Access:**
❌ Client orders
❌ Payment verification
❌ Partner tier management
❌ Job board posting
❌ System settings

---

### Admin Access Matrix

| Module | Super Admin | Admin 1 | Admin 2 | Admin 3 | Admin 4 |
|--------|-------------|---------|---------|---------|---------|
| Clients | ✅ Full | ✅ Full | ❌ | ❌ | ❌ |
| Orders | ✅ Full | ✅ Full | ❌ | ❌ | ❌ |
| Payments | ✅ Full | ✅ Full | ❌ | ❌ | ❌ |
| Demo Requests | ✅ Full | ✅ Full | ❌ | ❌ | ❌ |
| Support Tickets | ✅ Full | ✅ Full | ❌ | ❌ | ❌ |
| Partners | ✅ Full | ❌ | 👁️ View | ✅ Full | 👁️ View |
| SPVs | ✅ Full | ❌ | ✅ Full | 👁️ View | 👁️ View |
| Managers | ✅ Full | ❌ | ❌ | ❌ | ✅ Full |
| Tiers | ✅ Full | ❌ | ❌ | ✅ Full | ❌ |
| Commissions | ✅ Full | ❌ | ✅ SPV | ✅ Partner | ✅ Manager |
| Withdrawals | ✅ All | ❌ | ✅ SPV | ✅ Partner | ✅ Manager |
| ARPU Bonuses | ✅ Full | ❌ | ✅ Full | ❌ | ✅ Manager |
| Job Board (Post) | ✅ Only | ❌ | ❌ | ❌ | ❌ |
| Job Board (View) | ✅ Full | ✅ View | ✅ View | ✅ View | ✅ View |
| Services | ✅ Full | 👁️ View | ❌ | ❌ | ❌ |
| Portfolio | ✅ Full | 👁️ View | ❌ | ❌ | ❌ |
| Reports | ✅ All | ✅ Client | ✅ SPV | ✅ Partner | ✅ Manager |
| System Settings | ✅ Only | ❌ | ❌ | ❌ | ❌ |
| Users (All) | ✅ Full | ❌ | ❌ | ❌ | ❌ |

---

## 4. COMMISSION STRUCTURE

### Cascade Commission Model

Ketika partner membawa client dan client order:
- **Partner:** 30-55% (tergantung tier)
- **SPV partner tersebut:** 10%
- **Manager area SPV tersebut:** 5%
- **SITUNEO:** Sisanya

**Total commission paid out:** 45-70% (tergantung partner tier)

### Partner Tier System (4 Tiers)

#### TIER 1 (Starting Tier)
- **Commission Rate:** 30%
- **Requirement:** Join sebagai partner (auto dapat TIER 1)
- **Maintenance:** Tidak ada minimum (tidak bisa turun dari TIER 1)
- **Upgrade ke TIER 2:** Capai 10 orders TOTAL (cumulative all-time)
- **Benefits:**
  * Akses dashboard partner
  * Referral link generator
  * Marketing materials
  * Withdrawal min Rp 50.000
  * Basic training materials

**Example Calculation:**
- Client order Rp 1.500.000
- Partner dapat: 30% × Rp 1.500.000 = Rp 450.000
- SPV dapat: 10% × Rp 1.500.000 = Rp 150.000
- Manager dapat: 5% × Rp 1.500.000 = Rp 75.000
- SITUNEO dapat: 55% = Rp 825.000

---

#### TIER 2
- **Commission Rate:** 40%
- **Requirement:** Total 10 orders (cumulative dari TIER 1)
- **Maintenance:** Minimum 10 orders/month untuk MEMPERTAHANKAN TIER 2
- **Jika gagal maintenance:** Turun ke TIER 1
- **Re-upgrade:** Harus capai total 10 orders lagi dari TIER 1
- **Upgrade ke TIER 3:** Capai total 50 orders (cumulative all-time)
- **Additional Benefits:**
  * Higher priority support
  * Advanced analytics
  * Custom marketing materials
  * Monthly performance report

**Example Calculation:**
- Client order Rp 1.500.000
- Partner dapat: 40% × Rp 1.500.000 = Rp 600.000
- SPV dapat: 10% × Rp 1.500.000 = Rp 150.000
- Manager dapat: 5% × Rp 1.500.000 = Rp 75.000
- SITUNEO dapat: 45% = Rp 675.000

---

#### TIER 3
- **Commission Rate:** 50%
- **Requirement:** Total 50 orders (cumulative dari TIER 2)
- **Maintenance:** Minimum 50 orders/month untuk MEMPERTAHANKAN TIER 3
- **Jika gagal maintenance:** Turun ke TIER 2 (bukan ke TIER 1!)
- **Re-upgrade:** Harus capai total 50 orders lagi
- **Upgrade ke TIER MAX:** Capai total 75 orders (cumulative all-time)
- **Additional Benefits:**
  * VIP support line
  * Dedicated account manager
  * Co-branding opportunities
  * Early access to new services
  * Quarterly business review

**Example Calculation:**
- Client order Rp 1.500.000
- Partner dapat: 50% × Rp 1.500.000 = Rp 750.000
- SPV dapat: 10% × Rp 1.500.000 = Rp 150.000
- Manager dapat: 5% × Rp 1.500.000 = Rp 75.000
- SITUNEO dapat: 35% = Rp 525.000

---

#### TIER MAX (Maximum Tier)
- **Commission Rate:** 55% (50% base + 5% MAX bonus)
- **Requirement:** Total 75 orders (cumulative dari TIER 3)
- **Maintenance:** Minimum 75 orders/month untuk MEMPERTAHANKAN TIER MAX
- **Jika gagal maintenance:** Turun ke TIER 3
- **Re-upgrade:** Harus capai total 75 orders lagi
- **Permanent Status:** TIDAK ADA tier permanent (harus maintain setiap bulan)
- **Ultimate Benefits:**
  * Maximum commission rate
  * White-label opportunities
  * Revenue sharing programs
  * Strategic partnership consideration
  * Annual retreat invitation
  * Personal branding support
  * Exclusive networking events

**Example Calculation:**
- Client order Rp 1.500.000
- Partner dapat: 55% × Rp 1.500.000 = Rp 825.000
- SPV dapat: 10% × Rp 1.500.000 = Rp 150.000
- Manager dapat: 5% × Rp 1.500.000 = Rp 75.000
- SITUNEO dapat: 30% = Rp 450.000

---

### Tier Progression Rules

**Key Points:**
1. **Cumulative Counting:** Upgrade requirements count ALL orders from the beginning
2. **Monthly Maintenance:** Maintenance requirements count only CURRENT MONTH orders
3. **Drop Mechanics:**
   - From TIER 2 → Drop to TIER 1 (if < 10 orders/month)
   - From TIER 3 → Drop to TIER 2 (if < 50 orders/month)
   - From TIER MAX → Drop to TIER 3 (if < 75 orders/month)
4. **Re-Upgrade:** Harus achieve the milestone lagi (cumulative reset)
5. **No Permanent Status:** Semua tier (except TIER 1) require monthly maintenance

**Progression Example:**
```
Month 1: 8 orders → TIER 1 (30%)
Month 2: 5 orders → Total 13 → TIER 2 (40%)
Month 3: 3 orders → < 10/month → DROP to TIER 1 (30%)
Month 4: 12 orders → Rebuilding... (need 10 total again)
Month 5: 15 orders → Total 27 from restart → Not yet TIER 2
Month 6: 10 orders → Total 37 → Back to TIER 2? NO! Need to hit 10 total first
```

---

### SPV Commission (10%)

**How SPV Earns:**
- SPV gets 10% of EVERY order from partners in their team
- Does NOT depend on partner tier
- Fixed 10% regardless

**Example:**
SPV has 10 partners:
- Partner A (TIER 1): 5 orders × Rp 1M = Rp 5M → SPV gets 10% × Rp 5M = Rp 500K
- Partner B (TIER 2): 12 orders × Rp 1.5M = Rp 18M → SPV gets 10% × Rp 18M = Rp 1.8M
- Partner C (TIER 3): 55 orders × Rp 2M = Rp 110M → SPV gets 10% × Rp 110M = Rp 11M
- ... (8 more partners)

**Total SPV Commission:** Sum of 10% from ALL team partners' orders

**SPV ARPU Bonus (Additional):**

ARPU = Average Revenue Per User (per partner)

**Formula:**
```
ARPU = Total Team Revenue / Number of Active Partners
```

**ARPU Bonus Tiers:**

| ARPU Range | Bonus |
|------------|-------|
| < Rp 1M/partner/month | No bonus |
| Rp 1M - 2.99M | +2% bonus on total team revenue |
| Rp 3M - 4.99M | +3% bonus on total team revenue |
| Rp 5M - 9.99M | +5% bonus on total team revenue |
| Rp 10M+ | +7% bonus on total team revenue |

**Example:**
- SPV has 10 partners
- Total team revenue: Rp 50M/month
- ARPU: Rp 50M / 10 = Rp 5M/partner
- ARPU bonus: +5% on Rp 50M = Rp 2.5M
- SPV total: (10% × Rp 50M) + Rp 2.5M = Rp 5M + Rp 2.5M = **Rp 7.5M**

---

### Manager Area Commission (5%)

**How Manager Earns:**
- Manager gets 5% of EVERY order from ALL partners in ALL SPV teams under them
- Does NOT depend on partner tier or SPV
- Fixed 5% regardless

**Example:**
Manager has 5 SPVs:
- SPV 1: 10 partners → Rp 50M revenue → Manager gets 5% × Rp 50M = Rp 2.5M
- SPV 2: 8 partners → Rp 30M revenue → Manager gets 5% × Rp 30M = Rp 1.5M
- SPV 3: 12 partners → Rp 70M revenue → Manager gets 5% × Rp 70M = Rp 3.5M
- SPV 4: 6 partners → Rp 20M revenue → Manager gets 5% × Rp 20M = Rp 1M
- SPV 5: 9 partners → Rp 40M revenue → Manager gets 5% × Rp 40M = Rp 2M

**Total Manager Commission:** Rp 10.5M

**Manager ARPU Bonus (Additional):**

ARPU = Average Revenue Per SPV

**Formula:**
```
ARPU = Total Area Revenue / Number of Active SPVs
```

**ARPU Bonus Tiers:**

| ARPU Range | Bonus |
|------------|-------|
| < Rp 20M/SPV/month | No bonus |
| Rp 20M - 49.99M | +2% bonus on total area revenue |
| Rp 50M - 99.99M | +4% bonus on total area revenue |
| Rp 100M - 199.99M | +6% bonus on total area revenue |
| Rp 200M+ | +8% bonus on total area revenue |

**Example:**
- Manager has 5 SPVs
- Total area revenue: Rp 210M/month
- ARPU: Rp 210M / 5 = Rp 42M/SPV
- ARPU bonus: +2% on Rp 210M = Rp 4.2M
- Manager total: (5% × Rp 210M) + Rp 4.2M = Rp 10.5M + Rp 4.2M = **Rp 14.7M**

---

### Commission Calculation Workflow

**When Client Completes Payment:**

1. **Admin verifies payment** (Admin 1 - Client Service)
2. **System auto-calculates commissions:**
   - Check if order has referral code
   - If YES:
     * Calculate partner commission (based on current tier)
     * Calculate SPV commission (10%)
     * Calculate Manager commission (5%)
     * Add to pending balance
   - If NO referral:
     * No commission
     * Full revenue to SITUNEO

3. **Commission becomes "Pending"** until project completed

4. **When project marked "Completed":**
   - Pending commission → Available balance
   - Partner can withdraw (min Rp 50K)
   - SPV can withdraw (min Rp 100K)
   - Manager can withdraw (min Rp 150K)

5. **ARPU Bonus Calculation (Monthly Cron):**
   - Run on 1st of every month
   - Calculate previous month ARPU
   - Determine bonus tier
   - Add bonus to available balance
   - Send notification email

6. **Tier Maintenance Check (Monthly Cron):**
   - Run on 1st of every month
   - Count previous month orders per partner
   - Check against maintenance requirement
   - Upgrade/downgrade tiers
   - Send notification email
   - Update tier badge on dashboard

---

### Services That Generate Commission

✅ **YES - Commission Applies:**
1. All website development services
2. Design & branding services
3. Mobile app development
4. Digital marketing services
5. Content creation
6. SEO services
7. Maintenance packages
8. Training & consulting
9. Custom development
10. All bundling packages

❌ **NO - No Commission:**
1. Domain registration (.com, .id, etc.) - third-party
2. Hosting (shared/VPS) - third-party
3. SSL Certificate - third-party
4. Email hosting - third-party
5. Google Workspace - third-party
6. Premium plugins/themes purchased - third-party
7. Payment gateway fees - third-party

**Note:** Commission only applies to SITUNEO's services, NOT third-party products/services that SITUNEO resells.

---

### Withdrawal Rules

#### Partner Withdrawal:
- **Minimum:** Rp 50.000
- **Maximum:** No limit (withdraw all available balance)
- **Processing Time:** 1×24 jam (business days)
- **Method:** Bank transfer
- **Fee:** FREE
- **Frequency:** Unlimited (kapan aja bisa request)
- **Approval:** Admin 3 (Partner Management)

#### SPV Withdrawal:
- **Minimum:** Rp 100.000
- **Maximum:** No limit
- **Processing Time:** 1×24 jam (business days)
- **Method:** Bank transfer
- **Fee:** FREE
- **Frequency:** Unlimited
- **Approval:** Admin 2 (SPV Management)

#### Manager Withdrawal:
- **Minimum:** Rp 150.000
- **Maximum:** No limit
- **Processing Time:** 1×24 jam (business days)
- **Method:** Bank transfer
- **Fee:** FREE
- **Frequency:** Unlimited
- **Approval:** Admin 4 (Manager Management)

**Withdrawal Process:**
1. Partner/SPV/Manager request withdrawal
2. Input bank account details (if not saved)
3. Enter withdrawal amount
4. Add optional note
5. Submit request
6. Relevant admin receives notification
7. Admin reviews request
8. Admin approves/rejects
9. If approved: Admin transfers money
10. Admin uploads transfer proof
11. User receives notification + receipt
12. Balance updated

---
