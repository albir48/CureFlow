<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

include("config/db.php");
include("utils/response.php");

// Get counts for dashboard
$stats = [];

// Total Users
$res = $conn->query("SELECT COUNT(*) as total FROM users");
$stats['total_users'] = $res->fetch_assoc()['total'];

// Total Doctors
$res = $conn->query("SELECT COUNT(*) as total FROM doctors");
$stats['total_doctors'] = $res->fetch_assoc()['total'];

// Total Patients
$res = $conn->query("SELECT COUNT(*) as total FROM patients");
$stats['total_patients'] = $res->fetch_assoc()['total'];

// Total Appointments (Tokens)
$res = $conn->query("SELECT COUNT(*) as total FROM tokens");
$stats['total_appointments'] = $res->fetch_assoc()['total'];

// Pending Appointments
$res = $conn->query("SELECT COUNT(*) as total FROM tokens WHERE status = 'pending_payment' OR status = 'confirmed'");
$stats['pending_appointments'] = $res->fetch_assoc()['total'];

// Completed Appointments
$res = $conn->query("SELECT COUNT(*) as total FROM tokens WHERE status = 'completed'");
$stats['completed_appointments'] = $res->fetch_assoc()['total'];

// Live Queues (Current tokens for all active doctors)
$sql = "SELECT 
            u.NAME as name, 
            d.specialization,
            d.doctor_id,
            (SELECT token_number FROM tokens WHERE doctor_id = d.doctor_id AND STATUS = 'in_progress' AND appointment_date = CURDATE() LIMIT 1) as current_token
        FROM doctors d
        JOIN users u ON d.user_id = u.user_id";
$res = $conn->query($sql);
$stats['live_queues'] = [];
while ($row = $res->fetch_assoc()) {
    $stats['live_queues'][] = $row;
}

sendResponse("success", $stats);
?>
