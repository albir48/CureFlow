<?php
include("config/db.php");

// 1. Add lab_tests to medical_history
$conn->query("ALTER TABLE medical_history ADD COLUMN IF NOT EXISTS lab_tests TEXT NULL");

// 2. Create partner_orders table
$sql = "CREATE TABLE IF NOT EXISTS partner_orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    token_id INT NOT NULL,
    partner_name VARCHAR(100),
    order_type ENUM('pharmacy', 'lab'),
    details TEXT,
    status ENUM('pending', 'processing', 'out_for_delivery', 'completed', 'cancelled') DEFAULT 'pending',
    amount DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)";
$conn->query($sql);

echo "Database updated successfully.\n";
?>
