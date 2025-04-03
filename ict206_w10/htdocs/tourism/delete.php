<?php
require_once 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    $data = json_decode(file_get_contents('php://input'), true);
    $id = $data['id'] ?? '';

    if (empty($id)) {
        echo json_encode(['error' => 'ID is required']);
        exit;
    }

    try {
        $stmt = $pdo->prepare("DELETE FROM places WHERE id = ?");
        $stmt->execute([$id]);
        
        $rowCount = $stmt->rowCount();
        if ($rowCount > 0) {
            echo json_encode(['success' => true]);
        } else {
            echo json_encode(['error' => 'Place not found']);
        }
    } catch (PDOException $e) {
        echo json_encode(['error' => $e->getMessage()]);
    }
}
?>