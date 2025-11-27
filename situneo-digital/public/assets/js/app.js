/**
 * SITUNEO DIGITAL - Main JavaScript
 * PT SITUNEO DIGITAL SOLUSI INDONESIA
 *
 * Custom JavaScript utilities dan helper functions
 */

(function($) {
    'use strict';

    /**
     * Document Ready
     */
    $(document).ready(function() {
        // Initialize tooltips
        initTooltips();

        // Initialize popovers
        initPopovers();

        // Add CSRF token to all AJAX requests
        setupAjaxCSRF();

        // Setup form validation
        setupFormValidation();

        // Setup confirmation dialogs
        setupConfirmDialogs();

        // Auto-hide alerts
        autoHideAlerts();
    });

    /**
     * Initialize Bootstrap Tooltips
     */
    function initTooltips() {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    }

    /**
     * Initialize Bootstrap Popovers
     */
    function initPopovers() {
        var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
        popoverTriggerList.map(function (popoverTriggerEl) {
            return new bootstrap.Popover(popoverTriggerEl);
        });
    }

    /**
     * Setup AJAX CSRF Token
     */
    function setupAjaxCSRF() {
        // Get CSRF token from meta tag
        var token = $('meta[name="csrf-token"]').attr('content');

        // Add to all AJAX requests
        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': token
            }
        });
    }

    /**
     * Setup Form Validation
     */
    function setupFormValidation() {
        // HTML5 validation
        var forms = document.querySelectorAll('.needs-validation');

        Array.prototype.slice.call(forms).forEach(function (form) {
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }

                form.classList.add('was-validated');
            }, false);
        });
    }

    /**
     * Setup Confirmation Dialogs
     */
    function setupConfirmDialogs() {
        $('[data-confirm]').on('click', function(e) {
            var message = $(this).data('confirm');

            if (!confirm(message)) {
                e.preventDefault();
                return false;
            }
        });
    }

    /**
     * Auto-hide Alerts after 5 seconds
     */
    function autoHideAlerts() {
        setTimeout(function() {
            $('.alert').fadeOut('slow', function() {
                $(this).remove();
            });
        }, 5000);
    }

    /**
     * Show Loading Spinner
     */
    window.showLoading = function(message) {
        message = message || 'Loading...';

        var loadingHtml = `
            <div class="modal fade" id="loadingModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered modal-sm">
                    <div class="modal-content">
                        <div class="modal-body text-center py-4">
                            <div class="spinner-border text-primary mb-3" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                            <p class="mb-0">${message}</p>
                        </div>
                    </div>
                </div>
            </div>
        `;

        $('body').append(loadingHtml);
        var modal = new bootstrap.Modal(document.getElementById('loadingModal'));
        modal.show();
    };

    /**
     * Hide Loading Spinner
     */
    window.hideLoading = function() {
        var modalEl = document.getElementById('loadingModal');
        if (modalEl) {
            var modal = bootstrap.Modal.getInstance(modalEl);
            if (modal) {
                modal.hide();
                setTimeout(function() {
                    modalEl.remove();
                }, 300);
            }
        }
    };

    /**
     * Show Toast Notification
     */
    window.showToast = function(message, type) {
        type = type || 'info';

        var bgClass = {
            'success': 'bg-success',
            'error': 'bg-danger',
            'warning': 'bg-warning',
            'info': 'bg-info'
        };

        var toastHtml = `
            <div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 9999">
                <div class="toast align-items-center text-white ${bgClass[type]} border-0" role="alert">
                    <div class="d-flex">
                        <div class="toast-body">
                            ${message}
                        </div>
                        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                    </div>
                </div>
            </div>
        `;

        $('body').append(toastHtml);

        var toastEl = $('.toast').last()[0];
        var toast = new bootstrap.Toast(toastEl, {
            autohide: true,
            delay: 3000
        });

        toast.show();

        // Remove after hide
        $(toastEl).on('hidden.bs.toast', function() {
            $(this).parent().remove();
        });
    };

    /**
     * Format Number as Rupiah
     */
    window.formatRupiah = function(amount) {
        return 'Rp ' + parseInt(amount).toLocaleString('id-ID');
    };

    /**
     * Format Date Indonesia
     */
    window.formatTanggal = function(dateString) {
        var date = new Date(dateString);
        var options = { year: 'numeric', month: 'long', day: 'numeric' };
        return date.toLocaleDateString('id-ID', options);
    };

    /**
     * Debounce Function
     */
    window.debounce = function(func, wait) {
        var timeout;
        return function executedFunction() {
            var context = this;
            var args = arguments;

            var later = function() {
                timeout = null;
                func.apply(context, args);
            };

            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
        };
    };

    /**
     * Copy to Clipboard
     */
    window.copyToClipboard = function(text) {
        var $temp = $("<input>");
        $("body").append($temp);
        $temp.val(text).select();
        document.execCommand("copy");
        $temp.remove();

        showToast('Copied to clipboard!', 'success');
    };

    /**
     * AJAX Form Submit Helper
     */
    window.ajaxFormSubmit = function(formSelector, successCallback, errorCallback) {
        $(formSelector).on('submit', function(e) {
            e.preventDefault();

            var $form = $(this);
            var formData = new FormData(this);
            var url = $form.attr('action');
            var method = $form.attr('method') || 'POST';

            // Disable submit button
            $form.find('[type="submit"]').prop('disabled', true);

            // Show loading
            showLoading('Processing...');

            $.ajax({
                url: url,
                method: method,
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    hideLoading();
                    $form.find('[type="submit"]').prop('disabled', false);

                    if (successCallback) {
                        successCallback(response);
                    } else {
                        showToast(response.message || 'Success!', 'success');

                        if (response.redirect) {
                            setTimeout(function() {
                                window.location.href = response.redirect;
                            }, 1000);
                        }
                    }
                },
                error: function(xhr) {
                    hideLoading();
                    $form.find('[type="submit"]').prop('disabled', false);

                    var message = 'An error occurred.';

                    if (xhr.responseJSON && xhr.responseJSON.message) {
                        message = xhr.responseJSON.message;
                    }

                    if (errorCallback) {
                        errorCallback(xhr, message);
                    } else {
                        showToast(message, 'error');
                    }
                }
            });
        });
    };

    /**
     * DataTable Helper
     */
    window.initDataTable = function(selector, options) {
        var defaultOptions = {
            responsive: true,
            pageLength: 25,
            language: {
                url: '//cdn.datatables.net/plug-ins/1.13.7/i18n/id.json'
            }
        };

        var mergedOptions = $.extend({}, defaultOptions, options);

        return $(selector).DataTable(mergedOptions);
    };

    /**
     * Toggle Password Visibility
     */
    window.togglePasswordVisibility = function(inputId) {
        var input = document.getElementById(inputId);
        var icon = document.querySelector('[data-toggle-password="' + inputId + '"]');

        if (input.type === 'password') {
            input.type = 'text';
            if (icon) {
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            }
        } else {
            input.type = 'password';
            if (icon) {
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        }
    };

    /**
     * File Upload Preview
     */
    window.previewImage = function(input, previewSelector) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function(e) {
                $(previewSelector).attr('src', e.target.result).show();
            };

            reader.readAsDataURL(input.files[0]);
        }
    };

    /**
     * Auto-grow Textarea
     */
    $('textarea.auto-grow').on('input', function() {
        this.style.height = 'auto';
        this.style.height = (this.scrollHeight) + 'px';
    });

    /**
     * Character Counter
     */
    $('[data-maxlength]').each(function() {
        var $input = $(this);
        var maxLength = $input.data('maxlength');

        $input.after('<small class="form-text text-muted char-counter">0 / ' + maxLength + ' characters</small>');

        $input.on('input', function() {
            var currentLength = $(this).val().length;
            $(this).next('.char-counter').text(currentLength + ' / ' + maxLength + ' characters');

            if (currentLength > maxLength) {
                $(this).next('.char-counter').addClass('text-danger');
            } else {
                $(this).next('.char-counter').removeClass('text-danger');
            }
        });
    });

    /**
     * Smooth Scroll to Anchor
     */
    $('a[href^="#"]').on('click', function(e) {
        var target = $(this.getAttribute('href'));

        if (target.length) {
            e.preventDefault();
            $('html, body').stop().animate({
                scrollTop: target.offset().top - 100
            }, 800);
        }
    });

    /**
     * Console log for debugging (only in development)
     */
    window.debug = function(message, data) {
        if (console && typeof console.log !== 'undefined') {
            console.log('[DEBUG] ' + message, data || '');
        }
    };

})(jQuery);
