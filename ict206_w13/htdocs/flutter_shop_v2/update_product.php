<?php
include 'condb.php';

try {
    // ตรวจสอบว่ามีการส่งข้อมูลมาหรือไม่
    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        // รับค่าจาก Flutter (JSON)
        $data = json_decode(file_get_contents('php://input'), true);
        
        // ตรวจสอบว่า $data มีค่าหรือไม่
        if (!$data) {
            echo json_encode(["status" => "error", "message" => "Invalid data received"]);
            exit;
        }

        // รับค่าต่างๆ จาก Flutter
        $id = $data['id'];  // รับ ID ของสินค้าที่จะอัปเดต
        $name = $data['name'];
        $description = $data['description'];
        $price = $data['price'];
        $image = $data['image'];
        $amount = $data['amount'];

        // ตรวจสอบข้อมูลที่ได้รับ
        if (empty($id) || empty($name) || empty($description) || empty($price) || empty($image)) {
            echo json_encode(["status" => "error", "message" => "Missing required fields"]);
            exit;
        }

        // เตรียมคำสั่ง SQL สำหรับการอัปเดตข้อมูลสินค้า
        $stmt = $conn->prepare("UPDATE products SET name = :name, description = :description, price = :price, image = :image, amount = :amount WHERE id = :id");

        // ผูกค่าตัวแปรกับคำสั่ง SQL
        $stmt->bindParam(':id', $id);
        $stmt->bindParam(':name', $name);
        $stmt->bindParam(':description', $description);
        $stmt->bindParam(':price', $price);
        $stmt->bindParam(':image', $image);
        $stmt->bindParam(':amount', $amount);

        // รันคำสั่ง SQL
        if ($stmt->execute()) {
            echo json_encode(["status" => "success", "message" => "Product updated successfully"]);
        } else {
            echo json_encode(["status" => "error", "message" => "Failed to update product"]);
        }
    } else {
        echo json_encode(["status" => "error", "message" => "Invalid request method"]);
    }
} catch (PDOException $e) {
    echo json_encode(["status" => "error", "message" => "Database error: " . $e->getMessage()]);
}
?>
