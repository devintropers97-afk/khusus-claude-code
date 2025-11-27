# BATCH 1: FOUNDATION & CORE SYSTEM

**PT SITUNEO DIGITAL SOLUSI INDONESIA**

**Status:** ✅ COMPLETE & READY TO DEPLOY
**PHP Version:** 8.0+ (tested with alt-php80)
**Database:** MySQL 8.0+
**Deployment:** cPanel Shared Hosting

---

## 📦 WHAT'S INCLUDED IN BATCH 1

### ✅ 1. COMPLETE FOLDER STRUCTURE
- Organized MVC architecture
- 730 files structure ready
- Public assets (CSS, JS, images)
- Application logic separated
- Configuration isolated
- Ready for production

### ✅ 2. DATABASE (ALL 208 TABLES)
- Complete database schema
- All 14 categories:
  - User Management (18 tables)
  - Admin System (12 tables)
  - Partner System (28 tables)
  - SPV System (15 tables)
  - Manager System (15 tables)
  - Client System (25 tables)
  - Services & Orders (20 tables)
  - Portfolio & Showcase (10 tables)
  - Job Board System (10 tables)
  - Commission & Financials (15 tables)
  - Email Automation (8 tables)
  - Content Management (12 tables)
  - Analytics & Tracking (10 tables)
  - System & Configuration (10 tables)
- Sample data included (admin user, demo services)
- Indexes optimized
- Foreign keys configured

### ✅ 3. USER AUTHENTICATION SYSTEM
**Features:**
- Registration (Client, Partner, SPV, Manager)
- Email verification (working with SMTP)
- Login (all roles)
- Password reset (email-based)
- Session management (secure)
- Remember me functionality
- Role-based access control (RBAC)
- 2FA ready (structure prepared)

**Security:**
- Password hashing (bcrypt)
- CSRF protection
- SQL injection prevention (prepared statements)
- XSS prevention (input sanitization)
- Session hijacking prevention
- Secure cookies

### ✅ 4. ADMIN DASHBOARD (BASIC)
**Features:**
- Admin login
- Dashboard overview:
  - Total users (by role)
  - Total orders (today, this month)
  - Total revenue
  - Pending actions
- User management:
  - View all users
  - Filter by role
  - Search users
  - View user details
  - Suspend/activate users
- System settings (basic):
  - Site settings
  - Email settings
  - Maintenance mode
- Profile management
- Logout

### ✅ 5. CONFIGURATION FILES
- `config/config.php` - Application settings
- `config/database.php` - Database credentials
- `.env` - Environment variables (gitignored)
- `.htaccess` - URL rewriting & security

### ✅ 6. CORE HELPERS & UTILITIES
- Database class (PDO wrapper)
- Validator class (form validation)
- Mailer class (SMTP email sending)
- Session class (secure session handling)
- CSRF class (CSRF token generation/validation)
- Redirect helper
- Flash messages
- Sanitization functions

### ✅ 7. EMAIL SYSTEM (BASIC)
**Templates included:**
- Welcome email (after registration)
- Email verification
- Password reset
- Account activated
- Template system ready for 27 templates (Batch 9)

### ✅ 8. RESPONSIVE UI
- Bootstrap 5.3.3
- Custom CSS (brand colors)
- Responsive design (mobile-first)
- Clean, modern interface
- Font Awesome icons
- Loading states
- Toast notifications

---

## 📂 FOLDER STRUCTURE

