import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ชื่อผู้ใช้งาน'),
                SizedBox(height: 4),
                Container(
                  width: 320,
                  height: 64,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'ชื่อผู้ใช้งาน',
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('รหัสผ่าน'),
                SizedBox(height: 4),
                Container(
                  width: 320,
                  height: 64,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'รหัสผ่าน',
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
