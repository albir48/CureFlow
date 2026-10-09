<?php
include("config/db.php");

// Check current doctor tau
$res = $conn->query("SELECT doctor_id, current_tau FROM doctors");
echo "=== Doctor Tau Values ===\n";
while ($row = $res->fetch_assoc()) {
    echo "  Doctor #" . $row['doctor_id'] . ": tau = " . $row['current_tau'] . " min\n";
}

// Check for any negative wait times
$res = $conn->query("SELECT token_id, token_number, estimated_wait_time, appointment_date, STATUS FROM tokens WHERE estimated_wait_time < 0");
echo "\n=== Tokens with Negative Wait Times ===\n";
$count = 0;
while ($row = $res->fetch_assoc()) {
    echo "  Token #" . $row['token_number'] . " | Date: " . $row['appointment_date'] . " | Wait: " . $row['estimated_wait_time'] . "m | Status: " . $row['STATUS'] . "\n";
    $count++;
}
echo "Total: $count\n";

// Check today's tokens
$today = date('Y-m-d');
$res = $conn->query("SELECT COUNT(*) as c FROM tokens WHERE appointment_date = '$today'");
$row = $res->fetch_assoc();
echo "\nTokens for today ($today): " . $row['c'] . "\n";
?>
