import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:latlong2/latlong.dart';

class Beach {
  final String name;
  final LatLng location;
  final String placeId;

  Beach({required this.name, required this.location, required this.placeId});

  factory Beach.fromJson(Map<String, dynamic> json) {
    return Beach(
      name: json['display_name'],
      location: LatLng(
        double.parse(json['lat']),
        double.parse(json['lon']),
      ),
      placeId: json['place_id'].toString(),
    );
  }
}

class OpenStreetMapService {
  static const String _baseUrl = 'https://nominatim.openstreetmap.org/search';

  Future<List<Beach>> searchBeaches(String query) async {
    final Uri url = Uri.parse('$_baseUrl?q=$query+beach&format=json&limit=10');

    try {
      print('Searching for beaches with query: $query');
      print('URL: $url');

      final response = await http.get(url, headers: {
        'User-Agent': 'ShoreGuardApp/1.0',
      }).timeout(Duration(seconds: 10));

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<Beach> beaches = data.map((place) => Beach.fromJson(place)).toList();
        print('Found ${beaches.length} beaches');
        return beaches;
      } else {
        print('Failed to load beaches: ${response.statusCode}');
        throw Exception('Failed to load beaches: ${response.statusCode}');
      }
    } catch (e) {
      print('Error searching beaches: $e');
      throw Exception('Error searching beaches: $e');
    }
  }
}
