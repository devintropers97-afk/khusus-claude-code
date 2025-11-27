    <!-- Footer -->
    <footer class="footer mt-auto py-4 bg-light">
        <div class="container text-center">
            <div class="row">
                <div class="col-md-12">
                    <p class="mb-1">
                        <strong><?php echo COMPANY_NAME; ?></strong>
                    </p>
                    <p class="text-muted small mb-2">
                        NIB: <?php echo COMPANY_NIB; ?> |
                        Email: <?php echo COMPANY_EMAIL; ?> |
                        Phone: <?php echo COMPANY_PHONE; ?>
                    </p>
                    <p class="text-muted small">
                        &copy; <?php echo date('Y'); ?> <?php echo APP_NAME; ?>. All rights reserved.
                    </p>
                </div>
            </div>
        </div>
    </footer>

    <!-- jQuery 3.7.1 -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <!-- Bootstrap 5.3.3 JS Bundle (includes Popper) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Custom JS -->
    <script src="<?php echo asset('js/app.js'); ?>"></script>

    <?php if (isset($additionalJS)): ?>
        <?php echo $additionalJS; ?>
    <?php endif; ?>

    <script>
        // Auto-dismiss alerts after 5 seconds
        setTimeout(function() {
            $('.alert').fadeOut('slow');
        }, 5000);
    </script>
</body>
</html>
