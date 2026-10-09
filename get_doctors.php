<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

include("config/db.php");
include("utils/response.php");

$sql = "SELECT d.doctor_id, u.NAME as name, d.specialization, d.phone, dep.NAME as department_name, 
        u.email, 'Active' as status, '10+ yrs' as experience
        FROM doctors d 
        JOIN users u ON d.user_id = u.user_id
        LEFT JOIN departments dep ON d.department_id = dep.department_id";

$res = $conn->query($sql);
$doctors = [];

while ($row = $res->fetch_assoc()) {
    $doctors[] = $row;
}

sendResponse("success", $doctors);
?>
