<?php
include 'condb.php';

$stmt = $conn->prepare("SELECT * FROM places");
$stmt->execute();
$places = $stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode($places);
?>