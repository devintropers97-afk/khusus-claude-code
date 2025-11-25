# 📋 SITUNEO - BATCH 4-15 CONTINUATION
## PANDUAN DEVELOPMENT LANJUTAN

**File ini adalah lanjutan dari:** SITUNEO_BATCH_BREAKDOWN_COMPLETE.md  
**Batch Range:** 4-15  
**Status:** Development Blueprint

---

# 🎯 BATCH 4: AUTHENTICATION SYSTEM
**Status:** 🔴 Belum Mulai  
**Prioritas:** 🔥 CRITICAL  
**Estimasi:** 4-5 hari kerja  
**Dependencies:** ✅ Batch 1-3 (DB + Core + Public ready)

## Tujuan Batch 4
Membuat sistem authentication lengkap: Login, Register (2 types), Forgot Password, Email Verification, Session Management, dan Security.

## Pages yang Dibuat (6 Pages)

```
1. Login (/login)
2. Register Client (/register)
3. Register Partner/SPV/Manager (/register/partner OR /spv OR /manager)
4. Forgot Password (/forgot-password)
5. Reset Password (/reset-password)
6. Email Verification (/verify-email)
```

## Features Detail

### 1. Login Page (Split Design)
```
LEFT SIDE: Login Form
├─ Email input (with validation)
├─ Password input (with show/hide toggle)
├─ Remember me checkbox
├─ Forgot password link
├─ Login button (primary, full width)
├─ Social login (Optional Phase 2)
└─ Register link

RIGHT SIDE: Branding
├─ Gradient background + network animation
├─ Headline: "Platform Digital Agency Terlengkap"
├─ Feature list (4 items)
└─ Stats (500+ Clients, 4.9/5 Rating)

FUNCTIONALITY:
├─ Client-side validation (real-time)
├─ Server-side validation
├─ CSRF protection
├─ reCAPTCHA v3 (invisible)
├─ Rate limiting (5 attempts / 15 min)
├─ Remember me (extend session to 30 days)
├─ Activity logging (IP, device, timestamp)
└─ Redirect based on role:
    ├─ Admin → /admin/dashboard
    ├─ Manager → /manager/dashboard
    ├─ SPV → /spv/dashboard
    ├─ Partner → /partner/dashboard
    └─ Client → /client/dashboard
```

### 2. Register Client (Simple Form)
```
FIELDS:
├─ Full Name (required)
├─ Email (required, unique, format validation)
├─ Phone (required, format: 08xx or +62xxx)
├─ Password (required, min 8 char, show/hide toggle)
├─ Confirm Password (required, must match)
├─ Agree to Terms checkbox (required)
└─ Register button

FLOW:
1. User fills form
2. Submit → Server validation
3. If valid:
   ├─ Insert to users table (status: pending)
   ├─ Insert to clients table
   ├─ Generate verification token
   ├─ Send verification email
   └─ Show success message: "Check your email"
4. User clicks verification link in email
5. Account activated (status: active)
6. Redirect to login
```

### 3. Register Partner/SPV/Manager (Detailed Form)
```
STEP 1: Role Selection
├─ Radio buttons: Partner / SPV / Manager Area
└─ Description for each role

STEP 2: Basic Info
├─ Full Name
├─ Email
├─ Phone
├─ Password
├─ Confirm Password

STEP 3: Address
├─ Jalan (street address)
├─ Kota (city)
├─ Provinsi (province, dropdown)
├─ Kode Pos (postal code)

STEP 4: Documents
├─ Upload KTP (JPG/PNG, max 2MB)
├─ Upload CV (PDF/DOC, max 5MB)

STEP 5: Referral (Optional)
├─ Referral Code input (auto-filled if from referral link)
└─ Verify referral code (check if valid)

STEP 6: Review & Submit
├─ Show summary of entered data
├─ Agree to Terms checkbox
├─ Submit Application button

FLOW:
1. User completes multi-step form
2. Submit → Server validation
3. If valid:
   ├─ Insert to users table (status: pending)
   ├─ Insert to partners/spv/manager table (based on role)
   ├─ Save documents to uploads folder
   ├─ Link referral (if provided)
   ├─ Send notification to admin (new application)
   └─ Show success: "Application submitted, wait for approval"
4. Admin reviews application (in Admin Dashboard)
5. Admin approves → Account activated
6. User receives welcome email with login credentials
7. User can login
```

