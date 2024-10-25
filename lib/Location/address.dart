import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> getCurrentAddress(double latitude, double longitude) async {
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
