<?php
include("config/db.php");
include("../utils/response.php");

$data = json_decode(file_get_contents("php://input"), true);

$token_id = $data['token_id'];

// Get token info
$token = $conn->query("
    SELECT t.*, d.consultation_fee, t.patient_id
    FROM tokens t
    JOIN doctors d ON t.doctor_id = d.doctor_id
    WHERE t.token_id = $token_id
")->fetch_assoc();

$amount = $token['consultation_fee'];

// Create payment record
$conn->query("
INSERT INTO payments (token_id, patient_id, amount, payment_status, payment_gateway)
VALUES ($token_id, {$token['patient_id']}, $amount, 'pending', 'bkash')
");

$payment_id = $conn->insert_id;

// 🔥 Return fake payment URL (for now)
sendResponse("success", [
    "payment_id" => $payment_id,
    "amount" => $amount,
    "payment_url" => "http://localhost/fake-payment-success?token_id=$token_id"
]);
?>
