<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

include("config/db.php");
include("utils/response.php");

// 🛠️ Self-Healing Migration (Quiet check)
$conn->query("CREATE TABLE IF NOT EXISTS ai_conversations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    profile_id INT NOT NULL,
    user_role VARCHAR(20) NOT NULL,
    title VARCHAR(255) DEFAULT 'New Conversation',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)");

$check = $conn->query("SHOW COLUMNS FROM ai_chatbot_logs LIKE 'ai_response'");
if ($check && $check->num_rows == 0) {
    $conn->query("ALTER TABLE ai_chatbot_logs ADD COLUMN ai_response TEXT");
}
$check = $conn->query("SHOW COLUMNS FROM ai_chatbot_logs LIKE 'user_role'");
if ($check && $check->num_rows == 0) {
    $conn->query("ALTER TABLE ai_chatbot_logs ADD COLUMN user_role VARCHAR(20) DEFAULT 'patient'");
}
$check = $conn->query("SHOW COLUMNS FROM ai_chatbot_logs LIKE 'conversation_id'");
if ($check && $check->num_rows == 0) {
    $conn->query("ALTER TABLE ai_chatbot_logs ADD COLUMN conversation_id INT AFTER chat_id");
}

// 🔑 Gemini API Key (Using the same key provided by user)
$api_key = "AIzaSyB-AEnc4c2nqT4WoEwZBR1A6Ho0c17Szt0";

// Get input data
$data = json_decode(file_get_contents("php://input"), true);
$user_message = $data['message'] ?? '';
$profile_id = $data['patient_id'] ?? null;
$role = $data['role'] ?? 'patient';
$conversation_id = $data['conversation_id'] ?? null;

if (empty($user_message)) {
    sendResponse("error", "Message is required.");
}

// 0. Handle Conversation Creation
if (!$conversation_id) {
    // Generate a title from the first 40 chars of message
    $title = (strlen($user_message) > 40) ? substr($user_message, 0, 37) . "..." : $user_message;
    $stmt = $conn->prepare("INSERT INTO ai_conversations (profile_id, user_role, title) VALUES (?, ?, ?)");
    $stmt->bind_param("iss", $profile_id, $role, $title);
    $stmt->execute();
    $conversation_id = $stmt->insert_id;
}

// 1. Fetch Context from DB
$depts = [];
$res = $conn->query("SELECT * FROM departments");
while ($row = $res->fetch_assoc()) $depts[] = $row;

$docs = [];
$res = $conn->query("SELECT d.doctor_id, u.name, d.specialization, d.department_id FROM doctors d JOIN users u ON d.user_id = u.user_id");
while ($row = $res->fetch_assoc()) $docs[] = $row;

// 2. Build System Prompt based on ROLE
if ($role === "admin") {
    $system_prompt = "You are an AI Technical Assistant for the Admin of the 'CureFlow' Hospital System. 
    The Admin is a Computer Science student. Feature development and DB health are priorities.";
} else if ($role === "doctor") {
    $system_prompt = "You are a Clinical Decision Support Assistant for Doctors at 'CureFlow' Hospital.";
} else {
    $system_prompt = "You are a highly capable AI Healthcare Advisor for 'CureFlow' Hospital. 
    Your goal is to provide empathetic, detailed, and clinically relevant guidance to patients.
    - If a patient asks about diet (e.g., 'what to eat for diabetes'), provide evidence-based nutritional advice (e.g., fiber-rich foods, lean proteins, monitoring glycemic index).
    - If symptoms are serious, prioritize triage.
    - Always suggest specific departments or doctors from the hospital database when relevant.
    - Be conversational and informative, not just a list-maker.
    
    Hospital Data:
    Departments: " . json_encode($depts) . "
    Doctors: " . json_encode($docs);
}

$system_prompt .= "\nIMPORTANT: At the very end of your response, IF and ONLY IF you are a patient assistant recommending a doctor, include [TRIAGE_DATA:{\"dept_id\": X, \"doc_id\": Y}] where X and Y are IDs.";

// 3. Smart Call Gemini API with Fallback (Stable v1 API)
function callGemini($model, $system_prompt, $user_msg, $api_key) {
    // Standardizing on the stable endpoint as requested
    $url = "https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$api_key";
    
    $payload = [
        "contents" => [
            [
                "role" => "user",
                "parts" => [
                    ["text" => "System Instructions: " . $system_prompt],
                    ["text" => "User Query: " . $user_msg]
                ]
            ]
        ],
        "generationConfig" => [
            "temperature" => 0.7,
            "maxOutputTokens" => 800
        ]
    ];

    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Content-Type: application/json'
    ]);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($payload));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    
    $response = curl_exec($ch);
    $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $err = curl_error($ch);
    curl_close($ch);

    return [
        'code' => $http_code,
        'body' => json_decode($response, true),
        'model' => $model,
        'error' => $err
    ];
}

// Attempting models in order of efficiency and availability (2026 Standards)
$models_to_try = ["gemini-2.5-flash"];
$result = null;

foreach ($models_to_try as $model_id) {
    $result = callGemini($model_id, $system_prompt, $user_message, $api_key);
    if ($result['code'] === 200) {
        break; // Successfully connected
    }
}

if ($result['error']) {
    sendResponse("error", "API failure: " . $result['error']);
}

$resData = $result['body'];
$ai_text = $resData['candidates'][0]['content']['parts'][0]['text'] ?? null;

if (!$ai_text) {
    sendResponse("error", [
        "message" => "Gemini API Failure or Invalid Response",
        "raw_debug" => $resData,
        "http_code" => $result['code'],
        "model_tried" => $result['model']
    ]);
}

// Parse recommendations
$recommended_dept = null;
$recommended_doc = null;
if (preg_match('/\[TRIAGE_DATA:(.*?)\]/', $ai_text, $matches)) {
    $triage = json_decode($matches[1], true);
    $recommended_dept = $triage['dept_id'] ?? null;
    $recommended_doc = $triage['doc_id'] ?? null;
}
$clean_response = trim(preg_replace('/\[TRIAGE_DATA:.*?\]/', '', $ai_text));

// 4. Log the Interaction with Persistence
$stmt = $conn->prepare("INSERT INTO ai_chatbot_logs (patient_id, user_role, conversation_id, recommended_department, recommended_doctor, symptoms, ai_response) VALUES (?, ?, ?, ?, ?, ?, ?)");
$stmt->bind_param("isiiiss", $profile_id, $role, $conversation_id, $recommended_dept, $recommended_doc, $user_message, $clean_response);
$stmt->execute();

sendResponse("success", [
    "message" => $clean_response,
    "recommended_dept" => $recommended_dept,
    "recommended_doc" => $recommended_doc,
    "conversation_id" => $conversation_id
]);
?>
