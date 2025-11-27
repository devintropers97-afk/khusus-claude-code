# 🎯 SITUNEO - QUICK REFERENCE CARD
## PANDUAN CEPAT DEVELOPMENT

---

## 📋 15 BATCH - ONE PAGE VIEW

```
┌─────────────────────────────────────────────────────────────────────┐
│  FASE 1: FOUNDATION (Week 1-3)                                      │
├─────────────────────────────────────────────────────────────────────┤
│  Batch 1: Database (85+ tables) ...................... 3-5 days 🔥  │
│  Batch 2: Core System (MVC, Router, Classes) ......... 5-7 days 🔥  │
│  Batch 3: Public Website (11 pages, premium) ......... 5-7 days 🔥  │
├─────────────────────────────────────────────────────────────────────┤
│  FASE 2: AUTH & CLIENT (Week 4-5)                                   │
├─────────────────────────────────────────────────────────────────────┤
│  Batch 4: Auth System (Login, Register, Reset) ....... 4-5 days 🔥  │
│  Batch 5: Client Dashboard (18 pages, 26 fields) ..... 5-7 days 🔥  │
├─────────────────────────────────────────────────────────────────────┤
│  FASE 3: PARTNER & SPV (Week 6-8)                                   │
├─────────────────────────────────────────────────────────────────────┤
│  Batch 6: Partner Dashboard (30 pages, tier) ......... 5-7 days 🟠  │
│  Batch 7: SPV Dashboard (35 pages, ARPU) ............. 5-7 days 🟠  │
│  Batch 8: Commission & ARPU (Auto, Cron) ............. 4-5 days 🔥  │
├─────────────────────────────────────────────────────────────────────┤
│  FASE 4: MANAGER & ADMIN (Week 9-11)                                │
├─────────────────────────────────────────────────────────────────────┤
│  Batch 9: Manager Dashboard (35 pages, area) ......... 5-7 days 🟡  │
│  Batch 10: Admin Part 1 (User, Order, Payment) ....... 7-10 days 🔥 │
│  Batch 11: Admin Part 2 (Commission, CMS, Settings) .. 7-10 days 🔥 │
├─────────────────────────────────────────────────────────────────────┤
│  FASE 5: ADVANCED FEATURES (Week 12-13)                             │
├─────────────────────────────────────────────────────────────────────┤
│  Batch 12: Demo Request (26 fields, copy detail) ..... 3-4 days 🟡  │
│  Batch 13: Task Board (post, take, submit) ........... 4-5 days 🟡  │
├─────────────────────────────────────────────────────────────────────┤
│  FASE 6: POLISH & DEPLOY (Week 14-16)                               │
├─────────────────────────────────────────────────────────────────────┤
│  Batch 14: 50 Demo Websites (10 categories) .......... 10-14 days 🟢│
│  Batch 15: Polish & Deploy (test, optimize, deploy) .. 5-7 days 🔥  │
└─────────────────────────────────────────────────────────────────────┘

TOTAL: 12-16 weeks (60-90 hari kerja)
```

---

## 💰 COMMISSION SYSTEM - QUICK CALC

```
┌───────────────────────────────────────────────────────────┐
│  EXAMPLE: Client order Rp 10,000,000                     │
├───────────────────────────────────────────────────────────┤
│  Partner (Tier 2 - 40%):  Rp 4,000,000  ← DAPAT         │
│  SPV (10%):                Rp 1,000,000  ← DAPAT         │
│  Manager (5%):             Rp   500,000  ← DAPAT         │
│  ────────────────────────────────────────────────         │
│  Total Commission (55%):   Rp 5,500,000                  │
│  SITUNEO Net (45%):        Rp 4,500,000                  │
└───────────────────────────────────────────────────────────┘

TIER PERCENTAGES:
Tier 1:   30% (0-10 orders, no maintenance)
Tier 2:   40% (10-25 orders, maintain 10/month)
Tier 3:   50% (50-75 orders, maintain 25/month)
Tier MAX: 55% (75+ orders, maintain 50/month)

COMMISSION RULES:
- Beli Putus: Commission 1x (after project done)
- Sewa: Commission 1x bulan pertama saja
- Tanggungan: Jika client stop <3 bulan, partner bayar
```

