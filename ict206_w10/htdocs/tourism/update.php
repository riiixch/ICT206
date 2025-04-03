<?php
require_once 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    $data = json_decode(file_get_contents('php://input'), true);
    
    $id = $data['id'] ?? '';
    $name = $data['name'] ?? '';
    $description = $data['description'] ?? '';
    $image = $data['image'] ?? '';
    $location = $data['location'] ?? '';

    if (empty($id) || empty($name)) {
        echo json_encode(['error' => 'ID and Name are required']);
        exit;
    }

    try {
        $stmt = $pdo->prepare("UPDATE places SET name = ?, description = ?, image = ?, location = ? WHERE id = ?");
        $stmt->execute([$name, $description, $image, $location, $id]);
        
        echo json_encode(['success' => true]);
    } catch (PDOException $e) {
        echo json_encode(['error' => $e->getMessage()]);
    }
}
?>