// Function to fetch current location and data from OceanInfo
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shoreguard/Location/coordinates.dart';
import 'package:shoreguard/OceanApi/predict_ocean_condition_score.dart';
import 'package:shoreguard/OceanApi/services.dart';
import '../widgets/ocean_score.dart';

Future<void> fetchCurrentLocationAndData() async {
  try {
    // Fetch current location in terms of coordinates
    Position? position = await getCurrentCoordinates();
    if (position != null) {
      final oceanData =
          OceanData(lat: position.latitude, long: position.longitude);
      if (kDebugMode) {
        print("${position.latitude} ${position.longitude} ");
      }

      // Fetch ocean data based on location
      Map fetchData = await oceanData.fetchData();
      if (kDebugMode) {
        print(fetchData);
      }

      // checking if person is near ocean or not
      if (fetchData["current"]["wave_height"] != null) {
        double waveHeight = await fetchData["current"]["wave_height"];
        double swellWaveHeight =
            await fetchData["current"]["swell_wave_height"];
        double windWaveHeight = await fetchData["current"]["wind_wave_height"];
        double oceanCurrentVelocity =
            await fetchData["current"]["ocean_current_velocity"];

        //person is near ocean and predict ocean condition score
        OceanScore.score = predictOceanConditionScore(
            waveHeight: waveHeight,
            swellWaveHeight: swellWaveHeight,
            windWaveHeight: windWaveHeight,
            oceanCurrentVelocity: oceanCurrentVelocity);
      } else {
        //person is away from ocean
        OceanScore.score = 0;
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}
