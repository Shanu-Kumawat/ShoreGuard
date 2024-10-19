import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performSearch(String query) async {
    // Set loading state
    setState(() {
      _isLoading = true;
    });

    // TODO: Implement your Map API call here
    // This is where you would make a call to your chosen Map API
    // For example, if using Google Places API:
    // final results = await GoogleMapsService.searchPlaces(query);

    // Simulating API call with a delay
    await Future.delayed(const Duration(seconds: 1));

    // TODO: Parse the API response and update _searchResults
    // This is just a placeholder. Replace with actual API data
    _searchResults = [
      {'name': 'Sample Location 1', 'address': '123 Main St'},
      {'name': 'Sample Location 2', 'address': '456 Elm St'},
    ];

    // Update UI
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for a location...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchResults.clear();
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  _performSearch(value);
                } else {
                  setState(() {
                    _searchResults.clear();
                  });
                }
              },
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final result = _searchResults[index];
                      return ListTile(
                        leading:
                            const Icon(Icons.location_on, color: Colors.blue),
                        title: Text(result['name']),
                        subtitle: Text(result['address']),
                        onTap: () {
                          // TODO: Handle location selection
                          print('Selected: ${result['name']}');
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
