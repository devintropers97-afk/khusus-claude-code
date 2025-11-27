<?php
$pageTitle = 'Login';
$bodyClass = 'auth-page d-flex flex-column min-vh-100';
require_once __DIR__ . '/../layouts/header.php';
?>

<div class="container flex-grow-1 d-flex align-items-center justify-content-center py-5">
    <div class="row w-100">
        <div class="col-md-5 col-lg-4 mx-auto">
            <!-- Flash Messages -->
            <?php echo Session::displayFlash(); ?>

            <!-- Login Card -->
            <div class="card shadow-lg border-0 rounded-lg">
                <div class="card-body p-5">
                    <!-- Logo & Title -->
                    <div class="text-center mb-4">
                        <div class="mb-3">
                            <i class="fas fa-shield-halved fa-3x text-primary"></i>
                        </div>
                        <h2 class="fw-bold text-primary mb-1"><?php echo APP_NAME; ?></h2>
                        <p class="text-muted small"><?php echo COMPANY_NAME; ?></p>
                        <hr class="my-3">
                        <h5 class="text-dark">Login</h5>
                        <p class="text-muted small">Masuk ke akun Anda</p>
                    </div>

                    <!-- Login Form -->
                    <form action="<?php echo url('process-login.php'); ?>" method="POST">
                        <?php echo CSRF::inputField(); ?>

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
                                       required
                                       autofocus>
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
                                       placeholder="Masukkan password"
                                       required>
                                <button class="btn btn-outline-secondary"
                                        type="button"
                                        onclick="togglePassword('password')">
                                    <i class="fas fa-eye" id="password-icon"></i>
                                </button>
                            </div>
                        </div>

                        <!-- Remember Me & Forgot Password -->
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="remember" name="remember">
                                <label class="form-check-label small" for="remember">
                                    Ingat Saya
                                </label>
                            </div>
                            <a href="<?php echo url('forgot-password.php'); ?>" class="small text-decoration-none">
                                Lupa Password?
                            </a>
                        </div>

                        <!-- Login Button -->
                        <button type="submit" class="btn btn-primary w-100 btn-lg mb-3">
                            <i class="fas fa-sign-in-alt me-2"></i> Login
                        </button>

                        <!-- Register Link -->
                        <div class="text-center">
                            <p class="small text-muted mb-0">
                                Belum punya akun?
                                <a href="<?php echo url('register.php'); ?>" class="text-decoration-none fw-bold">
                                    Daftar Sekarang
                                </a>
                            </p>
                        </div>
                    </form>

                    <!-- Resend Verification Link -->
                    <div class="text-center mt-3 pt-3 border-top">
                        <p class="small text-muted mb-0">
                            Belum terverifikasi?
                            <a href="#" class="text-decoration-none" data-bs-toggle="modal" data-bs-target="#resendModal">
                                Kirim Ulang Email Verifikasi
                            </a>
                        </p>
                    </div>
                </div>
            </div>

            <!-- Info -->
            <div class="text-center mt-4">
                <p class="small text-muted">
                    <i class="fas fa-shield-alt me-1"></i>
                    Login Anda dilindungi dengan enkripsi tingkat tinggi
                </p>
            </div>
        </div>
    </div>
</div>

<!-- Resend Verification Modal -->
<div class="modal fade" id="resendModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="fas fa-envelope me-2"></i>Kirim Ulang Email Verifikasi
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="<?php echo url('resend-verification.php'); ?>" method="POST">
                <?php echo CSRF::inputField(); ?>
                <div class="modal-body">
                    <p class="text-muted">Masukkan email Anda untuk menerima link verifikasi baru:</p>
                    <div class="mb-3">
                        <label for="resend-email" class="form-label">Email</label>
                        <input type="email"
                               class="form-control"
                               id="resend-email"
                               name="email"
                               placeholder="nama@email.com"
                               required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-paper-plane me-1"></i> Kirim
                    </button>
                </div>
            </form>
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
</script>

<?php require_once __DIR__ . '/../layouts/footer.php'; ?>
