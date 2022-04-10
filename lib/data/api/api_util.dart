import 'package:ranks_test_weather_app/data/api/request/get_weather_body.dart';
import 'package:ranks_test_weather_app/data/api/service/weather_service.dart';
import 'package:ranks_test_weather_app/data/mapper/weather_mapper.dart';
import 'package:ranks_test_weather_app/domain/model/weather.dart';

class ApiUtil {
  final WeatherService _weatherService;

  ApiUtil(this._weatherService);

  Future<Weather> getWeather({
    required double lat,
    required double lon,
  }) async {
    final body = GetWeatherBody(lat: lat, lon: lon);
    final result = await _weatherService.getWeather(getWeatherBody: body);
    return WeatherMapper.fromApi(result);
  }
}