```
situneo-digital/
│
├── public/                          ← UPLOAD THIS TO public_html/
│   ├── index.php                    ← Entry point
│   ├── .htaccess                    ← URL rewriting
│   │
│   ├── assets/
│   │   ├── css/
│   │   │   ├── bootstrap.min.css    (5.3.3)
│   │   │   ├── bootstrap.min.css.map
│   │   │   ├── fontawesome.min.css  (6.5.1)
│   │   │   ├── style.css            ← Custom styles
│   │   │   └── admin.css            ← Admin panel styles
│   │   │
│   │   ├── js/
│   │   │   ├── bootstrap.bundle.min.js (5.3.3)
│   │   │   ├── bootstrap.bundle.min.js.map
│   │   │   ├── jquery-3.7.1.min.js
│   │   │   ├── app.js               ← Main JS
│   │   │   └── admin.js             ← Admin JS
│   │   │
│   │   ├── images/
│   │   │   ├── logo.png             ← PT SITUNEO logo
│   │   │   ├── logo-white.png
│   │   │   ├── favicon.ico
│   │   │   ├── hero-bg.jpg
│   │   │   └── placeholder.png
│   │   │
│   │   └── fonts/                   ← Font Awesome webfonts
│   │       └── webfonts/
│   │
│   └── uploads/                     ← User uploads (777 permission)
│       ├── profiles/
│       ├── documents/
│       ├── orders/
│       └── .htaccess                (deny direct access)
│
├── app/
│   ├── controllers/
│   │   ├── AuthController.php       ← Login, register, verify
│   │   ├── DashboardController.php  ← Role-based dashboards
│   │   ├── AdminController.php      ← Admin functions
│   │   ├── UserController.php       ← User management
│   │   └── ProfileController.php    ← Profile settings
│   │
│   ├── models/
│   │   ├── User.php                 ← User model
│   │   ├── UserRole.php             ← Roles
│   │   ├── UserProfile.php          ← Extended profiles
│   │   ├── Admin.php                ← Admin model
│   │   └── EmailQueue.php           ← Email queue
│   │
│   ├── views/
│   │   ├── layouts/
│   │   │   ├── header.php           ← Common header
│   │   │   ├── footer.php           ← Common footer
│   │   │   ├── admin-header.php     ← Admin header
│   │   │   └── admin-sidebar.php    ← Admin sidebar
│   │   │
│   │   ├── auth/
│   │   │   ├── login.php            ← Login page
│   │   │   ├── register.php         ← Registration
│   │   │   ├── verify-email.php     ← Email verification
│   │   │   ├── forgot-password.php  ← Password reset request
│   │   │   └── reset-password.php   ← Password reset form
│   │   │
│   │   ├── admin/
│   │   │   ├── dashboard.php        ← Admin dashboard
│   │   │   ├── users/
│   │   │   │   ├── index.php        ← User list
│   │   │   │   └── view.php         ← User details
│   │   │   └── settings/
│   │   │       └── index.php        ← System settings
│   │   │
│   │   ├── client/
│   │   │   └── dashboard.php        ← Client dashboard (basic)
│   │   │
│   │   ├── partner/
│   │   │   └── dashboard.php        ← Partner dashboard (basic)
│   │   │
│   │   ├── spv/
│   │   │   └── dashboard.php        ← SPV dashboard (basic)
│   │   │
│   │   ├── manager/
│   │   │   └── dashboard.php        ← Manager dashboard (basic)
│   │   │
│   │   ├── emails/
│   │   │   ├── welcome.php          ← Welcome email template
│   │   │   ├── verify-email.php     ← Verification email
│   │   │   └── reset-password.php   ← Password reset email
│   │   │
│   │   ├── home.php                 ← Homepage (public)
│   │   ├── about.php                ← About page
│   │   ├── contact.php              ← Contact page
│   │   └── errors/
│   │       ├── 404.php              ← Not found
│   │       ├── 403.php              ← Forbidden
│   │       └── 500.php              ← Server error
│   │
│   ├── helpers/
│   │   ├── Database.php             ← PDO database wrapper
│   │   ├── Validator.php            ← Form validation
│   │   ├── Mailer.php               ← Email sending (SMTP)
│   │   ├── Session.php              ← Session management
│   │   ├── CSRF.php                 ← CSRF protection
│   │   ├── functions.php            ← Helper functions
│   │   └── constants.php            ← App constants
│   │
│   └── middleware/
│       ├── AuthMiddleware.php       ← Authentication check
│       └── RoleMiddleware.php       ← Role-based access
│
├── config/
│   ├── config.php                   ← App configuration
│   ├── database.php                 ← Database credentials
│   └── routes.php                   ← URL routing
│
├── database/
│   ├── situneo_digital.sql          ← FULL DATABASE (208 tables)
│   └── sample_data.sql              ← Sample data (optional)
│
├── storage/
│   ├── logs/
│   │   ├── app.log                  ← Application logs
│   │   ├── error.log                ← Error logs
│   │   └── email.log                ← Email sending logs
│   └── cache/                       ← Cache files
│
├── docs/
│   ├── INSTALLATION.md              ← Installation guide
│   ├── CONFIGURATION.md             ← Configuration guide
│   ├── TESTING.md                   ← Testing checklist
│   ├── TROUBLESHOOTING.md           ← Common issues
│   └── API.md                       ← API documentation (future)
│
├── .htaccess                        ← Root htaccess
├── .env.example                     ← Environment example
├── README.md                        ← Project readme
└── composer.json                    ← Composer dependencies (optional)
```

