import 'package:http/http.dart' as http;
import 'dart:convert';

class Beach {
  final String name;
  final double lat;
  final double lon;

  Beach({required this.name, required this.lat, required this.lon});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lat': lat,
      'lon': lon,
    };
  }
}

class BeachService {
  final String overpassUrl = 'https://overpass-api.de/api/interpreter';

  Future<List<Beach>> searchBeaches(String query) async {
    // Overpass QL query to search for beaches
    final overpassQuery = '''
      [out:json];
      area["name"~"$query",i]->.searchArea;
      (
        node["natural"="beach"](area.searchArea);
        way["natural"="beach"](area.searchArea);
        relation["natural"="beach"](area.searchArea);
      );
      out center;
    ''';

    final response =
        await http.post(Uri.parse(overpassUrl), body: {'data': overpassQuery});

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      List<Beach> beaches = [];
      for (var element in data['elements']) {
        if (element['type'] == 'node') {
          beaches.add(Beach(
            name: element['tags']['name'] ?? 'Unnamed Beach',
            lat: element['lat'],
            lon: element['lon'],
          ));
        } else {
          beaches.add(Beach(
            name: element['tags']['name'] ?? 'Unnamed Beach',
            lat: element['center']['lat'],
            lon: element['center']['lon'],
          ));
        }
      }
      return beaches;
    } else {
      throw Exception('Failed to load beaches');
    }
  }
}
