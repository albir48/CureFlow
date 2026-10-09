<?php
include("config/db.php");
$conn->query("UPDATE doctors SET current_tau = 5.0");
$conn->query("UPDATE tokens SET estimated_wait_time = 0 WHERE estimated_wait_time < 0");
echo "Reset tau and negative wait times.";
?>
