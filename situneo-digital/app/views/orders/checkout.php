<?php
$pageTitle = 'Checkout';
require_once APP_PATH . '/views/layouts/header.php';
?>

<div class="container py-5">
    <h1 class="mb-4"><i class="fas fa-credit-card me-2"></i>Checkout</h1>

    <!-- Flash Messages -->
    <?php echo Session::displayFlash(); ?>

    <form method="POST" action="<?php echo url('process-checkout.php'); ?>" id="checkoutForm">
        <?php echo CSRF::generateInput(); ?>

        <div class="row">
            <!-- Order Details -->
            <div class="col-lg-8">
                <!-- Customer Information -->
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-light">
                        <h5 class="mb-0"><i class="fas fa-user me-2"></i>Customer Information</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Full Name</label>
                                <input type="text" class="form-control" value="<?php echo e($user['name'] ?? ''); ?>" readonly>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" value="<?php echo e($user['email'] ?? ''); ?>" readonly>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Phone</label>
                                <input type="text" class="form-control" value="<?php echo e($profile['phone'] ?? 'Not set'); ?>" readonly>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Company</label>
                                <input type="text" class="form-control" value="<?php echo e($profile['company'] ?? 'Not set'); ?>" readonly>
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
                                    <?php foreach ($cartItems as $item): ?>
                                        <tr>
                                            <td>
                                                <strong><?php echo e($item['service_name']); ?></strong>
                                            </td>
                                            <td>
                                                <span class="badge bg-<?php echo $item['type'] === 'beli' ? 'primary' : 'success'; ?>">
                                                    <?php echo strtoupper($item['type']); ?>
                                                </span>
                                            </td>
                                            <td>
                                                <?php if ($item['type'] === 'sewa'): ?>
                                                    <?php echo $item['months']; ?> month<?php echo $item['months'] > 1 ? 's' : ''; ?>
                                                <?php else: ?>
                                                    One-time
                                                <?php endif; ?>
                                            </td>
                                            <td class="text-end">
                                                <strong><?php echo rupiah($item['total']); ?></strong>
                                            </td>
                                        </tr>
                                    <?php endforeach; ?>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Payment Method -->
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-light">
                        <h5 class="mb-0"><i class="fas fa-credit-card me-2"></i>Payment Method</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <div class="form-check card p-3">
                                    <input class="form-check-input" type="radio" name="payment_method"
                                           id="paymentTransfer" value="transfer" checked>
                                    <label class="form-check-label w-100" for="paymentTransfer">
                                        <i class="fas fa-university fa-2x d-block mb-2 text-primary"></i>
                                        <strong>Bank Transfer</strong>
                                        <small class="d-block text-muted">BCA, Mandiri, BNI</small>
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="form-check card p-3">
                                    <input class="form-check-input" type="radio" name="payment_method"
                                           id="paymentEwallet" value="ewallet">
                                    <label class="form-check-label w-100" for="paymentEwallet">
                                        <i class="fas fa-mobile-alt fa-2x d-block mb-2 text-success"></i>
                                        <strong>E-Wallet</strong>
                                        <small class="d-block text-muted">GoPay, OVO, DANA</small>
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="form-check card p-3">
                                    <input class="form-check-input" type="radio" name="payment_method"
                                           id="paymentCreditCard" value="credit_card" disabled>
                                    <label class="form-check-label w-100" for="paymentCreditCard">
                                        <i class="fas fa-credit-card fa-2x d-block mb-2 text-muted"></i>
                                        <strong>Credit Card</strong>
                                        <small class="d-block text-muted">Coming Soon</small>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Additional Information -->
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-light">
                        <h5 class="mb-0"><i class="fas fa-sticky-note me-2"></i>Additional Notes</h5>
                    </div>
                    <div class="card-body">
                        <textarea name="notes" class="form-control" rows="3"
                                  placeholder="Any special requests or notes for this order..."></textarea>
                    </div>
                </div>

                <!-- Partner Reference (Optional) -->
                <?php if (Session::getRole() !== 3): // Not partner ?>
                    <div class="card shadow-sm border-0 mb-4">
                        <div class="card-header bg-light">
                            <h5 class="mb-0"><i class="fas fa-handshake me-2"></i>Partner Reference (Optional)</h5>
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <label class="form-label">Partner Code or ID</label>
                                <input type="text" name="partner_code" class="form-control"
                                       placeholder="Enter partner code if you have one">
                                <small class="text-muted">If you were referred by a partner, enter their code here</small>
                            </div>
                        </div>
                    </div>
                <?php endif; ?>
            </div>

            <!-- Order Summary -->
            <div class="col-lg-4">
                <div class="card shadow-sm border-0 sticky-top" style="top: 20px;">
                    <div class="card-header bg-gradient text-white">
                        <h5 class="mb-0"><i class="fas fa-receipt me-2"></i>Order Summary</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-flex justify-content-between mb-2">
                            <span>Subtotal:</span>
                            <strong><?php echo rupiah($subtotal); ?></strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Setup Fees:</span>
                            <strong><?php echo rupiah($setupFees); ?></strong>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between mb-4">
                            <h5 class="mb-0">Total:</h5>
                            <h4 class="mb-0 text-primary"><?php echo rupiah($total); ?></h4>
                        </div>

                        <input type="hidden" name="order_type" value="layanan">

                        <button type="submit" class="btn btn-primary w-100 mb-2">
                            <i class="fas fa-check me-2"></i>Place Order
                        </button>

                        <a href="<?php echo url('cart.php'); ?>" class="btn btn-outline-secondary w-100">
                            <i class="fas fa-arrow-left me-2"></i>Back to Cart
                        </a>

                        <div class="alert alert-info mt-3 mb-0">
                            <small>
                                <i class="fas fa-info-circle me-1"></i>
                                You will receive payment instructions after placing the order
                            </small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('checkoutForm');

    form.addEventListener('submit', function(e) {
        const paymentMethod = document.querySelector('input[name="payment_method"]:checked');

        if (!paymentMethod) {
            e.preventDefault();
            alert('Please select a payment method');
            return false;
        }

        // Confirm order
        if (!confirm('Are you sure you want to place this order?')) {
            e.preventDefault();
            return false;
        }
    });
});
</script>

<?php require_once APP_PATH . '/views/layouts/footer.php'; ?>
