<?php
$pageTitle = 'My Orders';
require_once APP_PATH . '/views/layouts/header.php';
?>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
            <div class="position-sticky pt-3">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo url('client/dashboard.php'); ?>">
                            <i class="fas fa-home me-2"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo url('client/profile.php'); ?>">
                            <i class="fas fa-user me-2"></i> My Profile
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="<?php echo url('client/orders.php'); ?>">
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
                <h1 class="h2">My Orders</h1>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <a href="<?php echo url('services.php'); ?>" class="btn btn-sm btn-primary">
                        <i class="fas fa-plus me-1"></i> New Order
                    </a>
                </div>
            </div>

            <!-- Flash Messages -->
            <?php echo Session::displayFlash(); ?>

            <!-- Orders Table -->
            <div class="card shadow-sm">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="fas fa-list me-2"></i>Order History</h5>
                </div>
                <div class="card-body">
                    <?php if (empty($orders)): ?>
                        <div class="text-center py-5">
                            <i class="fas fa-shopping-cart fa-4x text-muted mb-3"></i>
                            <h4>No Orders Yet</h4>
                            <p class="text-muted">You haven't placed any orders yet.</p>
                            <a href="<?php echo url('services.php'); ?>" class="btn btn-primary">
                                Browse Services
                            </a>
                        </div>
                    <?php else: ?>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Order Number</th>
                                        <th>Date</th>
                                        <th>Type</th>
                                        <th>Items</th>
                                        <th>Total</th>
                                        <th>Status</th>
                                        <th>Payment</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach ($orders as $order): ?>
                                        <tr>
                                            <td>
                                                <strong><?php echo e($order['order_number']); ?></strong>
                                            </td>
                                            <td><?php echo tanggal($order['created_at'], 'd M Y'); ?></td>
                                            <td>
                                                <span class="badge bg-info">
                                                    <?php echo strtoupper($order['order_type']); ?>
                                                </span>
                                            </td>
                                            <td><?php echo $order['items_count']; ?> item(s)</td>
                                            <td><strong><?php echo rupiah($order['total_amount']); ?></strong></td>
                                            <td>
                                                <?php
                                                $statusColors = [
                                                    'pending' => 'warning',
                                                    'confirmed' => 'info',
                                                    'processing' => 'primary',
                                                    'completed' => 'success',
                                                    'cancelled' => 'danger'
                                                ];
                                                $color = $statusColors[$order['status']] ?? 'secondary';
                                                ?>
                                                <span class="badge bg-<?php echo $color; ?>">
                                                    <?php echo strtoupper($order['status']); ?>
                                                </span>
                                            </td>
                                            <td>
                                                <?php
                                                $paymentColors = [
                                                    'unpaid' => 'danger',
                                                    'partial' => 'warning',
                                                    'paid' => 'success',
                                                    'refunded' => 'info'
                                                ];
                                                $color = $paymentColors[$order['payment_status']] ?? 'secondary';
                                                ?>
                                                <span class="badge bg-<?php echo $color; ?>">
                                                    <?php echo strtoupper($order['payment_status']); ?>
                                                </span>
                                            </td>
                                            <td>
                                                <a href="<?php echo url('client/order-detail.php?id=' . $order['id']); ?>"
                                                   class="btn btn-sm btn-outline-primary">
                                                    <i class="fas fa-eye"></i> View
                                                </a>
                                            </td>
                                        </tr>
                                    <?php endforeach; ?>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        <?php if ($pagination['total_pages'] > 1): ?>
                            <nav aria-label="Orders pagination" class="mt-3">
                                <ul class="pagination justify-content-center">
                                    <?php for ($i = 1; $i <= $pagination['total_pages']; $i++): ?>
                                        <li class="page-item <?php echo $i == $pagination['page'] ? 'active' : ''; ?>">
                                            <a class="page-link" href="?page=<?php echo $i; ?>">
                                                <?php echo $i; ?>
                                            </a>
                                        </li>
                                    <?php endfor; ?>
                                </ul>
                            </nav>
                        <?php endif; ?>
                    <?php endif; ?>
                </div>
            </div>
        </main>
    </div>
</div>

<?php require_once APP_PATH . '/views/layouts/footer.php'; ?>
