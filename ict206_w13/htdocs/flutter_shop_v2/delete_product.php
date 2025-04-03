<?php
include 'condb.php'; // รวมไฟล์ที่ใช้เชื่อมต่อฐานข้อมูล

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $id = $_POST['id'];

    try {
      
        // เตรียมคำสั่ง SQL สำหรับลบข้อมูล
        $sql = "DELETE FROM products WHERE id = :id";
        $stmt = $conn->prepare($sql);
        // ผูกค่าของ id
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);

        // execute การลบข้อมูล
        if ($stmt->execute()) {
            echo json_encode(["message" => "ลบสำเร็จ"]);
        } else {
            echo json_encode(["error" => "ลบไม่สำเร็จ"]);
        }
    } catch (PDOException $e) {
        // ถ้ามีข้อผิดพลาดเกิดขึ้น จะมีข้อความข้อผิดพลาดนี้
        echo json_encode(["error" => "เกิดข้อผิดพลาด: " . $e->getMessage()]);
    }

    // ปิดการเชื่อมต่อฐานข้อมูล
    $conn = null;
}
?>
