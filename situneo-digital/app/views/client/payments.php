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
                <h2><i class="fas fa-money-check-alt"></i> My Payments</h2>
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
                        <div class="col-md-3">
                            <input type="text" name="search" class="form-control" placeholder="Search payments..." value="<?= htmlspecialchars($data['filters']['search']) ?>">
                        </div>
                        <div class="col-md-3">
                            <select name="status" class="form-select">
                                <option value="">All Status</option>
                                <option value="pending" <?= $data['filters']['status'] == 'pending' ? 'selected' : '' ?>>Pending</option>
                                <option value="verified" <?= $data['filters']['status'] == 'verified' ? 'selected' : '' ?>>Verified</option>
                                <option value="rejected" <?= $data['filters']['status'] == 'rejected' ? 'selected' : '' ?>>Rejected</option>
                                <option value="refunded" <?= $data['filters']['status'] == 'refunded' ? 'selected' : '' ?>>Refunded</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <select name="payment_method" class="form-select">
                                <option value="">All Methods</option>
                                <option value="bank_transfer" <?= $data['filters']['payment_method'] == 'bank_transfer' ? 'selected' : '' ?>>Bank Transfer</option>
                                <option value="credit_card" <?= $data['filters']['payment_method'] == 'credit_card' ? 'selected' : '' ?>>Credit Card</option>
                                <option value="debit_card" <?= $data['filters']['payment_method'] == 'debit_card' ? 'selected' : '' ?>>Debit Card</option>
                                <option value="e_wallet" <?= $data['filters']['payment_method'] == 'e_wallet' ? 'selected' : '' ?>>E-Wallet</option>
                                <option value="virtual_account" <?= $data['filters']['payment_method'] == 'virtual_account' ? 'selected' : '' ?>>Virtual Account</option>
                            </select>
                        </div>
                        <div class="col-md-1">
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                        <div class="col-md-2">
                            <a href="/client/payments" class="btn btn-secondary w-100">
                                <i class="fas fa-redo"></i> Reset
                            </a>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Payments Table -->
            <div class="card">
                <div class="card-body">
                    <?php if (empty($data['payments'])): ?>
                        <div class="text-center py-5">
                            <i class="fas fa-money-check-alt fa-4x text-muted mb-3"></i>
                            <p class="text-muted">No payments found</p>
                        </div>
                    <?php else: ?>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Payment Reference</th>
                                        <th>Date</th>
                                        <th>Invoice/Order</th>
                                        <?php if (in_array(Session::get('role_id'), [1, 2])): ?>
                                            <th>Client</th>
                                        <?php endif; ?>
                                        <th class="text-end">Amount</th>
                                        <th>Method</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach ($data['payments'] as $payment): ?>
                                        <?php
                                        $statusClass = [
                                            'pending' => 'warning',
                                            'verified' => 'success',
                                            'rejected' => 'danger',
                                            'refunded' => 'info'
                                        ][$payment['status']] ?? 'secondary';
                                        ?>
                                        <tr>
                                            <td>
                                                <strong><?= $payment['payment_reference'] ?></strong>
                                                <?php if ($payment['transaction_id']): ?>
                                                    <br><small class="text-muted">TRX: <?= $payment['transaction_id'] ?></small>
                                                <?php endif; ?>
                                            </td>
                                            <td>
                                                <?= date('d M Y', strtotime($payment['created_at'])) ?>
                                                <br><small class="text-muted"><?= date('H:i', strtotime($payment['created_at'])) ?></small>
                                            </td>
                                            <td>
                                                <?php if ($payment['invoice_number']): ?>
                                                    <a href="/client/invoices/view/<?= $payment['invoice_id'] ?>">
                                                        <?= $payment['invoice_number'] ?>
                                                    </a>
                                                <?php elseif ($payment['order_number']): ?>
                                                    <a href="/client/orders/view/<?= $payment['order_id'] ?>">
                                                        <?= $payment['order_number'] ?>
                                                    </a>
                                                <?php else: ?>
                                                    <span class="text-muted">-</span>
                                                <?php endif; ?>
                                            </td>
                                            <?php if (in_array(Session::get('role_id'), [1, 2])): ?>
                                                <td>
                                                    <?= htmlspecialchars($payment['company_name'] ?? ($payment['first_name'] . ' ' . $payment['last_name'])) ?>
                                                    <br><small class="text-muted"><?= $payment['client_code'] ?></small>
                                                </td>
                                            <?php endif; ?>
                                            <td class="text-end">
                                                <strong>Rp <?= number_format($payment['amount'], 0, ',', '.') ?></strong>
                                                <?php if ($payment['refund_amount'] > 0): ?>
                                                    <br><small class="text-info">Refunded: Rp <?= number_format($payment['refund_amount'], 0, ',', '.') ?></small>
                                                <?php endif; ?>
                                            </td>
                                            <td>
                                                <?php
                                                $methodLabels = [
                                                    'bank_transfer' => 'Bank Transfer',
                                                    'credit_card' => 'Credit Card',
                                                    'debit_card' => 'Debit Card',
                                                    'e_wallet' => 'E-Wallet',
                                                    'virtual_account' => 'Virtual Account'
                                                ];
                                                echo $methodLabels[$payment['payment_method']] ?? $payment['payment_method'];
                                                ?>
                                            </td>
                                            <td>
                                                <span class="badge bg-<?= $statusClass ?>">
                                                    <?= ucfirst($payment['status']) ?>
                                                </span>
                                                <?php if ($payment['status'] == 'verified' && $payment['verified_at']): ?>
                                                    <br><small class="text-muted"><?= date('d M Y', strtotime($payment['verified_at'])) ?></small>
                                                <?php endif; ?>
                                            </td>
                                            <td>
                                                <a href="/client/payments/view/<?= $payment['id'] ?>" class="btn btn-sm btn-primary" title="View Details">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                                <?php if ($payment['payment_proof']): ?>
                                                    <a href="/client/payments/viewProof/<?= $payment['id'] ?>" class="btn btn-sm btn-info" target="_blank" title="View Proof">
                                                        <i class="fas fa-image"></i>
                                                    </a>
                                                <?php endif; ?>
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
                                            <a class="page-link" href="?page=<?= $i ?><?= !empty($data['filters']['status']) ? '&status=' . $data['filters']['status'] : '' ?><?= !empty($data['filters']['payment_method']) ? '&payment_method=' . $data['filters']['payment_method'] : '' ?><?= !empty($data['filters']['search']) ? '&search=' . urlencode($data['filters']['search']) : '' ?>">
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
                                    <strong>Summary:</strong> Showing <?= count($data['payments']) ?> of <?= $data['pagination']['total'] ?> total payments
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
