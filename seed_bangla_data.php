<?php
include("config/db.php");

echo "<h1>CureFlow Bangladeshi Data Seeder</h1>";
echo "<p>Initializing population of Bangladeshi demonstration dataset...</p>";

// --- CONFIGURATION ---
$DEPARTMENTS = ["Cardiology", "Neurology", "Pediatrics", "Orthopedics", "General Medicine", "Dermatology"];
$FIRST_NAMES = ["Ariful", "Nusrat", "Fahim", "Sumaiya", "Tanvir", "Ishrat", "Sabbir", "Meher", "Riyad", "Anika", "Zubair", "Tasnim", "Kamrul", "Sadia", "Mahmud", "Farhana", "Shafik", "Nabila", "Asif", "Lamia"];
$LAST_NAMES = ["Islam", "Jahan", "Shakur", "Akter", "Hossain", "Begum", "Ahmed", "Sultana", "Rahman", "Khan", "Chowdhury", "Majumder", "Bhuiyan", "Talukder", "Miah", "Sarkar", "Ali", "Haque", "Uddin", "Munshi"];
$CONDITIONS = ["Chronic Hypertension", "Type 2 Diabetes", "Seasonal Allergies", "Lower Back Pain", "Migraine", "Asthma", "High Cholesterol", "Acid Reflux"];
$PRESCRIPTIONS = ["Lisinopril 10mg", "Metformin 500mg", "Amoxicillin 500mg", "Ibuprofen 400mg", "Atorvastatin 20mg", "Albuterol Inhaler", "Omeprazole 20mg"];

// --- 1. CLEANUP ---
$conn->query("SET FOREIGN_KEY_CHECKS = 0");
$conn->query("TRUNCATE TABLE users");
$conn->query("TRUNCATE TABLE patients");
$conn->query("TRUNCATE TABLE doctors");
$conn->query("TRUNCATE TABLE admins");
$conn->query("TRUNCATE TABLE departments");
$conn->query("TRUNCATE TABLE tokens");
$conn->query("TRUNCATE TABLE medical_history");
$conn->query("TRUNCATE TABLE medical_reports");
$conn->query("TRUNCATE TABLE payments");
$conn->query("SET FOREIGN_KEY_CHECKS = 1");
echo "[OK] Tables truncated.<br>";

// --- 2. DEPARTMENTS ---
$dept_ids = [];
foreach ($DEPARTMENTS as $name) {
    if ($conn->query("INSERT INTO departments (NAME) VALUES ('$name')")) {
        $dept_ids[] = $conn->insert_id;
    }
}
echo "[OK] 6 Departments created.<br>";

// --- 3. THE ADMIN ---
$conn->query("INSERT INTO users (NAME, email, PASSWORD, role) VALUES ('System Administrator', 'admin@cureflow.com', 'admin123', 'admin')");
$conn->query("INSERT INTO admins (user_id) VALUES (" . $conn->insert_id . ")");
echo "[OK] Admin created (admin@cureflow.com).<br>";

// --- 4. DOCTORS (12) ---
$doctor_ids = [];
for ($i = 1; $i <= 12; $i++) {
    $name = "Dr. " . $FIRST_NAMES[array_rand($FIRST_NAMES)] . " " . $LAST_NAMES[array_rand($LAST_NAMES)];
    $email = "doctor_$i@cureflow.com";
    $pass = "doctor123";
    $dept_id = $dept_ids[($i - 1) % count($dept_ids)];
    $spec = $DEPARTMENTS[($i - 1) % count($DEPARTMENTS)] . " Specialist";
    $phone = "017" . rand(10000000, 99999999);

    $conn->query("INSERT INTO users (NAME, email, PASSWORD, role) VALUES ('$name', '$email', '$pass', 'doctor')");
    $user_id = $conn->insert_id;
    $conn->query("INSERT INTO doctors (user_id, specialization, phone, department_id) VALUES ($user_id, '$spec', '$phone', $dept_id)");
    $doctor_ids[] = $conn->insert_id;
}
echo "[OK] 12 Bangladeshi Doctors generated.<br>";

// --- 5. PATIENTS (50) ---
$patient_ids = [];
for ($i = 1; $i <= 50; $i++) {
    $name = $FIRST_NAMES[array_rand($FIRST_NAMES)] . " " . $LAST_NAMES[array_rand($LAST_NAMES)];
    $email = "patient_$i@cureflow.com";
    $pass = "patient123";
    $phone = "018" . rand(10000000, 99999999);
    $dob = date('Y-m-d', strtotime('-' . rand(18, 70) . ' years -' . rand(0, 365) . ' days'));
    $gender = rand(0, 1) ? 'male' : 'female';
    $addr = rand(10, 99) . " " . $LAST_NAMES[array_rand($LAST_NAMES)] . " Road, Dhaka";

    $conn->query("INSERT INTO users (NAME, email, PASSWORD, role) VALUES ('$name', '$email', '$pass', 'patient')");
    $user_id = $conn->insert_id;
    $conn->query("INSERT INTO patients (user_id, phone, dob, gender, address) VALUES ($user_id, '$phone', '$dob', '$gender', '$addr')");
    $patient_ids[] = $conn->insert_id;
}
echo "[OK] 50 Bangladeshi Patients generated.<br>";

// --- 6. TOKENS & HISTORY (180) ---
$statuses = ['completed', 'completed', 'completed', 'confirmed', 'in_queue', 'pending_payment', 'cancelled'];
for ($i = 1; $i <= 180; $i++) {
    $p_id = $patient_ids[array_rand($patient_ids)];
    $d_id = $doctor_ids[array_rand($doctor_ids)];
    $status = $statuses[array_rand($statuses)];
    $date = date('Y-m-d', strtotime((rand(0, 1) ? '-' : '+') . rand(0, 60) . ' days'));
    $token_num = rand(100, 999);
    
    $conn->query("INSERT INTO tokens (patient_id, doctor_id, token_number, appointment_date, STATUS) 
                  VALUES ($p_id, $d_id, $token_num, '$date', '$status')");
    $t_id = $conn->insert_id;

    // If completed, add history
    if ($status === 'completed') {
        $diag = $CONDITIONS[array_rand($CONDITIONS)];
        $presc = $PRESCRIPTIONS[array_rand($PRESCRIPTIONS)];
        $conn->query("INSERT INTO medical_history (patient_id, doctor_id, diagnosis, prescription, visit_date) 
                      VALUES ($p_id, $d_id, '$diag', '$presc', '$date')");
                      
        // Add a mock report
        $report_type = "Clinical Report - " . substr($diag, 0, 10);
        $conn->query("INSERT INTO medical_reports (patient_id, report_type, file_path) 
                      VALUES ($p_id, '$report_type', '/reports/sample_$i.pdf')");
    }

    // Add payment for completed/confirmed
    if ($status === 'completed' || $status === 'confirmed') {
        $amount = rand(500, 1500) . ".00";
        $p_status = ($status === 'completed') ? 'paid' : 'pending';
        $method = rand(0, 1) ? 'bKash' : 'Nagad';
        $conn->query("INSERT INTO payments (token_id, patient_id, method, amount, payment_status) 
                      VALUES ($t_id, $p_id, '$method', $amount, '$p_status')");
    }
}
echo "[OK] 180 Bangladeshi Records generated.<br>";

echo "<h2>Population Successful!</h2>";
?>
