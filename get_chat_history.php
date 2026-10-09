<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

include("config/db.php");
include("utils/response.php");

// 🛠️ Self-Healing Migration (Quiet check)
$check = $conn->query("SHOW COLUMNS FROM ai_chatbot_logs LIKE 'conversation_id'");
if ($check && $check->num_rows == 0) {
    $conn->query("ALTER TABLE ai_chatbot_logs ADD COLUMN conversation_id INT AFTER chat_id");
}

$profile_id = $_GET['profile_id'] ?? null;
$role = $_GET['role'] ?? 'patient';
$conversation_id = $_GET['conversation_id'] ?? null;

if (!$profile_id) {
    sendResponse("error", "Profile ID is required.");
}

if (!$conversation_id) {
    sendResponse("success", []); // Return empty if no conversation selected
    exit;
}

$sql = "SELECT symptoms as user_text, ai_response, timestamps 
        FROM ai_chatbot_logs 
        WHERE patient_id = ? AND user_role = ? AND conversation_id = ?
        ORDER BY timestamps ASC";

$stmt = $conn->prepare($sql);
$stmt->bind_param("isi", $profile_id, $role, $conversation_id);
$stmt->execute();
$res = $stmt->get_result();

$history = [];
while ($row = $res->fetch_assoc()) {
    $history[] = [
        "user" => $row['user_text'],
        "ai" => $row['ai_response'],
        "time" => $row['timestamps']
    ];
}

sendResponse("success", $history);
?>