---

## 📊 ARPU BONUS - QUICK REF

```
SPV ARPU BONUS (Monthly):
┌───────────┬──────────────┐
│ Rp 15M    │ Bonus Rp 500K│
│ Rp 35M    │ Bonus Rp 1M  │
│ Rp 75M    │ Bonus Rp 2M  │
│ Rp 200M+  │ Bonus Rp 10M │
└───────────┴──────────────┘

MANAGER ARPU BONUS (Monthly):
┌───────────┬──────────────┐
│ Rp 45M    │ Bonus Rp 1M  │
│ Rp 105M   │ Bonus Rp 2M  │
│ Rp 225M   │ Bonus Rp 3M  │
│ Rp 600M+  │ Bonus Rp 15M │
└───────────┴──────────────┘

CALCULATION:
Total revenue bulan ini dari semua downline
= ARPU (Average Revenue Per User)
→ Cek tier → Dapat bonus
→ Bonus diberikan akhir bulan (cron job)
```

---

## 🗄️ DATABASE - QUICK INFO

```
TOTAL TABLES: 85+ tables

KEY TABLES:
├─ users (master user: admin, manager, spv, partner, client)
├─ partners (tier, commission, referral_code)
├─ spv_supervisors (team, ARPU, bonus)
├─ manager_area_managers (area, ARPU, bonus)
├─ clients (orders, payments)
├─ orders (order_type, status, amount)
├─ services (232+ services)
├─ demo_requests (26 fields!)
└─ commission_calculations (auto-calc)

CREDENTIALS:
Host: localhost
User: nrrskfvk_user_situneo_digital
Pass: Devin1922$
Name: nrrskfvk_situneo_digital
```

---

## 🔐 SECURITY - CHECKLIST

```
✅ bcrypt password (cost 12)
✅ CSRF token (all forms)
✅ PDO prepared statements (SQL injection)
✅ Rate limiting (5 attempts / 15 min)
✅ Session security (httponly, secure, samesite)
✅ Input validation (client + server)
✅ Output encoding (htmlspecialchars)
✅ XSS protection (CSP headers)
✅ SSL/TLS (HTTPS only)
✅ File upload validation (type, size)
```

---

## 📧 EMAIL TEMPLATES - LIST

```
1. Welcome Email (after register)
2. Email Verification (activate account)
3. Application Received (Partner/SPV/Manager)
4. Application Approved (welcome + credentials)
5. Application Rejected (with reason)
6. Password Reset (reset link)
7. Order Confirmation (after order)
8. Payment Verified (after admin approve)
9. Project Update (status change)
10. Project Completed (ready for download)
11. Commission Earned (after order complete)
12. ARPU Bonus (monthly, if achieved)
13. Withdrawal Request (confirmation)
14. Withdrawal Processed (transfer done)
```

---

## 🎨 DESIGN SYSTEM - QUICK REF

```
COLORS:
Primary Blue: #1E5C99
Dark Blue: #0F3057
Gold: #FFB400
Bright Gold: #FFD700

FONTS:
Body: 'Inter', sans-serif
Heading: 'Plus Jakarta Sans', sans-serif
Mono: 'Fira Code', monospace

FRAMEWORK:
Bootstrap 5.3.3 (responsive grid, components)
Bootstrap Icons 1.11.3 (icon library)

ANIMATIONS:
GSAP 3.12+ (scroll, tweens)
AOS 2.3+ (animate on scroll)
Canvas API (network particles)

CHARTS:
Chart.js 4.4+ (reports, analytics)
```

---

