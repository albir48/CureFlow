<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

include("config/db.php");
include("utils/response.php");

$sql = "SELECT p.patient_id, u.NAME as name, u.email, p.phone, p.dob, p.gender, p.address, 
        u.created_at as registered, 'Active' as status
        FROM patients p
        JOIN users u ON p.user_id = u.user_id";

$res = $conn->query($sql);
$patients = [];

while ($row = $res->fetch_assoc()) {
    $patients[] = $row;
}

sendResponse("success", $patients);
?>
