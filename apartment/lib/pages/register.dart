import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("สมัครสมาชิก")),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 8),
              Text("สมัครสมาชิก", style: TextStyle(fontSize: 32)),
              SizedBox(height: 32),
              Container(
                width: 356,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.solidUser, size: 16),
                        SizedBox(width: 8),
                        Text("ชื่อผู้ใช้งาน", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Container(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'ชื่อผู้ใช้งาน',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: 356,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.solidEnvelope, size: 16),
                        SizedBox(width: 8),
                        Text("อีเมล", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Container(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'อีเมล',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: 356,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.lock, size: 16),
                        SizedBox(width: 8),
                        Text("รหัสผ่าน", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Container(
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'รหัสผ่าน',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: 356,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.lock, size: 16),
                        SizedBox(width: 8),
                        Text("ยืนยันรหัสผ่าน", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Container(
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'ยืนยันรหัสผ่าน',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              Container(
                width: 356,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("สมัครสมาชิก", style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}