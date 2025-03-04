import 'package:flutter/material.dart';
import 'products_screen.dart';
import 'escuela_products_screen.dart';
import 'fake_store_in_products_screen.dart'; // เพิ่มการนำเข้า

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const ProductsScreen(),
    const EscuelaProductsScreen(),
    const FakeStoreInProductsScreen(), // เพิ่มหน้าใหม่
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Fake Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Escuela Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop_2),
            label: 'Fake Store IN',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black87,
        onTap: _onItemTapped,
      ),
    );
  }
}