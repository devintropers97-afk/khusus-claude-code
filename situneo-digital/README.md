# SITUNEO DIGITAL - Production Ready Platform

**PT SITUNEO DIGITAL SOLUSI INDONESIA**
NIB: 1401250064281

---

## 📋 DESKRIPSI

Sistem SITUNEO DIGITAL adalah platform manajemen partner dan komisi yang lengkap!

### ✅ BATCH 1: Foundation & Core System (COMPLETED)
- ✅ Complete User Management System (18 tables)
- ✅ Complete Admin System (12 tables)
- ✅ Authentication & Authorization
- ✅ Email Verification System
- ✅ Password Reset System
- ✅ Session Management
- ✅ Activity Logging
- ✅ CSRF Protection
- ✅ Modern UI dengan Bootstrap 5.3.3

### ✅ BATCH 2: Partner, SPV & Manager System (COMPLETED)
- ✅ Partner Management (28 tables) - Multi-tier commission system
- ✅ SPV Management (15 tables) - Supervisor operations
- ✅ Manager Management (15 tables) - Manager operations
- ✅ Commission Calculator (Auto-calculate tier-based commissions)
- ✅ ARPU Tracking & Bonus System
- ✅ Partner Dashboard with stats
- ✅ Withdrawal Management
- ✅ Performance Tracking
- ✅ Client Management

**Current Status:**
- **Total Files:** ~50+ files
- **Total Tables:** 88 tables (30 from BATCH 1 + 58 from BATCH 2)
- **Commission Tiers:** 4 tiers (30%, 40%, 50%, 55%)
- **Roles:** Super Admin, Manager, SPV, Partner, Client

---

## 🚀 CARA INSTALL DI CPANEL

### STEP 1: Download Files

1. Download semua files dari repository
2. Extract ZIP file ke komputer Anda

### STEP 2: Upload ke cPanel

1. Login ke **cPanel**
2. Buka **File Manager**
3. Masuk ke folder `public_html`
4. Upload semua file dari folder `situneo-digital/`
5. Ekstrak jika dalam bentuk ZIP

Struktur folder setelah upload:
```
public_html/
├── .env
├── .htaccess
├── config/
├── app/
├── public/
├── storage/
└── database/
```

### STEP 3: Setup Database

1. Buka **cPanel → MySQL® Databases**
2. **Create Database:**
   - Database Name: `situneo_digital`
   - Click **Create Database**

3. **Create User:**
   - Username: `situneo_user`
   - Password: (generate strong password)
   - Click **Create User**

4. **Add User to Database:**
   - User: `situneo_user`
   - Database: `situneo_digital`
   - Privileges: **ALL PRIVILEGES**
   - Click **Make Changes**

5. **Import Database:**
   - Buka **phpMyAdmin**
   - Pilih database `situneo_digital`
   - Click tab **Import**
   - Choose file: `database/situneo_digital.sql`
   - Click **Go**

### STEP 4: Konfigurasi Environment

1. Edit file `.env` di root folder:

```env
# Database
DB_HOST=localhost
DB_PORT=3306
DB_DATABASE=situneo_digital
DB_USERNAME=situneo_user
DB_PASSWORD=your_database_password_here

# Application
APP_URL=https://yourdomain.com

# Email (SMTP)
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=your-email@gmail.com
MAIL_PASSWORD=your-app-password
MAIL_FROM_ADDRESS=noreply@yourdomain.com
```

2. Save file

### STEP 5: Set Permissions

Via **File Manager** di cPanel:

```
storage/ → 755
storage/logs/ → 755
public/uploads/ → 755
```

Cara set permissions:
1. Right-click folder
2. Click **Change Permissions**
3. Set ke **755**
4. Check ✅ **Recurse into subdirectories**
5. Click **Change Permissions**

### STEP 6: Setup PHP Version

1. Buka **cPanel → Select PHP Version**
2. Pilih **PHP 8.0** atau lebih tinggi
3. **Enable Extensions:**
   - ✅ pdo
   - ✅ pdo_mysql
   - ✅ mbstring
   - ✅ openssl
   - ✅ curl
   - ✅ json
   - ✅ fileinfo

4. Click **Save**

### STEP 7: Test Installation