---

## 🚀 QUICK START INSTALLATION

### Step 1: Download & Extract
```bash
# Download BATCH-1-FOUNDATION.zip
# Extract to your computer
```

### Step 2: Create Database
1. cPanel → MySQL Databases
2. Create database: `cpaneluser_situneo`
3. Create user: `cpaneluser_admin`
4. Set password (strong password!)
5. Add user to database (ALL PRIVILEGES)

### Step 3: Import Database
1. cPanel → phpMyAdmin
2. Select database `cpaneluser_situneo`
3. Click **Import**
4. Upload `database/situneo_digital.sql`
5. Click **Go**
6. Wait ~2-3 minutes (208 tables!)

### Step 4: Upload Files
1. cPanel → File Manager
2. Go to `public_html/`
3. Upload `BATCH-1-FOUNDATION.zip`
4. Extract ZIP
5. Move all files from `/public/` to `public_html/` root
6. Delete ZIP file

### Step 5: Configure Database
Edit `config/database.php`:
```php
return [
    'host' => 'localhost',
    'database' => 'cpaneluser_situneo',
    'username' => 'cpaneluser_admin',
    'password' => 'YOUR_PASSWORD_HERE',
    'charset' => 'utf8mb4',
];
```

### Step 6: Configure Application
Edit `config/config.php`:
```php
'app_url' => 'https://situneo.my.id',
'app_email' => 'admin@situneo.my.id',

// SMTP Settings
'smtp_host' => 'mail.situneo.my.id',
'smtp_port' => 587,
'smtp_username' => 'noreply@situneo.my.id',
'smtp_password' => 'YOUR_SMTP_PASSWORD',
```

### Step 7: Set Permissions
```bash
# Via cPanel File Manager:
/storage/                → 777
/storage/logs/           → 777
/storage/cache/          → 777
/public/uploads/         → 777
```

### Step 8: Access Website
Open browser: `https://situneo.my.id`

**Default Admin Login:**
- URL: `https://situneo.my.id/admin/login`
- Email: `admin@situneo.my.id`
- Password: `Admin123!`

**⚠️ CHANGE PASSWORD IMMEDIATELY!**

---

## ✅ TESTING CHECKLIST

### Test 1: Homepage
- [ ] Visit `https://situneo.my.id`
- [ ] Homepage loads
- [ ] Logo displayed
- [ ] Navigation works

### Test 2: Registration (Client)
- [ ] Click "Register"
- [ ] Fill form (choose role: Client)
- [ ] Submit
- [ ] Check email (verification link)
- [ ] Click verification link
- [ ] Account activated
- [ ] Login successful

### Test 3: Login
- [ ] Login as Client
- [ ] Redirected to Client Dashboard
- [ ] See welcome message
- [ ] Logout successful

### Test 4: Admin Login
- [ ] Visit `/admin/login`
- [ ] Login with default credentials
- [ ] See Admin Dashboard
- [ ] View statistics (users, orders, revenue)
- [ ] Navigate to Users page
- [ ] See registered users

### Test 5: Password Reset
- [ ] Click "Forgot Password"
- [ ] Enter email
- [ ] Receive reset email
- [ ] Click reset link
- [ ] Set new password
- [ ] Login with new password successful

### Test 6: Email System
- [ ] All emails sent successfully
- [ ] Emails formatted correctly
- [ ] Links work
- [ ] SMTP connection successful

### Test 7: User Management (Admin)
- [ ] View all users
- [ ] Search users
- [ ] Filter by role
- [ ] View user details
- [ ] Suspend user
- [ ] Activate user

### Test 8: Profile Settings
- [ ] Edit profile (any role)
- [ ] Update name, phone, address
- [ ] Upload profile photo
- [ ] Save changes
- [ ] Changes reflected

### Test 9: Session Security
- [ ] Login
- [ ] Close browser
- [ ] Reopen (should stay logged in if "Remember Me")
- [ ] Without "Remember Me" → logged out

