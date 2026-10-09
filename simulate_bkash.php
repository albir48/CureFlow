<?php
include("config/db.php");

$token_id = $_GET['token_id'] ?? null;
$amount = $_GET['amount'] ?? 500;

if (!$token_id) {
    die("Error: No Token ID provided for simulation.");
}

// Get doctor and patient info for the simulation display
$sql = "SELECT t.*, u.name as doctor_name FROM tokens t JOIN doctors d ON t.doctor_id = d.doctor_id JOIN users u ON d.user_id = u.user_id WHERE t.token_id = $token_id";
$res = $conn->query($sql);
$token = $res->fetch_assoc();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>bKash Payment Simulation</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;700;900&display=swap');
        body { font-family: 'Inter', sans-serif; background-color: #f1f1f1; }
    </style>
</head>
<body class="flex items-center justify-center min-h-screen p-4">
    <div class="w-full max-w-md bg-[#D12053] rounded-2xl shadow-2xl overflow-hidden animate-in fade-in zoom-in duration-300">
        <div class="p-8 text-center">
            <img src="https://www.logo.wine/a/logo/BKash/BKash-Logo.wine.svg" alt="bKash" class="w-32 mx-auto invert brightness-0 mb-4">
            <div class="bg-white/10 backdrop-blur-md rounded-xl p-4 text-white mb-6">
                <p class="text-xs font-bold uppercase tracking-widest opacity-70 mb-1">Payment for Token #<?php echo $token['token_number']; ?></p>
                <p class="text-lg font-black"><?php echo $token['doctor_name']; ?></p>
                <p class="text-3xl font-black mt-2">৳ <?php echo $amount; ?>.00</p>
            </div>

            <div class="space-y-4">
                <form action="simulate_callback.php" method="POST">
                    <input type="hidden" name="token_id" value="<?php echo $token_id; ?>">
                    <input type="hidden" name="amount" value="<?php echo $amount; ?>">
                    <button type="submit" name="status" value="success" class="w-full py-4 bg-white text-[#D12053] rounded-xl font-black text-lg hover:bg-gray-100 transition-all shadow-xl">
                        Simulate Success
                    </button>
                    <button type="submit" name="status" value="fail" class="w-full mt-4 py-3 bg-black/20 text-white rounded-xl font-bold text-sm hover:bg-black/30 transition-all">
                        Simulate Failure
                    </button>
                </form>
            </div>
            
            <p class="text-[10px] text-white/50 mt-8 font-medium uppercase tracking-widest">
                Safe & Secure Payment Simulator
            </p>
        </div>
    </div>
</body>
</html>