### 4. Forgot Password
```
PAGE 1: Enter Email
├─ Email input
├─ Submit button
└─ Back to login link

FLOW:
1. User enters email
2. Submit → Check if email exists
3. If exists:
   ├─ Generate reset token (random, unique, expires 1 hour)
   ├─ Save to password_resets table
   ├─ Send reset email with link
   └─ Show: "Check your email for reset link"
4. If not exists:
   └─ Show: "Email sent if account exists" (security: don't reveal if email exists)

PAGE 2: Reset Password (from email link)
├─ Token validation (check if valid & not expired)
├─ New password input (min 8 char, show/hide)
├─ Confirm password input
├─ Submit button

FLOW:
1. User clicks reset link in email
2. System validates token
3. If valid:
   ├─ Show reset form
   ├─ User enters new password
   ├─ Submit → Update password (bcrypt hash)
   ├─ Delete reset token
   ├─ Invalidate all sessions (force re-login)
   └─ Show success: "Password updated, please login"
4. If invalid/expired:
   └─ Show error: "Invalid or expired link"
```

### 5. Email Verification
```
TRIGGER: After Register Client (auto-send)

EMAIL CONTENT:
├─ Subject: "Verify Your Email - SITUNEO Digital"
├─ Greeting: "Hi [Name],"
├─ Message: "Please verify your email to activate your account"
├─ Verification Button/Link:
│   https://situneo.my.id/verify-email?token=[TOKEN]
└─ Footer: Contact info, social media

VERIFICATION FLOW:
1. User clicks link in email
2. System validates token (check if exists & not expired)
3. If valid:
   ├─ Update users.email_verified = TRUE
   ├─ Update users.status = 'active'
   ├─ Delete verification token
   ├─ Show success page: "Email verified! You can now login"
   └─ Redirect to login after 3 seconds
4. If invalid/expired:
   ├─ Show error: "Invalid or expired link"
   └─ Offer to resend verification email
```

### 6. Session Management
```php
// Session Configuration
session_start([
    'cookie_lifetime' => 7200, // 2 hours default
    'cookie_secure' => true,   // HTTPS only
    'cookie_httponly' => true, // JavaScript cannot access
    'cookie_samesite' => 'Strict',
    'use_strict_mode' => true
]);

// Store user data in session after login
$_SESSION['user_id'] = $user['id'];
$_SESSION['user'] = [
    'id' => $user['id'],
    'username' => $user['username'],
    'email' => $user['email'],
    'full_name' => $user['full_name'],
    'role' => $user['role'],
    'avatar' => $user['avatar'],
    'language' => $user['language_preference']
];
$_SESSION['logged_in'] = true;
$_SESSION['login_time'] = time();
$_SESSION['ip'] = $_SERVER['REMOTE_ADDR'];

// Remember Me (extend session to 30 days)
if (isset($_POST['remember_me'])) {
    setcookie('remember_token', $token, time() + (30 * 24 * 60 * 60), '/', '', true, true);
    // Store token in database (user_sessions table)
}

// Session Timeout Check (Middleware)
if (time() - $_SESSION['login_time'] > 7200) { // 2 hours
    session_destroy();
    header('Location: /login?timeout=1');
    exit;
}

// Activity Update (every request)
$_SESSION['last_activity'] = time();
```

## Security Measures