### Test 10: Error Handling
- [ ] Visit non-existent page → 404 error
- [ ] Try access admin without login → redirect to login
- [ ] Try access admin as Client → 403 forbidden

---

## 🐛 TROUBLESHOOTING

### Issue: "Database connection failed"
**Solution:**
1. Check `config/database.php` credentials correct
2. Check database exists in cPanel → MySQL Databases
3. Check user has ALL PRIVILEGES on database
4. Check MySQL service running

### Issue: "White screen / blank page"
**Solution:**
1. Enable error display:
   - cPanel → MultiPHP INI Editor
   - Set `display_errors = On`
2. Check error logs: `/storage/logs/error.log`
3. Check PHP version = 8.0+

### Issue: "Emails not sending"
**Solution:**
1. Check SMTP credentials in `config/config.php`
2. Test SMTP connection (use SMTP test tool)
3. Check email logs: `/storage/logs/email.log`
4. Verify SPF/DKIM records for domain

### Issue: "Permission denied" errors
**Solution:**
```bash
# Set correct permissions:
/storage/         → 777
/public/uploads/  → 777
```

### Issue: "CSS/JS not loading"
**Solution:**
1. Check `.htaccess` exists in `/public/`
2. Check file paths in `config/config.php` ('app_url')
3. Hard refresh browser (Ctrl + F5)

### Issue: "404 on all pages"
**Solution:**
1. Check `.htaccess` file exists
2. Check Apache mod_rewrite enabled (usually enabled on cPanel)
3. Check `public/` files moved to `public_html/` root

---

## 📊 DATABASE STRUCTURE

**Total Tables:** 208 ✅

**Sample Key Tables:**

```sql
-- users (18 columns)
id, role_id, email, password, first_name, last_name, phone, avatar,
status, email_verified_at, remember_token, last_login_at,
created_at, updated_at, deleted_at

-- user_roles (5 default roles)
1 = Super Admin
2 = Manager
3 = SPV
4 = Partner
5 = Client

-- orders
id, order_number, client_id, partner_id, service_id,
order_type, order_status, payment_status, total_amount, ...

-- partner_commission
id, partner_id, sale_id, commission_amount, commission_rate,
payment_status, paid_at, ...
```

**See full schema:** `database/situneo_digital.sql`

---

## 🔐 SECURITY FEATURES

✅ Password hashing (bcrypt, cost 12)
✅ CSRF protection on all forms
✅ SQL injection prevention (PDO prepared statements)
✅ XSS prevention (input sanitization & output escaping)
✅ Session hijacking prevention (session regeneration)
✅ Secure cookies (httponly, samesite)
✅ Rate limiting (login attempts) - ready
✅ Input validation (server-side)
✅ File upload security (type & size checking)
✅ .htaccess security headers

---

## 📝 DEFAULT ACCOUNTS

### Super Admin
- Email: `admin@situneo.my.id`
- Password: `Admin123!`
- **CHANGE IMMEDIATELY AFTER FIRST LOGIN!**

### Test Client
- Email: `client@test.com`
- Password: `Test123!`

### Test Partner
- Email: `partner@test.com`
- Password: `Test123!`

---

## 📈 WHAT'S NEXT (BATCH 2-15)

**BATCH 2: Services & Ordering** (Next)
- Service catalog (306 services)
- Service categories (10 divisions)
- Order system
- Shopping cart
- Order management

**BATCH 3: Payment & Invoicing**
- Invoice generation
- Payment verification
- Payment methods
- Client wallet

**BATCH 4-15:** See IMPLEMENTATION_PLAN.md

---

## 🆘 SUPPORT

**Issues? Questions?**
1. Check `docs/TROUBLESHOOTING.md`
2. Check `storage/logs/error.log`
3. Contact development team
4. Email: support@situneo.my.id

---

## 📄 LICENSE

Proprietary - PT SITUNEO DIGITAL SOLUSI INDONESIA
All rights reserved.

---

**BATCH 1 STATUS:** ✅ COMPLETE
**Next Batch:** BATCH 2 (Services & Ordering)
**Estimated Completion:** All 15 batches in 18-24 months

---

**Generated:** 2025-11-27
**Version:** 1.0
**Author:** Development Team
