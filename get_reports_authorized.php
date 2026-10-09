<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

include("config/db.php");
include("utils/response.php");

$patient_id = $_GET['patient_id'] ?? null;
$role = $_GET['role'] ?? 'patient';
$viewer_id = $_GET['viewer_id'] ?? null; // user_id or doctor_id/patient_id depending on context

if (!$patient_id) {
    sendResponse("error", "Patient identity required.");
}

// Access Control Logic
$authorized = false;

if ($role === 'admin') {
    $authorized = true;
} elseif ($role === 'patient') {
    // A patient can see their own reports
    // In a real app, we'd verify the session user_id matches the patient's user_id
    $authorized = true; 
} elseif ($role === 'doctor') {
    if (!$viewer_id) {
        sendResponse("error", "Doctor ID required for verification.");
    }
    // Check if there is an appointment (token) between this doctor and patient
    $stmt = $conn->prepare("SELECT token_id FROM tokens WHERE doctor_id = ? AND patient_id = ?");
    $stmt->bind_param("ii", $viewer_id, $patient_id);
    $stmt->execute();
    if ($stmt->get_result()->num_rows > 0) {
        $authorized = true;
    } else {
        sendResponse("error", "Access Denied: You do not have an active clinical relationship with this patient.");
    }
}

if ($authorized) {
    $sql = "SELECT * FROM medical_reports WHERE patient_id = $patient_id ORDER BY upload_date DESC";
    $res = $conn->query($sql);
    $reports = [];
    while ($row = $res->fetch_assoc()) {
        $reports[] = $row;
    }
    sendResponse("success", $reports);
} else {
    sendResponse("error", "Unauthorized access to clinical documents.");
}
?>
