import 'package:ranks_test_weather_app/data/repository/weather_data_repository.dart';
import 'package:ranks_test_weather_app/domain/repository/weather_repository.dart';
import 'package:ranks_test_weather_app/internal/dependencies/api_module.dart';

class RepositoryModule {
  static WeatherRepository? _weatherRepository;

  static WeatherRepository weatherRepository() {
    _weatherRepository ??= WeatherDataRepository(
      ApiModule.apiUtil(),
    );
    return _weatherRepository!;
  }
}
