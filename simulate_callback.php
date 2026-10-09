<?php
include("config/db.php");

$token_id = $_POST['token_id'] ?? null;
$amount = $_POST['amount'] ?? 500;
$status = $_POST['status'] ?? 'fail';

if (!$token_id) {
    die("Invalid request.");
}

if ($status === 'success') {
    $conn->begin_transaction();
    try {
        // 1. Update Payment status
        $stmt = $conn->prepare("UPDATE payments SET payment_status = 'paid', transaction_id = 'SIM_".time()."' WHERE token_id = ?");
        $stmt->bind_param("i", $token_id);
        $stmt->execute();

        // 2. Update Token status to confirmed
        $stmt = $conn->prepare("UPDATE tokens SET STATUS = 'confirmed' WHERE token_id = ?");
        $stmt->bind_param("i", $token_id);
        $stmt->execute();

        $conn->commit();

        // 3. Send Notification (Simulated)
        include_once("utils/notifications.php");
        sendAppointmentConfirmation($conn, $token_id);

        $message = "Payment Successful! Your appointment is now confirmed.";
        $type = "success";
    } catch (Exception $e) {
        $conn->rollback();
        $message = "Simulation Error: " . $e->getMessage();
        $type = "error";
    }
} else {
    $message = "Payment Failed or Cancelled.";
    $type = "error";
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Processing...</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">
    <div class="bg-white p-8 rounded-3xl shadow-xl text-center max-w-sm">
        <h2 class="text-2xl font-bold mb-4 <?php echo $type === 'success' ? 'text-green-600' : 'text-red-600'; ?>">
            <?php echo $message; ?>
        </h2>
        <p class="text-gray-500 mb-8">Redirecting you back to your dashboard...</p>
        <script>
            setTimeout(() => {
                if (window.parent && window.parent !== window) {
                    window.parent.postMessage('payment_complete', '*');
                } else {
                    window.location.href = "/"; 
                }
            }, 3000);
        </script>
    </div>
</body>
</html>
