import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ict206_w10/models/tourism_place.dart';
import 'package:ict206_w10/screens/detail_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<TourismPlace>> futureTourismPlaces;
  List<TourismPlace> allPlaces = [];
  List<TourismPlace> filteredPlaces = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureTourismPlaces = fetchTourismPlaces();
    _searchController.addListener(_filterPlaces);
  }

  Future<List<TourismPlace>> fetchTourismPlaces() async {
    final response = await http.get(Uri.parse('http://localhost/tourism/api/'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((place) => TourismPlace.fromJson(place)).toList();
    } else {
      throw Exception('Failed to load tourism places');
    }
  }

  void _filterPlaces() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredPlaces = allPlaces
          .where((place) => place.name.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'ค้นหาสถานที่...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<TourismPlace>>(
              future: futureTourismPlaces,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  allPlaces = snapshot.data!;
                  filteredPlaces = _searchController.text.isEmpty
                      ? allPlaces
                      : filteredPlaces;
                  return ListView.builder(
                    itemCount: filteredPlaces.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Image.network(
                            "assets/images/${filteredPlaces[index].image}",
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(filteredPlaces[index].name),
                          subtitle: Text(filteredPlaces[index].description),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  place: filteredPlaces[index],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}