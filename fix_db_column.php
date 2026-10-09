<?php
include("config/db.php");
$conn->query("ALTER TABLE medical_reports ADD COLUMN IF NOT EXISTS doctor_id INT NULL AFTER patient_id");
echo "Added doctor_id to medical_reports table";
?>