### 1. Password Security
```php
// Hash password (bcrypt, cost 12)
$password_hash = password_hash($password, PASSWORD_BCRYPT, ['cost' => 12]);

// Verify password
if (password_verify($input_password, $stored_hash)) {
    // Login success
} else {
    // Login failed
}

// Password Requirements (client + server validation)
- Minimum 8 characters
- No complexity requirement (UX-friendly)
- No reuse of last 3 passwords (optional)
```

### 2. CSRF Protection
```php
// Generate CSRF token (on form load)
$_SESSION['csrf_token'] = bin2hex(random_bytes(32));

// In form HTML
<input type="hidden" name="csrf_token" value="<?= $_SESSION['csrf_token'] ?>">

// Validate on submit
if (!isset($_POST['csrf_token']) || $_POST['csrf_token'] !== $_SESSION['csrf_token']) {
    die('CSRF validation failed');
}

// Regenerate token after use
unset($_SESSION['csrf_token']);
```

### 3. Rate Limiting
```php
// Login attempts (max 5 attempts per 15 min per IP)
$attempts_key = 'login_attempts_' . $_SERVER['REMOTE_ADDR'];

if (!isset($_SESSION[$attempts_key])) {
    $_SESSION[$attempts_key] = ['count' => 0, 'time' => time()];
}

// Check if locked
if ($_SESSION[$attempts_key]['count'] >= 5) {
    if (time() - $_SESSION[$attempts_key]['time'] < 900) { // 15 min
        die('Too many attempts. Please try again in ' . (900 - (time() - $_SESSION[$attempts_key]['time'])) . ' seconds.');
    } else {
        // Reset after 15 min
        $_SESSION[$attempts_key] = ['count' => 0, 'time' => time()];
    }
}

// Increment on failed login
if ($login_failed) {
    $_SESSION[$attempts_key]['count']++;
}

// Reset on success
if ($login_success) {
    unset($_SESSION[$attempts_key]);
}
```

### 4. Input Validation
```php
// Email validation
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    $errors[] = 'Invalid email format';
}

// Phone validation (Indonesia format)
if (!preg_match('/^(08|\\+628)\\d{8,11}$/', $phone)) {
    $errors[] = 'Invalid phone format. Use 08xx or +628xx';
}

// Password strength (min 8 char)
if (strlen($password) < 8) {
    $errors[] = 'Password must be at least 8 characters';
}

// Sanitize input
$name = htmlspecialchars(trim($_POST['name']), ENT_QUOTES, 'UTF-8');
$email = filter_var(trim($_POST['email']), FILTER_SANITIZE_EMAIL);
```

### 5. SQL Injection Prevention
```php
// ALWAYS use prepared statements (never raw SQL with user input)
$stmt = $db->prepare("SELECT * FROM users WHERE email = ? AND password_hash = ?");
$stmt->bind_param("ss", $email, $password_hash);
$stmt->execute();
$result = $stmt->get_result();
```

## Email Templates (14 Types)

### 1. Welcome Email (After Register Client)
```
Subject: Welcome to SITUNEO Digital!
Body:
Hi [Name],

Welcome to SITUNEO Digital! Your account has been created successfully.

Email: [Email]
Username: [Username]

You can now:
✅ Order 232+ digital services
✅ Request free demo
✅ Track your orders
✅ Get 24/7 support

[Button: Login to Dashboard]

Need help? Contact us:
📧 support@situneo.my.id
📱 +62 831-7386-8915

Best regards,
SITUNEO Digital Team
```

### 2. Application Received (Partner/SPV/Manager)
```
Subject: Application Received - SITUNEO Digital
Body:
Hi [Name],

Your application for [Role] has been received!

We're reviewing your application and will notify you within 1-3 business days.

Application Details:
- Role: [Partner/SPV/Manager]
- Email: [Email]
- Phone: [Phone]
- Submitted: [Date]

[Button: Check Application Status]

Need help? Contact us:
📧 career@situneo.my.id
📱 +62 831-7386-8915

Best regards,
SITUNEO Digital Team
```

