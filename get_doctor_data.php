<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

include("config/db.php");
include("utils/response.php");

$doctor_id = $_GET['doctor_id'] ?? 1; // Default to 1 for demo

$data = [];

// Get Doctor Profile
$sql = "SELECT d.*, u.name, u.email,
               (SELECT token_number FROM tokens WHERE doctor_id = d.doctor_id AND STATUS = 'in_progress' AND appointment_date = CURDATE() LIMIT 1) as current_live_token
        FROM doctors d 
        JOIN users u ON d.user_id = u.user_id 
        WHERE d.doctor_id = $doctor_id";
$res = $conn->query($sql);
$data['profile'] = $res->fetch_assoc();

// Get Appointments
$sql = "SELECT t.*, u.name as patient_name, p.phone as patient_phone 
        FROM tokens t 
        JOIN patients p ON t.patient_id = p.patient_id 
        JOIN users u ON p.user_id = u.user_id 
        WHERE t.doctor_id = $doctor_id AND (t.hidden_by_doctor = 0 OR t.hidden_by_doctor IS NULL)
        ORDER BY t.appointment_date DESC, t.token_number ASC";
$res = $conn->query($sql);
$data['appointments'] = [];
while ($row = $res->fetch_assoc()) {
    $data['appointments'][] = $row;
}

// Get Patients list
$sql = "SELECT DISTINCT p.*, u.name, u.email 
        FROM patients p 
        JOIN users u ON p.user_id = u.user_id 
        JOIN tokens t ON p.patient_id = t.patient_id 
        WHERE t.doctor_id = $doctor_id";
$res = $conn->query($sql);
$data['patients'] = [];
while ($row = $res->fetch_assoc()) {
    $data['patients'][] = $row;
}

// Get Reports uploaded by this doctor
$sql = "SELECT r.*, u.name as patient_name 
        FROM medical_reports r 
        JOIN patients p ON r.patient_id = p.patient_id 
        JOIN users u ON p.user_id = u.user_id 
        WHERE r.doctor_id = $doctor_id 
        ORDER BY r.upload_date DESC";
$res = $conn->query($sql);
$data['doctor_reports'] = [];
while ($row = $res->fetch_assoc()) {
    $data['doctor_reports'][] = $row;
}

sendResponse("success", $data);
?>
