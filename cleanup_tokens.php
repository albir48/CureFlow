<?php
include("config/db.php");

// Delete tokens with serial 100+
$conn->query("DELETE FROM payments WHERE token_id IN (SELECT token_id FROM tokens WHERE token_number >= 100)");
$conn->query("DELETE FROM notifications WHERE token_id IN (SELECT token_id FROM tokens WHERE token_number >= 100)");
$conn->query("DELETE FROM tokens WHERE token_number >= 100");
echo "Deleted tokens with serial 100+: " . $conn->affected_rows . "\n";
?>
