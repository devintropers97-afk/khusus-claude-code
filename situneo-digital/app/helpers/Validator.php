<?php
/**
 * Validator Helper Class
 * Class untuk validasi input form dan data
 *
 * Menyediakan berbagai rules validasi yang umum digunakan
 */

class Validator {
    /**
     * Array untuk menyimpan error messages
     */
    private $errors = [];

    /**
     * Validate data berdasarkan rules
     *
     * @param array $data Data yang akan divalidasi
     * @param array $rules Rules validasi (format: 'field' => 'rule1|rule2|rule3')
     * @return bool True jika valid, false jika ada error
     */
    public function validate($data, $rules) {
        $this->errors = [];

        foreach ($rules as $field => $ruleSet) {
            $rulesArray = explode('|', $ruleSet);
            $value = isset($data[$field]) ? $data[$field] : null;

            foreach ($rulesArray as $rule) {
                $this->applyRule($field, $value, $rule, $data);
            }
        }

        return empty($this->errors);
    }

    /**
     * Apply single validation rule
     *
     * @param string $field Field name
     * @param mixed $value Field value
     * @param string $rule Validation rule
     * @param array $data All data (untuk rule comparison)
     * @return void
     */
    private function applyRule($field, $value, $rule, $data) {
        // Parse rule dengan parameter (contoh: min:3, max:50)
        $ruleParams = explode(':', $rule);
        $ruleName = $ruleParams[0];
        $ruleValue = isset($ruleParams[1]) ? $ruleParams[1] : null;

        switch ($ruleName) {
            case 'required':
                if (empty($value) && $value !== '0') {
                    $this->addError($field, ucfirst($field) . ' wajib diisi.');
                }
                break;

            case 'email':
                if (!empty($value) && !filter_var($value, FILTER_VALIDATE_EMAIL)) {
                    $this->addError($field, ucfirst($field) . ' harus berupa email yang valid.');
                }
                break;

            case 'min':
                if (!empty($value) && strlen($value) < $ruleValue) {
                    $this->addError($field, ucfirst($field) . " minimal $ruleValue karakter.");
                }
                break;

            case 'max':
                if (!empty($value) && strlen($value) > $ruleValue) {
                    $this->addError($field, ucfirst($field) . " maksimal $ruleValue karakter.");
                }
                break;

            case 'numeric':
                if (!empty($value) && !is_numeric($value)) {
                    $this->addError($field, ucfirst($field) . ' harus berupa angka.');
                }
                break;

            case 'alpha':
                if (!empty($value) && !ctype_alpha($value)) {
                    $this->addError($field, ucfirst($field) . ' hanya boleh berisi huruf.');
                }
                break;

            case 'alphanumeric':
                if (!empty($value) && !ctype_alnum($value)) {
                    $this->addError($field, ucfirst($field) . ' hanya boleh berisi huruf dan angka.');
                }
                break;

            case 'phone':
                if (!empty($value) && !preg_match('/^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,8}$/', $value)) {
                    $this->addError($field, ucfirst($field) . ' harus berupa nomor telepon yang valid.');
                }
                break;

            case 'url':
                if (!empty($value) && !filter_var($value, FILTER_VALIDATE_URL)) {
                    $this->addError($field, ucfirst($field) . ' harus berupa URL yang valid.');
                }
                break;

            case 'confirmed':
                // Field harus sama dengan field_confirmation
                $confirmField = $field . '_confirmation';
                if (!empty($value) && (!isset($data[$confirmField]) || $value !== $data[$confirmField])) {
                    $this->addError($field, ucfirst($field) . ' tidak cocok dengan konfirmasi.');
                }
                break;

            case 'unique':
                // Format: unique:table,column
                if (!empty($value) && $ruleValue) {
                    $params = explode(',', $ruleValue);
                    $table = $params[0];
                    $column = isset($params[1]) ? $params[1] : $field;
                    $excludeId = isset($params[2]) ? $params[2] : null;

                    if ($this->checkUnique($value, $table, $column, $excludeId)) {
                        $this->addError($field, ucfirst($field) . ' sudah digunakan.');
                    }
                }
                break;

            case 'exists':
                // Format: exists:table,column
                if (!empty($value) && $ruleValue) {
                    $params = explode(',', $ruleValue);
                    $table = $params[0];
                    $column = isset($params[1]) ? $params[1] : 'id';

                    if (!$this->checkExists($value, $table, $column)) {
                        $this->addError($field, ucfirst($field) . ' tidak ditemukan.');
                    }
                }
                break;

            case 'in':
                // Format: in:value1,value2,value3
                if (!empty($value) && $ruleValue) {
                    $allowedValues = explode(',', $ruleValue);
                    if (!in_array($value, $allowedValues)) {
                        $this->addError($field, ucfirst($field) . ' tidak valid.');
                    }
                }
                break;

            case 'date':
                if (!empty($value) && !strtotime($value)) {
                    $this->addError($field, ucfirst($field) . ' harus berupa tanggal yang valid.');
                }
                break;

            case 'image':
                if (!empty($value) && is_array($value) && isset($value['tmp_name'])) {
                    $allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
                    $fileType = mime_content_type($value['tmp_name']);
                    if (!in_array($fileType, $allowedTypes)) {
                        $this->addError($field, ucfirst($field) . ' harus berupa gambar (JPEG, PNG, GIF).');
                    }
                }
                break;
        }
    }

