class Weather {
  final String cityName;
  final String condition;
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final double windSpeed;
  final int windDeg;

  Weather(
      {required this.cityName,
      required this.temperature,
      required this.feelsLike,
      required this.tempMin,
      required this.tempMax,
      required this.humidity,
      required this.windSpeed,
      required this.windDeg,
      required this.condition});
}
