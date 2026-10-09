<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

include("config/db.php");
include("utils/response.php");

$data = json_decode(file_get_contents("php://input"), true);
$email = $data['email'] ?? '';
$password = $data['password'] ?? '';
$role = $data['role'] ?? '';

if (empty($email) || empty($password) || empty($role)) {
    sendResponse("error", "Email, password, and role are required.");
}

// 1. Check user credentials
$stmt = $conn->prepare("SELECT user_id, NAME, email, role FROM users WHERE email = ? AND PASSWORD = ? AND role = ?");
$stmt->bind_param("sss", $email, $password, $role);
$stmt->execute();
$result = $stmt->get_result();
$user = $result->fetch_assoc();

if (!$user) {
    sendResponse("error", "Invalid credentials or role mismatch.");
}

$user_id = $user['user_id'];
$response_data = [
    "user_id" => $user_id,
    "name" => $user['NAME'],
    "email" => $user['email'],
    "role" => $user['role']
];

// 2. Fetch role-specific ID
if ($role === 'patient') {
    $res = $conn->query("SELECT patient_id FROM patients WHERE user_id = $user_id");
    $row = $res->fetch_assoc();
    $response_data['patient_id'] = $row['patient_id'] ?? null;
} elseif ($role === 'doctor') {
    $res = $conn->query("SELECT doctor_id FROM doctors WHERE user_id = $user_id");
    $row = $res->fetch_assoc();
    $response_data['doctor_id'] = $row['doctor_id'] ?? null;
} elseif ($role === 'admin') {
    $res = $conn->query("SELECT admin_id FROM admins WHERE user_id = $user_id");
    $row = $res->fetch_assoc();
    $response_data['admin_id'] = $row['admin_id'] ?? null;
}

sendResponse("success", $response_data);
?>