    /**
     * Check apakah value unique di database
     *
     * @param mixed $value
     * @param string $table
     * @param string $column
     * @param int|null $excludeId ID yang dikecualikan (untuk update)
     * @return bool True jika sudah ada (tidak unique)
     */
    private function checkUnique($value, $table, $column, $excludeId = null) {
        $db = Database::getInstance();

        if ($excludeId) {
            $db->query("SELECT COUNT(*) as count FROM $table WHERE $column = :value AND id != :id");
            $db->bind(':value', $value);
            $db->bind(':id', $excludeId);
        } else {
            $db->query("SELECT COUNT(*) as count FROM $table WHERE $column = :value");
            $db->bind(':value', $value);
        }

        $result = $db->single();
        return $result['count'] > 0;
    }

    /**
     * Check apakah value exists di database
     *
     * @param mixed $value
     * @param string $table
     * @param string $column
     * @return bool True jika exists
     */
    private function checkExists($value, $table, $column) {
        $db = Database::getInstance();
        $db->query("SELECT COUNT(*) as count FROM $table WHERE $column = :value");
        $db->bind(':value', $value);
        $result = $db->single();
        return $result['count'] > 0;
    }

    /**
     * Add error message
     *
     * @param string $field
     * @param string $message
     * @return void
     */
    private function addError($field, $message) {
        if (!isset($this->errors[$field])) {
            $this->errors[$field] = [];
        }
        $this->errors[$field][] = $message;
    }

    /**
     * Get all errors
     *
     * @return array
     */
    public function getErrors() {
        return $this->errors;
    }

    /**
     * Get first error (untuk flash message)
     *
     * @return string|null
     */
    public function firstError() {
        if (empty($this->errors)) {
            return null;
        }

        $firstField = array_key_first($this->errors);
        return $this->errors[$firstField][0];
    }

    /**
     * Sanitize input string
     *
     * @param string $input
     * @return string
     */
    public static function sanitize($input) {
        return htmlspecialchars(strip_tags(trim($input)), ENT_QUOTES, 'UTF-8');
    }

    /**
     * Sanitize array of inputs
     *
     * @param array $inputs
     * @return array
     */
    public static function sanitizeArray($inputs) {
        $sanitized = [];
        foreach ($inputs as $key => $value) {
            if (is_array($value)) {
                $sanitized[$key] = self::sanitizeArray($value);
            } else {
                $sanitized[$key] = self::sanitize($value);
            }
        }
        return $sanitized;
    }
}
