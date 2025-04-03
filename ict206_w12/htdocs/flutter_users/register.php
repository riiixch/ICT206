<?php
include 'db_connect.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);
    
    $firstname = $data['firstname'];
    $lastname = $data['lastname'];
    $email = $data['email'];
    $password = $data['password'];

    $sql = "INSERT INTO users (firstname, lastname, email, password) VALUES (:firstname, :lastname, :email, :password)";
    $stmt = $pdo->prepare($sql);
    
    try {
        $stmt->execute([
            ':firstname' => $firstname,
            ':lastname' => $lastname,
            ':email' => $email,
            ':password' => $password
        ]);
        echo json_encode(['message' => 'Registration successful']);
    } catch (PDOException $e) {
        echo json_encode(['error' => 'Registration failed: ' . $e->getMessage()]);
    }
}
?>