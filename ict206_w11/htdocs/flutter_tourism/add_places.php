<?php
include 'condb.php';

$data = json_decode(file_get_contents("php://input"), true);

$name = $data['name'];
$description = $data['description'];
$image = $data['image'];
$location = $data['location'];

$stmt = $conn->prepare("INSERT INTO places (name, description, image, location) VALUES (?, ?, ?, ?)");
$stmt->execute([$name, $description, $image, $location]);

echo json_encode(["message" => "Place added successfully"]);
?>