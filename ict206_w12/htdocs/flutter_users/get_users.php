<?php
include 'db_connect.php';

$sql = "SELECT user_id, firstname, lastname, email, created_at FROM users";
$stmt = $pdo->prepare($sql);
$stmt->execute();
$users = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($users);
?>