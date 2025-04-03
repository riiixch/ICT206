import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShowDataPage extends StatefulWidget {
  @override
  _ShowDataPageState createState() => _ShowDataPageState();
}

class _ShowDataPageState extends State<ShowDataPage> {
  List<dynamic> users = [];
  List<dynamic> filteredUsers = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUsers();
    searchController.addListener(_filterUsers);
  }

  Future<void> fetchUsers() async {
    final response = await http.get(Uri.parse('http://localhost/flutter_users/get_users.php'));
    if (response.statusCode == 200) {
      setState(() {
        users = jsonDecode(response.body);
        filteredUsers = users;
      });
    }
  }

  void _filterUsers() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredUsers = users.where((user) =>
          user['firstname'].toLowerCase().contains(query) ||
          user['lastname'].toLowerCase().contains(query)).toList();
    });
  }

  void _showUserDetails(dynamic user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          '${user['firstname']} ${user['lastname']}',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${user['email']}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Created: ${user['created_at']}', style: TextStyle(fontSize: 16)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(color: Colors.teal)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              labelText: 'Search Users',
              prefixIcon: Icon(Icons.search, color: Colors.teal),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                final user = filteredUsers[index];
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      '${user['firstname']} ${user['lastname']}',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Text(user['email'], style: TextStyle(color: Colors.grey[600])),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.teal),
                    onTap: () => _showUserDetails(user),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}