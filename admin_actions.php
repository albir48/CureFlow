<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

include("config/db.php");
include("utils/response.php");

// 🛠️ Self-Healing Migration (Queue Management) - Using safer check pattern
function addColumnIfMissing($conn, $table, $column, $definition) {
    $check = $conn->query("SHOW COLUMNS FROM `$table` LIKE '$column'");
    if ($check && $check->num_rows == 0) {
        $conn->query("ALTER TABLE `$table` ADD COLUMN `$column` $definition");
    }
}

addColumnIfMissing($conn, 'doctors', 'current_tau', 'FLOAT DEFAULT 5.0');
addColumnIfMissing($conn, 'tokens', 'predicted_duration', 'FLOAT DEFAULT 5.0');
addColumnIfMissing($conn, 'tokens', 'actual_duration', 'FLOAT DEFAULT NULL');
addColumnIfMissing($conn, 'tokens', 'started_at', 'TIMESTAMP NULL');
addColumnIfMissing($conn, 'tokens', 'completed_at', 'TIMESTAMP NULL');
addColumnIfMissing($conn, 'tokens', 'hidden_by_patient', 'TINYINT(1) DEFAULT 0');
addColumnIfMissing($conn, 'tokens', 'hidden_by_doctor', 'TINYINT(1) DEFAULT 0');

// Update STATUS enum to include 'in_progress'
$conn->query("ALTER TABLE tokens MODIFY COLUMN STATUS enum('pending_payment','confirmed','in_queue','in_progress','completed','cancelled') DEFAULT 'pending_payment'");

$data = json_decode(file_get_contents("php://input"), true);
$action = $data['action'] ?? '';