1. Buka browser
2. Akses: `https://yourdomain.com`
3. Anda akan redirect ke login page
4. Click **"Daftar Sekarang"**
5. Isi form registrasi
6. Check email untuk verifikasi
7. Setelah verifikasi, login dengan akun Anda

---

## 🧪 TESTING CHECKLIST

### ✅ Test 1: Register User Baru
- [ ] Buka halaman register
- [ ] Isi semua field
- [ ] Submit form
- [ ] Check apakah email verifikasi terkirim
- [ ] Check database apakah user tersimpan

### ✅ Test 2: Email Verification
- [ ] Buka email verifikasi
- [ ] Click link verifikasi
- [ ] Check apakah redirect ke login
- [ ] Check database `email_verified_at` terisi

### ✅ Test 3: Login
- [ ] Masukkan email dan password
- [ ] Check apakah redirect ke dashboard
- [ ] Check apakah session tersimpan
- [ ] Check activity_logs di database

### ✅ Test 4: Logout
- [ ] Click tombol logout
- [ ] Check apakah redirect ke login
- [ ] Check apakah session terhapus

### ✅ Test 5: Forgot Password
- [ ] Click "Lupa Password"
- [ ] Masukkan email
- [ ] Check email reset password
- [ ] Click link reset
- [ ] Masukkan password baru
- [ ] Login dengan password baru

---

## 📁 STRUKTUR FILES

```
situneo-digital/
├── .env                          # Environment config
├── .htaccess                     # Apache config
├── config/
│   └── config.php               # Main configuration
├── app/
│   ├── helpers/
│   │   ├── Database.php         # Database connection (PDO)
│   │   ├── Validator.php        # Form validation
│   │   ├── Mailer.php           # Email sending
│   │   ├── Session.php          # Session management
│   │   └── CSRF.php             # CSRF protection
│   ├── models/
│   │   └── User.php             # User model
│   ├── controllers/
│   │   └── AuthController.php   # Authentication controller
│   └── views/
│       ├── layouts/
│       │   ├── header.php       # Header template
│       │   └── footer.php       # Footer template
│       └── auth/
│           ├── login.php        # Login view
│           └── register.php     # Register view
├── public/
│   ├── index.php                # Main entry point
│   ├── login.php                # Login page
│   ├── register.php             # Register page
│   ├── process-login.php        # Login handler
│   ├── process-register.php     # Register handler
│   ├── verify-email.php         # Email verification handler
│   ├── logout.php               # Logout handler
│   ├── dashboard.php            # Dashboard (placeholder)
│   ├── .htaccess                # Public .htaccess
│   ├── assets/
│   │   ├── css/
│   │   │   └── style.css        # Custom CSS
│   │   └── js/
│   │       └── app.js           # Custom JavaScript
│   └── uploads/                 # User uploads
├── storage/
│   └── logs/                    # Application logs
└── database/
    └── situneo_digital.sql      # Database schema
```

---

## 🔧 TROUBLESHOOTING

### Error: "Database connection failed"
**Solusi:**
- Check kredensial database di `.env`
- Pastikan database sudah dibuat
- Pastikan user sudah di-assign ke database
- Check apakah PDO extension enabled

### Error: "Email not sent"
**Solusi:**
- Check konfigurasi SMTP di `.env`
- Gunakan App Password (bukan password Gmail biasa)
- Enable "Less secure app access" di Gmail (jika perlu)
- Check firewall port 587

### Error: "Permission denied"
**Solusi:**
- Set folder permissions:
  - `storage/` → 755
  - `storage/logs/` → 755
  - `public/uploads/` → 755

### Error: "CSRF token invalid"
**Solusi:**
- Clear browser cookies
- Check session configuration di `config/config.php`
- Pastikan session folder writable

### Error: "Class not found"
**Solusi:**
- Check autoloader di `config/config.php`
- Pastikan semua files terupload dengan benar
- Check case-sensitivity (Linux hosting)

### Page tidak bisa diakses (404)
**Solusi:**
- Check `.htaccess` file ada
- Enable `mod_rewrite` di Apache
- Check `RewriteBase` di `.htaccess`

---

## 📊 DATABASE STRUCTURE

