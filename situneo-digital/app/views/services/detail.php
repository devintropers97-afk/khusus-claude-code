<?php
$pageTitle = $service['name'];
require_once APP_PATH . '/views/layouts/header.php';
?>

<div class="container py-5">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<?php echo url('/'); ?>">Home</a></li>
            <li class="breadcrumb-item"><a href="<?php echo url('services.php'); ?>">Services</a></li>
            <li class="breadcrumb-item active"><?php echo e($service['name']); ?></li>
        </ol>
    </nav>

    <!-- Flash Messages -->
    <?php echo Session::displayFlash(); ?>

    <div class="row">
        <!-- Service Details -->
        <div class="col-lg-8">
            <div class="card shadow-sm border-0 mb-4">
                <div class="card-body p-4">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <span class="badge bg-primary fs-6"><?php echo e($service['category_name']); ?></span>
                        <?php if ($service['is_featured']): ?>
                            <span class="badge bg-warning text-dark fs-6">
                                <i class="fas fa-star"></i> Featured
                            </span>
                        <?php endif; ?>
                    </div>

                    <h1 class="display-5 fw-bold mb-3"><?php echo e($service['name']); ?></h1>

                    <div class="mb-4">
                        <small class="text-muted">
                            <i class="fas fa-eye me-1"></i> <?php echo number_format($service['views']); ?> views
                        </small>
                    </div>

                    <div class="service-description">
                        <h5 class="fw-bold mb-3">Description</h5>
                        <p class="text-muted"><?php echo nl2br(e($service['description'])); ?></p>
                    </div>

                    <?php if (!empty($features)): ?>
                        <div class="mt-4">
                            <h5 class="fw-bold mb-3">Features</h5>
                            <ul class="list-unstyled">
                                <?php foreach ($features as $feature): ?>
                                    <li class="mb-2">
                                        <i class="fas fa-check-circle text-success me-2"></i>
                                        <?php echo e($feature); ?>
                                    </li>
                                <?php endforeach; ?>
                            </ul>
                        </div>
                    <?php endif; ?>

                    <?php if (!empty($service['technical_specs'])): ?>
                        <div class="mt-4">
                            <h5 class="fw-bold mb-3">Technical Specifications</h5>
                            <p class="text-muted"><?php echo nl2br(e($service['technical_specs'])); ?></p>
                        </div>
                    <?php endif; ?>
                </div>
            </div>
        </div>

        <!-- Pricing & Order -->
        <div class="col-lg-4">
            <div class="card shadow-sm border-0 sticky-top" style="top: 20px;">
                <div class="card-header bg-gradient text-white">
                    <h5 class="mb-0"><i class="fas fa-shopping-cart me-2"></i>Order This Service</h5>
                </div>
                <div class="card-body">
                    <!-- Purchase Option -->
                    <?php if ($service['available_for_purchase']): ?>
                        <div class="border rounded p-3 mb-3">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h6 class="mb-0">Purchase (Beli)</h6>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="order_type" id="typeBeli"
                                           value="beli" checked>
                                </div>
                            </div>
                            <div class="pricing">
                                <div class="d-flex justify-content-between mb-1">
                                    <small class="text-muted">Base Price:</small>
                                    <strong><?php echo rupiah($service['base_price']); ?></strong>
                                </div>
                                <?php if ($service['setup_fee'] > 0): ?>
                                    <div class="d-flex justify-content-between mb-1">
                                        <small class="text-muted">Setup Fee:</small>
                                        <strong><?php echo rupiah($service['setup_fee']); ?></strong>
                                    </div>
                                <?php endif; ?>
                                <hr>
                                <div class="d-flex justify-content-between">
                                    <strong>Total:</strong>
                                    <h5 class="text-primary mb-0" id="totalBeli">
                                        <?php echo rupiah($service['base_price'] + $service['setup_fee']); ?>
                                    </h5>
                                </div>
                            </div>
                        </div>
                    <?php endif; ?>

                    <!-- Rent Option -->
                    <?php if ($service['available_for_rent']): ?>
                        <div class="border rounded p-3 mb-3">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h6 class="mb-0">Rent (Sewa)</h6>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="order_type" id="typeSewa"
                                           value="sewa" <?php echo !$service['available_for_purchase'] ? 'checked' : ''; ?>>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label small">Contract Duration:</label>
                                <select class="form-select form-select-sm" id="contractMonths">
                                    <?php for ($i = $service['min_contract_months']; $i <= 24; $i++): ?>
                                        <option value="<?php echo $i; ?>"><?php echo $i; ?> Month<?php echo $i > 1 ? 's' : ''; ?></option>
                                    <?php endfor; ?>
                                </select>
                            </div>
                            <div class="pricing">
                                <div class="d-flex justify-content-between mb-1">
                                    <small class="text-muted">Monthly Price:</small>
                                    <strong><?php echo rupiah($service['monthly_price']); ?></strong>
                                </div>
                                <div class="d-flex justify-content-between mb-1">
                                    <small class="text-muted">Duration:</small>
                                    <strong><span id="displayMonths"><?php echo $service['min_contract_months']; ?></span> months</strong>
                                </div>
                                <?php if ($service['setup_fee'] > 0): ?>
                                    <div class="d-flex justify-content-between mb-1">
                                        <small class="text-muted">Setup Fee:</small>
                                        <strong><?php echo rupiah($service['setup_fee']); ?></strong>
                                    </div>
                                <?php endif; ?>
                                <hr>
                                <div class="d-flex justify-content-between">
                                    <strong>Total:</strong>
                                    <h5 class="text-success mb-0" id="totalSewa">
                                        <?php echo rupiah(($service['monthly_price'] * $service['min_contract_months']) + $service['setup_fee']); ?>
                                    </h5>
                                </div>
                            </div>
                        </div>
                    <?php endif; ?>

                    <!-- Add to Cart Button -->
                    <button type="button" class="btn btn-primary w-100 mb-2" id="addToCartBtn">
                        <i class="fas fa-cart-plus me-2"></i>Add to Cart
                    </button>

                    <a href="<?php echo url('services.php'); ?>" class="btn btn-outline-secondary w-100">
                        <i class="fas fa-arrow-left me-2"></i>Back to Services
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Related Services -->
    <?php if (!empty($relatedServices)): ?>
        <div class="mt-5">
            <h3 class="mb-4">Related Services</h3>
            <div class="row g-4">
                <?php foreach ($relatedServices as $related): ?>
                    <div class="col-md-3">
                        <div class="card h-100 shadow-sm border-0">
                            <div class="card-body">
                                <span class="badge bg-primary mb-2"><?php echo e($related['category_name']); ?></span>
                                <h6 class="card-title"><?php echo e($related['name']); ?></h6>
                                <p class="card-text small text-muted"><?php echo e(substr($related['description'], 0, 60)); ?>...</p>
                                <div class="mt-2">
                                    <small class="text-muted">From</small><br>
                                    <strong class="text-primary"><?php echo rupiah($related['base_price']); ?></strong>
                                </div>
                                <a href="<?php echo url('service-detail.php?slug=' . $related['slug']); ?>"
                                   class="btn btn-outline-primary btn-sm w-100 mt-3">
                                    View Details
                                </a>
                            </div>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>
    <?php endif; ?>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const serviceId = <?php echo $service['id']; ?>;
    const basePrice = <?php echo $service['base_price']; ?>;
    const monthlyPrice = <?php echo $service['monthly_price']; ?>;
    const setupFee = <?php echo $service['setup_fee']; ?>;
    const contractMonthsSelect = document.getElementById('contractMonths');
    const displayMonths = document.getElementById('displayMonths');
    const totalSewa = document.getElementById('totalSewa');

    // Update sewa total when months change
    if (contractMonthsSelect) {
        contractMonthsSelect.addEventListener('change', function() {
            const months = parseInt(this.value);
            displayMonths.textContent = months;
            const total = (monthlyPrice * months) + setupFee;
            totalSewa.textContent = formatRupiah(total);
        });
    }

    // Add to cart
    document.getElementById('addToCartBtn').addEventListener('click', function() {
        const orderType = document.querySelector('input[name="order_type"]:checked').value;
        const months = orderType === 'sewa' ? parseInt(contractMonthsSelect.value) : 1;

        fetch('<?php echo url("api/add-to-cart.php"); ?>', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                service_id: serviceId,
                type: orderType,
                months: months
            })
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert(data.message);
                window.location.href = '<?php echo url("cart.php"); ?>';
            } else {
                alert(data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Failed to add to cart');
        });
    });

    function formatRupiah(amount) {
        return 'Rp ' + new Intl.NumberFormat('id-ID').format(amount);
    }
});
</script>

<?php require_once APP_PATH . '/views/layouts/footer.php'; ?>
