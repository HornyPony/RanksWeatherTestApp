import '../api/api_util.dart';
import 'package:ranks_test_weather_app/domain/model/weather.dart';
import 'package:ranks_test_weather_app/domain/repository/weather_repository.dart';

class WeatherDataRepository extends WeatherRepository {
  final ApiUtil _apiUtil;

  WeatherDataRepository(this._apiUtil);

  @override
  Future<Weather> getWeather({required double lat, required double lon}) {
    return _apiUtil.getWeather(lat: lat, lon: lon);
  }
}
