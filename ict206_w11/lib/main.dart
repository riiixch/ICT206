import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/place_list_screen.dart';
import 'screens/add_place_screen.dart';
import 'screens/about_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tourism App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainScreen(), // เปลี่ยนเป็น MainScreen ที่มี BottomNavigationBar
      routes: {
        '/places': (context) => PlaceListScreen(),
        '/add_place': (context) => AddPlaceScreen(),
        '/about': (context) => AboutScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // รายการหน้าที่จะแสดงตาม BottomNavigationBar
  final List<Widget> _screens = [
    HomeScreen(),
    PlaceListScreen(),
    AddPlaceScreen(),
    AboutScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // แสดงหน้าตาม index ที่เลือก
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            label: 'Places',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Place',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}