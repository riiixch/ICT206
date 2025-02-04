import 'package:apartment/pages/billing.dart';
import 'package:apartment/pages/home.dart';
import 'package:apartment/pages/menus.dart';
import 'package:apartment/pages/notifications.dart';
import 'package:apartment/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ICT Apartment',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    SearchPage(),
    BillingPage(),
    NotificationsPage(),
    MenusPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("ICT Apartment", style: TextStyle(fontWeight: FontWeight.bold))
          ],
        ),
      ),

      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house, size: 18),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.search, size: 18),
            label: 'ค้นหาห้อง',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.receipt, size: 18),
            label: 'บิลค่าห้อง',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.bell, size: 18),
            label: 'แจ้งเตือน',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_sharp),
            label: 'เมนูเพิ่มเติม',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
