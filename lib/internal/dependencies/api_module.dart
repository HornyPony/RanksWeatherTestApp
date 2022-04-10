import 'package:ranks_test_weather_app/data/api/api_util.dart';
import 'package:ranks_test_weather_app/data/api/service/weather_service.dart';

class ApiModule {
  static ApiUtil? _apiUtil;

  static ApiUtil apiUtil() {
    _apiUtil ??= ApiUtil(WeatherService());
    return _apiUtil!;
  }
}
