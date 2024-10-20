import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gif/gif.dart';
import 'package:http/http.dart' as http;
import 'package:shoreguard/oceanmap.dart';
import 'package:shoreguard/widgets/ocean_score.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var conditionDetails = oceanConditionMap[OceanScore.score];
  List suitableActivity =
      oceanConditionMap[OceanScore.score]!['suitableActivities'];
  late GifController controller;
  String locationName = 'Loading...';

  Future<String> getLocationInfo(double latitude, double longitude) async {
    final url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1';

    final response =
        await http.get(Uri.parse(url), headers: {'User-Agent': 'ShoreGuard'});

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final address = data['address'];

      if (address.containsKey('beach')) {
        final beachName = address['beach'] ?? '';
        final city =
            address['city'] ?? address['town'] ?? address['village'] ?? '';
        return '$beachName, $city';
      } else {
        final city =
            address['city'] ?? address['town'] ?? address['village'] ?? '';
        final country = address['country'] ?? '';
        return '$city, $country';
      }
    } else {
      return 'Location information not available';
    }
  }

  @override
  void initState() {
    super.initState();
    print(OceanScore.score);
    print("Homepage score ${OceanScore.score}");
    controller = GifController(vsync: this);
    controller.repeat(
        min: 0, max: 1, period: const Duration(milliseconds: 3000));

    // Call a separate method to handle the asynchronous operations
    _loadLocationInfo();
  }

  // New method to handle asynchronous operations
  void _loadLocationInfo() async {
    try {
      Position? position = await _getCurrentLocation();
      if (position != null) {
        String location = await getLocationInfo(position.latitude, position.longitude);
        setState(() {
          locationName = location;
        });
      }
    } catch (e) {
      print('Error getting location: $e');
      setState(() {
        locationName = 'Unable to get location';
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background GIF
        Positioned.fill(
          child: Gif(
            controller: controller,
            image: AssetImage(conditionDetails!['backgroundGifPath'] as String),
            fit: BoxFit.cover,
          ),
        ),
        // Overlay with semi-transparent background for readability
        Container(
          color: Colors.black.withOpacity(0.5),
        ),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.blue),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        locationName,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    _buildCard(
                      'Ocean Condition Score:',
                      child: Column(
                        children: [
                          SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: OceanScore.score * 0.2,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                                OceanScore.score > 3
                                    ? Colors.green
                                    : OceanScore.score > 1
                                        ? Colors.yellow
                                        : Colors.red),
                          ),
                          SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: OceanScore.score==0? Text('-'):Text('${OceanScore.score}/5',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      icon: Icons.waves,
                    ),
                    SizedBox(height: 16),
                    _buildCard(
                      'Activity-specific Suitability:',
                      child: SizedBox(
                        height: suitableActivity.length.toDouble() * 30,
                        child: ListView.builder(
                          itemCount: suitableActivity.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: Text(
                                "- ${suitableActivity[index]}",
                                style: TextStyle(fontSize: 17),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCard(String title, {Widget? child, IconData? icon}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (icon != null) Icon(icon, color: Colors.blue),
                if (icon != null) SizedBox(width: 8),
                Text(title,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            if (child != null) child,
          ],
        ),
      ),
    );
  }

  Future<Position?> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied. Enable them from settings.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
  }
}