## 📱 RESPONSIVE BREAKPOINTS

```
xs: 0-575px    (Mobile Portrait)  ← PRIMARY FOCUS
sm: 576-767px  (Mobile Landscape)
md: 768-991px  (Tablet)
lg: 992-1199px (Desktop)
xl: 1200-1535px(Large Desktop)
2xl: 1536px+   (XL Desktop)

PRIORITY:
1. Mobile (375px-767px) - FIRST!
2. Desktop (992px+) - SECOND
3. Tablet (768px-991px) - ADAPT
```

---

## ⏰ CRON JOBS - SCHEDULE

```
1. tier-update.php
   Schedule: Monthly, 1st day, 01:00 AM
   Function: Check maintenance, upgrade/downgrade tiers
   
2. arpu-calculate.php
   Schedule: Monthly, 1st day, 02:00 AM
   Function: Calculate ARPU, credit bonus to balances
   
3. invoice-generate.php
   Schedule: Monthly, 1st day, 03:00 AM
   Function: Generate recurring invoices (sewa)

SETUP (cPanel):
Cron Jobs → Add New Cron Job → Set schedule → Command:
/usr/bin/php /home/username/public_html/cron/tier-update.php
```

---

## 🔗 FILE STRUCTURE - QUICK MAP

```
/
├─ /public/              (Document root)
│  ├─ index.php          (Entry point)
│  ├─ .htaccess          (URL rewriting)
│  ├─ /assets/           (CSS, JS, images)
│  └─ /demos/            (50 demo websites)
├─ /config/              (Config files)
│  ├─ config.php
│  ├─ database.php
│  └─ email.php
├─ /core/                (Core classes)
│  ├─ Database.php
│  ├─ Router.php
│  └─ Controller.php
├─ /app/                 (Application)
│  ├─ /controllers/      (by role: public, auth, client, etc)
│  ├─ /models/           (85+ models)
│  └─ /views/            (templates)
├─ /helpers/             (Utility functions)
├─ /cron/                (Scheduled jobs)
└─ /database/            (Schema, migrations, seeds)
```

---

## 🧪 TESTING - QUICK CHECKLIST

```
AFTER EACH BATCH:
☑️ Unit Test (functions work)
☑️ Integration Test (features work together)
☑️ UI Test (looks good on mobile + desktop)
☑️ Security Test (no vulnerabilities)
☑️ Performance Test (load time <3s)

BEFORE DEPLOYMENT:
☑️ All features work (no critical bugs)
☑️ Cross-browser (Chrome, Firefox, Safari, Edge)
☑️ Mobile (iOS + Android)
☑️ Lighthouse score >90/100
☑️ Security headers (A+ SSL Labs)
```

---

## 🚀 DEPLOYMENT - QUICK STEPS

```
1. Prepare package:
   ├─ ZIP all files
   ├─ Include database dump
   └─ Include documentation

2. Upload to server (cPanel):
   ├─ Upload ZIP to public_html
   ├─ Extract files
   └─ Set file permissions (644/755)

3. Setup database:
   ├─ Create database (phpMyAdmin)
   ├─ Import schema.sql
   ├─ Import seeds.sql
   └─ Update config/database.php

4. Setup email:
   ├─ Create email accounts (cPanel)
   ├─ Update config/email.php
   └─ Test SMTP (send test email)

5. Setup SSL:
   ├─ Install Let's Encrypt (cPanel)
   ├─ Force HTTPS (.htaccess)
   └─ Test SSL (SSL Labs)

6. Setup cron jobs:
   ├─ Add 3 cron jobs (cPanel)
   └─ Test execution

7. Final testing:
   ├─ Test all features on production
   ├─ Fix any issues
   └─ Monitor for 24 hours

8. GO LIVE! 🎉
```

---

## 📞 SUPPORT INFO