### Users & Authentication (18 tables)
1. ✅ `roles` - User roles
2. ✅ `users` - Main users table
3. ✅ `user_profiles` - Extended profiles
4. ✅ `verification_tokens` - Email/password tokens
5. ✅ `remember_tokens` - Remember me cookies
6. ✅ `activity_logs` - User activity tracking
7. ✅ `permissions` - System permissions
8. ✅ `role_permissions` - Role-permission mapping
9. ✅ `user_sessions` - Active sessions
10. ✅ `user_settings` - User preferences
11. ✅ `user_devices` - User devices
12. ✅ `user_notifications` - Notifications
13. ✅ `user_addresses` - Delivery addresses
14. ✅ `user_documents` - KYC documents
15. ✅ `user_bank_accounts` - Bank accounts
16. ✅ `user_referrals` - Referral system
17. ✅ `user_kyc` - KYC verification
18. ✅ `user_messages` - Internal messaging

### Admin System (12 tables)
1. ✅ `admin_dashboard_widgets` - Dashboard customization
2. ✅ `admin_settings` - System settings
3. ✅ `admin_announcements` - System announcements
4. ✅ `admin_menu_items` - Dynamic menu
5. ✅ `admin_audit_logs` - Audit trail
6. ✅ `admin_reports` - Report generation
7. ✅ `admin_backups` - Backup management
8. ✅ `admin_system_logs` - System logs
9. ✅ `admin_scheduled_tasks` - Cron jobs
10. ✅ `admin_email_queue` - Email queue
11. ✅ `admin_cache` - Cache storage
12. ✅ `admin_failed_jobs` - Failed job tracking

**Total:** 30 tables (BATCH 1)

---

## 🔐 SECURITY FEATURES

- ✅ **Password Hashing:** bcrypt dengan cost 12
- ✅ **SQL Injection Prevention:** PDO prepared statements
- ✅ **XSS Prevention:** htmlspecialchars pada output
- ✅ **CSRF Protection:** Token validation
- ✅ **Session Security:** Regenerate ID on login
- ✅ **Email Verification:** Required untuk aktivasi
- ✅ **Activity Logging:** Track semua user actions
- ✅ **Remember Me:** Secure token-based
- ✅ **Rate Limiting:** (akan ditambahkan di BATCH berikutnya)

---

## 🎨 DESIGN FEATURES

- ✅ Modern UI dengan Bootstrap 5.3.3
- ✅ Gradient color themes
- ✅ Responsive design (mobile-friendly)
- ✅ Font Awesome 6.4.0 icons
- ✅ Custom CSS dengan smooth animations
- ✅ Toast notifications
- ✅ Loading spinners
- ✅ Form validation feedback
- ✅ Password visibility toggle

---

## 📧 EMAIL TEMPLATES

Semua email menggunakan HTML template yang konsisten:
- ✅ Welcome email
- ✅ Email verification
- ✅ Password reset
- ✅ Account notifications

---

## 🔄 FUTURE BATCHES

### BATCH 2: Partner & Commission System
- Partner dashboard
- Commission calculation
- Tier management
- Partner reports

### BATCH 3: Services & Ordering
- Service catalog
- Order management
- Payment processing
- Invoice generation

### BATCH 4: Client Portal
- Client dashboard
- Service requests
- Order tracking
- Support tickets

### BATCH 5: Analytics & Reporting
- Sales analytics
- Commission reports
- User statistics
- Performance metrics

---

## 📞 SUPPORT

Jika ada pertanyaan atau issue:
- Email: info@situneo.com
- Phone: +62-xxx-xxxx-xxxx

---

## 📝 CHANGELOG

### Version 1.0.0 - BATCH 1 (Current)
- ✅ User registration & login
- ✅ Email verification
- ✅ Password reset
- ✅ User management
- ✅ Admin system foundation
- ✅ Activity logging
- ✅ CSRF protection

### Version 1.1.0 - BATCH 2 (Coming Soon)
- Partner system
- Commission calculator
- Multi-tier commission
- SPV & Manager dashboards

---

## 📄 LICENSE

Copyright © 2024 PT SITUNEO DIGITAL SOLUSI INDONESIA
NIB: 1401250064281
All Rights Reserved

---

**Selamat menggunakan SITUNEO DIGITAL! 🚀**
