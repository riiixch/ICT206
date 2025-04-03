import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  final Place place;

  PlaceDetailScreen({required this.place});

  Future<void> _launchUrl(String url) async {
    String validUrl = url.trim(); // ลบช่องว่างส่วนเกิน
    if (!validUrl.startsWith('http://') && !validUrl.startsWith('https://')) {
      validUrl = 'https://$validUrl'; // เติม https:// ถ้าขาด
    }
    final Uri uri = Uri.parse(validUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $validUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.name)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(place.image),
            SizedBox(height: 16),
            Text(place.name, style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 8),
            Text(place.description),
            SizedBox(height: 16),
            InkWell(
              onTap: () async {
                print('Attempting to launch: ${place.location}'); // Debug
                try {
                  await _launchUrl(place.location);
                } catch (e) {
                  print('Error: $e'); // Debug
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Could not open location URL')),
                  );
                }
              },
              child: Text(
                'Location: ${place.location}',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            SizedBox(height: 8),
            Text('Created: ${place.createdAt}'),
          ],
        ),
      ),
    );
  }
}