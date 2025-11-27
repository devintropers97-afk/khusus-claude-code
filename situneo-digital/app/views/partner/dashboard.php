<?php
$pageTitle = 'Partner Dashboard';
require_once APP_PATH . '/views/layouts/header.php';

$partner = $stats['partner'];
$monthlyPerf = $stats['monthly_performance'];
$arpu = $stats['arpu'];
?>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
            <div class="position-sticky pt-3">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="<?php echo url('partner/dashboard.php'); ?>">
                            <i class="fas fa-home me-2"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo url('partner/clients.php'); ?>">
                            <i class="fas fa-users me-2"></i> My Clients
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo url('partner/commissions.php'); ?>">
                            <i class="fas fa-money-bill me-2"></i> Commissions
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo url('partner/withdrawals.php'); ?>">
                            <i class="fas fa-wallet me-2"></i> Withdrawals
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo url('partner/performance.php'); ?>">
                            <i class="fas fa-chart-line me-2"></i> Performance
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo url('partner/calculator.php'); ?>">
                            <i class="fas fa-calculator me-2"></i> Commission Calculator
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo url('partner/training.php'); ?>">
                            <i class="fas fa-graduation-cap me-2"></i> Training
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo url('partner/support.php'); ?>">
                            <i class="fas fa-headset me-2"></i> Support
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
                <h1 class="h2">Partner Dashboard</h1>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <span class="badge bg-primary fs-6">
                        <?php echo e($partner['partner_code']); ?>
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
                            <h4><i class="fas fa-smile me-2"></i>Welcome, <?php echo e($partner['first_name']); ?>!</h4>
                            <p class="mb-0">
                                <strong>Current Tier:</strong>
                                <span class="badge bg-gradient-primary">
                                    <?php echo strtoupper($partner['tier']); ?> (<?php echo $partner['commission_rate']; ?>%)
                                </span>
                            </p>
                            <?php if ($partner['spv_id']): ?>
                                <p class="mb-0">
                                    <strong>SPV:</strong> <?php echo e($partner['spv_first_name'] . ' ' . $partner['spv_last_name']); ?>
                                </p>
                            <?php endif; ?>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Stats Cards -->
            <div class="row mb-4">
                <!-- Monthly Sales -->
                <div class="col-md-3 mb-3">
                    <div class="card text-white bg-gradient-primary">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="card-title">Monthly Sales</h6>
                                    <h3 class="mb-0"><?php echo rupiah($monthlyPerf['total_sales']); ?></h3>
                                    <small><?php echo $monthlyPerf['total_orders']; ?> orders</small>
                                </div>
                                <i class="fas fa-shopping-cart fa-3x opacity-50"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Total Clients -->
                <div class="col-md-3 mb-3">
                    <div class="card text-white bg-gradient-success">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="card-title">Active Clients</h6>
                                    <h3 class="mb-0"><?php echo $stats['total_clients']; ?></h3>
                                    <small>Total clients</small>
                                </div>
                                <i class="fas fa-users fa-3x opacity-50"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Pending Commission -->
                <div class="col-md-3 mb-3">
                    <div class="card text-white bg-gradient-warning">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="card-title">Pending Commission</h6>
                                    <h3 class="mb-0"><?php echo rupiah($stats['pending_commissions']); ?></h3>
                                    <small>Ready to withdraw</small>
                                </div>
                                <i class="fas fa-money-bill fa-3x opacity-50"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- ARPU -->
                <div class="col-md-3 mb-3">
                    <div class="card text-white bg-gradient-danger">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="card-title">ARPU</h6>
                                    <h3 class="mb-0"><?php echo rupiah($arpu['arpu']); ?></h3>
                                    <small>Avg per client</small>
                                </div>
                                <i class="fas fa-chart-pie fa-3x opacity-50"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Commission Breakdown -->
            <div class="row mb-4">
                <div class="col-md-6">
                    <div class="card shadow-sm">
                        <div class="card-header bg-white">
                            <h5 class="mb-0"><i class="fas fa-percentage me-2"></i>Commission Breakdown</h5>
                        </div>
                        <div class="card-body">
                            <table class="table table-borderless">
                                <tr>
                                    <td><strong>Current Tier:</strong></td>
                                    <td class="text-end">
                                        <span class="badge bg-primary"><?php echo strtoupper($partner['tier']); ?></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>Commission Rate:</strong></td>
                                    <td class="text-end"><h4 class="mb-0 text-primary"><?php echo $partner['commission_rate']; ?>%</h4></td>
                                </tr>
                                <tr>
                                    <td><strong>This Month Commission:</strong></td>
                                    <td class="text-end"><?php echo rupiah($monthlyPerf['total_commission']); ?></td>
                                </tr>
                                <tr>
                                    <td><strong>ARPU Bonus:</strong></td>
                                    <td class="text-end"><?php echo rupiah($arpu['bonus_earned']); ?></td>
                                </tr>
                            </table>

                            <hr>

                            <h6>Tier Upgrade Requirements:</h6>
                            <ul class="small">
                                <li><strong>Tier 2 (40%):</strong> 10+ Juta/bulan</li>
                                <li><strong>Tier 3 (50%):</strong> 25+ Juta/bulan</li>
                                <li><strong>Tier 4 (55%):</strong> 50+ Juta/bulan</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card shadow-sm">
                        <div class="card-header bg-white">
                            <h5 class="mb-0"><i class="fas fa-bolt me-2"></i>Quick Actions</h5>
                        </div>
                        <div class="card-body">
                            <div class="d-grid gap-2">
                                <a href="<?php echo url('orders/create.php'); ?>" class="btn btn-primary btn-lg">
                                    <i class="fas fa-plus-circle me-2"></i>Create New Order
                                </a>
                                <a href="<?php echo url('partner/clients.php'); ?>" class="btn btn-success">
                                    <i class="fas fa-user-plus me-2"></i>Add New Client
                                </a>
                                <a href="<?php echo url('partner/withdrawals.php'); ?>" class="btn btn-warning">
                                    <i class="fas fa-wallet me-2"></i>Request Withdrawal
                                </a>
                                <a href="<?php echo url('partner/calculator.php'); ?>" class="btn btn-info">
                                    <i class="fas fa-calculator me-2"></i>Commission Calculator
                                </a>
                                <a href="<?php echo url('partner/support.php'); ?>" class="btn btn-secondary">
                                    <i class="fas fa-headset me-2"></i>Contact Support
                                </a>
                            </div>
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
                            <p class="text-muted">Recent orders, commissions, and activities will appear here...</p>
                            <p class="small">
                                <em>This feature will be available in the next update (BATCH 3).</em>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<?php require_once APP_PATH . '/views/layouts/footer.php'; ?>
