<?php
$pageTitle = 'Client Dashboard';
require_once APP_PATH . '/views/layouts/header.php';

$client = $stats['client'];
?>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
            <div class="position-sticky pt-3">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="<?php echo url('client/dashboard.php'); ?>">
                            <i class="fas fa-home me-2"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo url('client/profile.php'); ?>">
                            <i class="fas fa-user me-2"></i> My Profile
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo url('client/orders.php'); ?>">
                            <i class="fas fa-shopping-cart me-2"></i> My Orders
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo url('client/subscriptions.php'); ?>">
                            <i class="fas fa-calendar-check me-2"></i> Subscriptions
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo url('client/invoices.php'); ?>">
                            <i class="fas fa-file-invoice me-2"></i> Invoices
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo url('client/tickets.php'); ?>">
                            <i class="fas fa-headset me-2"></i> Support Tickets
                        </a>
                    </li>
                    <hr>
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
                <h1 class="h2">Client Dashboard</h1>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <span class="badge bg-primary fs-6">
                        <?php echo e($client['client_code']); ?>
                    </span>
                </div>
            </div>

            <!-- Flash Messages -->
            <?php echo Session::displayFlash(); ?>

            <!-- Welcome Message -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <h4><i class="fas fa-smile me-2"></i>Welcome, <?php echo e($client['first_name']); ?>!</h4>
                            <p class="mb-0">
                                <strong>Email:</strong> <?php echo e($client['email']); ?> |
                                <strong>Phone:</strong> <?php echo e($client['phone'] ?: '-'); ?>
                            </p>
                            <?php if ($client['company_name']): ?>
                                <p class="mb-0">
                                    <strong>Company:</strong> <?php echo e($client['company_name']); ?>
                                </p>
                            <?php endif; ?>
                            <p class="mb-0">
                                <strong>Member Since:</strong> <?php echo tanggal($client['created_at'], 'd M Y'); ?> |
                                <strong>Status:</strong>
                                <span class="badge bg-<?php echo $client['status'] === 'active' ? 'success' : 'warning'; ?>">
                                    <?php echo strtoupper($client['status']); ?>
                                </span>
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Stats Cards -->
            <div class="row mb-4">
                <!-- Total Orders -->
                <div class="col-md-3 mb-3">
                    <div class="card text-white bg-gradient-primary">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="card-title">Total Orders</h6>
                                    <h3 class="mb-0"><?php echo $stats['total_orders']; ?></h3>
                                    <small>Lifetime</small>
                                </div>
                                <i class="fas fa-shopping-cart fa-3x opacity-50"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Total Spent -->
                <div class="col-md-3 mb-3">
                    <div class="card text-white bg-gradient-success">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="card-title">Total Spent</h6>
                                    <h3 class="mb-0"><?php echo rupiah($stats['total_spent']); ?></h3>
                                    <small>All time</small>
                                </div>
                                <i class="fas fa-money-bill fa-3x opacity-50"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Active Subscriptions -->
                <div class="col-md-3 mb-3">
                    <div class="card text-white bg-gradient-warning">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="card-title">Active Subscriptions</h6>
                                    <h3 class="mb-0"><?php echo $stats['active_subscriptions']; ?></h3>
                                    <small>Currently active</small>
                                </div>
                                <i class="fas fa-calendar-check fa-3x opacity-50"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Open Tickets -->
                <div class="col-md-3 mb-3">
                    <div class="card text-white bg-gradient-danger">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="card-title">Open Tickets</h6>
                                    <h3 class="mb-0"><?php echo $stats['open_tickets']; ?></h3>
                                    <small>Need attention</small>
                                </div>
                                <i class="fas fa-headset fa-3x opacity-50"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Unpaid Invoices Alert -->
            <?php if ($stats['unpaid_invoices_count'] > 0): ?>
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="alert alert-warning">
                            <h5><i class="fas fa-exclamation-triangle me-2"></i>Unpaid Invoices</h5>
                            <p class="mb-0">
                                You have <strong><?php echo $stats['unpaid_invoices_count']; ?> unpaid invoice(s)</strong>
                                totaling <strong><?php echo rupiah($stats['unpaid_invoices_total']); ?></strong>.
                                <a href="<?php echo url('client/invoices.php'); ?>" class="alert-link">View invoices</a>
                            </p>
                        </div>
                    </div>
                </div>
            <?php endif; ?>

            <!-- Quick Actions & Loyalty Points -->
            <div class="row mb-4">
                <div class="col-md-6">
                    <div class="card shadow-sm">
                        <div class="card-header bg-white">
                            <h5 class="mb-0"><i class="fas fa-bolt me-2"></i>Quick Actions</h5>
                        </div>
                        <div class="card-body">
                            <div class="d-grid gap-2">
                                <a href="<?php echo url('services.php'); ?>" class="btn btn-primary">
                                    <i class="fas fa-shopping-cart me-2"></i>Browse Services
                                </a>
                                <a href="<?php echo url('client/tickets.php'); ?>" class="btn btn-success">
                                    <i class="fas fa-headset me-2"></i>Create Support Ticket
                                </a>
                                <a href="<?php echo url('client/orders.php'); ?>" class="btn btn-info">
                                    <i class="fas fa-list me-2"></i>View Order History
                                </a>
                                <a href="<?php echo url('client/profile.php'); ?>" class="btn btn-secondary">
                                    <i class="fas fa-user-edit me-2"></i>Edit Profile
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card shadow-sm">
                        <div class="card-header bg-white">
                            <h5 class="mb-0"><i class="fas fa-gift me-2"></i>Loyalty Program</h5>
                        </div>
                        <div class="card-body">
                            <div class="text-center mb-3">
                                <h2 class="text-primary"><?php echo number_format($client['loyalty_points']); ?></h2>
                                <p class="text-muted mb-0">Points Available</p>
                            </div>
                            <div class="progress mb-3" style="height: 25px;">
                                <?php
                                $nextTier = 1000;
                                $progress = min(($client['loyalty_points'] / $nextTier) * 100, 100);
                                ?>
                                <div class="progress-bar bg-gradient-primary" role="progressbar"
                                     style="width: <?php echo $progress; ?>%"
                                     aria-valuenow="<?php echo $progress; ?>" aria-valuemin="0" aria-valuemax="100">
                                    <?php echo round($progress); ?>%
                                </div>
                            </div>
                            <p class="small text-muted text-center mb-0">
                                Earn more points with every purchase!
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recent Activity -->
            <div class="row">
                <div class="col-12">
                    <div class="card shadow-sm">
                        <div class="card-header bg-white">
                            <h5 class="mb-0"><i class="fas fa-history me-2"></i>Recent Activity</h5>
                        </div>
                        <div class="card-body">
                            <p class="text-muted">Your recent orders, payments, and activities will appear here...</p>
                            <p class="small">
                                <em>View your <a href="<?php echo url('client/orders.php'); ?>">order history</a> for details.</em>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<?php require_once APP_PATH . '/views/layouts/footer.php'; ?>
