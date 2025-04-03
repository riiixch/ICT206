import 'package:flutter/material.dart';
import 'package:ict206_w10/models/tourism_place.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  final TourismPlace place;

  const DetailPage({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final List<String> coordinates = place.location.split(', ');
    final double lat = double.parse(coordinates[0]);
    final double lng = double.parse(coordinates[1]);
    final String mapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng';

    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/${place.image}",
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    place.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'พิกัด: ${place.location}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (await canLaunchUrl(Uri.parse(mapsUrl))) {
                        await launchUrl(Uri.parse(mapsUrl));
                      } else {
                        throw 'Could not launch $mapsUrl';
                      }
                    },
                    icon: const Icon(Icons.map),
                    label: const Text('ดูใน Google Maps'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}