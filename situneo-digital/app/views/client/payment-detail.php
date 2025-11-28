<?php require_once '../app/views/includes/header.php'; ?>

<?php
$payment = $data['payment'];

$statusClass = [
    'pending' => 'warning',
    'verified' => 'success',
    'rejected' => 'danger',
    'refunded' => 'info'
][$payment['status']] ?? 'secondary';

$methodLabels = [
    'bank_transfer' => 'Bank Transfer',
    'credit_card' => 'Credit Card',
    'debit_card' => 'Debit Card',
    'e_wallet' => 'E-Wallet',
    'virtual_account' => 'Virtual Account'
];
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
                    <a href="/client/payments" class="btn btn-outline-secondary btn-sm mb-2">
                        <i class="fas fa-arrow-left"></i> Back to Payments
                    </a>
                    <h2><i class="fas fa-money-check-alt"></i> Payment <?= $payment['payment_reference'] ?></h2>
                </div>
                <div>
                    <span class="badge bg-<?= $statusClass ?> fs-5">
                        <?= ucfirst($payment['status']) ?>
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

            <div class="row">
                <!-- Payment Details -->
                <div class="col-md-8">
                    <div class="card mb-4">
                        <div class="card-header">
                            <h5><i class="fas fa-info-circle"></i> Payment Details</h5>
                        </div>
                        <div class="card-body">
                            <table class="table table-borderless">
                                <tr>
                                    <td width="30%"><strong>Payment Reference:</strong></td>
                                    <td><?= $payment['payment_reference'] ?></td>
                                </tr>
                                <tr>
                                    <td><strong>Date:</strong></td>
                                    <td><?= date('d M Y H:i', strtotime($payment['created_at'])) ?></td>
                                </tr>
                                <tr>
                                    <td><strong>Amount:</strong></td>
                                    <td><strong class="text-success fs-4">Rp <?= number_format($payment['amount'], 0, ',', '.') ?></strong></td>
                                </tr>
                                <tr>
                                    <td><strong>Payment Method:</strong></td>
                                    <td><?= $methodLabels[$payment['payment_method']] ?? $payment['payment_method'] ?></td>
                                </tr>
                                <?php if ($payment['transaction_id']): ?>
                                    <tr>
                                        <td><strong>Transaction ID:</strong></td>
                                        <td><code><?= $payment['transaction_id'] ?></code></td>
                                    </tr>
                                <?php endif; ?>
                                <tr>
                                    <td><strong>Status:</strong></td>
                                    <td>
                                        <span class="badge bg-<?= $statusClass ?>">
                                            <?= ucfirst($payment['status']) ?>
                                        </span>
                                    </td>
                                </tr>
                            </table>

                            <?php if ($payment['status'] == 'pending'): ?>
                                <div class="alert alert-warning">
                                    <i class="fas fa-clock"></i>
                                    <strong>Pending Verification:</strong> Your payment is being reviewed by our admin team.
                                    You will receive a notification once it's verified.
                                </div>
                            <?php endif; ?>

                            <?php if ($payment['status'] == 'verified'): ?>
                                <div class="alert alert-success">
                                    <i class="fas fa-check-circle"></i>
                                    <strong>Payment Verified:</strong> Your payment has been successfully verified on <?= date('d M Y H:i', strtotime($payment['verified_at'])) ?>
                                </div>
                            <?php endif; ?>

                            <?php if ($payment['status'] == 'rejected'): ?>
                                <div class="alert alert-danger">
                                    <i class="fas fa-times-circle"></i>
                                    <strong>Payment Rejected:</strong> Your payment was rejected. Please check the notes below for the reason.
                                </div>
                            <?php endif; ?>

                            <?php if ($payment['status'] == 'refunded'): ?>
                                <div class="alert alert-info">
                                    <i class="fas fa-undo"></i>
                                    <strong>Payment Refunded:</strong>
                                    <?php if ($payment['refund_amount'] > 0): ?>
                                        Rp <?= number_format($payment['refund_amount'], 0, ',', '.') ?> has been refunded on <?= date('d M Y', strtotime($payment['refund_date'])) ?>
                                    <?php else: ?>
                                        This payment has been refunded.
                                    <?php endif; ?>
                                </div>
                            <?php endif; ?>
                        </div>
                    </div>

                    <!-- Related Information -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <h5><i class="fas fa-link"></i> Related Information</h5>
                        </div>
                        <div class="card-body">
                            <?php if ($payment['invoice_number']): ?>
                                <div class="mb-3">
                                    <strong>Invoice:</strong>
                                    <a href="/client/invoices/view/<?= $payment['invoice_id'] ?>" class="btn btn-sm btn-outline-primary ms-2">
                                        <i class="fas fa-file-invoice"></i> <?= $payment['invoice_number'] ?>
                                    </a>
                                </div>
                            <?php endif; ?>

                            <?php if ($payment['order_number']): ?>
                                <div class="mb-3">
                                    <strong>Order:</strong>
                                    <a href="/client/orders/view/<?= $payment['order_id'] ?>" class="btn btn-sm btn-outline-primary ms-2">
                                        <i class="fas fa-shopping-cart"></i> <?= $payment['order_number'] ?>
                                    </a>
                                </div>
                            <?php endif; ?>

                            <?php if (!$payment['invoice_number'] && !$payment['order_number']): ?>
                                <p class="text-muted mb-0">No linked invoice or order</p>
                            <?php endif; ?>
                        </div>
                    </div>

                    <!-- Notes -->
                    <?php if ($payment['notes']): ?>
                        <div class="card">
                            <div class="card-header">
                                <h5><i class="fas fa-sticky-note"></i> Notes</h5>
                            </div>
                            <div class="card-body">
                                <?= nl2br(htmlspecialchars($payment['notes'])) ?>
                            </div>
                        </div>
                    <?php endif; ?>
                </div>

                <!-- Sidebar Info -->
                <div class="col-md-4">
                    <!-- Payment Proof -->
                    <?php if ($payment['payment_proof']): ?>
                        <div class="card mb-4">
                            <div class="card-header">
                                <h6><i class="fas fa-image"></i> Payment Proof</h6>
                            </div>
                            <div class="card-body text-center">
                                <img src="/client/payments/viewProof/<?= $payment['id'] ?>"
                                     alt="Payment Proof"
                                     class="img-fluid rounded mb-3"
                                     style="max-height: 300px;">
                                <div class="d-grid gap-2">
                                    <a href="/client/payments/viewProof/<?= $payment['id'] ?>" target="_blank" class="btn btn-primary btn-sm">
                                        <i class="fas fa-external-link-alt"></i> View Full Size
                                    </a>
                                    <a href="/client/payments/downloadProof/<?= $payment['id'] ?>" class="btn btn-secondary btn-sm">
                                        <i class="fas fa-download"></i> Download
                                    </a>
                                </div>
                            </div>
                        </div>
                    <?php endif; ?>

                    <!-- Client Information -->
                    <?php if (in_array(Session::get('role_id'), [1, 2])): ?>
                        <div class="card mb-4">
                            <div class="card-header">
                                <h6><i class="fas fa-user"></i> Client Information</h6>
                            </div>
                            <div class="card-body">
                                <p class="mb-1"><strong><?= htmlspecialchars($payment['company_name'] ?? ($payment['first_name'] . ' ' . $payment['last_name'])) ?></strong></p>
                                <p class="mb-1 small text-muted"><?= $payment['client_code'] ?></p>
                                <p class="mb-0 small"><?= htmlspecialchars($payment['email']) ?></p>
                            </div>
                        </div>
                    <?php endif; ?>

                    <!-- Verification Info -->
                    <?php if ($payment['verified_at']): ?>
                        <div class="card">
                            <div class="card-header">
                                <h6><i class="fas fa-check-circle"></i> Verification Info</h6>
                            </div>
                            <div class="card-body">
                                <p class="mb-1 small"><strong>Verified:</strong></p>
                                <p class="mb-2 small"><?= date('d M Y H:i', strtotime($payment['verified_at'])) ?></p>

                                <?php if ($payment['refund_amount'] > 0): ?>
                                    <p class="mb-1 small"><strong>Refund Amount:</strong></p>
                                    <p class="mb-2 small text-info">Rp <?= number_format($payment['refund_amount'], 0, ',', '.') ?></p>

                                    <p class="mb-1 small"><strong>Refund Date:</strong></p>
                                    <p class="mb-0 small"><?= date('d M Y', strtotime($payment['refund_date'])) ?></p>
                                <?php endif; ?>
                            </div>
                        </div>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>
</div>

<?php require_once '../app/views/includes/footer.php'; ?>
