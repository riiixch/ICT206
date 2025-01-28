import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Room {
  final String name;
  final String price;

  Room({required this.name, required this.price});

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      name: json['name'],
      price: json['price'],
    );
  }
}

Future<List<Room>> fetchRooms() async {
  final response = await http.get(Uri.parse('http://localhost:3000/rooms'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((room) => Room.fromJson(room)).toList();
  } else {
    throw Exception('Failed to load rooms');
  }
}

List<Map<String, String>> rooms = [
  {'name': 'ห้องพัก A1', 'price': '3,500 บาท/เดือน'},
  {'name': 'ห้องพัก A2', 'price': '3,700 บาท/เดือน'},
  {'name': 'ห้องพัก B1', 'price': '3,900 บาท/เดือน'},
  {'name': 'ห้องพัก B2', 'price': '4,100 บาท/เดือน'},
  {'name': 'ห้องพัก C1', 'price': '4,300 บาท/เดือน'},
  {'name': 'ห้องพัก C2', 'price': '4,500 บาท/เดือน'},
  {'name': 'ห้องพัก D1', 'price': '4,700 บาท/เดือน'},
  {'name': 'ห้องพัก D2', 'price': '4,900 บาท/เดือน'},
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlutterLogo(size: 48),
                SizedBox(width: 10),
                Text(
                  "หอพัก ICT",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 32),
            Text("เลือกเช่า และจองห้องพักที่คุณต้องการ",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
            SizedBox(height: 48),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 16,
              children: rooms.map((room) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  height: 128,
                  width: 224,
                  padding: EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        room['name']!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        room['price']!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          // เพิ่มฟังก์ชันเมื่อกดปุ่มจอง
                          //print("จอง ${room['name']}");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text('จอง'),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
