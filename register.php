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
$name = $data['fullName'] ?? '';
$email = $data['email'] ?? '';
$phone = $data['phone'] ?? '';
$password = $data['password'] ?? '';
$role = 'patient'; // Registering as patient by default

if (empty($name) || empty($email) || empty($password)) {
    sendResponse("error", "Full name, email, and password are required.");
}

// 1. Check if email exists
$stmt = $conn->prepare("SELECT user_id FROM users WHERE email = ?");
$stmt->bind_param("s", $email);
$stmt->execute();
if ($stmt->get_result()->num_rows > 0) {
    sendResponse("error", "An account with this email already exists.");
}

// 2. Create User
$conn->begin_transaction();
try {
    $stmt = $conn->prepare("INSERT INTO users (NAME, email, PASSWORD, role) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("ssss", $name, $email, $password, $role);
    $stmt->execute();
    $user_id = $conn->insert_id;

    // 3. Create Patient Entry
    $stmt = $conn->prepare("INSERT INTO patients (user_id, phone) VALUES (?, ?)");
    $stmt->bind_param("is", $user_id, $phone);
    $stmt->execute();

    $conn->commit();
    sendResponse("success", "Account created successfully.");
} catch (Exception $e) {
    $conn->rollback();
    sendResponse("error", "Registration failed: " . $e->getMessage());
}
?>
