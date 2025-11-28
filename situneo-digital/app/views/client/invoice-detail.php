<?php require_once '../app/views/includes/header.php'; ?>

<?php
$invoice = $data['invoice'];
$items = $data['items'];
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
                    <a href="/client/invoices" class="btn btn-outline-secondary btn-sm mb-2">
                        <i class="fas fa-arrow-left"></i> Back to Invoices
                    </a>
                    <h2><i class="fas fa-file-invoice"></i> Invoice <?= $invoice['invoice_number'] ?></h2>
                </div>
                <div>
                    <span class="badge bg-<?= $statusClass ?> fs-5">
                        <?= ucfirst($invoice['status']) ?>
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

            <!-- Invoice Details -->
            <div class="card mb-4">
                <div class="card-body">
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <h5>From:</h5>
                            <strong>Situneo Digital</strong><br>
                            Jakarta, Indonesia<br>
                            Email: info@situneo.digital<br>
                            Phone: +62 xxx xxx xxx
                        </div>
                        <div class="col-md-6 text-md-end">
                            <h5>Bill To:</h5>
                            <strong><?= htmlspecialchars($invoice['company_name'] ?? ($invoice['first_name'] . ' ' . $invoice['last_name'])) ?></strong><br>
                            <?= htmlspecialchars($invoice['email']) ?><br>
                            <?php if ($invoice['address']): ?>
                                <?= htmlspecialchars($invoice['address']) ?><br>
                                <?= htmlspecialchars($invoice['city']) ?>, <?= htmlspecialchars($invoice['province']) ?>
                            <?php endif; ?>
                        </div>
                    </div>

                    <div class="row mb-4">
                        <div class="col-md-6">
                            <table class="table table-sm table-borderless">
                                <tr>
                                    <td><strong>Invoice Number:</strong></td>
                                    <td><?= $invoice['invoice_number'] ?></td>
                                </tr>
                                <tr>
                                    <td><strong>Invoice Date:</strong></td>
                                    <td><?= date('d M Y', strtotime($invoice['created_at'])) ?></td>
                                </tr>
                                <tr>
                                    <td><strong>Due Date:</strong></td>
                                    <td>
                                        <?= date('d M Y', strtotime($invoice['due_date'])) ?>
                                        <?php if ($invoice['status'] == 'overdue'): ?>
                                            <span class="badge bg-danger ms-2">Overdue</span>
                                        <?php endif; ?>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-md-6">
                            <table class="table table-sm table-borderless">
                                <?php if ($invoice['order_number']): ?>
                                    <tr>
                                        <td><strong>Order Number:</strong></td>
                                        <td>
                                            <a href="/client/orders/view/<?= $invoice['order_id'] ?>">
                                                <?= $invoice['order_number'] ?>
                                            </a>
                                        </td>
                                    </tr>
                                <?php endif; ?>
                                <tr>
                                    <td><strong>Payment Terms:</strong></td>
                                    <td><?= $invoice['payment_terms'] ?></td>
                                </tr>
                                <?php if ($invoice['paid_at']): ?>
                                    <tr>
                                        <td><strong>Paid Date:</strong></td>
                                        <td><?= date('d M Y', strtotime($invoice['paid_at'])) ?></td>
                                    </tr>
                                <?php endif; ?>
                            </table>
                        </div>
                    </div>

                    <!-- Items Table -->
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead class="table-light">
                                <tr>
                                    <th>Description</th>
                                    <th class="text-center" width="10%">Qty</th>
                                    <th class="text-end" width="15%">Unit Price</th>
                                    <th class="text-end" width="15%">Tax</th>
                                    <th class="text-end" width="15%">Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($items as $item): ?>
                                    <tr>
                                        <td><?= htmlspecialchars($item['description']) ?></td>
                                        <td class="text-center"><?= $item['quantity'] ?></td>
                                        <td class="text-end">Rp <?= number_format($item['unit_price'], 0, ',', '.') ?></td>
                                        <td class="text-end">Rp <?= number_format($item['tax_amount'], 0, ',', '.') ?></td>
                                        <td class="text-end">Rp <?= number_format($item['subtotal'] + $item['tax_amount'], 0, ',', '.') ?></td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="4" class="text-end"><strong>Subtotal:</strong></td>
                                    <td class="text-end">Rp <?= number_format($invoice['subtotal'], 0, ',', '.') ?></td>
                                </tr>
                                <tr>
                                    <td colspan="4" class="text-end"><strong>Tax (PPN 11%):</strong></td>
                                    <td class="text-end">Rp <?= number_format($invoice['tax_amount'], 0, ',', '.') ?></td>
                                </tr>
                                <?php if ($invoice['discount_amount'] > 0): ?>
                                    <tr>
                                        <td colspan="4" class="text-end"><strong>Discount:</strong></td>
                                        <td class="text-end text-success">- Rp <?= number_format($invoice['discount_amount'], 0, ',', '.') ?></td>
                                    </tr>
                                <?php endif; ?>
                                <tr class="table-primary">
                                    <td colspan="4" class="text-end"><strong>TOTAL:</strong></td>
                                    <td class="text-end"><strong>Rp <?= number_format($invoice['total_amount'], 0, ',', '.') ?></strong></td>
                                </tr>
                                <?php if ($invoice['paid_amount'] > 0): ?>
                                    <tr>
                                        <td colspan="4" class="text-end"><strong>Paid Amount:</strong></td>
                                        <td class="text-end text-success">Rp <?= number_format($invoice['paid_amount'], 0, ',', '.') ?></td>
                                    </tr>
                                    <tr class="table-warning">
                                        <td colspan="4" class="text-end"><strong>Balance Due:</strong></td>
                                        <td class="text-end"><strong>Rp <?= number_format($balance, 0, ',', '.') ?></strong></td>
                                    </tr>
                                <?php endif; ?>
                            </tfoot>
                        </table>
                    </div>

                    <?php if ($invoice['notes']): ?>
                        <div class="mt-3">
                            <h6>Notes:</h6>
                            <p><?= nl2br(htmlspecialchars($invoice['notes'])) ?></p>
                        </div>
                    <?php endif; ?>

                    <!-- Actions -->
                    <div class="mt-4 d-flex gap-2 justify-content-end">
                        <a href="/client/invoices/download/<?= $invoice['id'] ?>" class="btn btn-secondary">
                            <i class="fas fa-download"></i> Download PDF
                        </a>
                        <?php if ($invoice['status'] != 'paid' && $invoice['status'] != 'cancelled'): ?>
                            <a href="/client/invoices/pay/<?= $invoice['id'] ?>" class="btn btn-success">
                                <i class="fas fa-money-bill"></i> Pay Invoice
                            </a>
                        <?php endif; ?>
                    </div>
                </div>
            </div>

            <!-- Payment History -->
            <?php if ($invoice['paid_amount'] > 0): ?>
                <div class="card">
                    <div class="card-header">
                        <h5><i class="fas fa-history"></i> Payment History</h5>
                    </div>
                    <div class="card-body">
                        <div class="alert alert-info">
                            <strong>Total Paid:</strong> Rp <?= number_format($invoice['paid_amount'], 0, ',', '.') ?>
                            <?php if ($invoice['paid_at']): ?>
                                <br><strong>Last Payment:</strong> <?= date('d M Y H:i', strtotime($invoice['paid_at'])) ?>
                            <?php endif; ?>
                        </div>
                        <p class="text-muted">
                            <i class="fas fa-info-circle"></i> Full payment history is available in the Payments section.
                        </p>
                    </div>
                </div>
            <?php endif; ?>
        </div>
    </div>
</div>

<?php require_once '../app/views/includes/footer.php'; ?>
