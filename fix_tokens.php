<?php
include("config/db.php");

// Get all doctors
$docs = $conn->query("SELECT doctor_id FROM doctors");
$count = 0;

while ($doc = $docs->fetch_assoc()) {
    $doc_id = $doc['doctor_id'];
    
    // Get all dates for this doctor
    $dates = $conn->query("SELECT DISTINCT appointment_date FROM tokens WHERE doctor_id = $doc_id");
    
    while ($date_row = $dates->fetch_assoc()) {
        $date = $date_row['appointment_date'];
        
        // Get all tokens for this doctor on this date, ordered by created_at
        $tokens = $conn->query("SELECT token_id FROM tokens WHERE doctor_id = $doc_id AND appointment_date = '$date' ORDER BY created_at ASC");
        
        $n = 1;
        while ($t = $tokens->fetch_assoc()) {
            $t_id = $t['token_id'];
            $conn->query("UPDATE tokens SET token_number = $n WHERE token_id = $t_id");
            $n++;
            $count++;
        }
    }
}

echo "Fixed $count tokens to be sequential (1..N).";
?>
