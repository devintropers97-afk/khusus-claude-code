<?php
$pageTitle = 'Shopping Cart';
require_once APP_PATH . '/views/layouts/header.php';
?>

<div class="container py-5">
    <h1 class="mb-4"><i class="fas fa-shopping-cart me-2"></i>Shopping Cart</h1>

    <!-- Flash Messages -->
    <?php echo Session::displayFlash(); ?>

    <?php if (empty($cartItems)): ?>
        <!-- Empty Cart -->
        <div class="text-center py-5">
            <i class="fas fa-shopping-cart fa-5x text-muted mb-4"></i>
            <h3>Your cart is empty</h3>
            <p class="text-muted mb-4">Browse our services and add items to your cart</p>
            <a href="<?php echo url('services.php'); ?>" class="btn btn-primary">
                <i class="fas fa-search me-2"></i>Browse Services
            </a>
        </div>
    <?php else: ?>
        <div class="row">
            <!-- Cart Items -->
            <div class="col-lg-8">
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-body">
                        <?php foreach ($cartItems as $key => $item): ?>
                            <div class="cart-item border-bottom pb-3 mb-3">
                                <div class="row align-items-center">
                                    <div class="col-md-6">
                                        <h5 class="mb-2"><?php echo e($item['service_name']); ?></h5>
                                        <div class="text-muted small">
                                            <span class="badge bg-<?php echo $item['type'] === 'beli' ? 'primary' : 'success'; ?>">
                                                <?php echo strtoupper($item['type']); ?>
                                            </span>
                                            <?php if ($item['type'] === 'sewa'): ?>
                                                <span class="ms-2">
                                                    <i class="fas fa-calendar-alt me-1"></i>
                                                    <?php echo $item['months']; ?> month<?php echo $item['months'] > 1 ? 's' : ''; ?>
                                                </span>
                                            <?php endif; ?>
                                        </div>
                                    </div>

                                    <div class="col-md-3 text-center">
                                        <?php if ($item['type'] === 'sewa'): ?>
                                            <label class="form-label small mb-1">Duration:</label>
                                            <select class="form-select form-select-sm update-cart-months"
                                                    data-cart-key="<?php echo $key; ?>">
                                                <?php for ($i = 1; $i <= 24; $i++): ?>
                                                    <option value="<?php echo $i; ?>"
                                                            <?php echo $i == $item['months'] ? 'selected' : ''; ?>>
                                                        <?php echo $i; ?> month<?php echo $i > 1 ? 's' : ''; ?>
                                                    </option>
                                                <?php endfor; ?>
                                            </select>
                                        <?php endif; ?>
                                    </div>

                                    <div class="col-md-2 text-end">
                                        <h5 class="mb-0 text-primary item-total-<?php echo md5($key); ?>">
                                            <?php echo rupiah($item['total']); ?>
                                        </h5>
                                    </div>

                                    <div class="col-md-1 text-end">
                                        <button type="button" class="btn btn-sm btn-outline-danger remove-cart-item"
                                                data-cart-key="<?php echo $key; ?>">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        <?php endforeach; ?>
                    </div>
                </div>
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
                            <strong id="subtotalAmount"><?php echo rupiah($subtotal); ?></strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Setup Fees:</span>
                            <strong><?php echo rupiah($setupFees); ?></strong>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between mb-3">
                            <h5 class="mb-0">Total:</h5>
                            <h4 class="mb-0 text-primary" id="totalAmount"><?php echo rupiah($total); ?></h4>
                        </div>

                        <a href="<?php echo url('checkout.php'); ?>" class="btn btn-primary w-100 mb-2">
                            <i class="fas fa-credit-card me-2"></i>Proceed to Checkout
                        </a>

                        <a href="<?php echo url('services.php'); ?>" class="btn btn-outline-secondary w-100">
                            <i class="fas fa-arrow-left me-2"></i>Continue Shopping
                        </a>
                    </div>
                </div>
            </div>
        </div>
    <?php endif; ?>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Update cart item months
    document.querySelectorAll('.update-cart-months').forEach(select => {
        select.addEventListener('change', function() {
            const cartKey = this.dataset.cartKey;
            const months = parseInt(this.value);

            fetch('<?php echo url("api/update-cart-item.php"); ?>', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    cart_key: cartKey,
                    months: months
                })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Update item total
                    document.querySelector('.item-total-' + md5(cartKey)).textContent = data.item_total;
                    // Update cart total
                    document.getElementById('totalAmount').textContent = data.cart_total;
                    document.getElementById('subtotalAmount').textContent = data.cart_total;
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Failed to update cart');
            });
        });
    });

    // Remove cart item
    document.querySelectorAll('.remove-cart-item').forEach(button => {
        button.addEventListener('click', function() {
            if (!confirm('Are you sure you want to remove this item?')) {
                return;
            }

            const cartKey = this.dataset.cartKey;

            fetch('<?php echo url("api/remove-cart-item.php"); ?>', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    cart_key: cartKey
                })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    location.reload();
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Failed to remove item');
            });
        });
    });

    function md5(str) {
        // Simple hash function for demo - use proper hash in production
        return btoa(str).replace(/[^a-z0-9]/gi, '').substring(0, 16);
    }
});
</script>

<?php require_once APP_PATH . '/views/layouts/footer.php'; ?>