### 3. Application Approved
```
Subject: Congratulations! Your Application is Approved
Body:
Hi [Name],

Congratulations! Your application for [Role] has been approved!

Your account is now active. You can login using:
Email: [Email]
Password: [Your password]

Your Referral Link:
[Referral Link]

Share this link to recruit [clients/partners/SPV]!

[Button: Login to Dashboard]

Best regards,
SITUNEO Digital Team
```

### 4. Email Verification
```
Subject: Verify Your Email - SITUNEO Digital
Body:
Hi [Name],

Please verify your email address to activate your account.

[Button: Verify Email]

Or copy this link:
[Verification Link]

This link will expire in 24 hours.

If you didn't create an account, please ignore this email.

Best regards,
SITUNEO Digital Team
```

### 5. Password Reset
```
Subject: Reset Your Password - SITUNEO Digital
Body:
Hi [Name],

We received a request to reset your password.

Click the button below to reset your password:

[Button: Reset Password]

Or copy this link:
[Reset Link]

This link will expire in 1 hour.

If you didn't request this, please ignore this email.

Best regards,
SITUNEO Digital Team
```

## Testing Checklist

```
✅ Login works (all 5 roles)
✅ Register Client works (email verification)
✅ Register Partner/SPV/Manager works (application flow)
✅ Forgot Password works (email sent, reset works)
✅ Email Verification works (account activated)
✅ CSRF protection works (form submission blocked without token)
✅ Rate limiting works (5 failed attempts = locked)
✅ Session management works (timeout, remember me)
✅ Password hashing works (bcrypt)
✅ All email templates send correctly (14 types)
✅ Redirect based on role works
✅ Activity logging works
```

## Deliverables Summary

| Component | Files | Lines | Status |
|-----------|-------|-------|--------|
| Auth Pages | 6 files | ~1500 | 🔴 Todo |
| Auth Controllers | 3 files | ~800 | 🔴 Todo |
| Auth Models | 2 files | ~600 | 🔴 Todo |
| Email Templates | 14 files | ~700 | 🔴 Todo |
| Security Classes | 5 files | ~400 | 🔴 Todo |

**Total Output:** ~4,000 lines PHP + HTML

---

# 🎯 BATCH 5: CLIENT DASHBOARD
**Status:** 🔴 Belum Mulai  
**Prioritas:** 🔥 HIGH  
**Estimasi:** 5-7 hari kerja  
**Dependencies:** ✅ Batch 1-4 (DB + Core + Public + Auth ready)

## Tujuan Batch 5
Membuat Client Dashboard lengkap dengan semua fitur yang dibutuhkan client untuk order, track, payment, dan support.

## Pages yang Dibuat (20+ Pages)

```
CLIENT DASHBOARD PAGES:
1. Dashboard (overview, stats, recent activity)
2. Demo Request (26 fields form!)
3. Demo History (list of demo requests)
4. Create Order (multi-step form)
5. Order List (all orders with filters)
6. Order Detail (tracking, files, status)
7. Payment Upload (bukti transfer)
8. Payment History (all payments)
9. Invoice List (all invoices)
10. Invoice Detail (view HTML, download PDF, print)
11. Support Tickets (list)
12. Create Ticket (form with attachments)
13. Ticket Detail (conversation thread)
14. Notifications (all notifications)
15. Profile (edit profile, avatar)
16. Change Password
17. Address Management
18. Settings (language preference)

TOTAL: 18 main pages + partials
```

## Dashboard Overview

```
CLIENT DASHBOARD LAYOUT:
├─ Sidebar (fixed left, collapsible mobile)
│  ├─ Logo
│  ├─ User info (name, email, avatar)
│  ├─ Navigation menu:
│  │  ├─ Dashboard (overview)
│  │  ├─ Demo Request
│  │  ├─ Orders (with counter badge)
│  │  ├─ Payments (with pending badge)
│  │  ├─ Invoices
│  │  ├─ Support
│  │  └─ Settings
│  └─ Logout button
├─ Top Navbar (responsive)
│  ├─ Breadcrumb
│  ├─ Search (optional)
│  ├─ Notifications (dropdown with badge)
│  ├─ Language toggle (ID/EN)
│  └─ User dropdown (profile, settings, logout)
└─ Main Content Area
   └─ Page-specific content
```

