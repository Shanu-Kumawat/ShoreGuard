import 'package:http/http.dart' as http;
import 'dart:convert';

class OceanData {
  final double lat;
  final double long;

  OceanData({required this.lat, required this.long});

  Future fetchData() async {
    final Uri url = Uri.parse(
        "https://marine-api.open-meteo.com/v1/marine?latitude=$lat&longitude=$long&current=wave_height,wind_wave_height,swell_wave_height,ocean_current_velocity&wind_speed_unit=ms");

    try {
      final response = await http.get(url).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to load beaches: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }
}
