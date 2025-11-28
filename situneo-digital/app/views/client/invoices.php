<?php require_once '../app/views/includes/header.php'; ?>

<div class="container-fluid mt-4">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3 col-lg-2">
            <?php require_once '../app/views/client/includes/sidebar.php'; ?>
        </div>

        <!-- Main Content -->
        <div class="col-md-9 col-lg-10">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-file-invoice"></i> My Invoices</h2>
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

            <!-- Filters -->
            <div class="card mb-4">
                <div class="card-body">
                    <form method="GET" class="row g-3">
                        <div class="col-md-4">
                            <input type="text" name="search" class="form-control" placeholder="Search invoices..." value="<?= htmlspecialchars($data['filters']['search']) ?>">
                        </div>
                        <div class="col-md-3">
                            <select name="status" class="form-select">
                                <option value="">All Status</option>
                                <option value="draft" <?= $data['filters']['status'] == 'draft' ? 'selected' : '' ?>>Draft</option>
                                <option value="sent" <?= $data['filters']['status'] == 'sent' ? 'selected' : '' ?>>Sent</option>
                                <option value="partial" <?= $data['filters']['status'] == 'partial' ? 'selected' : '' ?>>Partially Paid</option>
                                <option value="paid" <?= $data['filters']['status'] == 'paid' ? 'selected' : '' ?>>Paid</option>
                                <option value="overdue" <?= $data['filters']['status'] == 'overdue' ? 'selected' : '' ?>>Overdue</option>
                                <option value="cancelled" <?= $data['filters']['status'] == 'cancelled' ? 'selected' : '' ?>>Cancelled</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-search"></i> Filter
                            </button>
                        </div>
                        <div class="col-md-2">
                            <a href="/client/invoices" class="btn btn-secondary w-100">
                                <i class="fas fa-redo"></i> Reset
                            </a>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Invoices Table -->
            <div class="card">
                <div class="card-body">
                    <?php if (empty($data['invoices'])): ?>
                        <div class="text-center py-5">
                            <i class="fas fa-file-invoice fa-4x text-muted mb-3"></i>
                            <p class="text-muted">No invoices found</p>
                        </div>
                    <?php else: ?>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Invoice Number</th>
                                        <th>Date</th>
                                        <th>Due Date</th>
                                        <?php if (in_array(Session::get('role_id'), [1, 2])): ?>
                                            <th>Client</th>
                                        <?php endif; ?>
                                        <th class="text-end">Amount</th>
                                        <th class="text-end">Paid</th>
                                        <th class="text-end">Balance</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach ($data['invoices'] as $invoice): ?>
                                        <?php
                                        $balance = $invoice['total_amount'] - $invoice['paid_amount'];
                                        $statusClass = [
                                            'draft' => 'secondary',
                                            'sent' => 'info',
                                            'partial' => 'warning',
                                            'paid' => 'success',
                                            'overdue' => 'danger',
                                            'cancelled' => 'dark'
                                        ][$invoice['status']] ?? 'secondary';
                                        ?>
                                        <tr>
                                            <td>
                                                <strong><?= $invoice['invoice_number'] ?></strong>
                                                <?php if ($invoice['order_number']): ?>
                                                    <br><small class="text-muted">Order: <?= $invoice['order_number'] ?></small>
                                                <?php endif; ?>
                                            </td>
                                            <td><?= date('d M Y', strtotime($invoice['created_at'])) ?></td>
                                            <td>
                                                <?= date('d M Y', strtotime($invoice['due_date'])) ?>
                                                <?php if ($invoice['status'] == 'overdue'): ?>
                                                    <br><small class="text-danger"><i class="fas fa-exclamation-triangle"></i> Overdue</small>
                                                <?php endif; ?>
                                            </td>
                                            <?php if (in_array(Session::get('role_id'), [1, 2])): ?>
                                                <td>
                                                    <?= htmlspecialchars($invoice['company_name'] ?? ($invoice['first_name'] . ' ' . $invoice['last_name'])) ?>
                                                    <br><small class="text-muted"><?= $invoice['client_code'] ?></small>
                                                </td>
                                            <?php endif; ?>
                                            <td class="text-end">Rp <?= number_format($invoice['total_amount'], 0, ',', '.') ?></td>
                                            <td class="text-end">Rp <?= number_format($invoice['paid_amount'], 0, ',', '.') ?></td>
                                            <td class="text-end">
                                                <strong>Rp <?= number_format($balance, 0, ',', '.') ?></strong>
                                            </td>
                                            <td>
                                                <span class="badge bg-<?= $statusClass ?>">
                                                    <?= ucfirst($invoice['status']) ?>
                                                </span>
                                            </td>
                                            <td>
                                                <a href="/client/invoices/view/<?= $invoice['id'] ?>" class="btn btn-sm btn-primary" title="View Details">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                                <?php if ($invoice['status'] != 'paid' && $invoice['status'] != 'cancelled'): ?>
                                                    <a href="/client/invoices/pay/<?= $invoice['id'] ?>" class="btn btn-sm btn-success" title="Pay Invoice">
                                                        <i class="fas fa-money-bill"></i>
                                                    </a>
                                                <?php endif; ?>
                                                <a href="/client/invoices/download/<?= $invoice['id'] ?>" class="btn btn-sm btn-secondary" title="Download PDF">
                                                    <i class="fas fa-download"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    <?php endforeach; ?>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        <?php if ($data['pagination']['total_pages'] > 1): ?>
                            <nav class="mt-4">
                                <ul class="pagination justify-content-center">
                                    <?php for ($i = 1; $i <= $data['pagination']['total_pages']; $i++): ?>
                                        <li class="page-item <?= $i == $data['pagination']['current_page'] ? 'active' : '' ?>">
                                            <a class="page-link" href="?page=<?= $i ?><?= !empty($data['filters']['status']) ? '&status=' . $data['filters']['status'] : '' ?><?= !empty($data['filters']['search']) ? '&search=' . urlencode($data['filters']['search']) : '' ?>">
                                                <?= $i ?>
                                            </a>
                                        </li>
                                    <?php endfor; ?>
                                </ul>
                            </nav>
                        <?php endif; ?>

                        <!-- Summary -->
                        <div class="row mt-4">
                            <div class="col-md-12">
                                <div class="alert alert-info">
                                    <strong>Summary:</strong> Showing <?= count($data['invoices']) ?> of <?= $data['pagination']['total'] ?> total invoices
                                </div>
                            </div>
                        </div>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>
</div>

<?php require_once '../app/views/includes/footer.php'; ?>