## Key Features Detail

### 1. Demo Request (26 FIELDS!)
```html
<form id="demo-request-form" method="POST" enctype="multipart/form-data">
    <!-- Progress Indicator: 1/8 Sections Completed -->
    <div class="progress-indicator">
        <div class="progress-bar" style="width: 0%"></div>
        <span class="progress-text">0 of 26 fields completed</span>
    </div>
    
    <!-- SECTION 1: Business Info (4 fields) -->
    <div class="form-section active" data-section="1">
        <h3>Informasi Bisnis</h3>
        
        <div class="form-group">
            <label>Nama Bisnis <span class="required">*</span></label>
            <input type="text" name="field_01_nama_bisnis" required 
                   placeholder="Contoh: Toko Online Baju Muslimah">
            <small class="form-text">Nama bisnis atau brand Anda</small>
        </div>
        
        <div class="form-group">
            <label>Jenis Usaha <span class="required">*</span></label>
            <input type="text" name="field_02_jenis_usaha" required
                   placeholder="Contoh: E-commerce Fashion">
        </div>
        
        <div class="form-group">
            <label>Target Market</label>
            <textarea name="field_03_target_market" rows="3"
                      placeholder="Contoh: Wanita muslimah usia 20-35 tahun, middle-up class"></textarea>
        </div>
        
        <div class="form-group">
            <label>Lokasi Bisnis</label>
            <input type="text" name="field_04_lokasi"
                   placeholder="Contoh: Jakarta, Bandung, atau Online">
        </div>
        
        <button type="button" class="btn btn-primary" onclick="nextSection()">
            Lanjut ke Aset Existing →
        </button>
    </div>
    
    <!-- SECTION 2: Existing Assets (3 fields) -->
    <div class="form-section" data-section="2">
        <h3>Aset yang Sudah Ada</h3>
        
        <div class="form-group">
            <label>Website Existing (Jika Ada)</label>
            <input type="url" name="field_05_website_existing"
                   placeholder="https://example.com">
        </div>
        
        <div class="form-group">
            <label>Logo Existing (Upload File)</label>
            <input type="file" name="field_11_logo_existing" 
                   accept="image/*,.pdf,.ai">
            <small>Format: JPG, PNG, PDF, AI (max 5MB)</small>
        </div>
        
        <div class="form-group">
            <label>Domain Existing (Jika Ada)</label>
            <input type="text" name="field_17_domain_existing"
                   placeholder="Contoh: tokobaju.com">
        </div>
        
        <button type="button" class="btn btn-secondary" onclick="prevSection()">
            ← Kembali
        </button>
        <button type="button" class="btn btn-primary" onclick="nextSection()">
            Lanjut ke Budget & Timeline →
        </button>
    </div>
    
    <!-- Continue for all 8 sections... -->
    
    <!-- FINAL SECTION: Review & Submit -->
    <div class="form-section" data-section="8">
        <h3>Review & Submit</h3>
        
        <div class="review-summary">
            <!-- Auto-filled summary of all entered data -->
            <h4>Informasi Bisnis</h4>
            <p><strong>Nama Bisnis:</strong> <span id="review-nama-bisnis"></span></p>
            <!-- Show all 26 fields in organized groups -->
        </div>
        
        <div class="form-group">
            <label>
                <input type="checkbox" name="agree" required>
                Saya setuju dengan <a href="/terms" target="_blank">Terms & Conditions</a>
            </label>
        </div>
        
        <button type="button" class="btn btn-secondary" onclick="prevSection()">
            ← Kembali
        </button>
        <button type="submit" class="btn btn-success btn-lg">
            <i class="bi bi-send"></i> Submit Demo Request
        </button>
    </div>
</form>

<script>
// Form state management
let currentSection = 1;
const totalFields = 26;
let filledFields = 0;

// Auto-save to localStorage (prevent data loss)
function autoSave() {
    const formData = new FormData(document.getElementById('demo-request-form'));
    const data = Object.fromEntries(formData);
    localStorage.setItem('demo_request_draft', JSON.stringify(data));
}

// Load saved draft on page load
window.addEventListener('load', () => {
    const draft = localStorage.getItem('demo_request_draft');
    if (draft) {
        const data = JSON.parse(draft);
        Object.keys(data).forEach(key => {
            const input = document.querySelector(`[name="${key}"]`);
            if (input) input.value = data[key];
        });
    }
});

// Update progress
function updateProgress() {
    filledFields = document.querySelectorAll('input:valid, textarea:valid, select:valid').length;
    const percentage = (filledFields / totalFields) * 100;
    document.querySelector('.progress-bar').style.width = percentage + '%';
    document.querySelector('.progress-text').textContent = `${filledFields} of ${totalFields} fields completed`;
}

// Section navigation
function nextSection() {
    // Validate current section
    const currentSectionEl = document.querySelector(`.form-section[data-section="${currentSection}"]`);
    const requiredInputs = currentSectionEl.querySelectorAll('[required]');
    let isValid = true;
    
    requiredInputs.forEach(input => {
        if (!input.value) {
            isValid = false;
            input.classList.add('is-invalid');
        } else {
            input.classList.remove('is-invalid');
        }
    });
    
    if (!isValid) {
        alert('Please fill all required fields');
        return;
    }
    
    // Move to next section
    currentSectionEl.classList.remove('active');
    currentSection++;
    document.querySelector(`.form-section[data-section="${currentSection}"]`).classList.add('active');
    updateProgress();
    autoSave();
    
    // Scroll to top
    window.scrollTo({ top: 0, behavior: 'smooth' });
}

function prevSection() {
    document.querySelector(`.form-section[data-section="${currentSection}"]`).classList.remove('active');
    currentSection--;
    document.querySelector(`.form-section[data-section="${currentSection}"]`).classList.add('active');
    window.scrollTo({ top: 0, behavior: 'smooth' });
}

// Form submission
document.getElementById('demo-request-form').addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const formData = new FormData(e.target);
    
    try {
        const response = await fetch('/client/demo-request/submit', {
            method: 'POST',
            body: formData
        });
        
        const result = await response.json();
        
        if (result.success) {
            // Clear draft
            localStorage.removeItem('demo_request_draft');
            
            // Show success
            Swal.fire({
                icon: 'success',
                title: 'Demo Request Submitted!',
                text: 'Kami akan review request Anda dan mengirimkan demo dalam 24 jam.',
                confirmButtonText: 'Lihat Status'
            }).then(() => {
                window.location.href = '/client/demo-history';
            });
        } else {
            throw new Error(result.message);
        }
    } catch (error) {
        Swal.fire({
            icon: 'error',
            title: 'Submission Failed',
            text: error.message
        });
    }
});
</script>
```

