# 🚀 SITUNEO DIGITAL - CLAUDE CODE COMPLETE INSTRUCTIONS

**Date:** November 12, 2025  
**For:** Building Complete SITUNEO Digital Platform  
**Method:** Claude Code with Project Files  

---

# 📋 COMPLETE STEP-BY-STEP GUIDE

## STEP 1: Install Claude Code

**Mac/Linux:**
```bash
curl -fsSL https://claude.ai/install.sh | sh
```

**Windows PowerShell (Run as Administrator):**
```powershell
irm https://claude.ai/install.ps1 | iex
```

**Verify:**
```bash
claude --version
```

---

## STEP 2: Login

```bash
claude auth login
```

---

## STEP 3: Create Project

```bash
mkdir situneo-digital
cd situneo-digital
git init
```

---

## STEP 4: Create Instruction File

Buat file `BUILD_INSTRUCTIONS.md` di folder project:

```bash
cat > BUILD_INSTRUCTIONS.md << 'EOF'
# SITUNEO DIGITAL - BUILD SPECIFICATION

## PROJECT OVERVIEW
Build complete SITUNEO Digital Platform dengan:
- 400+ files modular (PHP, CSS, JS)
- 85 database tables (MySQL)
- 50 demo websites (production-ready)
- 5 complete dashboards (Admin/Manager/SPV/Partner/Client)
- Full automation (commission, ARPU, email, tier)
- Complete security (CSRF, XSS, SQL injection prevention)

## CRITICAL SPECIFICATIONS

### 1. COMPANY INFO
```
PT SITUNEO DIGITAL SOLUSI INDONESIA
NIB: 1401250064281
Website: https://situneo.my.id
Database: nrrskfvk_situneo_digital
DB User: nrrskfvk_user_situneo_digital
DB Pass: Devin1922$
```

### 2. BUSINESS MODEL

**Pricing:**
- Beli Putus: Rp 350K/halaman
- Sewa Bulanan: Rp 150K/halaman/bulan (NO SETUP FEE!)

**232+ Layanan** dalam 10 divisi
**53 Kategori** → 1500+ website types

### 3. ROLE SYSTEM (5 Roles)

1. **ADMIN** - Full control everything
2. **MANAGER AREA** - 5% komisi + bonus ARPU (Rp 45M/105M/225M/600M)
3. **SPV** - 10% komisi + bonus ARPU (Rp 15M/35M/75M/200M)
4. **PARTNER** - 30-55% komisi (tier-based: 0-10/10-25/50+/75+ orders)
5. **CLIENT** - Order & track

### 4. COMMISSION SYSTEM

**Tier System (Partner):**
- Tier 1: 0-10 order → 30%
- Tier 2: 10-25 order → 40%
- Tier 3: 50+ order → 50%
- Tier MAX: 75+ order → 55%
- Maintenance: TIDAK PERNAH TURUN

**Cascade:**
Client order Rp 10M → Partner 40% (Rp 4M) + SPV 10% (Rp 1M) + Manager 5% (Rp 500K)

**Rules:**
- Beli Putus: Komisi setelah lunas + serah terima + admin approve
- Sewa: Komisi 1x bulan pertama, client wajib min 3 bulan
- Stop <3 bulan: Partner kena potong komisi (cascade ke SPV/Manager)

### 5. DATABASE (85 TABLES)

Users (6), Clients (6), Partners (10), SPV (8), Managers (8), 
Hierarchy (4), Services (7), Orders (5), Payments (5), Demos (3),
Commissions (6), Withdrawals (4), Tasks (5), Content (6), 
Leaderboard (4), Settings (5), Notifications (3), Analytics (7), 
Support (3), SEO (3), Media (2)

### 6. REFERRAL SYSTEM

- Partner→Client: situneo.my.id/register/client/USERNAME
- SPV→Partner: situneo.my.id/register/partner/USERNAME
- Manager→SPV: situneo.my.id/register/spv/USERNAME

### 7. DEMO WEBSITES (50 Production-Ready)

Location: /demos/nama-bisnis/
URL: situneo.my.id/demos/toko-baju/
Content: Real business names, real content, Unsplash images
Design: Paling bagus & terlihat mahal (untuk convince client)

**Top 10 (Batch 1):**
1. Toko Baju Modis Jakarta
2. Restoran Nusantara Enak
3. Klinik Sehat Keluarga
4. Konsultan Bisnis Profesional
5. Kursus Online Berkualitas
6. Laundry Express Cepat
7. Properti Rumah Impian
8. Cuci Mobil Premium Shine
9. Service Laptop Cepat Aman
10. Hotel Grand Jakarta

(40 demos lainnya pilih yang marketable)

### 8. DESIGN SYSTEM

**Colors:**
```css
--primary-blue: #1E5C99
--dark-blue: #0F3057
--gold: #FFB400
--bright-gold: #FFD700
```

**Fonts:**
- Body: Inter
- Heading: Plus Jakarta Sans

**Animations (SEMUA HALAMAN):**
- Network particle (30-40 particles LOW)
- Loading screen dinamis per page
- NIB badge (footer, medium, pulse)
- Circuit pattern overlay
- AOS, GSAP

### 9. SPECIAL FEATURES

**Demo Request Form (26 Fields):**
Bagian 1: Tentang Usaha (3)
Bagian 2: Tampilan (3)
Bagian 3: Halaman (2)
Bagian 4: Fitur (2)
Bagian 5: Gambar & Logo (2)
Bagian 6: Isi & Kontak (5)
Bagian 7: Catatan (2)
+ 7 fields tambahan

**"Copy Detail" Button:**
- Admin bisa copy semua 26 fields
- Format: Structured text untuk AI
- Label: "Salin Data" (bukan "Copy for AI")

**Public Leaderboard:**
- Top Partners (tanpa login)
- Top SPV (tanpa login)
- Top Managers (tanpa login)
- Ranking, orders, revenue

**Admin Task System:**
- Admin post tugas
- Partner apply
- Admin approve & assign
- Partner submit
- Admin review & bayar

### 10. AUTOMATION (CRITICAL!)

**Real-time:**
- Commission calculation (setelah admin approve order)
- ARPU tracking (update per order)
- Tier progression (auto upgrade)
- Email notifications (11 types auto)
- Invoice generation (format: INV-SITUNEO-DD-MMM-YYYY)

**Email Auto-Send:**
1. Registration confirmation
2. Partner application submitted
3. Partner approved/rejected
4. Order notification (client & admin)
5. Payment received
6. Order completed
7. Commission earned
8. Withdrawal requested
9. Withdrawal approved
10. Password reset
11. Demo request submitted

### 11. UI/UX REQUIREMENTS

**Public Pages:** Singkat & inti, ALL CTA → Register/Login
**Full Features:** Login required

**Components (Consistent di SEMUA halaman):**
- Loading screen (dinamis: "Memuat [Nama Halaman]...")
- Network particle background (30-40 particles)
- NIB badge (footer, medium size)
- FREE DEMO banner (floating always)
- Pop-up demo (homepage, 10 detik)
- WhatsApp button (floating kanan bawah)
- Back to top button

### 12. PARTNER REGISTRATION

**Wajib:**
- Nama, Email, Password, WhatsApp
- Upload KTP (max 2MB)
- Upload CV (max 3MB)
- Alamat Domisili Lengkap
- Pilih Role (Partner/SPV/Manager)

**Optional:**
- Kode Referral

**Flow:**
Register → Pending → Admin Review (lihat KTP, CV) → Approve/Reject → Active

### 13. SECURITY (MANDATORY)

✅ Password hashing (bcrypt)
✅ CSRF protection (all forms)
✅ SQL injection prevention (prepared statements)
✅ XSS protection (htmlspecialchars all output)
✅ Session security (httponly, secure, samesite)
✅ File upload validation (size, type, extension)
✅ Rate limiting (login attempts)
✅ .htaccess security rules

### 14. PERFORMANCE

✅ Lazy loading images
✅ WebP format (fallback JPG/PNG)
✅ Auto-compress on upload
✅ CDN for Bootstrap/icons
✅ Browser caching
✅ CSS/JS minification
✅ Target: <3 sec loading

### 15. SEO

✅ Meta tags lengkap
✅ Schema markup (JSON-LD)
✅ Open Graph (social media)
✅ robots.txt
✅ sitemap.xml
✅ Google Analytics: G-RPW3MZ3RPY

### 16. FILE STRUCTURE (400+ FILES)

**Modular:**
- 1 file = 1 purpose
- Easy to edit
- Simple naming ("orang bodoh pun tahu")

**Structure:**
```
/config/ (database, constants, settings, email, paths, session, security)
/includes/ (header, footer, navigation, components)
/helpers/ (common, validation, formatting, security, email, upload)
/core/ (Database, Router, Session, Auth, Validator, Mailer, Uploader)
/assets/ (css, js, images, uploads)
/auth/ (login, register-client, register-partner, logout, forgot-password)
/client/ (dashboard, orders, demo-request, payments, invoices, profile)
/partner/ (dashboard, earnings, referral, withdrawal, tier, tasks, leaderboard, profile)
/spv/ (dashboard, team, earnings, arpu-tracking, referral, withdrawal, profile)
/manager/ (dashboard, area-management, team, earnings, arpu-tracking, referral, withdrawal, profile)
/admin/ (dashboard, users, hierarchy, services, orders, payments, partners, commissions, demo-requests, withdrawals, tasks, website, reports, settings)
/demos/ (50 demo websites)
/leaderboard/ (partners, spv, managers - PUBLIC)
/database/ (SQL files)
```

### 17. DELIVERABLE

Output:
- ZIP file (ready upload cPanel)
- Database SQL (85 tables + structure)
- README.md (installation guide)
- Test accounts:
  * admin@situneo.my.id / admin123
  * client@situneo.my.id / client123
  * partner@situneo.my.id / partner123
  * spv@situneo.my.id / spv123
  * manager@situneo.my.id / manager123

---

## CRITICAL RULES

1. ✅ MODULAR 400+ files
2. ✅ NO dummy data (except 50 demos)
3. ✅ AUTOMATION first
4. ✅ MOBILE first
5. ✅ SECURITY complete
6. ✅ KONSISTEN total (brand colors & design)
7. ✅ PRODUCTION ready

---

## QUALITY TARGET

**"Website Paling Bagus & Paling Mahal Se-Indonesia!"** 🏆

- Design: WOW factor, premium
- Fitur: Lengkap & berfungsi sempurna
- Performance: Fast (<3 sec)
- SEO: Complete
- Mobile: Perfect responsive
- Security: Complete
- Code: Clean, documented, modular

---

## START BUILDING!

Generate SEMUA files sesuai specification di atas.
Test everything.
Create production-ready package.

Good luck! 🚀
EOF
```

