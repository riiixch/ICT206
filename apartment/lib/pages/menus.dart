import 'package:apartment/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class MenusPage extends StatelessWidget {
  const MenusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 8),
            Container(
              width: 356,
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  String? token = await storage.read(key: "token");

                  if (token == null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  } else {

                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.solidUser, size: 18, color: Colors.orange),
                        SizedBox(width: 16),
                        Text("ข้อมูลผู้ใช้งาน"),
                      ],
                    ),
                    FaIcon(FontAwesomeIcons.chevronRight, size: 18, color: Colors.orange),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),
            Container(
              width: 356,
              height: 40,
              child: ElevatedButton(
                onPressed: null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.fileCircleCheck, size: 18, color: Colors.orange),
                        SizedBox(width: 16),
                        Text("เงื่อนไขการใช้บริการ"),
                      ],
                    ),
                    FaIcon(FontAwesomeIcons.chevronRight, size: 18, color: Colors.orange),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),
            Container(
              width: 356,
              height: 40,
              child: ElevatedButton(
                onPressed: null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.shield, size: 18, color: Colors.orange),
                        SizedBox(width: 16),
                        Text("นโยบายความเป็นส่วนตัว"),
                      ],
                    ),
                    FaIcon(FontAwesomeIcons.chevronRight, size: 18, color: Colors.orange),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),
            Container(
              width: 356,
              height: 40,
              child: ElevatedButton(
                onPressed: null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.gear, size: 18, color: Colors.orange),
                        SizedBox(width: 16),
                        Text("ตั้งค่าการใช้งาน"),
                      ],
                    ),
                    FaIcon(FontAwesomeIcons.chevronRight, size: 18, color: Colors.orange),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
