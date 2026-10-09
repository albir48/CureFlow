<?php
include("config/db.php");
include("utils/response.php");

$data = json_decode(file_get_contents("php://input"), true);
$token_id = $data['token_id'] ?? null;
$amount = $data['amount'] ?? 500;

if (!$token_id) {
    sendResponse("error", "Invalid Token ID");
}

// 1. Get patient_id from the token
$stmt = $conn->prepare("SELECT patient_id FROM tokens WHERE token_id = ?");
$stmt->bind_param("i", $token_id);
$stmt->execute();
$token_data = $stmt->get_result()->fetch_assoc();
$patient_id = $token_data['patient_id'] ?? null;

// 2. Check if payment already exists
$stmt = $conn->prepare("SELECT payment_id FROM payments WHERE token_id = ?");
$stmt->bind_param("i", $token_id);
$stmt->execute();
$existing = $stmt->get_result()->fetch_assoc();

if ($existing) {
    $payment_id = $existing['payment_id'];
} else {
    $stmt = $conn->prepare("INSERT INTO payments (token_id, patient_id, amount, payment_status, method, payment_gateway) VALUES (?, ?, ?, 'pending', 'bKash', 'bkash')");
    $stmt->bind_param("iid", $token_id, $patient_id, $amount);
    $stmt->execute();
    $payment_id = $conn->insert_id;
}

// Detect if we are running through the Vite proxy (localhost:5173) or directly
$is_dev = (strpos($_SERVER['HTTP_REFERER'] ?? '', ':5173') !== false);
$redirect_path = $is_dev ? "/api/simulate_bkash.php" : "simulate_bkash.php";

// SIMULATION MODE: Redirect to our fake bKash page
sendResponse("success", [
    "bkashURL" => $redirect_path . "?token_id=$token_id&amount=$amount"
]);
?>
