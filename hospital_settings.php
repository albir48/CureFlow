<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

include("utils/response.php");

$settings_file = "hospital_settings.json";

// Default settings
$default_settings = [
    "hospital_name" => "CureFlow Health Center",
    "admin_email" => "admin@cureflow.com",
    "last_updated" => date("Y-m-d H:i:s")
];

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (file_exists($settings_file)) {
        $settings = json_decode(file_get_contents($settings_file), true);
        sendResponse("success", $settings);
    } else {
        sendResponse("success", $default_settings);
    }
} elseif ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);
    
    // Merge with existing or default
    $existing = file_exists($settings_file) ? json_decode(file_get_contents($settings_file), true) : $default_settings;
    $new_settings = array_merge($existing, $data);
    $new_settings['last_updated'] = date("Y-m-d H:i:s");
    
    if (file_put_contents($settings_file, json_encode($new_settings, JSON_PRETTY_PRINT))) {
        sendResponse("success", $new_settings);
    } else {
        sendResponse("error", "Failed to save settings.");
    }
}
?>
