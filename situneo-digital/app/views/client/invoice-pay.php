<?php require_once '../app/views/includes/header.php'; ?>

<?php
$invoice = $data['invoice'];
$remaining = $data['remaining'];
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
            <div class="mb-4">
                <a href="/client/invoices/view/<?= $invoice['id'] ?>" class="btn btn-outline-secondary btn-sm mb-2">
                    <i class="fas fa-arrow-left"></i> Back to Invoice
                </a>
                <h2><i class="fas fa-money-bill"></i> Pay Invoice <?= $invoice['invoice_number'] ?></h2>
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
                <!-- Invoice Summary -->
                <div class="col-md-4 mb-4">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <h5 class="mb-0">Invoice Summary</h5>
                        </div>
                        <div class="card-body">
                            <table class="table table-sm table-borderless mb-0">
                                <tr>
                                    <td><strong>Invoice Number:</strong></td>
                                    <td class="text-end"><?= $invoice['invoice_number'] ?></td>
                                </tr>
                                <tr>
                                    <td><strong>Total Amount:</strong></td>
                                    <td class="text-end">Rp <?= number_format($invoice['total_amount'], 0, ',', '.') ?></td>
                                </tr>
                                <tr>
                                    <td><strong>Paid Amount:</strong></td>
                                    <td class="text-end text-success">Rp <?= number_format($invoice['paid_amount'], 0, ',', '.') ?></td>
                                </tr>
                                <tr class="border-top">
                                    <td><strong>Balance Due:</strong></td>
                                    <td class="text-end"><strong class="text-danger">Rp <?= number_format($remaining, 0, ',', '.') ?></strong></td>
                                </tr>
                                <tr>
                                    <td><strong>Due Date:</strong></td>
                                    <td class="text-end">
                                        <?= date('d M Y', strtotime($invoice['due_date'])) ?>
                                        <?php if (strtotime($invoice['due_date']) < time()): ?>
                                            <br><span class="badge bg-danger">Overdue</span>
                                        <?php endif; ?>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>

                    <!-- Payment Instructions -->
                    <div class="card mt-3">
                        <div class="card-header">
                            <h6 class="mb-0"><i class="fas fa-info-circle"></i> Payment Instructions</h6>
                        </div>
                        <div class="card-body">
                            <p class="small mb-2"><strong>Bank Transfer:</strong></p>
                            <p class="small mb-1">Bank BCA</p>
                            <p class="small mb-1">Account: 1234567890</p>
                            <p class="small mb-3">Name: PT Situneo Digital</p>

                            <p class="small mb-2"><strong>Bank Mandiri:</strong></p>
                            <p class="small mb-1">Account: 0987654321</p>
                            <p class="small mb-3">Name: PT Situneo Digital</p>

                            <div class="alert alert-warning small mb-0">
                                <i class="fas fa-exclamation-triangle"></i> Please upload your payment proof after making the transfer.
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Payment Form -->
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">Submit Payment</h5>
                        </div>
                        <div class="card-body">
                            <form action="/client/invoices/submitPayment" method="POST" enctype="multipart/form-data" id="paymentForm">
                                <input type="hidden" name="csrf_token" value="<?= generateCSRFToken() ?>">
                                <input type="hidden" name="invoice_id" value="<?= $invoice['id'] ?>">

                                <div class="mb-3">
                                    <label class="form-label">Payment Amount <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text">Rp</span>
                                        <input type="number" name="amount" class="form-control"
                                               min="1" max="<?= $remaining ?>"
                                               value="<?= $remaining ?>"
                                               required>
                                    </div>
                                    <small class="text-muted">Maximum: Rp <?= number_format($remaining, 0, ',', '.') ?></small>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Payment Method <span class="text-danger">*</span></label>
                                    <select name="payment_method" class="form-select" required>
                                        <option value="">Select Payment Method</option>
                                        <option value="bank_transfer">Bank Transfer</option>
                                        <option value="credit_card">Credit Card</option>
                                        <option value="debit_card">Debit Card</option>
                                        <option value="e_wallet">E-Wallet</option>
                                        <option value="virtual_account">Virtual Account</option>
                                    </select>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Payment Proof <span class="text-danger">*</span></label>
                                    <input type="file" name="payment_proof" class="form-control"
                                           accept="image/*,application/pdf" required>
                                    <small class="text-muted">Upload transfer receipt or payment confirmation (JPG, PNG, or PDF, max 5MB)</small>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Payment Date</label>
                                    <input type="date" name="payment_date" class="form-control"
                                           value="<?= date('Y-m-d') ?>" max="<?= date('Y-m-d') ?>">
                                </div>

                                <div class="mb-4">
                                    <label class="form-label">Notes (Optional)</label>
                                    <textarea name="notes" class="form-control" rows="3"
                                              placeholder="Reference number, additional information..."></textarea>
                                </div>

                                <div class="alert alert-info">
                                    <i class="fas fa-info-circle"></i>
                                    <strong>Important:</strong> Your payment will be verified by our admin within 1-2 business days.
                                    You will receive a notification once the payment is confirmed.
                                </div>

                                <div class="d-flex gap-2 justify-content-end">
                                    <a href="/client/invoices/view/<?= $invoice['id'] ?>" class="btn btn-secondary">
                                        Cancel
                                    </a>
                                    <button type="submit" class="btn btn-success">
                                        <i class="fas fa-check"></i> Submit Payment
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
document.getElementById('paymentForm').addEventListener('submit', function(e) {
    const amount = parseFloat(document.querySelector('input[name="amount"]').value);
    const maxAmount = <?= $remaining ?>;

    if (amount <= 0) {
        e.preventDefault();
        alert('Payment amount must be greater than 0');
        return false;
    }

    if (amount > maxAmount) {
        e.preventDefault();
        alert('Payment amount cannot exceed the balance due');
        return false;
    }

    const fileInput = document.querySelector('input[name="payment_proof"]');
    if (fileInput.files.length > 0) {
        const fileSize = fileInput.files[0].size;
        const maxSize = 5 * 1024 * 1024; // 5MB

        if (fileSize > maxSize) {
            e.preventDefault();
            alert('File size cannot exceed 5MB');
            return false;
        }
    }
});
</script>

<?php require_once '../app/views/includes/footer.php'; ?>
