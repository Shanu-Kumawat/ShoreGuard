int predictOceanConditionScore({
  required double waveHeight,
  required double swellWaveHeight,
  required double windWaveHeight,
  required double oceanCurrentVelocity,
}) {
  // Helper function to calculate score based on a value and predefined thresholds
  int getScore(double value, List<double> thresholds) {
    if (value <= thresholds[0]) return 5;
    if (value <= thresholds[1]) return 4;
    if (value <= thresholds[2]) return 3;
    if (value <= thresholds[3]) return 2;
    return 1;
  }

  // Define thresholds for each condition
  List<double> waveHeightThresholds = [0.5, 1.0, 1.5, 2.0]; // in meters
  List<double> swellWaveHeightThresholds = [0.5, 1.0, 1.5, 2.0]; // in meters
  List<double> windWaveHeightThresholds = [0.2, 0.5, 1.0, 1.5]; // in meters
  List<double> oceanCurrentVelocityThresholds = [0.2, 0.5, 1.0, 1.5]; // in m/s

  // Calculate individual scores
  int waveScore = getScore(waveHeight, waveHeightThresholds);
  int swellWaveScore = getScore(swellWaveHeight, swellWaveHeightThresholds);
  int windWaveScore = getScore(windWaveHeight, windWaveHeightThresholds);
  int currentVelocityScore =
      getScore(oceanCurrentVelocity, oceanCurrentVelocityThresholds);

  // Average the scores to get the final ocean condition score
  double averageScore =
      (waveScore + swellWaveScore + windWaveScore + currentVelocityScore) / 4;

  // Round the average score to the nearest whole number
  return averageScore.round();
}
