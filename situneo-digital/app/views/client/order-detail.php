<?php require_once '../app/views/includes/header.php'; ?>

<?php
$order = $data['order'];
$items = $data['items'] ?? [];

$statusClass = [
    'pending' => 'warning',
    'confirmed' => 'info',
    'processing' => 'primary',
    'completed' => 'success',
    'cancelled' => 'danger'
][$order['status']] ?? 'secondary';

$paymentClass = [
    'unpaid' => 'danger',
    'partial' => 'warning',
    'paid' => 'success',
    'refunded' => 'info'
][$order['payment_status']] ?? 'secondary';
?>

<div class="container-fluid mt-4">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3 col-lg-2">
            <?php require_once '../app/views/client/includes/sidebar.php'; ?>
        </div>

        <!-- Main Content -->
        <div class="col-md-9 col-lg-10">
            <!-- Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <a href="/client/orders" class="btn btn-outline-secondary btn-sm mb-2">
                        <i class="fas fa-arrow-left"></i> Back to Orders
                    </a>
                    <h2><i class="fas fa-shopping-cart"></i> Order <?= $order['order_number'] ?></h2>
                </div>
                <div>
                    <span class="badge bg-<?= $statusClass ?> fs-6 me-2">
                        <?= ucfirst($order['status']) ?>
                    </span>
                    <span class="badge bg-<?= $paymentClass ?> fs-6">
                        Payment: <?= ucfirst($order['payment_status']) ?>
                    </span>
                </div>
            </div>

            <!-- Flash Messages -->
            <?php if (Session::hasFlash('success')): ?>
                <div class="alert alert-success alert-dismissible fade show">
                    <?= Session::getFlash('success') ?>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <?php endif; ?>

            <?php if (Session::hasFlash('error')): ?>
                <div class="alert alert-danger alert-dismissible fade show">
                    <?= Session::getFlash('error') ?>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <?php endif; ?>

            <!-- Order Information -->
            <div class="row">
                <div class="col-md-8">
                    <!-- Order Items -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <h5><i class="fas fa-list"></i> Order Items</h5>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Service</th>
                                            <th class="text-center" width="10%">Qty</th>
                                            <th class="text-end" width="15%">Unit Price</th>
                                            <th class="text-end" width="15%">Subtotal</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php foreach ($items as $item): ?>
                                            <tr>
                                                <td>
                                                    <strong><?= htmlspecialchars($item['service_name']) ?></strong>
                                                    <br><small class="text-muted"><?= $item['service_code'] ?></small>
                                                    <?php if ($item['order_type'] == 'sewa'): ?>
                                                        <br><span class="badge bg-info">Rental - <?= $item['months'] ?> month(s)</span>
                                                    <?php endif; ?>
                                                </td>
                                                <td class="text-center"><?= $item['quantity'] ?></td>
                                                <td class="text-end">Rp <?= number_format($item['unit_price'], 0, ',', '.') ?></td>
                                                <td class="text-end"><strong>Rp <?= number_format($item['subtotal'], 0, ',', '.') ?></strong></td>
                                            </tr>
                                        <?php endforeach; ?>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td colspan="3" class="text-end"><strong>Subtotal:</strong></td>
                                            <td class="text-end">Rp <?= number_format($order['subtotal'], 0, ',', '.') ?></td>
                                        </tr>
                                        <?php if ($order['setup_fees'] > 0): ?>
                                            <tr>
                                                <td colspan="3" class="text-end"><strong>Setup Fees:</strong></td>
                                                <td class="text-end">Rp <?= number_format($order['setup_fees'], 0, ',', '.') ?></td>
                                            </tr>
                                        <?php endif; ?>
                                        <?php if ($order['discount_amount'] > 0): ?>
                                            <tr>
                                                <td colspan="3" class="text-end"><strong>Discount:</strong></td>
                                                <td class="text-end text-success">- Rp <?= number_format($order['discount_amount'], 0, ',', '.') ?></td>
                                            </tr>
                                        <?php endif; ?>
                                        <tr class="table-primary">
                                            <td colspan="3" class="text-end"><strong>TOTAL:</strong></td>
                                            <td class="text-end"><strong class="fs-5">Rp <?= number_format($order['total_amount'], 0, ',', '.') ?></strong></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- Order Timeline -->
                    <div class="card">
                        <div class="card-header">
                            <h5><i class="fas fa-history"></i> Order Timeline</h5>
                        </div>
                        <div class="card-body">
                            <div class="timeline">
                                <div class="timeline-item">
                                    <div class="timeline-marker bg-primary"></div>
                                    <div class="timeline-content">
                                        <strong>Order Placed</strong>
                                        <p class="text-muted small mb-0"><?= date('d M Y H:i', strtotime($order['created_at'])) ?></p>
                                    </div>
                                </div>

                                <?php if ($order['confirmed_at']): ?>
                                    <div class="timeline-item">
                                        <div class="timeline-marker bg-info"></div>
                                        <div class="timeline-content">
                                            <strong>Order Confirmed</strong>
                                            <p class="text-muted small mb-0"><?= date('d M Y H:i', strtotime($order['confirmed_at'])) ?></p>
                                        </div>
                                    </div>
                                <?php endif; ?>

                                <?php if ($order['completed_at']): ?>
                                    <div class="timeline-item">
                                        <div class="timeline-marker bg-success"></div>
                                        <div class="timeline-content">
                                            <strong>Order Completed</strong>
                                            <p class="text-muted small mb-0"><?= date('d M Y H:i', strtotime($order['completed_at'])) ?></p>
                                        </div>
                                    </div>
                                <?php endif; ?>

                                <?php if ($order['cancelled_at']): ?>
                                    <div class="timeline-item">
                                        <div class="timeline-marker bg-danger"></div>
                                        <div class="timeline-content">
                                            <strong>Order Cancelled</strong>
                                            <p class="text-muted small mb-0"><?= date('d M Y H:i', strtotime($order['cancelled_at'])) ?></p>
                                            <?php if ($order['cancel_reason']): ?>
                                                <p class="small mb-0"><em>Reason: <?= htmlspecialchars($order['cancel_reason']) ?></em></p>
                                            <?php endif; ?>
                                        </div>
                                    </div>
                                <?php endif; ?>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Sidebar Info -->
                <div class="col-md-4">
                    <!-- Order Summary -->
                    <div class="card mb-4">
                        <div class="card-header bg-primary text-white">
                            <h6 class="mb-0">Order Information</h6>
                        </div>
                        <div class="card-body">
                            <table class="table table-sm table-borderless mb-0">
                                <tr>
                                    <td><strong>Order Number:</strong></td>
                                    <td class="text-end"><?= $order['order_number'] ?></td>
                                </tr>
                                <tr>
                                    <td><strong>Order Date:</strong></td>
                                    <td class="text-end"><?= date('d M Y', strtotime($order['created_at'])) ?></td>
                                </tr>
                                <tr>
                                    <td><strong>Order Type:</strong></td>
                                    <td class="text-end">
                                        <span class="badge bg-info"><?= strtoupper($order['order_type']) ?></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>Total Amount:</strong></td>
                                    <td class="text-end"><strong class="text-success">Rp <?= number_format($order['total_amount'], 0, ',', '.') ?></strong></td>
                                </tr>
                            </table>
                        </div>
                    </div>

                    <!-- Payment Status -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <h6 class="mb-0"><i class="fas fa-credit-card"></i> Payment Status</h6>
                        </div>
                        <div class="card-body">
                            <p class="mb-2">
                                <strong>Status:</strong>
                                <span class="badge bg-<?= $paymentClass ?> float-end">
                                    <?= ucfirst($order['payment_status']) ?>
                                </span>
                            </p>

                            <?php if ($order['payment_status'] == 'unpaid'): ?>
                                <div class="alert alert-warning small mb-3">
                                    <i class="fas fa-exclamation-triangle"></i> Payment required to process your order
                                </div>
                                <div class="d-grid gap-2">
                                    <?php if ($order['invoice_id']): ?>
                                        <a href="/client/invoices/view/<?= $order['invoice_id'] ?>" class="btn btn-primary btn-sm">
                                            <i class="fas fa-file-invoice"></i> View Invoice
                                        </a>
                                        <a href="/client/invoices/pay/<?= $order['invoice_id'] ?>" class="btn btn-success btn-sm">
                                            <i class="fas fa-money-bill"></i> Pay Now
                                        </a>
                                    <?php endif; ?>
                                </div>
                            <?php endif; ?>

                            <?php if ($order['payment_status'] == 'paid'): ?>
                                <div class="alert alert-success small mb-0">
                                    <i class="fas fa-check-circle"></i> Payment received successfully
                                </div>
                            <?php endif; ?>
                        </div>
                    </div>

                    <!-- Billing Address -->
                    <?php if ($order['billing_address']): ?>
                        <div class="card mb-4">
                            <div class="card-header">
                                <h6 class="mb-0"><i class="fas fa-map-marker-alt"></i> Billing Address</h6>
                            </div>
                            <div class="card-body">
                                <p class="mb-1"><?= htmlspecialchars($order['billing_address']) ?></p>
                                <p class="mb-0">
                                    <?= htmlspecialchars($order['billing_city']) ?>,
                                    <?= htmlspecialchars($order['billing_province']) ?>
                                    <?php if ($order['billing_postal_code']): ?>
                                        <?= htmlspecialchars($order['billing_postal_code']) ?>
                                    <?php endif; ?>
                                </p>
                            </div>
                        </div>
                    <?php endif; ?>

                    <!-- Notes -->
                    <?php if ($order['notes']): ?>
                        <div class="card">
                            <div class="card-header">
                                <h6 class="mb-0"><i class="fas fa-sticky-note"></i> Order Notes</h6>
                            </div>
                            <div class="card-body">
                                <p class="mb-0"><?= nl2br(htmlspecialchars($order['notes'])) ?></p>
                            </div>
                        </div>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
.timeline {
    position: relative;
    padding: 20px 0;
}

.timeline-item {
    position: relative;
    padding-left: 40px;
    padding-bottom: 30px;
}

.timeline-item:before {
    content: '';
    position: absolute;
    left: 10px;
    top: 20px;
    bottom: -10px;
    width: 2px;
    background: #dee2e6;
}

.timeline-item:last-child:before {
    display: none;
}

.timeline-marker {
    position: absolute;
    left: 0;
    top: 0;
    width: 20px;
    height: 20px;
    border-radius: 50%;
    border: 3px solid #fff;
    box-shadow: 0 0 0 2px currentColor;
}

.timeline-content {
    padding-top: 2px;
}
</style>

<?php require_once '../app/views/includes/footer.php'; ?>