### 2. Order Creation (Multi-Step)
```
STEP 1: Select Type
├─ Option 1: Request Demo First (recommended)
│   └─ Redirect to Demo Request form
└─ Option 2: Direct Order
    └─ Continue to next step

STEP 2: Select Service/Package
├─ Browse 232+ services (with search & filter)
├─ Or select package (Starter/Business/Premium)
├─ Add to cart (can add multiple services)
└─ Show cart summary (total items, total price)

STEP 3: Choose Payment Type
├─ Radio: Beli Putus (Rp 350K/page)
└─ Radio: Sewa Bulanan (Rp 150K/page/month, min 3 months)

STEP 4: Enter Requirements
├─ Brief description (textarea)
├─ Upload files:
│   ├─ Logo (if have)
│   ├─ Content/Text (if ready)
│   ├─ Reference websites (screenshots)
│   └─ Other files (max 10 files, 50MB total)
└─ Special requests (textarea)

STEP 5: Review Order
├─ Order summary:
│   ├─ Services selected (list)
│   ├─ Payment type
│   ├─ Total pages (if website)
│   ├─ Price breakdown
│   └─ Total amount (large, bold)
├─ Estimated delivery: [X] days
├─ Terms agreement checkbox
└─ Submit Order button

AFTER SUBMIT:
├─ Order created (status: Pending)
├─ Invoice generated (unique number)
├─ Redirect to Payment Upload page
└─ Email notification sent (order confirmation)
```

