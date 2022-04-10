class DailyWeather {
  final String date;
  final num maxTemperature;
  final num minTemperature;
  final num morningTemperature;
  final num eveTemperature;
  final num windSpeed;
  final String weatherIconId;

  DailyWeather({
    required this.date,
    required this.maxTemperature,
    required this.minTemperature,
    required this.morningTemperature,
    required this.eveTemperature,
    required this.windSpeed,
    required this.weatherIconId,
  });
}
