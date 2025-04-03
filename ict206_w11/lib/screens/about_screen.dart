import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About Us')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://static.thairath.co.th/media/Dtbezn3nNUxytg04aveWoepodnwuliOM7SkM4fx5pUbErD.webp'), // Add your image
            ),
            SizedBox(height: 16),
            Text('Student ID: 65064435'),
            Text('Name: Sompop Iemsombat'),
          ],
        ),
      ),
    );
  }
}