<?php
/**
 * Database Helper Class
 * Menggunakan PDO dengan pattern Singleton
 *
 * Class ini menyediakan koneksi database yang aman dan efisien
 * dengan prepared statements untuk mencegah SQL Injection
 */

class Database {
    /**
     * Instance singleton dari Database
     */
    private static $instance = null;

    /**
     * PDO connection object
     */
    private $pdo;

    /**
     * PDO statement object
     */
    private $stmt;

    /**
     * Constructor (private untuk singleton pattern)
     */
    private function __construct() {
        try {
            // Data Source Name
            $dsn = DB_CONNECTION . ':host=' . DB_HOST . ';port=' . DB_PORT . ';dbname=' . DB_DATABASE . ';charset=utf8mb4';

            // PDO Options
            $options = [
                PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES   => false,
                PDO::ATTR_PERSISTENT         => true,
            ];

            // Create PDO instance
            $this->pdo = new PDO($dsn, DB_USERNAME, DB_PASSWORD, $options);

        } catch (PDOException $e) {
            // Log error
            logError('Database connection failed: ' . $e->getMessage());

            // Tampilkan error jika dalam mode debug
            if (APP_DEBUG) {
                die('Database Connection Error: ' . $e->getMessage());
            } else {
                die('Terjadi kesalahan koneksi database. Silakan hubungi administrator.');
            }
        }
    }

    /**
     * Get singleton instance
     *
     * @return Database
     */
    public static function getInstance() {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    /**
     * Prepare SQL query
     *
     * @param string $sql
     * @return void
     */
    public function query($sql) {
        $this->stmt = $this->pdo->prepare($sql);
    }

    /**
     * Bind value ke prepared statement
     *
     * @param string|int $param Parameter placeholder
     * @param mixed $value Nilai yang akan di-bind
     * @param int|null $type PDO parameter type
     * @return void
     */
    public function bind($param, $value, $type = null) {
        // Auto-detect type jika tidak dispesifikkan
        if (is_null($type)) {
            switch (true) {
                case is_int($value):
                    $type = PDO::PARAM_INT;
                    break;
                case is_bool($value):
                    $type = PDO::PARAM_BOOL;
                    break;
                case is_null($value):
                    $type = PDO::PARAM_NULL;
                    break;
                default:
                    $type = PDO::PARAM_STR;
            }
        }

        $this->stmt->bindValue($param, $value, $type);
    }

    /**
     * Execute prepared statement
     *
     * @return bool
     */
    public function execute() {
        try {
            return $this->stmt->execute();
        } catch (PDOException $e) {
            logError('Query execution failed: ' . $e->getMessage(), [
                'query' => $this->stmt->queryString
            ]);

            if (APP_DEBUG) {
                throw $e;
            }
            return false;
        }
    }

    /**
     * Get multiple rows (array of objects)
     *
     * @return array
     */
    public function resultSet() {
        $this->execute();
        return $this->stmt->fetchAll();
    }

    /**
     * Get single row (object)
     *
     * @return array|false
     */
    public function single() {
        $this->execute();
        return $this->stmt->fetch();
    }

    /**
     * Get row count
     *
     * @return int
     */
    public function rowCount() {
        return $this->stmt->rowCount();
    }

    /**
     * Get last inserted ID
     *
     * @return string
     */
    public function lastInsertId() {
        return $this->pdo->lastInsertId();
    }

    /**
     * Begin transaction
     *
     * @return bool
     */
    public function beginTransaction() {
        return $this->pdo->beginTransaction();
    }

    /**
     * Commit transaction
     *
     * @return bool
     */
    public function commit() {
        return $this->pdo->commit();
    }

    /**
     * Rollback transaction
     *
     * @return bool
     */
    public function rollback() {
        return $this->pdo->rollback();
    }

    /**
     * Get PDO object (untuk advanced usage)
     *
     * @return PDO
     */
    public function getPdo() {
        return $this->pdo;
    }

    /**
     * Prevent cloning of singleton
     */
    private function __clone() {}

    /**
     * Prevent unserialization of singleton
     */
    public function __wakeup() {
        throw new Exception("Cannot unserialize singleton");
    }
}
