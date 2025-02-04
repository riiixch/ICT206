import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 8),
            Container(
              width: 320,
              height: 40,
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 117, 191, 225),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: FaIcon(FontAwesomeIcons.bell, size: 18),
                    ),
                  ),
                  SizedBox(width: 16),
                  Text("ค่าห้อง 3,500 บาท")
                ],
              ),
            ),
            SizedBox(height: 8),
            Container(
              width: 320,
              height: 40,
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 117, 191, 225),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: FaIcon(FontAwesomeIcons.bell, size: 18),
                    ),
                  ),
                  SizedBox(width: 16),
                  Text("แจ้งซ่อมไฟวันที่ 16 ม.ค. 2568\nเวลา 13.00 น. - 15.00 น.")
                ],
              ),
            ),
            SizedBox(height: 8),
            Container(
              width: 320,
              height: 40,
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 117, 191, 225),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: FaIcon(FontAwesomeIcons.bell, size: 18),
                    ),
                  ),
                  SizedBox(width: 16),
                  Text("ค่าห้อง 3,500 บาท")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
