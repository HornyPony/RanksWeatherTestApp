import 'package:ranks_test_weather_app/domain/model/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather({
    required double lat,
    required double lon,
  });
}
