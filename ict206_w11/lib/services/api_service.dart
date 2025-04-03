import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/place.dart';

class ApiService {
  static const String baseUrl = 'http://localhost/flutter_tourism'; // Adjust this URL

  Future<List<Place>> getPlaces() async {
    final response = await http.get(Uri.parse('$baseUrl/show_places.php'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((place) => Place.fromJson(place)).toList();
    } else {
      throw Exception('Failed to load places');
    }
  }

  Future<void> addPlace(Place place) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add_places.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': place.name,
        'description': place.description,
        'image': place.image,
        'location': place.location,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add place');
    }
  }
}