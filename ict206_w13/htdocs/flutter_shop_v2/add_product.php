<?php
include 'condb.php';

try {
    // การเชื่อมต่อฐานข้อมูลด้วย PDO
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    // ตรวจสอบว่ามีการส่งข้อมูลมาหรือไม่
    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        // รับค่าจาก Flutter (JSON)
        $data = json_decode(file_get_contents('php://input'), true);
        
        // รับค่าต่างๆ จาก Flutter
        $name = $data['name'];
        $description = $data['description'];
        $price = $data['price'];
        $image = $data['image'];
        $amount = $data['amount'];

        // เตรียมคำสั่ง SQL
        $stmt = $pdo->prepare("INSERT INTO products (name, description, price, image, amount) VALUES (:name, :description, :price, :image, :amount)");

        // ผูกค่าตัวแปรกับคำสั่ง SQL
        $stmt->bindParam(':name', $name);
        $stmt->bindParam(':description', $description);
        $stmt->bindParam(':price', $price);
        $stmt->bindParam(':image', $image);
        $stmt->bindParam(':amount', $amount);

        // รันคำสั่ง SQL
        if ($stmt->execute()) {
            echo json_encode(["status" => "success", "message" => "Product added successfully"]);
        } else {
            echo json_encode(["status" => "error", "message" => "Failed to add product"]);
        }
    }
} catch (PDOException $e) {
    echo json_encode(["status" => "error", "message" => $e->getMessage()]);
}
?>
