<?php
/**
 * User Model
 * Model untuk mengelola data user
 *
 * Menyediakan CRUD operations dan authentication functions
 */

class User {
    private $db;

    public function __construct() {
        $this->db = Database::getInstance();
    }

    /**
     * Create new user
     *
     * @param array $data User data
     * @return int|false User ID jika berhasil, false jika gagal
     */
    public function create($data) {
        try {
            $this->db->beginTransaction();

            // Hash password
            $hashedPassword = password_hash($data['password'], PASSWORD_BCRYPT, ['cost' => BCRYPT_COST]);

            // Insert user
            $this->db->query("INSERT INTO users (role_id, email, password, first_name, last_name, phone, status)
                             VALUES (:role_id, :email, :password, :first_name, :last_name, :phone, :status)");

            $this->db->bind(':role_id', $data['role_id'] ?? 5); // Default: Client
            $this->db->bind(':email', $data['email']);
            $this->db->bind(':password', $hashedPassword);
            $this->db->bind(':first_name', $data['first_name']);
            $this->db->bind(':last_name', $data['last_name']);
            $this->db->bind(':phone', $data['phone'] ?? null);
            $this->db->bind(':status', $data['status'] ?? 'active');

            $this->db->execute();
            $userId = $this->db->lastInsertId();

            // Generate dan kirim verification email
            $token = Mailer::generateToken();
            Mailer::saveToken($userId, $token, 'email_verification', 24);

            $mailer = new Mailer();
            $mailer->sendVerificationEmail(
                $data['email'],
                $data['first_name'] . ' ' . $data['last_name'],
                $token
            );

            $this->db->commit();

            // Log activity
            Session::logActivity($userId, 'register', 'User registered', [
                'email' => $data['email']
            ]);

            return $userId;

        } catch (Exception $e) {
            $this->db->rollback();
            logError('User creation failed: ' . $e->getMessage(), $data);
            return false;
        }
    }

    /**
     * Find user by ID
     *
     * @param int $id
     * @return array|false
     */
    public function findById($id) {
        $this->db->query("SELECT u.*, r.name as role_name
                         FROM users u
                         LEFT JOIN roles r ON u.role_id = r.id
                         WHERE u.id = :id AND u.deleted_at IS NULL");
        $this->db->bind(':id', $id);

        return $this->db->single();
    }

    /**
     * Find user by email
     *
     * @param string $email
     * @return array|false
     */
    public function findByEmail($email) {
        $this->db->query("SELECT u.*, r.name as role_name
                         FROM users u
                         LEFT JOIN roles r ON u.role_id = r.id
                         WHERE u.email = :email AND u.deleted_at IS NULL");
        $this->db->bind(':email', $email);

        return $this->db->single();
    }

    /**
     * Update user
     *
     * @param int $id
     * @param array $data
     * @return bool
     */
    public function update($id, $data) {
        try {
            // Build dynamic UPDATE query based on provided fields
            $fields = [];
            $params = [':id' => $id];

            foreach ($data as $key => $value) {
                if ($key === 'password') {
                    // Hash password jika di-update
                    $value = password_hash($value, PASSWORD_BCRYPT, ['cost' => BCRYPT_COST]);
                }

                $fields[] = "$key = :$key";
                $params[":$key"] = $value;
            }

            $fieldsStr = implode(', ', $fields);

            $this->db->query("UPDATE users SET $fieldsStr, updated_at = NOW() WHERE id = :id");

            foreach ($params as $param => $value) {
                $this->db->bind($param, $value);
            }

            $success = $this->db->execute();

            if ($success) {
                Session::logActivity($id, 'update_profile', 'User updated profile');
            }

            return $success;

        } catch (Exception $e) {
            logError('User update failed: ' . $e->getMessage(), ['id' => $id, 'data' => $data]);
            return false;
        }
    }

    /**
     * Soft delete user
     *
     * @param int $id
     * @return bool
     */
    public function delete($id) {
        try {
            $this->db->query("UPDATE users SET deleted_at = NOW() WHERE id = :id");
            $this->db->bind(':id', $id);

            $success = $this->db->execute();

            if ($success) {
                Session::logActivity($id, 'account_deleted', 'User account deleted');
            }

            return $success;

        } catch (Exception $e) {
            logError('User deletion failed: ' . $e->getMessage(), ['id' => $id]);
            return false;
        }
    }

    /**
     * Get all users dengan pagination
     *
     * @param int $page Current page
     * @param int $perPage Items per page
     * @param array $filters Optional filters
     * @return array
     */
    public function getAll($page = 1, $perPage = 20, $filters = []) {
        $offset = ($page - 1) * $perPage;

        // Build WHERE clause from filters
        $where = ['u.deleted_at IS NULL'];
        $params = [];

        if (!empty($filters['role_id'])) {
            $where[] = 'u.role_id = :role_id';
            $params[':role_id'] = $filters['role_id'];
        }

        if (!empty($filters['status'])) {
            $where[] = 'u.status = :status';
            $params[':status'] = $filters['status'];
        }

        if (!empty($filters['search'])) {
            $where[] = "(u.email LIKE :search OR u.first_name LIKE :search OR u.last_name LIKE :search)";
            $params[':search'] = '%' . $filters['search'] . '%';
        }

        $whereStr = implode(' AND ', $where);

        // Get total count
        $this->db->query("SELECT COUNT(*) as total FROM users u WHERE $whereStr");
        foreach ($params as $param => $value) {
            $this->db->bind($param, $value);
        }
        $totalResult = $this->db->single();
        $total = $totalResult['total'];

        // Get users
        $this->db->query("SELECT u.*, r.name as role_name
                         FROM users u
                         LEFT JOIN roles r ON u.role_id = r.id
                         WHERE $whereStr
                         ORDER BY u.created_at DESC
                         LIMIT :limit OFFSET :offset");

        foreach ($params as $param => $value) {
            $this->db->bind($param, $value);
        }
        $this->db->bind(':limit', $perPage, PDO::PARAM_INT);
        $this->db->bind(':offset', $offset, PDO::PARAM_INT);

        $users = $this->db->resultSet();

        return [
            'users' => $users,
            'total' => $total,
            'page' => $page,
            'per_page' => $perPage,
            'total_pages' => ceil($total / $perPage)
        ];
    }

    /**
     * Verify password dan return user jika valid
     *
     * @param string $email
     * @param string $password
     * @return array|false User data jika valid, false jika invalid
     */
    public function verifyPassword($email, $password) {
        $user = $this->findByEmail($email);

        if (!$user) {
            return false;
        }

        // Check if account is active
        if ($user['status'] !== 'active') {
            return false;
        }

        // Verify password
        if (!password_verify($password, $user['password'])) {
            return false;
        }

        return $user;
    }

    /**
     * Verify email dengan token
     *
     * @param string $token
     * @return bool
     */
    public function verifyEmail($token) {
        try {
            $this->db->beginTransaction();

            // Verify token
            $result = Mailer::verifyToken($token, 'email_verification');

            if (!$result) {
                $this->db->rollback();
                return false;
            }

            // Update user email_verified_at
            $this->db->query("UPDATE users SET email_verified_at = NOW() WHERE id = :id");
            $this->db->bind(':id', $result['user_id']);
            $this->db->execute();

            // Mark token as used
            Mailer::markTokenAsUsed($token);

            // Send welcome email
            $mailer = new Mailer();
            $mailer->sendWelcomeEmail(
                $result['email'],
                $result['first_name'] . ' ' . $result['last_name']
            );

            $this->db->commit();

            // Log activity
            Session::logActivity($result['user_id'], 'email_verified', 'Email verified');

            return true;

        } catch (Exception $e) {
            $this->db->rollback();
            logError('Email verification failed: ' . $e->getMessage(), ['token' => $token]);
            return false;
        }
    }

    /**
     * Change password
     *
     * @param int $userId
     * @param string $oldPassword
     * @param string $newPassword
     * @return bool
     */
    public function changePassword($userId, $oldPassword, $newPassword) {
        try {
            $user = $this->findById($userId);

            if (!$user) {
                return false;
            }

            // Verify old password
            if (!password_verify($oldPassword, $user['password'])) {
                return false;
            }

            // Update password
            $hashedPassword = password_hash($newPassword, PASSWORD_BCRYPT, ['cost' => BCRYPT_COST]);

            $this->db->query("UPDATE users SET password = :password, updated_at = NOW() WHERE id = :id");
            $this->db->bind(':password', $hashedPassword);
            $this->db->bind(':id', $userId);

            $success = $this->db->execute();

            if ($success) {
                Session::logActivity($userId, 'password_changed', 'Password changed');
            }

            return $success;

        } catch (Exception $e) {
            logError('Password change failed: ' . $e->getMessage(), ['user_id' => $userId]);
            return false;
        }
    }

    /**
     * Reset password dengan token
     *
     * @param string $token
     * @param string $newPassword
     * @return bool
     */
    public function resetPassword($token, $newPassword) {
        try {
            $this->db->beginTransaction();

            // Verify token
            $result = Mailer::verifyToken($token, 'password_reset');

            if (!$result) {
                $this->db->rollback();
                return false;
            }

            // Update password
            $hashedPassword = password_hash($newPassword, PASSWORD_BCRYPT, ['cost' => BCRYPT_COST]);

            $this->db->query("UPDATE users SET password = :password, updated_at = NOW() WHERE id = :id");
            $this->db->bind(':password', $hashedPassword);
            $this->db->bind(':id', $result['user_id']);
            $this->db->execute();

            // Mark token as used
            Mailer::markTokenAsUsed($token);

            $this->db->commit();

            // Log activity
            Session::logActivity($result['user_id'], 'password_reset', 'Password reset via email');

            return true;

        } catch (Exception $e) {
            $this->db->rollback();
            logError('Password reset failed: ' . $e->getMessage(), ['token' => $token]);
            return false;
        }
    }

    /**
     * Update user status
     *
     * @param int $userId
     * @param string $status active, inactive, suspended
     * @return bool
     */
    public function updateStatus($userId, $status) {
        $allowedStatuses = ['active', 'inactive', 'suspended'];

        if (!in_array($status, $allowedStatuses)) {
            return false;
        }

        try {
            $this->db->query("UPDATE users SET status = :status, updated_at = NOW() WHERE id = :id");
            $this->db->bind(':status', $status);
            $this->db->bind(':id', $userId);

            $success = $this->db->execute();

            if ($success) {
                Session::logActivity($userId, 'status_changed', "Status changed to $status");
            }

            return $success;

        } catch (Exception $e) {
            logError('Status update failed: ' . $e->getMessage(), ['user_id' => $userId, 'status' => $status]);
            return false;
        }
    }

    /**
     * Get user statistics
     *
     * @return array
     */
    public function getStatistics() {
        // Total users by role
        $this->db->query("SELECT r.name as role, COUNT(u.id) as count
                         FROM users u
                         LEFT JOIN roles r ON u.role_id = r.id
                         WHERE u.deleted_at IS NULL
                         GROUP BY u.role_id, r.name");
        $byRole = $this->db->resultSet();

        // Total users by status
        $this->db->query("SELECT status, COUNT(*) as count
                         FROM users
                         WHERE deleted_at IS NULL
                         GROUP BY status");
        $byStatus = $this->db->resultSet();

        // New users today
        $this->db->query("SELECT COUNT(*) as count
                         FROM users
                         WHERE DATE(created_at) = CURDATE()
                         AND deleted_at IS NULL");
        $todayResult = $this->db->single();

        // New users this month
        $this->db->query("SELECT COUNT(*) as count
                         FROM users
                         WHERE YEAR(created_at) = YEAR(CURDATE())
                         AND MONTH(created_at) = MONTH(CURDATE())
                         AND deleted_at IS NULL");
        $monthResult = $this->db->single();

        return [
            'by_role' => $byRole,
            'by_status' => $byStatus,
            'new_today' => $todayResult['count'],
            'new_this_month' => $monthResult['count']
        ];
    }
}
