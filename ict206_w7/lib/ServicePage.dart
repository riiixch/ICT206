import 'package:flutter/material.dart';

class ServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Our Service',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          _buildServiceCard(
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2b/12/b8/49/evening-view.jpg?w=600&h=600&s=1',
            'พิพิธภัณฑ์ปราสาทสัจธรรม',
            'ค้นหาความหมายชีวิตที่พิพิธภัณฑ์ไม้ที่ใหญ่ที่สุดในโลก...',
          ),
          _buildServiceCard(
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/12/a9/26/87/comples.jpg?w=600&h=600&s=1',
            'ศาลเจ้านาจา อ่างศิลา',
            'ศาลเจ้าจีนที่งดงามและสูงถึง 4 ชั้น...',
          ),
          _buildServiceCard(
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/05/7a/de/1e/khao-phra-tamnak.jpg?w=600&h=600&s=1',
            'จุดชมวิวเขาพระตำหนัก',
            'จุดชมวิวที่ตั้งอยู่ระหว่างหาดพัทยาใต้และหาดจอมเทียน...',
          ),
          _buildServiceCard(
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/08/5e/63/04/caption.jpg?w=600&h=600&s=1',
            'เขาสามมุข',
            'จุดท่องเที่ยวที่มีชื่อเสียงควบคู่กับหาดบางแสน...',
          ),
          _buildServiceCard(
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0c/42/70/e5/fiskebatar-i-angsila.jpg?w=600&h=600&s=1',
            'ตลาดเก่าอ่างศิลา',
            'ตลาดเก่าอ่างศิลา เป็นตลาดที่มีมานานถึง 133 ปี...',
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(String imageUrl, String title, String description) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.network(imageUrl, height: 200, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(description, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}