<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *'); // Allow CORS for Flutter app
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

require_once '../config.php';

try {
    $stmt = $pdo->prepare("SELECT * FROM places");
    $stmt->execute();
    $places = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    echo json_encode($places);
} catch (PDOException $e) {
    echo json_encode(['error' => $e->getMessage()]);
}
?>