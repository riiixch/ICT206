<?php
require_once 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    
    $name = $data['name'] ?? '';
    $description = $data['description'] ?? '';
    $image = $data['image'] ?? '';
    $location = $data['location'] ?? '';

    if (empty($name)) {
        echo json_encode(['error' => 'Name is required']);
        exit;
    }

    try {
        $stmt = $pdo->prepare("INSERT INTO places (name, description, image, location) VALUES (?, ?, ?, ?)");
        $stmt->execute([$name, $description, $image, $location]);
        
        echo json_encode(['success' => true, 'id' => $pdo->lastInsertId()]);
    } catch (PDOException $e) {
        echo json_encode(['error' => $e->getMessage()]);
    }
}
?>