### 3. Payment Upload
```html
<form id="payment-upload-form">
    <div class="form-group">
        <label>Select Order</label>
        <select name="order_id" required>
            <option value="">-- Pilih Order --</option>
            <?php foreach ($unpaid_orders as $order): ?>
            <option value="<?= $order['order_id'] ?>">
                Order #<?= $order['order_id'] ?> - <?= $order['service_name'] ?> - Rp <?= number_format($order['total_amount']) ?>
            </option>
            <?php endforeach; ?>
        </select>
    </div>
    
    <div class="form-group">
        <label>Payment Method</label>
        <select name="payment_method" required>
            <option value="">-- Pilih Metode --</option>
            <option value="bank_transfer">Bank Transfer</option>
            <option value="qris">QRIS</option>
        </select>
    </div>
    
    <!-- Bank Account Info (show when bank_transfer selected) -->
    <div id="bank-info" style="display: none;">
        <div class="alert alert-info">
            <h5>Transfer ke:</h5>
            <p><strong>Bank BCA</strong><br>
            Account: 2750424018<br>
            Name: Devin Prasetyo Hermawan</p>
        </div>
    </div>
    
    <!-- QRIS Code (show when qris selected) -->
    <div id="qris-info" style="display: none;">
        <div class="text-center">
            <img src="/assets/img/qris-situneo.png" alt="QRIS SITUNEO" style="max-width: 300px;">
            <p>Scan QR code dengan aplikasi mobile banking Anda</p>
        </div>
    </div>
    
    <div class="form-group">
        <label>Upload Bukti Transfer</label>
        <input type="file" name="proof" accept="image/*" required>
        <small>Format: JPG, PNG (max 5MB)</small>
        
        <!-- Image Preview -->
        <div id="preview" style="margin-top: 10px;"></div>
    </div>
    
    <div class="form-group">
        <label>Transfer Amount</label>
        <input type="number" name="amount" required placeholder="Contoh: 1750000">
        <small>Masukkan jumlah yang Anda transfer (tanpa titik)</small>
    </div>
    
    <div class="form-group">
        <label>Transfer Date</label>
        <input type="date" name="transfer_date" required>
    </div>
    
    <div class="form-group">
        <label>Sender Name (Nama Pengirim)</label>
        <input type="text" name="sender_name" required placeholder="Sesuai rekening bank">
    </div>
    
    <button type="submit" class="btn btn-primary btn-lg btn-block">
        <i class="bi bi-upload"></i> Submit Payment
    </button>
</form>

<script>
// Show bank/QRIS info based on method
document.querySelector('[name="payment_method"]').addEventListener('change', (e) => {
    document.getElementById('bank-info').style.display = 'none';
    document.getElementById('qris-info').style.display = 'none';
    
    if (e.target.value === 'bank_transfer') {
        document.getElementById('bank-info').style.display = 'block';
    } else if (e.target.value === 'qris') {
        document.getElementById('qris-info').style.display = 'block';
    }
});

// Image preview
document.querySelector('[name="proof"]').addEventListener('change', (e) => {
    const file = e.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = (e) => {
            document.getElementById('preview').innerHTML = 
                `<img src="${e.target.result}" style="max-width: 300px; border: 1px solid #ddd; border-radius: 5px;">`;
        };
        reader.readAsDataURL(file);
    }
});

// Form submission
document.getElementById('payment-upload-form').addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const formData = new FormData(e.target);
    
    try {
        const response = await fetch('/client/payment/upload', {
            method: 'POST',
            body: formData
        });
        
        const result = await response.json();
        
        if (result.success) {
            Swal.fire({
                icon: 'success',
                title: 'Payment Uploaded!',
                text: 'Payment Anda sedang diverifikasi admin. Kami akan kirim notifikasi setelah verified.',
                confirmButtonText: 'OK'
            }).then(() => {
                window.location.href = '/client/payments';
            });
        }
    } catch (error) {
        Swal.fire({
            icon: 'error',
            title: 'Upload Failed',
            text: error.message
        });
    }
});
</script>
```