---

## STEP 5: Run Claude Code

**MASTER COMMAND (Copy-paste ini EXACTLY):**

```bash
claude code "Baca file BUILD_INSTRUCTIONS.md dan buat COMPLETE SITUNEO Digital Platform sesuai specification. Generate 400+ files modular, 85 database tables, 50 demo websites production-ready, 5 complete dashboards, commission system cascade, ARPU tracking real-time, referral system 3 types, public leaderboard, admin task posting, demo request form 26 fields dengan Copy Detail button, email notifications 11 types auto, partner registration dengan KTP/CV upload, automatic tier progression, withdrawal system min 50K, invoice generation format INV-SITUNEO-DD-MMM-YYYY, dan semua automation. Target quality: Website paling bagus & paling mahal se-Indonesia. Follow ALL specifications exactly. NO improvisation. Production-ready code only."
```

---

## STEP 6: Monitor Progress

Claude Code akan:
1. ✅ Baca BUILD_INSTRUCTIONS.md
2. ✅ Generate file structure (400+ files)
3. ✅ Create database schema (85 tables)
4. ✅ Build authentication system
5. ✅ Create 5 dashboards (full features)
6. ✅ Build 50 demo websites
7. ✅ Implement commission cascade
8. ✅ Setup automation (ARPU, email, tier)
9. ✅ Add security features
10. ✅ Test everything
11. ✅ Create deployment package