switch ($action) {
    case 'add_doctor':
        $name = $data['name'] ?? '';
        $email = $data['email'] ?? '';
        $specialization = $data['specialization'] ?? '';
        $phone = $data['phone'] ?? '';
        $password = $data['password'] ?? 'doctor123';
        $department_id = $data['department_id'] ?? 1; // Default to 'General Medicine' (assuming ID 1)

        if (empty($name) || empty($email)) {
            sendResponse("error", "Name and Email are required.");
        }

        $conn->begin_transaction();
        try {
            $stmt = $conn->prepare("INSERT INTO users (NAME, email, PASSWORD, role) VALUES (?, ?, ?, 'doctor')");
            $stmt->bind_param("sss", $name, $email, $password);
            $stmt->execute();
            $user_id = $conn->insert_id;

            $stmt = $conn->prepare("INSERT INTO doctors (user_id, specialization, phone, department_id) VALUES (?, ?, ?, ?)");
            $stmt->bind_param("issi", $user_id, $specialization, $phone, $department_id);
            $stmt->execute();

            $conn->commit();
            sendResponse("success", "Specialist registered successfully.");
        } catch (Exception $e) {
            $conn->rollback();
            sendResponse("error", "Database Error: " . $e->getMessage());
        }
        break;

    case 'add_patient':
        $name = $data['name'] ?? '';
        $email = $data['email'] ?? '';
        $phone = $data['phone'] ?? '';
        $gender = $data['gender'] ?? 'other';
        $password = $data['password'] ?? 'patient123';

        if (empty($name) || empty($email)) {
            sendResponse("error", "Name and Email are required.");
        }

        $conn->begin_transaction();
        try {
            $stmt = $conn->prepare("INSERT INTO users (NAME, email, PASSWORD, role) VALUES (?, ?, ?, 'patient')");
            $stmt->bind_param("sss", $name, $email, $password);
            $stmt->execute();
            $user_id = $conn->insert_id;

            $stmt = $conn->prepare("INSERT INTO patients (user_id, phone, gender) VALUES (?, ?, ?)");
            $stmt->bind_param("iss", $user_id, $phone, $gender);
            $stmt->execute();

            $conn->commit();
            sendResponse("success", "Patient profile initialized.");
        } catch (Exception $e) {
            $conn->rollback();
            sendResponse("error", "Database Error: " . $e->getMessage());
        }
        break;

    case 'cancel_appointment':
        $token_id = $data['token_id'] ?? null;
        if (!$token_id) sendResponse("error", "Token ID is required.");

        $stmt = $conn->prepare("UPDATE tokens SET STATUS = 'cancelled' WHERE token_id = ?");
        $stmt->bind_param("i", $token_id);
        
        if ($stmt->execute()) {
            sendResponse("success", "Appointment cancelled successfully.");
        } else {
            sendResponse("error", "Cancellation failed.");
        }
        break;

    case 'update_doctor':
        $doctor_id = $data['doctor_id'] ?? null;
        $name = $data['name'] ?? null;
        if (!$doctor_id) sendResponse("error", "Doctor ID is required.");

        $conn->begin_transaction();
        try {
            $stmt = $conn->prepare("SELECT user_id FROM doctors WHERE doctor_id = ?");
            $stmt->bind_param("i", $doctor_id);
            $stmt->execute();
            $user_id = $stmt->get_result()->fetch_assoc()['user_id'];

            if ($name) {
                $stmt = $conn->prepare("UPDATE users SET NAME = ? WHERE user_id = ?");
                $stmt->bind_param("si", $name, $user_id);
                $stmt->execute();
            }
            $conn->commit();
            sendResponse("success", "Profile updated.");
        } catch (Exception $e) {
            $conn->rollback();
            sendResponse("error", "Update failed: " . $e->getMessage());
        }
        break;

    case 'delete_doctor':
        $doctor_id = $data['doctor_id'] ?? null;
        if (!$doctor_id) sendResponse("error", "ID required");

        $stmt = $conn->prepare("SELECT user_id FROM doctors WHERE doctor_id = ?");
        $stmt->bind_param("i", $doctor_id);
        $stmt->execute();
        $user_id = $stmt->get_result()->fetch_assoc()['user_id'];

        // Simple deletion attempt
        $stmt = $conn->prepare("DELETE FROM users WHERE user_id = ?");
        $stmt->bind_param("i", $user_id);
        
        try {
            if ($stmt->execute()) {
                sendResponse("success", "Doctor removed.");
            } else {
                sendResponse("error", "Deletion blocked: Specialist has clinical dependencies (appointments/records).");
            }
        } catch (Exception $e) {
            sendResponse("error", "Deletion blocked: This specialist has active clinical records in the system.");
        }
        break;

    case 'delete_patient':
        $patient_id = $data['patient_id'] ?? null;
        if (!$patient_id) sendResponse("error", "ID required");

        $stmt = $conn->prepare("SELECT user_id FROM patients WHERE patient_id = ?");
        $stmt->bind_param("i", $patient_id);
        $stmt->execute();
        $user_id = $stmt->get_result()->fetch_assoc()['user_id'];

        $stmt = $conn->prepare("DELETE FROM users WHERE user_id = ?");
        $stmt->bind_param("i", $user_id);
        
        try {
            if ($stmt->execute()) {
                sendResponse("success", "Patient removed.");
            } else {
                sendResponse("error", "Deletion blocked: Patient has active session data or clinical records.");
            }
        } catch (Exception $e) {
            sendResponse("error", "Deletion blocked: This patient has active medical records or history in the system.");
        }
        break;

    case 'update_appointment_status':
        $token_id = $data['token_id'] ?? null;
        $status = $data['status'] ?? null;
        if (!$token_id || !$status) sendResponse("error", "Token ID and status are required.");

        $conn->begin_transaction();
        try {
            // Fetch current state
            $stmt = $conn->prepare("SELECT patient_id, doctor_id, started_at, predicted_duration FROM tokens WHERE token_id = ?");
            $stmt->bind_param("i", $token_id);
            $stmt->execute();
            $token_data = $stmt->get_result()->fetch_assoc();
            $doctor_id = $token_data['doctor_id'];
            $patient_id = $token_data['patient_id'];

            if ($status === 'in_progress') {
                $stmt = $conn->prepare("UPDATE tokens SET STATUS = ?, started_at = CURRENT_TIMESTAMP WHERE token_id = ?");
                $stmt->bind_param("si", $status, $token_id);
                $stmt->execute();
            } else if ($status === 'completed') {
                // Calculate duration
                $started_at = $token_data['started_at'];
                if (!$started_at) {
                    // Fallback if started_at wasn't set (e.g. skipped status)
                    $started_at = date('Y-m-d H:i:s', time() - 300); // assume 5 mins
                }
                // Calculate duration, ensuring it's at least 1 minute
                $actual_duration = max(1, (time() - strtotime($started_at)) / 60); // in minutes
                $predicted_prev = max(1, $token_data['predicted_duration']);
                
                // SJF Prediction: tau_{n+1} = alpha * actual_n + (1-alpha) * tau_n
                $alpha = 0.5;
                $new_tau = max(1, ($alpha * $actual_duration) + ((1 - $alpha) * $predicted_prev));
                
                // Update token
                $stmt = $conn->prepare("UPDATE tokens SET STATUS = ?, completed_at = CURRENT_TIMESTAMP, actual_duration = ? WHERE token_id = ?");
                $stmt->bind_param("sdi", $status, $actual_duration, $token_id);
                $stmt->execute();
                
                // Update doctor's global prediction for next patients
                $stmt = $conn->prepare("UPDATE doctors SET current_tau = ? WHERE doctor_id = ?");
                $stmt->bind_param("di", $new_tau, $doctor_id);
                $stmt->execute();

                // NEW: Save to medical_history if diagnosis/prescription/lab_tests provided
                $diagnosis = $data['diagnosis'] ?? null;
                $prescription = $data['prescription'] ?? null;
                $lab_tests = $data['lab_tests'] ?? null;

                if ($diagnosis || $prescription || $lab_tests) {
                    $stmt = $conn->prepare("INSERT INTO medical_history (patient_id, doctor_id, diagnosis, prescription, lab_tests, visit_date) VALUES (?, ?, ?, ?, ?, CURDATE())");
                    $stmt->bind_param("iisss", $patient_id, $doctor_id, $diagnosis, $prescription, $lab_tests);
                    $stmt->execute();
                }
            } else {
                $stmt = $conn->prepare("UPDATE tokens SET STATUS = ? WHERE token_id = ?");
                $stmt->bind_param("si", $status, $token_id);
                $stmt->execute();
            }

            $conn->commit();
            sendResponse("success", "Appointment status updated to $status.");
        } catch (Exception $e) {
            $conn->rollback();
            sendResponse("error", "Update failed: " . $e->getMessage());
        }
        break;

    case 'send_test_notification':
        $patient_id = $data['patient_id'] ?? null;
        $message = $data['message'] ?? 'This is a test notification from CureFlow.';
        if (!$patient_id) sendResponse("error", "Patient ID is required.");

        $stmt = $conn->prepare("INSERT INTO notifications (patient_id, message, is_read) VALUES (?, ?, 0)");
        $stmt->bind_param("is", $patient_id, $message);
        
        if ($stmt->execute()) {
            sendResponse("success", "Notification sent successfully.");
        } else {
            sendResponse("error", "Failed to send notification.");
        }
        break;

    case 'partner_order':
        $patient_id = $data['patient_id'] ?? null;
        $token_id = $data['token_id'] ?? null;
        $partner_name = $data['partner_name'] ?? null;
        $order_type = $data['order_type'] ?? null;
        $details = $data['details'] ?? null;
        
        if (!$patient_id || !$token_id || !$partner_name || !$order_type) {
            sendResponse("error", "Missing required order details.");
        }
        
        // Mock pricing based on type
        $amount = ($order_type === 'lab') ? rand(1500, 5000) : rand(500, 2000);
        
        $stmt = $conn->prepare("INSERT INTO partner_orders (patient_id, token_id, partner_name, order_type, details, amount, status) VALUES (?, ?, ?, ?, ?, ?, 'pending')");
        $stmt->bind_param("iisssd", $patient_id, $token_id, $partner_name, $order_type, $details, $amount);
        
        if ($stmt->execute()) {
            sendResponse("success", [
                "message" => "Order sent to $partner_name successfully.",
                "amount" => $amount,
                "order_id" => $conn->insert_id
            ]);
        } else {
            sendResponse("error", "Failed to place partner order.");
        }
        break;

    case 'simulate_appointment_message':
        $token_id = $data['token_id'] ?? null;
        if (!$token_id) sendResponse("error", "Token ID is required.");
        
        include_once("utils/notifications.php");
        if (sendAppointmentConfirmation($conn, $token_id)) {
            sendResponse("success", "Appointment message simulated and sent.");
        } else {
            sendResponse("error", "Failed to simulate message. Verify token ID.");
        }
        break;

    case 'delete_cancelled_appointments':
        // Delete dependencies first
        $conn->query("DELETE FROM payments WHERE token_id IN (SELECT token_id FROM tokens WHERE STATUS = 'cancelled')");
        $conn->query("DELETE FROM notifications WHERE token_id IN (SELECT token_id FROM tokens WHERE STATUS = 'cancelled')");
        
        $stmt = $conn->prepare("DELETE FROM tokens WHERE STATUS = 'cancelled'");
        if ($stmt->execute()) {
            sendResponse("success", "All cancelled appointments cleared.");
        } else {
            sendResponse("error", "Failed to clear appointments.");
        }
        break;

    case 'delete_appointment':
        $token_id = $data['token_id'] ?? null;
        if (!$token_id) sendResponse("error", "ID required");
        
        // Delete dependencies first
        $stmt = $conn->prepare("DELETE FROM payments WHERE token_id = ?");
        $stmt->bind_param("i", $token_id);
        $stmt->execute();

        $stmt = $conn->prepare("DELETE FROM notifications WHERE token_id = ?");
        $stmt->bind_param("i", $token_id);
        $stmt->execute();

        $stmt = $conn->prepare("DELETE FROM tokens WHERE token_id = ?");
        $stmt->bind_param("i", $token_id);
        if ($stmt->execute()) {
            sendResponse("success", "Appointment record deleted.");
        } else {
            sendResponse("error", "Deletion failed.");
        }
        break;

    case 'delete_notification':
        $notification_id = $data['notification_id'] ?? null;
        if (!$notification_id) sendResponse("error", "ID required");
        $stmt = $conn->prepare("DELETE FROM notifications WHERE notification_id = ?");
        $stmt->bind_param("i", $notification_id);
        if ($stmt->execute()) {
            sendResponse("success", "Notification deleted.");
        } else {
            sendResponse("error", "Deletion failed.");
        }
        break;

    case 'delete_report':
        $report_id = $data['report_id'] ?? null;
        if (!$report_id) sendResponse("error", "ID required");
        
        // Fetch path to delete physical file
        $stmt = $conn->prepare("SELECT file_path FROM clinical_reports WHERE report_id = ?");
        $stmt->bind_param("i", $report_id);
        $stmt->execute();
        $res = $stmt->get_result()->fetch_assoc();
        
        if ($res) {
            $path = $res['file_path'];
            if (file_exists($path)) unlink($path);
        }

        $stmt = $conn->prepare("DELETE FROM clinical_reports WHERE report_id = ?");
        $stmt->bind_param("i", $report_id);
        if ($stmt->execute()) {
            sendResponse("success", "Report deleted.");
        } else {
            sendResponse("error", "Deletion failed.");
        }
        break;

    case 'delete_conversation':
        $conversation_id = $data['conversation_id'] ?? null;
        if (!$conversation_id) sendResponse("error", "ID required");
        
        $stmt = $conn->prepare("DELETE FROM ai_chatbot_logs WHERE conversation_id = ?");
        $stmt->bind_param("i", $conversation_id);
        $stmt->execute();

        $stmt = $conn->prepare("DELETE FROM ai_conversations WHERE id = ?");
        $stmt->bind_param("i", $conversation_id);
        
        if ($stmt->execute()) {
            sendResponse("success", "Conversation deleted.");
        } else {
            sendResponse("error", "Deletion failed.");
        }
        break;

    case 'delete_chat_history':
        $user_id = $data['user_id'] ?? null;
        if (!$user_id) sendResponse("error", "User ID required");
        
        $stmt = $conn->prepare("DELETE FROM ai_chatbot_logs WHERE user_id = ?");
        $stmt->bind_param("i", $user_id);
        if ($stmt->execute()) {
            sendResponse("success", "Chat history cleared.");
        } else {
            sendResponse("error", "Failed to clear chat.");
        }
        break;

    case 'book_appointment':
        $patient_id = $data['patient_id'] ?? null;
        $doctor_id = $data['doctor_id'] ?? null;
        $appointment_date = $data['appointment_date'] ?? date('Y-m-d');
        $appointment_time = $data['appointment_time'] ?? '09:00:00';

        if (!$patient_id || !$doctor_id) {
            sendResponse("error", "Patient ID and Doctor ID are required.");
        }

        // 1. Fetch Doctor's current prediction parameters
        $stmt = $conn->prepare("SELECT current_tau FROM doctors WHERE doctor_id = ?");
        $stmt->bind_param("i", $doctor_id);
        $stmt->execute();
        $doc_res = $stmt->get_result()->fetch_assoc();
        $predicted_duration = $doc_res['current_tau'] ?? 5.0;

        // 2. Calculate next token number for this doctor on this date (Sequential 1..N)
        $stmt = $conn->prepare("SELECT MAX(token_number) as last_token FROM tokens WHERE doctor_id = ? AND appointment_date = ?");
        $stmt->bind_param("is", $doctor_id, $appointment_date);
        $stmt->execute();
        $res = $stmt->get_result()->fetch_assoc();
        $next_token = ($res['last_token'] ?? 0) + 1;

        // 3. Calculate wait for patients AHEAD of this new one (already booked today)
        $stmt = $conn->prepare("SELECT SUM(predicted_duration) as total_wait FROM tokens WHERE doctor_id = ? AND appointment_date = ? AND STATUS NOT IN ('cancelled','completed')");
        $stmt->bind_param("is", $doctor_id, $appointment_date);
        $stmt->execute();
        $wait_res = $stmt->get_result()->fetch_assoc();
        $total_wait_mins = (float)($wait_res['total_wait'] ?? 0); // minutes to wait before this patient

        // 4. Calculate this patient's actual estimated appointment time
        // slot_start + cumulative wait of all patients ahead
        $slot_start_seconds = strtotime($appointment_date . ' ' . $appointment_time);
        $estimated_start_seconds = $slot_start_seconds + ($total_wait_mins * 60);
        $patient_appointment_time = date('H:i:s', $estimated_start_seconds);

        // 5. Create the token entry — store the computed start time, not the raw slot
        $stmt = $conn->prepare("INSERT INTO tokens (patient_id, doctor_id, token_number, appointment_date, appointment_time, STATUS, predicted_duration, estimated_wait_time) VALUES (?, ?, ?, ?, ?, 'pending_payment', ?, ?)");
        $stmt->bind_param("iiissdd", $patient_id, $doctor_id, $next_token, $appointment_date, $patient_appointment_time, $predicted_duration, $total_wait_mins);
        
        if ($stmt->execute()) {
            sendResponse("success", [
                "token_id" => $conn->insert_id,
                "token_number" => $next_token,
                "estimated_wait_time" => $total_wait_mins,
                "appointment_time" => $patient_appointment_time,
                "message" => "Token #$next_token generated. Your appointment is around " . date('g:i A', $estimated_start_seconds) . ". Please proceed to payment."
            ]);
        } else {
            sendResponse("error", "Failed to generate token.");
        }
        break;

    case 'hide_appointment':
        $token_id = $data['token_id'] ?? null;
        $role = $data['role'] ?? null;
        if (!$token_id || !$role) sendResponse("error", "Token ID and role required.");
        
        $column = ($role === 'patient') ? 'hidden_by_patient' : 'hidden_by_doctor';
        $stmt = $conn->prepare("UPDATE tokens SET $column = 1 WHERE token_id = ?");
        $stmt->bind_param("i", $token_id);
        if ($stmt->execute()) {
            sendResponse("success", "Appointment hidden from your view.");
        } else {
            sendResponse("error", "Failed to hide appointment.");
        }
        break;

    default:
        sendResponse("error", "Invalid action.");
        break;
}
?>
