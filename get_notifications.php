<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

include("config/db.php");
include("utils/response.php");

$patient_id = $_GET['patient_id'] ?? '';

if (empty($patient_id)) {
    sendResponse("error", "Patient ID is required.");
}

// Fetch notifications, most recent first
$sql = "SELECT notification_id, message, notification_time, status, type, is_read 
        FROM notifications 
        WHERE patient_id = ? 
        ORDER BY notification_time DESC";

$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $patient_id);
$stmt->execute();
$result = $stmt->get_result();
$notifications = [];

while ($row = $result->fetch_assoc()) {
    $notifications[] = [
        "id" => (int)$row['notification_id'],
        "message" => $row['message'],
        "time" => $row['notification_time'],
        "status" => $row['status'],
        "type" => $row['type'],
        "is_read" => (bool)$row['is_read']
    ];
}

sendResponse("success", $notifications);
?>
