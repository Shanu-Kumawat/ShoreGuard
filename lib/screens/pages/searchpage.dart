import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:shoreguard/OpenStreetMap/services.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class SearchState extends ChangeNotifier {
  String _searchQuery = '';
  List<Beach> _searchResults = [];
  LatLng _mapCenter = LatLng(0, 0);
  double _mapZoom = 2.0;

  String get searchQuery => _searchQuery;
  List<Beach> get searchResults => _searchResults;
  LatLng get mapCenter => _mapCenter;
  double get mapZoom => _mapZoom;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSearchResults(List<Beach> results) {
    _searchResults = results;
    if (results.isNotEmpty) {
      _mapCenter = results[0].location;
      _mapZoom = 10.0;
    }
    notifyListeners();
  }

  void setMapPosition(LatLng center, double zoom) {
    _mapCenter = center;
    _mapZoom = zoom;
    notifyListeners();
  }
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Beach> _searchResults = [];
  bool _isLoading = false;
  final OpenStreetMapService _mapService = OpenStreetMapService();
  final MapController _mapController = MapController();
  List<Marker> _markers = [];
  LatLng? _selectedMarkerPosition;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final searchState = Provider.of<SearchState>(context, listen: false);
      _searchController.text = searchState.searchQuery;
      _updateMapMarkers();
      _mapController.move(searchState.mapCenter, searchState.mapZoom);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performSearch(String query) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final results = await _mapService.searchBeaches(query);
      Provider.of<SearchState>(context, listen: false)
          .setSearchResults(results);
      _updateMapMarkers();
      if (results.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No beaches found for "$query"')),
        );
      }
    } catch (e) {
      print('Error searching beaches: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error searching beaches: ${e.toString()}')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _updateMapMarkers() {
    final searchState = Provider.of<SearchState>(context, listen: false);
    _markers = searchState.searchResults
        .map((beach) => Marker(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedMarkerPosition = beach.location;
                  });
                },
                child: Icon(Icons.location_on, color: Colors.red),
              ),
              width: 80.0,
              height: 80.0,
              point: beach.location,
            ))
        .toList();

    if (searchState.searchResults.isNotEmpty) {
      _mapController.move(searchState.mapCenter, searchState.mapZoom);
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchState>(context);

    _searchController.text = searchState.searchQuery;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              searchState.setSearchQuery(value);
            },
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: 'Search for a beach...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchResults.clear();
                          _markers.clear();
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
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                _performSearch(value);
              }
            },
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        initialCenter: searchState.mapCenter,
                        initialZoom: searchState.mapZoom,
                        onPositionChanged: (position, hasGesture) {
                          if (hasGesture) {
                            searchState.setMapPosition(
                              position.center!,
                              position.zoom!,
                            );
                          }
                        },
                        onTap: (_, __) {
                          setState(() {
                            _selectedMarkerPosition = null;
                          });
                        },
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: ['a', 'b', 'c'],
                        ),
                        MarkerLayer(markers: _markers),
                      ],
                    ),
              if (_selectedMarkerPosition != null)
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      'Latitude: ${_selectedMarkerPosition!.latitude.toStringAsFixed(6)}\n'
                      'Longitude: ${_selectedMarkerPosition!.longitude.toStringAsFixed(6)}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
