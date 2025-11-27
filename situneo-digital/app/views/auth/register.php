<?php
$pageTitle = 'Daftar Akun Baru';
$bodyClass = 'auth-page d-flex flex-column min-vh-100';
require_once __DIR__ . '/../layouts/header.php';
?>

<div class="container flex-grow-1 d-flex align-items-center justify-content-center py-5">
    <div class="row w-100">
        <div class="col-md-6 col-lg-5 mx-auto">
            <!-- Flash Messages -->
            <?php echo Session::displayFlash(); ?>

            <!-- Register Card -->
            <div class="card shadow-lg border-0 rounded-lg">
                <div class="card-body p-5">
                    <!-- Logo & Title -->
                    <div class="text-center mb-4">
                        <div class="mb-3">
                            <i class="fas fa-user-plus fa-3x text-primary"></i>
                        </div>
                        <h2 class="fw-bold text-primary mb-1"><?php echo APP_NAME; ?></h2>
                        <p class="text-muted small"><?php echo COMPANY_NAME; ?></p>
                        <hr class="my-3">
                        <h5 class="text-dark">Daftar Akun Baru</h5>
                        <p class="text-muted small">Bergabunglah bersama kami</p>
                    </div>

                    <!-- Register Form -->
                    <form action="<?php echo url('process-register.php'); ?>" method="POST">
                        <?php echo CSRF::inputField(); ?>

                        <!-- First Name & Last Name -->
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="first_name" class="form-label">
                                    <i class="fas fa-user me-1"></i> Nama Depan
                                </label>
                                <input type="text"
                                       class="form-control"
                                       id="first_name"
                                       name="first_name"
                                       placeholder="Nama Depan"
                                       value="<?php echo Session::old('first_name'); ?>"
                                       required
                                       autofocus>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="last_name" class="form-label">
                                    <i class="fas fa-user me-1"></i> Nama Belakang
                                </label>
                                <input type="text"
                                       class="form-control"
                                       id="last_name"
                                       name="last_name"
                                       placeholder="Nama Belakang"
                                       value="<?php echo Session::old('last_name'); ?>"
                                       required>
                            </div>
                        </div>

                        <!-- Email -->
                        <div class="mb-3">
                            <label for="email" class="form-label">
                                <i class="fas fa-envelope me-1"></i> Email
                            </label>
                            <div class="input-group">
                                <span class="input-group-text bg-light">
                                    <i class="fas fa-envelope text-muted"></i>
                                </span>
                                <input type="email"
                                       class="form-control"
                                       id="email"
                                       name="email"
                                       placeholder="nama@email.com"
                                       value="<?php echo Session::old('email'); ?>"
                                       required>
                            </div>
                            <div class="form-text">
                                <i class="fas fa-info-circle me-1"></i>
                                Gunakan email aktif untuk verifikasi
                            </div>
                        </div>

                        <!-- Phone -->
                        <div class="mb-3">
                            <label for="phone" class="form-label">
                                <i class="fas fa-phone me-1"></i> Nomor Telepon (Opsional)
                            </label>
                            <div class="input-group">
                                <span class="input-group-text bg-light">
                                    <i class="fas fa-phone text-muted"></i>
                                </span>
                                <input type="tel"
                                       class="form-control"
                                       id="phone"
                                       name="phone"
                                       placeholder="08xxxxxxxxxx"
                                       value="<?php echo Session::old('phone'); ?>">
                            </div>
                        </div>

                        <!-- Password -->
                        <div class="mb-3">
                            <label for="password" class="form-label">
                                <i class="fas fa-lock me-1"></i> Password
                            </label>
                            <div class="input-group">
                                <span class="input-group-text bg-light">
                                    <i class="fas fa-lock text-muted"></i>
                                </span>
                                <input type="password"
                                       class="form-control"
                                       id="password"
                                       name="password"
                                       placeholder="Minimal 8 karakter"
                                       required>
                                <button class="btn btn-outline-secondary"
                                        type="button"
                                        onclick="togglePassword('password')">
                                    <i class="fas fa-eye" id="password-icon"></i>
                                </button>
                            </div>
                            <div class="form-text">
                                <i class="fas fa-info-circle me-1"></i>
                                Minimal 8 karakter
                            </div>
                        </div>

                        <!-- Password Confirmation -->
                        <div class="mb-3">
                            <label for="password_confirmation" class="form-label">
                                <i class="fas fa-lock me-1"></i> Konfirmasi Password
                            </label>
                            <div class="input-group">
                                <span class="input-group-text bg-light">
                                    <i class="fas fa-lock text-muted"></i>
                                </span>
                                <input type="password"
                                       class="form-control"
                                       id="password_confirmation"
                                       name="password_confirmation"
                                       placeholder="Masukkan password lagi"
                                       required>
                                <button class="btn btn-outline-secondary"
                                        type="button"
                                        onclick="togglePassword('password_confirmation')">
                                    <i class="fas fa-eye" id="password_confirmation-icon"></i>
                                </button>
                            </div>
                        </div>

                        <!-- Terms & Conditions -->
                        <div class="form-check mb-4">
                            <input class="form-check-input"
                                   type="checkbox"
                                   id="terms"
                                   name="terms"
                                   required>
                            <label class="form-check-label small" for="terms">
                                Saya setuju dengan
                                <a href="#" class="text-decoration-none">Syarat & Ketentuan</a>
                                dan
                                <a href="#" class="text-decoration-none">Kebijakan Privasi</a>
                            </label>
                        </div>

                        <!-- Register Button -->
                        <button type="submit" class="btn btn-primary w-100 btn-lg mb-3">
                            <i class="fas fa-user-plus me-2"></i> Daftar Sekarang
                        </button>

                        <!-- Login Link -->
                        <div class="text-center">
                            <p class="small text-muted mb-0">
                                Sudah punya akun?
                                <a href="<?php echo url('login.php'); ?>" class="text-decoration-none fw-bold">
                                    Login Di Sini
                                </a>
                            </p>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Info -->
            <div class="text-center mt-4">
                <p class="small text-muted">
                    <i class="fas fa-shield-alt me-1"></i>
                    Data Anda aman dan terenkripsi
                </p>
            </div>
        </div>
    </div>
</div>

<script>
function togglePassword(fieldId) {
    const field = document.getElementById(fieldId);
    const icon = document.getElementById(fieldId + '-icon');

    if (field.type === 'password') {
        field.type = 'text';
        icon.classList.remove('fa-eye');
        icon.classList.add('fa-eye-slash');
    } else {
        field.type = 'password';
        icon.classList.remove('fa-eye-slash');
        icon.classList.add('fa-eye');
    }
}

// Password strength indicator
document.getElementById('password').addEventListener('input', function(e) {
    const password = e.target.value;
    let strength = 0;

    if (password.length >= 8) strength++;
    if (password.match(/[a-z]/)) strength++;
    if (password.match(/[A-Z]/)) strength++;
    if (password.match(/[0-9]/)) strength++;
    if (password.match(/[^a-zA-Z0-9]/)) strength++;

    // You can add visual feedback here
});
</script>

<?php require_once __DIR__ . '/../layouts/footer.php'; ?>
