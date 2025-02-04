import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // ตัวควบคุมการค้นหาข้อความ
  TextEditingController _controller = TextEditingController();
  
  // ข้อมูลห้องพักที่ใช้ในการค้นหา
  List<Map<String, String>> rooms = [
    {'name': 'ห้อง 101', 'price': '3000 บาท', 'status': 'ไม่ว่าง', 'image': 'assets/images/room1.png'},
    {'name': 'ห้อง 102', 'price': '3500 บาท', 'status': 'ติดจอง', 'image': 'assets/images/room2.png'},
    {'name': 'ห้อง 103', 'price': '4000 บาท', 'status': 'ว่าง', 'image': 'assets/images/room1.png'},
    {'name': 'ห้อง 104', 'price': '4500 บาท', 'status': 'ว่าง', 'image': 'assets/images/room2.png'},
    {'name': 'ห้อง 105', 'price': '5000 บาท', 'status': 'ว่าง', 'image': 'assets/images/room1.png'},
    {'name': 'ห้อง 106', 'price': '5500 บาท', 'status': 'ว่าง', 'image': 'assets/images/room2.png'},
  ];
  List<Map<String, String>> filteredRooms = [];

  @override
  void initState() {
    super.initState();
    filteredRooms = rooms; // เริ่มต้นให้แสดงทุกรายการ
  }

  void _filterRooms(String query) {
    setState(() {
      filteredRooms = rooms
          .where((room) => room['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList(); // กรองห้องที่ตรงกับคำค้นหาของผู้ใช้
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 16),
            Container(
              width: 320,
              child: SearchBarCustom(
                controller: _controller,
                onChanged: _filterRooms,
              ),
            ),
            SizedBox(height: 32),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: filteredRooms.map((room) {
                return Container(
                  width: 192,
                  height: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          room['image']!,
                          width: 192,
                          height: 130,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        room['name']!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'ราคา: ${room['price']}',
                        style: TextStyle(color: Colors.green, fontSize: 14),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'สถานะ: ${room['status']}',
                        style: TextStyle(
                          color: room['status'] == 'ว่าง' ? Colors.green : Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class SearchBarCustom extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const SearchBarCustom({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged, // เรียกใช้เมื่อมีการกรอกข้อความ
      decoration: InputDecoration(
        hintText: 'ค้นหาห้องพักที่คุณต้องการ...',
        hintStyle: TextStyle(color: Colors.grey[500]),
        prefixIcon: Icon(Icons.search, color: Colors.blue),
        filled: true,
        fillColor: Colors.blue[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
    );
  }
}
