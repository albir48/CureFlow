<?php
/**
 * Seed Queue Test Data
 * Creates test appointments to verify AI queue prediction:
 * - Test doctor (doctor_id=1) gets 5+ patients per slot
 * - Test patient (patient_id=1) gets 3+ appointments across slots
 * 
 * Run: php seed_queue_test.php
 */
include("config/db.php");

// Ensure columns exist
$conn->query("ALTER TABLE tokens MODIFY COLUMN STATUS enum('pending_payment','confirmed','in_queue','in_progress','completed','cancelled') DEFAULT 'pending_payment'");

$today = date('Y-m-d');

// Get first doctor
$doc_res = $conn->query("SELECT doctor_id FROM doctors LIMIT 1");
$doctor = $doc_res->fetch_assoc();
if (!$doctor) { die("No doctors found. Seed doctors first.\n"); }
$doctor_id = $doctor['doctor_id'];

// Get doctor's current prediction tau
$tau_res = $conn->query("SELECT current_tau FROM doctors WHERE doctor_id = $doctor_id");
$tau_row = $tau_res->fetch_assoc();
$current_tau = 5.0; // Always start from baseline for clean test

// Reset doctor's tau to baseline
$conn->query("UPDATE doctors SET current_tau = 5.0 WHERE doctor_id = $doctor_id");

// Get all patients
$pat_res = $conn->query("SELECT patient_id FROM patients LIMIT 10");
$patients = [];
while ($p = $pat_res->fetch_assoc()) {
    $patients[] = $p['patient_id'];
}

if (count($patients) < 2) { die("Need at least 2 patients. Seed patients first.\n"); }

// Clear today's test tokens for this doctor to avoid duplicates
$conn->query("DELETE FROM payments WHERE token_id IN (SELECT token_id FROM tokens WHERE doctor_id = $doctor_id AND appointment_date = '$today')");
$conn->query("DELETE FROM notifications WHERE token_id IN (SELECT token_id FROM tokens WHERE doctor_id = $doctor_id AND appointment_date = '$today')");
$conn->query("DELETE FROM tokens WHERE doctor_id = $doctor_id AND appointment_date = '$today'");

echo "Cleared existing today's tokens for doctor #$doctor_id\n";
echo "Doctor's current prediction (tau): {$current_tau} minutes\n\n";

$slots = [
    ['time' => '09:00:00', 'label' => 'Morning'],
    ['time' => '13:00:00', 'label' => 'Afternoon'],
    ['time' => '17:00:00', 'label' => 'Evening'],
];

$token_counter = 0;
$test_patient_id = $patients[0]; // First patient gets 3+ bookings

foreach ($slots as $slot) {
    $base_time = $slot['time'];
    $label = $slot['label'];
    echo "--- $label Slot ($base_time) ---\n";

    // 6 patients per slot
    $num_patients = 6;
    for ($i = 0; $i < $num_patients; $i++) {
        $token_counter++;
        
        // Alternate patients, but always include test patient (first 1 per slot)
        if ($i < 1) {
            $pid = $test_patient_id;
        } else {
            $pid = $patients[$i % count($patients)];
        }

        // Calculate cumulative wait for this position
        $wait_mins = round($i * $current_tau, 1);
        $appt_timestamp = strtotime($today . ' ' . $base_time) + intval($wait_mins * 60);
        $actual_appt_time = date('H:i:s', $appt_timestamp);

        // Set status: first 2 completed (with actual durations), next 1 in_progress, rest confirmed
        if ($i < 2) {
            $status = 'completed';
            // Simulate varying actual durations to test AI prediction
            $actual_durations = [3.2, 7.8, 4.5, 6.1, 2.9, 8.3];
            $actual_dur = $actual_durations[$i % count($actual_durations)];
            $started = date('Y-m-d H:i:s', $appt_timestamp);
            $completed = date('Y-m-d H:i:s', $appt_timestamp + ($actual_dur * 60));
        } elseif ($i == 2) {
            $status = 'in_progress';
            $actual_dur = null;
            $started = date('Y-m-d H:i:s');
            $completed = null;
        } else {
            $status = 'confirmed';
            $actual_dur = null;
            $started = null;
            $completed = null;
        }

        $started_sql = $started ? "'$started'" : "NULL";
        $completed_sql = $completed ? "'$completed'" : "NULL";
        $actual_dur_sql = $actual_dur !== null ? $actual_dur : "NULL";

        $sql = "INSERT INTO tokens (patient_id, doctor_id, token_number, appointment_date, appointment_time, STATUS, predicted_duration, estimated_wait_time, started_at, completed_at, actual_duration) 
                VALUES ($pid, $doctor_id, $token_counter, '$today', '$actual_appt_time', '$status', $current_tau, $wait_mins, $started_sql, $completed_sql, $actual_dur_sql)";
        
        if ($conn->query($sql)) {
            $est_time = date('g:i A', $appt_timestamp);
            echo "  Token #$token_counter | Patient #$pid | Status: $status | Est: $est_time | Wait: {$wait_mins}m";
            if ($actual_dur !== null) echo " | Actual: {$actual_dur}m";
            echo "\n";
        } else {
            echo "  ERROR: " . $conn->error . "\n";
        }
    }
    echo "\n";
}

// Now simulate the AI prediction feedback from completed appointments
echo "=== AI Prediction Feedback Simulation ===\n";
echo "Before: Doctor tau = $current_tau min\n";

$completed = $conn->query("SELECT actual_duration, predicted_duration FROM tokens WHERE doctor_id = $doctor_id AND appointment_date = '$today' AND STATUS = 'completed' ORDER BY token_number ASC");
$alpha = 0.5;
$tau = $current_tau;

while ($row = $completed->fetch_assoc()) {
    $actual = $row['actual_duration'];
    $predicted = $row['predicted_duration'];
    $new_tau = ($alpha * $actual) + ((1 - $alpha) * $tau);
    echo "  Actual: {$actual}m | Old tau: " . round($tau, 2) . "m | New tau: " . round($new_tau, 2) . "m\n";
    $tau = $new_tau;
}

// Update doctor's tau with the simulated feedback
$conn->query("UPDATE doctors SET current_tau = $tau WHERE doctor_id = $doctor_id");
echo "After: Doctor tau = " . round($tau, 2) . " min (AI-adjusted!)\n\n";

echo "✅ Seeded $token_counter tokens across " . count($slots) . " slots.\n";
echo "✅ Test patient #$test_patient_id has 3 appointments (1 per slot).\n";
echo "✅ Doctor #$doctor_id has 6 patients per slot.\n";
echo "✅ AI prediction tau updated from $current_tau to " . round($tau, 2) . " based on completed sessions.\n";
echo "\nTo test AI prediction:\n";
echo "1. Login as doctor, set a patient to 'In Progress'\n";
echo "2. Wait some time (e.g. 30 seconds to 2 minutes)\n";
echo "3. Set that patient to 'Completed'\n";
echo "4. The actual_duration is measured and tau recalculates!\n";
echo "5. Book a NEW appointment - the wait time will reflect the learned duration.\n";
?>
