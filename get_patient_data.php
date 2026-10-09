<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

include("config/db.php");
include("utils/response.php");

$patient_id = $_GET['patient_id'] ?? 1; // Default to 1 for demo

$data = [];

// Get Patient Profile
$sql = "SELECT p.*, u.name, u.email FROM patients p JOIN users u ON p.user_id = u.user_id WHERE p.patient_id = $patient_id";
$res = $conn->query($sql);
$data['profile'] = $res->fetch_assoc();

// Get Appointments with live queue status
$sql = "SELECT t.*, u.name as doctor_name, d.specialization, d.phone as doctor_phone,
               (SELECT token_number FROM tokens WHERE doctor_id = t.doctor_id AND STATUS = 'in_progress' AND appointment_date = CURDATE() LIMIT 1) as live_doctor_token
        FROM tokens t 
        JOIN doctors d ON t.doctor_id = d.doctor_id 
        JOIN users u ON d.user_id = u.user_id 
        WHERE t.patient_id = $patient_id AND (t.hidden_by_patient = 0 OR t.hidden_by_patient IS NULL)
        ORDER BY t.appointment_date DESC";
$res = $conn->query($sql);
$data['appointments'] = [];
while ($row = $res->fetch_assoc()) {
    // Format appointment_time as human-readable
    $appt_time_raw = $row['appointment_time'] ?? null;
    if ($appt_time_raw) {
        $row['estimated_start_label'] = date('g:i A', strtotime($row['appointment_date'] . ' ' . $appt_time_raw));
    } else {
        $row['estimated_start_label'] = null;
    }
    // Format wait in minutes
    $row['wait_minutes'] = (int)($row['estimated_wait_time'] ?? 0);
    $data['appointments'][] = $row;
}

// Get Medical History
$sql = "SELECT m.*, u.name as doctor_name 
        FROM medical_history m 
        JOIN doctors d ON m.doctor_id = d.doctor_id 
        JOIN users u ON d.user_id = u.user_id 
        WHERE m.patient_id = $patient_id 
        ORDER BY m.visit_date DESC";
$res = $conn->query($sql);
$data['medical_history'] = [];
while ($row = $res->fetch_assoc()) {
    $data['medical_history'][] = $row;
}

// Get Medical Reports
$sql = "SELECT * FROM medical_reports WHERE patient_id = $patient_id ORDER BY upload_date DESC";
$res = $conn->query($sql);
$data['medical_reports'] = [];
while ($row = $res->fetch_assoc()) {
    $data['medical_reports'][] = $row;
}

sendResponse("success", $data);
?>
