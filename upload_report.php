<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

include("config/db.php");
include("utils/response.php");

// 1. Check if file exists
if (!isset($_FILES['report']) || $_FILES['report']['error'] !== UPLOAD_ERR_OK) {
    sendResponse("error", "No file uploaded or upload error. Error code: " . ($_FILES['report']['error'] ?? 'None'));
}

$patient_id = $_POST['patient_id'] ?? null;
$doctor_id = $_POST['doctor_id'] ?? null;
$report_type = $_POST['report_type'] ?? 'General Report';

if (!$patient_id) {
    sendResponse("error", "Patient ID is required.");
}

// 2. Setup directory
$upload_dir = "uploads/";
if (!is_dir($upload_dir)) {
    if (!mkdir($upload_dir, 0777, true)) {
        sendResponse("error", "Server Error: Could not create 'uploads' directory. Check folder permissions.");
    }
}

if (!is_writable($upload_dir)) {
    sendResponse("error", "Server Error: 'uploads' directory is not writable. Check folder permissions.");
}

// 3. Security: Check file extension
$file_name = basename($_FILES['report']['name']);
$file_ext = strtolower(pathinfo($file_name, PATHINFO_EXTENSION));

if ($file_ext !== 'pdf') {
    sendResponse("error", "Only PDF files are allowed.");
}

// 4. Generate unique filename
$new_file_name = "report_" . time() . "_" . uniqid() . ".pdf";
$target_path = $upload_dir . $new_file_name;

if (move_uploaded_file($_FILES['report']['tmp_name'], $target_path)) {
    // 5. Insert into Database
    $stmt = $conn->prepare("INSERT INTO medical_reports (patient_id, doctor_id, report_type, file_path) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("iiss", $patient_id, $doctor_id, $report_type, $target_path);
    
    if ($stmt->execute()) {
        sendResponse("success", ["message" => "Report uploaded successfully", "path" => $target_path]);
    } else {
        @unlink($target_path); // Cleanup file if DB insert fails
        sendResponse("error", "Database error: " . $stmt->error);
    }
} else {
    sendResponse("error", "Failed to move uploaded file.");
}
?>
