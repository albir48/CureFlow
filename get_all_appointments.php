<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type");

include("config/db.php");
include("utils/response.php");

$sql = "SELECT 
            t.token_id, 
            t.token_number, 
            t.appointment_date, 
            t.appointment_time, 
            t.STATUS,
            t.estimated_wait_time,
            t.predicted_duration,
            t.actual_duration,
            t.started_at,
            t.completed_at,
            p_u.NAME as patient_name, 
            d_u.NAME as doctor_name
        FROM tokens t
        JOIN patients p ON t.patient_id = p.patient_id
        JOIN users p_u ON p.user_id = p_u.user_id
        JOIN doctors d ON t.doctor_id = d.doctor_id
        JOIN users d_u ON d.user_id = d_u.user_id
        ORDER BY t.appointment_date DESC, t.appointment_time DESC";

$result = $conn->query($sql);
$appointments = [];

while ($row = $result->fetch_assoc()) {
    $appointments[] = $row;
}

sendResponse("success", $appointments);
?>
