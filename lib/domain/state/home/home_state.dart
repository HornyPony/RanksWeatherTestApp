import 'package:mobx/mobx.dart';
import 'package:ranks_test_weather_app/domain/model/user_shared_preferences.dart';
import 'package:ranks_test_weather_app/domain/model/weather.dart';
import 'package:ranks_test_weather_app/domain/repository/weather_repository.dart';
import 'package:ranks_test_weather_app/presentation/models/added_city_weather.dart';

part 'home_state.g.dart';

class HomeState = HomeStateBase with _$HomeState;

abstract class HomeStateBase with Store {
  final WeatherRepository weatherRepository;

  HomeStateBase({required this.weatherRepository});

  @observable
  Weather? weather;

  @observable
  String? selectedCityName = UserSharedPreferences.getLastCityName();

  @observable
  bool isLoading = false;

  @action
  Future<void> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    isLoading = true;
    final weatherData =
        await weatherRepository.getWeather(lat: latitude, lon: longitude);
    weather = weatherData;
    isLoading = false;
  }

  @action
  void setCityName({required String cityName}) {
    selectedCityName = cityName;
    UserSharedPreferences.setLastCityName(cityName);
  }

  @action
  Future<void> addCityWeather({
    required String cityName,
    required String cityWeather,
    required num cityCurrentTemp,
  }) async {
    List<AddedCityWeather> addedCityWeatherList =
        UserSharedPreferences.getAddedCities();
    addedCityWeatherList.add(
      AddedCityWeather(
          cityName: cityName,
          cityWeather: cityWeather,
          cityCurrentTemperature: cityCurrentTemp),
    );
    await UserSharedPreferences.setAddedCities(addedCityWeatherList);
  }
}
