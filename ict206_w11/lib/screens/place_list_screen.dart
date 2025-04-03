import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/place.dart';
import 'place_detail_screen.dart';

class PlaceListScreen extends StatefulWidget {
  @override
  _PlaceListScreenState createState() => _PlaceListScreenState();
}

class _PlaceListScreenState extends State<PlaceListScreen> {
  late Future<List<Place>> futurePlaces;
  List<Place> allPlaces = [];
  List<Place> filteredPlaces = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futurePlaces = ApiService().getPlaces();
    futurePlaces.then((places) {
      setState(() {
        allPlaces = places;
        filteredPlaces = places;
      });
    });
  }

  void _filterPlaces(String query) {
    setState(() {
      filteredPlaces = allPlaces
          .where((place) =>
              place.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tourist Places')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: _filterPlaces,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Place>>(
              future: futurePlaces,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: filteredPlaces.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.network(filteredPlaces[index].image),
                        title: Text(filteredPlaces[index].name),
                        subtitle: Text(filteredPlaces[index].description),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PlaceDetailScreen(place: filteredPlaces[index]),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}