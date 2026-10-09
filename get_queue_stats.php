<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type");

include("config/db.php");
include("utils/response.php");

$sql = "SELECT 
            d.doctor_id, 
            u.NAME as doctor_name, 
            d.specialization,
            d.current_tau,
            (SELECT COUNT(*) FROM tokens WHERE doctor_id = d.doctor_id AND STATUS IN ('confirmed', 'in_queue', 'in_progress') AND appointment_date = CURDATE()) as queue_count,
            (SELECT token_number FROM tokens WHERE doctor_id = d.doctor_id AND STATUS = 'in_progress' AND appointment_date = CURDATE() LIMIT 1) as current_token
        FROM doctors d
        JOIN users u ON d.user_id = u.user_id";

$result = $conn->query($sql);
$stats = [];

while ($row = $result->fetch_assoc()) {
    $stats[] = [
        "doctor_id" => (int)$row['doctor_id'],
        "name" => $row['doctor_name'],
        "specialization" => $row['specialization'],
        "avg_duration" => round($row['current_tau'], 1),
        "queue_count" => (int)$row['queue_count'],
        "current_token" => $row['current_token'] ? (int)$row['current_token'] : null
    ];
}

sendResponse("success", $stats);
?>
