<?php
include("config/db.php");

$files = glob("migrations/*.sql");

foreach ($files as $file) {
    $sql = file_get_contents($file);

    if ($conn->multi_query($sql)) {
        echo "Migrated: $file\n";
        while ($conn->more_results() && $conn->next_result()) {}
    } else {
        echo "Error in $file: " . $conn->error . "\n";
    }
}

echo "Migration completed.";
?>
