import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final TextEditingController _factorial = TextEditingController();
  String _result = "";
  void _calculateFactorial() {
    try {
      final number = int.parse(_factorial.text);
      if (number < 0) {
        setState(() {
          _result = "กรุณาป้อนตัวเลขที่เป็นบวก!";
        });
      } else {
        int factorial = 1;
        for (int i = 1; i <= number; i++) {
          factorial *= i;
        }
        setState(() {
          _result = "$factorial";
        });
      }
    } catch (e) {
      setState(() {
        _result = "กรุณาป้อนตัวเลขที่ถูกต้อง!";
      });
    }
  }

  List<Widget> _buildPages() {
    return [
      Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Color - Container",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 30),
          Text("BLUE",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Container(
            decoration: BoxDecoration(color: Colors.blue),
            height: 100,
          ),
          SizedBox(height: 20),
          Text("RED",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Container(
            decoration: BoxDecoration(color: Colors.red),
            height: 100,
          ),
          SizedBox(height: 20),
          Text("YELLOW",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Container(
            decoration: BoxDecoration(color: Colors.yellow),
            height: 100,
          ),
          SizedBox(height: 20),
          Text("GREEN",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Container(
            decoration: BoxDecoration(color: Colors.green),
            height: 100,
          ),
          SizedBox(height: 20),
          Text("65064435 นาย สมภพ เอี่ยมสมบัติ",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ]),
      ),
      Center(
          child: Column(
        children: [
          Text("Image",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 30),
          Text("First Picture",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Image.network("https://picsum.photos/250?image=9"),
          SizedBox(height: 20),
          Text("Second Picture",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Image.network("https://picsum.photos/250?image=10"),
          SizedBox(height: 20),
          Text("65064435 นาย สมภพ เอี่ยมสมบัติ",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ],
      )),
      Center(
        child: Column(
          children: [
            Text("Factorial",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            Container(
              width: 300,
              height: 60,
              child: TextField(
                controller: _factorial,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "กรอกตัวเลขเพื่อใช้ Factorial",
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateFactorial,
              child: Text("คำนวณผล Factorial"),
            ),
            SizedBox(height: 20),
            Text(
              "ผลลัพธ์ Factorial : $_result",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text("65064435 นาย สมภพ เอี่ยมสมบัติ",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('ICT206'),
        ),
        body: _buildPages()[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.color_lens),
              label: 'Color',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo),
              label: 'Photo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate),
              label: 'Factorial',
            ),
          ],
        ),
      ),
    );
  }
}
