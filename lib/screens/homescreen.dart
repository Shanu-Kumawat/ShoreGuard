import 'package:flutter/material.dart';
import 'package:shoreguard/OceanApi/current_ocean_data.dart';
import 'package:shoreguard/screens/pages/alertspage.dart';
import 'package:shoreguard/screens/pages/homepage.dart';
import 'package:shoreguard/screens/pages/searchpage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  String locationError = "";

  final List<Widget> _page = [
    HomePage(),
    SearchPage(),
    AlertsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.account_circle, color: Colors.blue),
          onPressed: () {},
        ),
        title: Text('ShoreGuard', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.blue),
            onPressed: () {
              setState(() {
                fetchCurrentLocationAndData();
              });
            },
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
}