### 4. Invoice System
```php
// Invoice Generation (Auto, after payment verified)
class Invoice {
    public function generate($order_id) {
        $order = Order::find($order_id);
        $client = Client::find($order['client_id']);
        
        // Generate unique invoice number
        $invoice_number = 'INV-SITUNEO-' . date('d-M-Y') . '-' . str_pad($this->getNextNumber(), 4, '0', STR_PAD_LEFT);
        
        // Insert to invoices table
        $invoice_id = $this->db->insert('invoices', [
            'invoice_number' => $invoice_number,
            'order_id' => $order_id,
            'client_id' => $order['client_id'],
            'issue_date' => date('Y-m-d'),
            'due_date' => date('Y-m-d', strtotime('+30 days')), // For sewa
            'total_amount' => $order['total_amount'],
            'status' => 'paid'
        ]);
        
        // Send invoice email
        $this->sendInvoiceEmail($invoice_id);
        
        return $invoice_id;
    }
    
    public function renderHTML($invoice_id) {
        $invoice = Invoice::find($invoice_id);
        $order = Order::find($invoice['order_id']);
        $client = Client::find($invoice['client_id']);
        
        // Load invoice template
        ob_start();
        include 'templates/invoice.php';
        return ob_get_clean();
    }
    
    public function generatePDF($invoice_id) {
        // Use TCPDF or Dompdf
        $html = $this->renderHTML($invoice_id);
        
        $pdf = new TCPDF();
        $pdf->AddPage();
        $pdf->writeHTML($html);
        return $pdf->Output('invoice.pdf', 'S'); // Return as string
    }
}
```

## Testing Checklist

```
✅ Dashboard loads correctly (stats, recent activity)
✅ Demo Request form works (26 fields, validation, auto-save)
✅ Order creation works (multi-step, cart, checkout)
✅ Payment upload works (image preview, validation)
✅ Order tracking works (timeline, status updates)
✅ Invoice generation works (unique number, HTML, PDF, print)
✅ Support tickets work (create, view, reply, close)
✅ Notifications work (in-app, email)
✅ Profile update works (name, email, phone, avatar)
✅ Password change works (current password required)
✅ Language toggle works (ID/EN)
```

## Deliverables Summary

| Component | Files | Lines | Status |
|-----------|-------|-------|--------|
| Dashboard Pages | 18 files | ~3500 | 🔴 Todo |
| Controllers | 5 files | ~1200 | 🔴 Todo |
| Models | 6 files | ~800 | 🔴 Todo |
| JavaScript | 8 files | ~1000 | 🔴 Todo |
| CSS (Custom) | 2 files | ~400 | 🔴 Todo |

**Total Output:** ~6,900 lines

---

**File ini akan dilanjutkan dengan BATCH 6-15...**

Mau saya lanjutkan dengan BATCH 6-15 (Partner, SPV, Manager, Admin Dashboards + Advanced Features)? Atau Anda sudah cukup puas dengan dokumentasi ini? 😊

Total yang sudah dibuat:
- ✅ BATCH 1-3 (Foundation)
- ✅ BATCH 4-5 (Auth + Client Dashboard)
- 🔴 BATCH 6-15 (Remaining 10 batches)

Konfirmasi ya! 🚀