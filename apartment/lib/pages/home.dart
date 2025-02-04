import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal, // ตั้งค่าทิศทางการเลื่อนเป็นแนวนอน
              child: Row(
                children: List.generate(5, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    width: 160,
                    height: 192,
                    decoration: BoxDecoration(
                      color: Colors.primaries[index % Colors.primaries.length],
                      borderRadius: BorderRadius.circular(20), // กำหนดขอบมนที่มุมทั้งหมด
                    ),
                    child: Center(
                      child: Text('Item $index'),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