**Progress akan tampil di terminal!**

---

## STEP 7: Review & Test

Setelah selesai:
```bash
# Review structure
ls -la

# Check database SQL
cat database/situneo_complete.sql

# Test locally (optional)
php -S localhost:8000

# Browse
open http://localhost:8000
```

---

## STEP 8: Deploy to cPanel

```bash
# Create ZIP
zip -r situneo-digital.zip . -x "*.git*"

# Upload ke cPanel
# 1. Login cPanel
# 2. File Manager
# 3. Upload ZIP
# 4. Extract
# 5. Import database SQL
# 6. Done!
```

---

## 📞 TROUBLESHOOTING

### Issue: Claude Code tidak response
**Fix:** 
```bash
claude auth logout
claude auth login
```

### Issue: Error saat generate
**Fix:** Check BUILD_INSTRUCTIONS.md format, pastikan valid markdown

### Issue: Files tidak lengkap
**Fix:** Re-run command dengan tambahan:
```bash
claude code "Continue previous build. Complete remaining files."
```

---

## ✅ EXPECTED RESULT

```
situneo-digital/
├── 400+ PHP/CSS/JS files ✅
├── database/
│   └── situneo_complete.sql (85 tables) ✅
├── demos/
│   ├── toko-baju/ ✅
│   ├── restoran/ ✅
│   └── ... (48 more) ✅
├── README.md ✅
└── .env.example ✅
```

**File size:** ~50-100 MB (with 50 demos)
**Time to build:** 30-60 minutes (depending on Claude Code)

---

## 🎯 FINAL NOTES

1. **PATIENCE:** Building 400+ files takes time
2. **DON'T INTERRUPT:** Let Claude Code finish completely
3. **REVIEW CODE:** Always review before deploying
4. **TEST FIRST:** Test di local/staging before production
5. **BACKUP:** Keep backup before replacing live site

---

## 🚀 READY TO BUILD!

**All set! Run the command and let Claude Code do the magic!** ✨

---

**Created by:** Claude (Anthropic)  
**For:** SITUNEO Digital Platform Development  
**Version:** 2.0 Final  
**Date:** November 12, 2025  
