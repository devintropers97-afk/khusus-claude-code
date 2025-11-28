<?php
$pageTitle = 'Our Services';
require_once APP_PATH . '/views/layouts/header.php';
?>

<div class="container py-5">
    <!-- Page Header -->
    <div class="text-center mb-5">
        <h1 class="display-4 fw-bold">Our Services</h1>
        <p class="lead text-muted">Find the perfect solution for your business needs</p>
    </div>

    <!-- Flash Messages -->
    <?php echo Session::displayFlash(); ?>

    <!-- Featured Services -->
    <?php if (!empty($featuredServices)): ?>
        <div class="mb-5">
            <h2 class="h3 mb-4"><i class="fas fa-star text-warning me-2"></i>Featured Services</h2>
            <div class="row g-4">
                <?php foreach ($featuredServices as $service): ?>
                    <div class="col-md-4">
                        <div class="card h-100 shadow-sm border-0 featured-card">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start mb-3">
                                    <span class="badge bg-primary"><?php echo e($service['category_name']); ?></span>
                                    <span class="badge bg-warning text-dark"><i class="fas fa-star"></i> Featured</span>
                                </div>
                                <h5 class="card-title"><?php echo e($service['name']); ?></h5>
                                <p class="card-text text-muted small"><?php echo e(substr($service['description'], 0, 100)); ?>...</p>
                                <div class="d-flex justify-content-between align-items-center mt-3">
                                    <div>
                                        <small class="text-muted">Starting from</small>
                                        <h4 class="mb-0 text-primary"><?php echo rupiah($service['base_price']); ?></h4>
                                    </div>
                                    <a href="<?php echo url('service-detail.php?slug=' . $service['slug']); ?>" class="btn btn-outline-primary btn-sm">
                                        View Details <i class="fas fa-arrow-right ms-1"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>
        <hr class="my-5">
    <?php endif; ?>

    <div class="row">
        <!-- Filters Sidebar -->
        <div class="col-lg-3 mb-4">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-gradient text-white">
                    <h5 class="mb-0"><i class="fas fa-filter me-2"></i>Filters</h5>
                </div>
                <div class="card-body">
                    <!-- Search -->
                    <form method="GET" action="<?php echo url('services.php'); ?>" id="filterForm">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Search</label>
                            <input type="text" class="form-control" name="search" placeholder="Search services..."
                                   value="<?php echo e($search ?? ''); ?>">
                        </div>

                        <!-- Category Filter -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Category</label>
                            <select class="form-select" name="category" onchange="this.form.submit()">
                                <option value="">All Categories</option>
                                <?php foreach ($categories as $cat): ?>
                                    <option value="<?php echo e($cat['slug']); ?>"
                                            <?php echo ($category ?? '') === $cat['slug'] ? 'selected' : ''; ?>>
                                        <?php echo e($cat['name']); ?> (<?php echo $cat['service_count']; ?>)
                                    </option>
                                <?php endforeach; ?>
                            </select>
                        </div>

                        <!-- Sort -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Sort By</label>
                            <select class="form-select" name="sort" onchange="this.form.submit()">
                                <option value="newest" <?php echo ($sort ?? 'newest') === 'newest' ? 'selected' : ''; ?>>Newest First</option>
                                <option value="price_low" <?php echo ($sort ?? '') === 'price_low' ? 'selected' : ''; ?>>Price: Low to High</option>
                                <option value="price_high" <?php echo ($sort ?? '') === 'price_high' ? 'selected' : ''; ?>>Price: High to Low</option>
                                <option value="popular" <?php echo ($sort ?? '') === 'popular' ? 'selected' : ''; ?>>Most Popular</option>
                            </select>
                        </div>

                        <button type="submit" class="btn btn-primary w-100">
                            <i class="fas fa-search me-2"></i>Apply Filters
                        </button>

                        <?php if (!empty($category) || !empty($search)): ?>
                            <a href="<?php echo url('services.php'); ?>" class="btn btn-outline-secondary w-100 mt-2">
                                <i class="fas fa-times me-2"></i>Clear Filters
                            </a>
                        <?php endif; ?>
                    </form>
                </div>
            </div>
        </div>

        <!-- Services Grid -->
        <div class="col-lg-9">
            <?php if (empty($services)): ?>
                <div class="text-center py-5">
                    <i class="fas fa-box-open fa-4x text-muted mb-3"></i>
                    <h4>No Services Found</h4>
                    <p class="text-muted">Try adjusting your filters or search terms</p>
                    <a href="<?php echo url('services.php'); ?>" class="btn btn-primary">
                        <i class="fas fa-arrow-left me-2"></i>View All Services
                    </a>
                </div>
            <?php else: ?>
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h5 class="mb-0">
                        Showing <?php echo count($services); ?> of <?php echo $pagination['total']; ?> services
                    </h5>
                </div>

                <div class="row g-4">
                    <?php foreach ($services as $service): ?>
                        <div class="col-md-6 col-lg-4">
                            <div class="card h-100 shadow-sm border-0 service-card">
                                <div class="card-body">
                                    <span class="badge bg-primary mb-3"><?php echo e($service['category_name']); ?></span>
                                    <h5 class="card-title"><?php echo e($service['name']); ?></h5>
                                    <p class="card-text text-muted small"><?php echo e(substr($service['description'], 0, 80)); ?>...</p>

                                    <div class="mt-3">
                                        <?php if ($service['available_for_purchase']): ?>
                                            <div class="mb-2">
                                                <small class="text-muted">Purchase:</small>
                                                <strong class="text-primary"><?php echo rupiah($service['base_price']); ?></strong>
                                            </div>
                                        <?php endif; ?>

                                        <?php if ($service['available_for_rent']): ?>
                                            <div class="mb-2">
                                                <small class="text-muted">Rent:</small>
                                                <strong class="text-success"><?php echo rupiah($service['monthly_price']); ?>/month</strong>
                                            </div>
                                        <?php endif; ?>
                                    </div>

                                    <a href="<?php echo url('service-detail.php?slug=' . $service['slug']); ?>"
                                       class="btn btn-outline-primary btn-sm w-100 mt-3">
                                        <i class="fas fa-info-circle me-1"></i> View Details
                                    </a>
                                </div>
                            </div>
                        </div>
                    <?php endforeach; ?>
                </div>

                <!-- Pagination -->
                <?php if ($pagination['total_pages'] > 1): ?>
                    <nav aria-label="Services pagination" class="mt-4">
                        <ul class="pagination justify-content-center">
                            <?php if ($pagination['page'] > 1): ?>
                                <li class="page-item">
                                    <a class="page-link" href="?page=<?php echo $pagination['page'] - 1; ?><?php echo !empty($category) ? '&category=' . $category : ''; ?><?php echo !empty($search) ? '&search=' . urlencode($search) : ''; ?><?php echo !empty($sort) ? '&sort=' . $sort : ''; ?>">
                                        <i class="fas fa-chevron-left"></i>
                                    </a>
                                </li>
                            <?php endif; ?>

                            <?php for ($i = 1; $i <= $pagination['total_pages']; $i++): ?>
                                <li class="page-item <?php echo $i == $pagination['page'] ? 'active' : ''; ?>">
                                    <a class="page-link" href="?page=<?php echo $i; ?><?php echo !empty($category) ? '&category=' . $category : ''; ?><?php echo !empty($search) ? '&search=' . urlencode($search) : ''; ?><?php echo !empty($sort) ? '&sort=' . $sort : ''; ?>">
                                        <?php echo $i; ?>
                                    </a>
                                </li>
                            <?php endfor; ?>

                            <?php if ($pagination['page'] < $pagination['total_pages']): ?>
                                <li class="page-item">
                                    <a class="page-link" href="?page=<?php echo $pagination['page'] + 1; ?><?php echo !empty($category) ? '&category=' . $category : ''; ?><?php echo !empty($search) ? '&search=' . urlencode($search) : ''; ?><?php echo !empty($sort) ? '&sort=' . $sort : ''; ?>">
                                        <i class="fas fa-chevron-right"></i>
                                    </a>
                                </li>
                            <?php endif; ?>
                        </ul>
                    </nav>
                <?php endif; ?>
            <?php endif; ?>
        </div>
    </div>
</div>

<style>
.featured-card {
    border-left: 4px solid #ffc107 !important;
    transition: transform 0.2s;
}

.featured-card:hover {
    transform: translateY(-5px);
}

.service-card {
    transition: transform 0.2s, box-shadow 0.2s;
}

.service-card:hover {
    transform: translateY(-3px);
    box-shadow: 0 0.5rem 1rem rgba(0,0,0,0.15) !important;
}
</style>

<?php require_once APP_PATH . '/views/layouts/footer.php'; ?>
