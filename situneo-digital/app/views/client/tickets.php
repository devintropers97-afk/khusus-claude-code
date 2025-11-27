<?php
$pageTitle = 'Support Tickets';
require_once APP_PATH . '/views/layouts/header.php';
?>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
            <div class="position-sticky pt-3">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo url('client/dashboard.php'); ?>">
                            <i class="fas fa-home me-2"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo url('client/profile.php'); ?>">
                            <i class="fas fa-user me-2"></i> My Profile
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo url('client/orders.php'); ?>">
                            <i class="fas fa-shopping-cart me-2"></i> My Orders
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo url('client/subscriptions.php'); ?>">
                            <i class="fas fa-calendar-check me-2"></i> Subscriptions
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo url('client/invoices.php'); ?>">
                            <i class="fas fa-file-invoice me-2"></i> Invoices
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="<?php echo url('client/tickets.php'); ?>">
                            <i class="fas fa-headset me-2"></i> Support Tickets
                        </a>
                    </li>
                    <hr>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo url('logout.php'); ?>">
                            <i class="fas fa-sign-out-alt me-2"></i> Logout
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Main Content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">Support Tickets</h1>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <button type="button" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#createTicketModal">
                        <i class="fas fa-plus me-1"></i> Create Ticket
                    </button>
                </div>
            </div>

            <!-- Flash Messages -->
            <?php echo Session::displayFlash(); ?>

            <!-- Tickets List -->
            <div class="card shadow-sm">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="fas fa-list me-2"></i>My Tickets</h5>
                </div>
                <div class="card-body">
                    <?php if (empty($tickets)): ?>
                        <div class="text-center py-5">
                            <i class="fas fa-headset fa-4x text-muted mb-3"></i>
                            <h4>No Tickets Yet</h4>
                            <p class="text-muted">You haven't created any support tickets.</p>
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createTicketModal">
                                Create First Ticket
                            </button>
                        </div>
                    <?php else: ?>
                        <div class="list-group">
                            <?php foreach ($tickets as $ticket): ?>
                                <a href="<?php echo url('client/ticket-detail.php?id=' . $ticket['id']); ?>"
                                   class="list-group-item list-group-item-action">
                                    <div class="d-flex w-100 justify-content-between align-items-start">
                                        <div class="flex-grow-1">
                                            <div class="d-flex align-items-center mb-2">
                                                <h5 class="mb-0 me-3"><?php echo e($ticket['subject']); ?></h5>
                                                <?php
                                                $statusColors = [
                                                    'open' => 'danger',
                                                    'in_progress' => 'warning',
                                                    'waiting_client' => 'info',
                                                    'resolved' => 'success',
                                                    'closed' => 'secondary'
                                                ];
                                                $color = $statusColors[$ticket['status']] ?? 'secondary';
                                                ?>
                                                <span class="badge bg-<?php echo $color; ?> me-2">
                                                    <?php echo strtoupper(str_replace('_', ' ', $ticket['status'])); ?>
                                                </span>
                                                <?php
                                                $priorityColors = [
                                                    'low' => 'success',
                                                    'medium' => 'warning',
                                                    'high' => 'danger',
                                                    'urgent' => 'danger'
                                                ];
                                                $color = $priorityColors[$ticket['priority']] ?? 'secondary';
                                                ?>
                                                <span class="badge bg-<?php echo $color; ?>">
                                                    <?php echo strtoupper($ticket['priority']); ?>
                                                </span>
                                            </div>
                                            <p class="mb-1 text-muted small">
                                                <i class="fas fa-tag me-1"></i>
                                                <?php echo ucfirst($ticket['category']); ?> |
                                                <i class="fas fa-clock me-1"></i>
                                                <?php echo tanggal($ticket['opened_at'], 'd M Y H:i'); ?>
                                                <?php if ($ticket['assigned_first_name']): ?>
                                                    | <i class="fas fa-user me-1"></i>
                                                    Assigned to: <?php echo e($ticket['assigned_first_name'] . ' ' . $ticket['assigned_last_name']); ?>
                                                <?php endif; ?>
                                            </p>
                                            <p class="mb-0 text-muted small">
                                                Ticket #<?php echo e($ticket['ticket_number']); ?>
                                            </p>
                                        </div>
                                        <div>
                                            <i class="fas fa-chevron-right"></i>
                                        </div>
                                    </div>
                                </a>
                            <?php endforeach; ?>
                        </div>
                    <?php endif; ?>
                </div>
            </div>
        </main>
    </div>
</div>

<!-- Create Ticket Modal -->
<div class="modal fade" id="createTicketModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="fas fa-plus-circle me-2"></i>Create Support Ticket
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="<?php echo url('client/create-ticket.php'); ?>" method="POST">
                <?php echo CSRF::inputField(); ?>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="category" class="form-label">Category *</label>
                            <select class="form-select" id="category" name="category" required>
                                <option value="">Select Category</option>
                                <option value="technical">Technical Issue</option>
                                <option value="billing">Billing Question</option>
                                <option value="general">General Inquiry</option>
                                <option value="complaint">Complaint</option>
                                <option value="feature_request">Feature Request</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="priority" class="form-label">Priority *</label>
                            <select class="form-select" id="priority" name="priority" required>
                                <option value="low">Low</option>
                                <option value="medium" selected>Medium</option>
                                <option value="high">High</option>
                                <option value="urgent">Urgent</option>
                            </select>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="subject" class="form-label">Subject *</label>
                        <input type="text" class="form-control" id="subject" name="subject"
                               placeholder="Brief description of your issue" required minlength="5" maxlength="255">
                    </div>
                    <div class="mb-3">
                        <label for="description" class="form-label">Description *</label>
                        <textarea class="form-control" id="description" name="description" rows="6"
                                  placeholder="Please provide detailed information about your issue..."
                                  required minlength="20"></textarea>
                        <div class="form-text">Minimum 20 characters. Please be as detailed as possible.</div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-paper-plane me-1"></i> Submit Ticket
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<?php require_once APP_PATH . '/views/layouts/footer.php'; ?>
