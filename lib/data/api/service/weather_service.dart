import 'package:dio/dio.dart';
import '../model/api_weather.dart';
import 'package:ranks_test_weather_app/data/api/request/get_weather_body.dart';

class WeatherService {
  static const _BASE_URL = 'https://api.openweathermap.org/data/2.5/onecall';

  final Dio _dio = Dio(
    BaseOptions(baseUrl: _BASE_URL),
  );

  Future<ApiWeather> getWeather(
      {required GetWeatherBody getWeatherBody}) async {
    final response = await _dio.get(
      _BASE_URL,
      queryParameters: getWeatherBody.toApi(),
    );
    return ApiWeather.fromApi(response.data);
  }
}
