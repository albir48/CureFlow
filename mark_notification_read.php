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
$notification_id = $data['notification_id'] ?? '';

if (empty($notification_id)) {
    sendResponse("error", "Notification ID is required.");
}

$stmt = $conn->prepare("UPDATE notifications SET is_read = 1 WHERE notification_id = ?");
$stmt->bind_param("i", $notification_id);

if ($stmt->execute()) {
    sendResponse("success", "Notification marked as read.");
} else {
    sendResponse("error", "Update failed.");
}
?>
