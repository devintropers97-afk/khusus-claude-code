<?php
$pageTitle = 'Order Confirmation - ' . $order['order_number'];
require_once APP_PATH . '/views/layouts/header.php';
?>

<div class="container py-5">
    <!-- Success Message -->
    <div class="text-center mb-5">
        <div class="mb-4">
            <i class="fas fa-check-circle fa-5x text-success"></i>
        </div>
        <h1 class="display-5 fw-bold mb-3">Order Placed Successfully!</h1>
        <p class="lead text-muted">Thank you for your order. We'll process it as soon as we receive your payment.</p>
        <p class="text-muted">Order Number: <strong class="text-primary"><?php echo e($order['order_number']); ?></strong></p>
    </div>

    <!-- Flash Messages -->
    <?php echo Session::displayFlash(); ?>

    <div class="row">
        <!-- Order Details -->
        <div class="col-lg-8">
            <!-- Order Information -->
            <div class="card shadow-sm border-0 mb-4">
                <div class="card-header bg-light">
                    <h5 class="mb-0"><i class="fas fa-info-circle me-2"></i>Order Information</h5>
                </div>
                <div class="card-body">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <p class="mb-1"><strong>Order Number:</strong></p>
                            <p class="text-muted"><?php echo e($order['order_number']); ?></p>
                        </div>
                        <div class="col-md-6">
                            <p class="mb-1"><strong>Order Date:</strong></p>
                            <p class="text-muted"><?php echo tanggal($order['created_at']); ?></p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <p class="mb-1"><strong>Status:</strong></p>
                            <p>
                                <span class="badge bg-warning">
                                    <?php echo strtoupper($order['status']); ?>
                                </span>
                            </p>
                        </div>
                        <div class="col-md-6">
                            <p class="mb-1"><strong>Payment Status:</strong></p>
                            <p>
                                <span class="badge bg-<?php echo $order['payment_status'] === 'paid' ? 'success' : 'danger'; ?>">
                                    <?php echo strtoupper($order['payment_status']); ?>
                                </span>
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Order Items -->
            <div class="card shadow-sm border-0 mb-4">
                <div class="card-header bg-light">
                    <h5 class="mb-0"><i class="fas fa-box me-2"></i>Order Items</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Service</th>
                                    <th>Type</th>
                                    <th>Duration</th>
                                    <th class="text-end">Price</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($orderItems as $item): ?>
                                    <tr>
                                        <td>
                                            <strong><?php echo e($item['service_name']); ?></strong>
                                        </td>
                                        <td>
                                            <span class="badge bg-<?php echo $item['purchase_type'] === 'beli' ? 'primary' : 'success'; ?>">
                                                <?php echo strtoupper($item['purchase_type']); ?>
                                            </span>
                                        </td>
                                        <td>
                                            <?php if ($item['purchase_type'] === 'sewa'): ?>
                                                <?php echo $item['contract_months']; ?> month<?php echo $item['contract_months'] > 1 ? 's' : ''; ?>
                                            <?php else: ?>
                                                One-time
                                            <?php endif; ?>
                                        </td>
                                        <td class="text-end">
                                            <strong><?php echo rupiah($item['subtotal']); ?></strong>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <th colspan="3" class="text-end">Total:</th>
                                    <th class="text-end">
                                        <h5 class="mb-0 text-primary"><?php echo rupiah($order['total_amount']); ?></h5>
                                    </th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Payment Instructions -->
            <?php if ($order['payment_status'] === 'unpaid'): ?>
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-light">
                        <h5 class="mb-0"><i class="fas fa-money-bill-wave me-2"></i>Payment Instructions</h5>
                    </div>
                    <div class="card-body">
                        <div class="alert alert-warning">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            <strong>Payment Required:</strong> Please complete payment within 24 hours to avoid order cancellation.
                        </div>

                        <h6 class="fw-bold mb-3"><?php echo e($paymentInfo['name']); ?></h6>
                        <p class="text-muted"><?php echo e($paymentInfo['description']); ?></p>

                        <?php if (!empty($paymentInfo['accounts'])): ?>
                            <div class="row mb-4">
                                <?php foreach ($paymentInfo['accounts'] as $account): ?>
                                    <div class="col-md-6 mb-3">
                                        <div class="border rounded p-3">
                                            <p class="mb-1"><strong><?php echo e($account['bank']); ?></strong></p>
                                            <p class="mb-1 h5 text-primary"><?php echo e($account['account_number']); ?></p>
                                            <p class="mb-0 text-muted small"><?php echo e($account['account_name']); ?></p>
                                        </div>
                                    </div>
                                <?php endforeach; ?>
                            </div>
                        <?php endif; ?>

                        <h6 class="fw-bold mb-2">Instructions:</h6>
                        <ol class="mb-0">
                            <?php foreach ($paymentInfo['instructions'] as $instruction): ?>
                                <li class="mb-2"><?php echo e($instruction); ?></li>
                            <?php endforeach; ?>
                        </ol>
                    </div>
                </div>

                <!-- Upload Payment Proof -->
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-light">
                        <h5 class="mb-0"><i class="fas fa-upload me-2"></i>Upload Payment Proof</h5>
                    </div>
                    <div class="card-body">
                        <form method="POST" action="<?php echo url('api/upload-payment-proof.php'); ?>"
                              enctype="multipart/form-data">
                            <?php echo CSRF::generateInput(); ?>
                            <input type="hidden" name="order_id" value="<?php echo $order['id']; ?>">

                            <div class="mb-3">
                                <label class="form-label">Payment Date</label>
                                <input type="date" name="payment_date" class="form-control"
                                       value="<?php echo date('Y-m-d'); ?>" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Amount Paid</label>
                                <input type="number" name="payment_amount" class="form-control"
                                       value="<?php echo $order['total_amount']; ?>" step="0.01" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Payment Proof (JPG, PNG, PDF - Max 2MB)</label>
                                <input type="file" name="payment_proof" class="form-control"
                                       accept="image/jpeg,image/png,application/pdf" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Notes (Optional)</label>
                                <textarea name="payment_notes" class="form-control" rows="2"
                                          placeholder="Any additional notes about the payment..."></textarea>
                            </div>

                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-upload me-2"></i>Upload Payment Proof
                            </button>
                        </form>
                    </div>
                </div>
            <?php else: ?>
                <div class="alert alert-success">
                    <i class="fas fa-check-circle me-2"></i>
                    <strong>Payment Received:</strong> Thank you for your payment. We'll start processing your order shortly.
                </div>
            <?php endif; ?>
        </div>

        <!-- Quick Actions -->
        <div class="col-lg-4">
            <div class="card shadow-sm border-0 sticky-top" style="top: 20px;">
                <div class="card-header bg-gradient text-white">
                    <h5 class="mb-0"><i class="fas fa-tasks me-2"></i>Quick Actions</h5>
                </div>
                <div class="card-body">
                    <a href="<?php echo url('client/order-detail.php?id=' . $order['id']); ?>"
                       class="btn btn-primary w-100 mb-2">
                        <i class="fas fa-eye me-2"></i>View Order Details
                    </a>

                    <a href="<?php echo url('client/orders.php'); ?>" class="btn btn-outline-primary w-100 mb-2">
                        <i class="fas fa-list me-2"></i>My Orders
                    </a>

                    <a href="<?php echo url('services.php'); ?>" class="btn btn-outline-secondary w-100">
                        <i class="fas fa-arrow-left me-2"></i>Browse More Services
                    </a>

                    <hr>

                    <div class="alert alert-info mb-0">
                        <small>
                            <i class="fas fa-info-circle me-1"></i>
                            Need help? <a href="<?php echo url('client/tickets.php'); ?>">Contact Support</a>
                        </small>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php require_once APP_PATH . '/views/layouts/footer.php'; ?>
