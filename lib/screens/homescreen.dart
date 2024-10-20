import 'package:flutter/material.dart';
import 'package:shoreguard/OceanApi/calculate_ocean_condition_score.dart';
import 'package:shoreguard/OceanApi/services.dart';
import 'package:shoreguard/screens/pages/alertspage.dart';
import 'package:shoreguard/screens/pages/homepage.dart';
import 'package:shoreguard/screens/pages/searchpage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shoreguard/widgets/ocean_score.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  Position? _currentPosition;
  String locationError = "";

  final List<Widget> _page = [
    HomePage(),
    SearchPage(),
    AlertsPage(),
  ];

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocationAndData(); // Start by fetching the location and data
  }

  // Function to fetch current location and data from OceanInfo
  Future<void> _fetchCurrentLocationAndData() async {
    try {
      Position? position = await _getCurrentLocation();
      setState(() {
        _currentPosition = position;
      });
      if (position != null) {
        final oceanData =
            OceeanInfo(lat: position.latitude, long: position.longitude);
        Map fetchData =
            await oceanData.fetchData(); // Fetch ocean data based on location
        double waveHeight = fetchData["current"]["wave_height"];
        double swellWaveHeight = fetchData["current"]["swell_wave_height"];
        double windWaveHeight = fetchData["current"]["wind_wave_height"];
        double oceanCurrentVelocity =
            fetchData["current"]["ocean_current_velocity"];
        OceanScore.score = calculateOceanConditionScore(
            waveHeight: waveHeight,
            swellWaveHeight: swellWaveHeight,
            windWaveHeight: windWaveHeight,
            oceanCurrentVelocity: oceanCurrentVelocity);
      }
    } catch (e) {
      _showLocationPermissionDialog(
          e.toString()); // Show a dialog in case of errors
    }
  }

  // Function to show a popup dialog requesting location access
  Future<void> _showLocationPermissionDialog(String errorMessage) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Location Permission Required'),
          content: Text(
              'This app requires location access to provide relevant data. Please allow location access. Error: $errorMessage'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close dialog
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close dialog
                await _fetchCurrentLocationAndData(); // Retry permission request
              },
              child: Text('Allow'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.blue),
          onPressed: () {},
        ),
        title: Text('ShoreGuard', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.blue),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _page[selectedIndex]),
          if (locationError.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(locationError, style: TextStyle(color: Colors.red)),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on), label: 'Location'),
          BottomNavigationBarItem(icon: Icon(Icons.warning), label: 'Alerts'),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  // Function to get the current location and request permissions if needed
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
      locationSettings: LocationSettings(accuracy: LocationAccuracy.best),
    );
  }
}
