<?php
/**
 * Dashboard Page (Default)
 * Generic dashboard untuk role yang belum memiliki dashboard spesifik
 */

// Load configuration
require_once __DIR__ . '/../config/config.php';

// Require login
Session::requireLogin();

// Get current user
$currentUser = Session::getCurrentUser();

$pageTitle = 'Dashboard';
require_once __DIR__ . '/../app/views/layouts/header.php';
?>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
            <div class="position-sticky pt-3">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="<?php echo url('dashboard.php'); ?>">
                            <i class="fas fa-home me-2"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo url('profile.php'); ?>">
                            <i class="fas fa-user me-2"></i> Profile
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo url('logout.php'); ?>">
                            <i class="fas fa-sign-out-alt me-2"></i> Logout
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Main Content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">Dashboard</h1>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <div class="dropdown">
                        <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user-circle me-1"></i>
                            <?php echo e($currentUser['first_name'] . ' ' . $currentUser['last_name']); ?>
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="<?php echo url('profile.php'); ?>">Profile</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="<?php echo url('logout.php'); ?>">Logout</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Flash Messages -->
            <?php echo Session::displayFlash(); ?>

            <!-- Welcome Card -->
            <div class="row">
                <div class="col-md-12">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <h3 class="card-title">
                                <i class="fas fa-smile me-2"></i>
                                Selamat Datang, <?php echo e($currentUser['first_name']); ?>!
                            </h3>
                            <p class="card-text">
                                Anda login sebagai: <strong><?php echo e($currentUser['role_name']); ?></strong>
                            </p>
                            <p class="card-text text-muted">
                                Email: <?php echo e($currentUser['email']); ?>
                            </p>
                            <hr>
                            <div class="alert alert-info">
                                <i class="fas fa-info-circle me-2"></i>
                                <strong>Dashboard untuk role Anda sedang dalam pengembangan.</strong>
                                <br>Halaman ini adalah placeholder sementara.
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Stats Cards -->
            <div class="row mt-4">
                <div class="col-md-3">
                    <div class="card text-white bg-primary mb-3">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="card-title">Status Akun</h6>
                                    <h3><?php echo ucfirst($currentUser['status']); ?></h3>
                                </div>
                                <i class="fas fa-check-circle fa-3x opacity-50"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card text-white bg-success mb-3">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="card-title">Email</h6>
                                    <h3><i class="fas fa-check"></i> Verified</h3>
                                </div>
                                <i class="fas fa-envelope-circle-check fa-3x opacity-50"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card text-white bg-info mb-3">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="card-title">Member Since</h6>
                                    <h3><?php echo date('M Y', strtotime($currentUser['created_at'])); ?></h3>
                                </div>
                                <i class="fas fa-calendar fa-3x opacity-50"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card text-white bg-warning mb-3">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="card-title">Last Login</h6>
                                    <h3><?php echo tanggal($currentUser['last_login_at'], 'd/m'); ?></h3>
                                </div>
                                <i class="fas fa-clock fa-3x opacity-50"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<?php require_once __DIR__ . '/../app/views/layouts/footer.php'; ?>
