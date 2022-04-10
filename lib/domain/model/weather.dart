import 'package:ranks_test_weather_app/domain/model/daily_weather.dart';
import 'package:ranks_test_weather_app/domain/model/hourly_weather.dart';

class Weather {
  final num temperature;
  final num temperatureFeelsLike;
  final int pressure;
  final int humidity;
  final String weatherDescription;
  final double windSpeed;
  final List<HourlyWeather> hourlyWeatherList;
  final List<DailyWeather> dailyWeatherList;

  Weather({
    required this.temperature,
    required this.temperatureFeelsLike,
    required this.pressure,
    required this.humidity,
    required this.weatherDescription,
    required this.windSpeed,
    required this.hourlyWeatherList,
    required this.dailyWeatherList,
  });
}
