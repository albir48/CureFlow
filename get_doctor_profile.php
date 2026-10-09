<?php
include("config/db.php");
include("../utils/response.php");

$doctor_id = $_GET['doctor_id'];

// Doctor info
$doctor = $conn->query("
    SELECT d.*, u.name 
    FROM doctors d
    JOIN users u ON d.user_id = u.user_id
    WHERE d.doctor_id = $doctor_id
")->fetch_assoc();

// Schedule
$schedule = [];
$result = $conn->query("
    SELECT * FROM doctor_schedules 
    WHERE doctor_id = $doctor_id
");

while ($row = $result->fetch_assoc()) {
    $schedule[] = $row;
}

sendResponse("success", [
    "doctor" => $doctor,
    "schedule" => $schedule
]);
?>