```
PROJECT: SITUNEO Digital Platform
COMPANY: PT SITUNEO DIGITAL SOLUSI INDONESIA

CONTACT:
📧 Email: vins@situneo.my.id
📱 WhatsApp: +62 831-7386-8915
📞 Phone: 021-8880-7229

OFFICE:
Jl. Bekasi Timur IX Dalam No. 27
Jakarta Timur 13450, Indonesia

LEGAL:
NIB: 1401250064281
NPWP: 90.296.264.6-002.000
```

---

## 🎯 MVP (MINIMUM VIABLE PRODUCT)

```
Untuk launch cepat, fokus pada:

CRITICAL (Must Have):
✅ Batch 1-5: Database + Core + Public + Auth + Client
✅ Batch 8: Commission auto-calculation
✅ Batch 10-11: Admin Dashboard (user & order management)

TOTAL MVP: 8 batch = 6-8 weeks

POST-LAUNCH (Can Add Later):
- Batch 6-7: Partner & SPV Dashboard
- Batch 9: Manager Dashboard
- Batch 12-13: Demo Request + Task Board
- Batch 14: 50 Demo Websites

START SIMPLE, SCALE LATER!
```

---

## 💡 TIPS & TRICKS

```
1. FOLLOW THE SEQUENCE
   ✅ Complete Batch 1 before Batch 2
   ✅ Test after each batch
   ✅ Document as you go

2. USE VERSION CONTROL
   ✅ Git commit after each feature
   ✅ Meaningful commit messages
   ✅ Branch for each batch

3. CODE QUALITY
   ✅ Follow PSR standards (PHP)
   ✅ Consistent naming (camelCase, snake_case)
   ✅ Add comments for complex logic
   ✅ Don't repeat yourself (DRY)

4. SECURITY FIRST
   ✅ Never trust user input
   ✅ Always validate + sanitize
   ✅ Use prepared statements
   ✅ Hash passwords (bcrypt)

5. PERFORMANCE
   ✅ Optimize database queries (indexes)
   ✅ Minify CSS/JS (production)
   ✅ Compress images (WebP, 80% quality)
   ✅ Enable caching (browser + server)

6. USER EXPERIENCE
   ✅ Mobile-first design
   ✅ Fast loading (<3s)
   ✅ Clear error messages
   ✅ Smooth animations (60fps)

7. TESTING
   ✅ Test on real devices (not just browser DevTools)
   ✅ Test with real data (not just sample)
   ✅ Test edge cases (empty, null, overflow)
   ✅ Test error handling (what if fails?)

8. DOCUMENTATION
   ✅ Code comments (why, not what)
   ✅ User manual (how to use)
   ✅ Admin manual (how to manage)
   ✅ API docs (if API exists)
```

---

## ⚠️ COMMON PITFALLS

```
❌ AVOID:
1. Skipping Batch 1-2 (Foundation is critical!)
2. Not testing after each batch
3. Hardcoding values (use config)
4. SQL injection (use prepared statements)
5. XSS vulnerabilities (escape output)
6. Ignoring mobile users (mobile-first!)
7. Over-engineering (keep it simple)
8. No backups (backup database daily!)
9. Weak passwords (enforce strong passwords)
10. No error handling (always handle errors)

✅ DO:
1. Follow the batch sequence
2. Test, test, test!
3. Use config files
4. Use prepared statements
5. Escape all output
6. Mobile-first design
7. Keep it simple (KISS)
8. Daily backups
9. Strong password policy
10. Proper error handling
```

---

## 🏁 READY TO START?

```
✅ Read all 3 documentation files
✅ Setup development environment
✅ Create project timeline
✅ Assign team members
✅ Start with Batch 1
✅ Follow the sequence
✅ Test after each batch
✅ Deploy when ready

REMEMBER:
- Quality > Speed
- Test > Fix > Test again
- Document as you go
- Ask when stuck
- Stay focused
- You got this! 💪

GOOD LUCK! 🚀
```

---

**END OF QUICK REFERENCE**