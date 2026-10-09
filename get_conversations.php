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
$conn->query("CREATE TABLE IF NOT EXISTS ai_conversations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    profile_id INT NOT NULL,
    user_role VARCHAR(20) NOT NULL,
    title VARCHAR(255) DEFAULT 'New Conversation',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)");

$profile_id = $_GET['profile_id'] ?? null;
$role = $_GET['role'] ?? 'patient';

if (!$profile_id) {
    sendResponse("error", "Profile ID is required.");
}

$sql = "SELECT id, title, created_at 
        FROM ai_conversations 
        WHERE profile_id = ? AND user_role = ? 
        ORDER BY created_at DESC";

$stmt = $conn->prepare($sql);
$stmt->bind_param("is", $profile_id, $role);
$stmt->execute();
$res = $stmt->get_result();

$conversations = [];
while ($row = $res->fetch_assoc()) {
    $conversations[] = $row;
}

sendResponse("success", $conversations);
?>
