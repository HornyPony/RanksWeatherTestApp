import 'package:shared_preferences/shared_preferences.dart';
import '../../presentation/models/added_city_weather.dart';

class UserSharedPreferences {
  static SharedPreferences? _preferences;

  static Future<void> init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future<void> setAddedCities(
      List<AddedCityWeather> addedCitiesList) async {
    final String encodedData = AddedCityWeather.encode(addedCitiesList);

    await _preferences!.setString('added_cities_list', encodedData);
  }

  static List<AddedCityWeather> getAddedCities() {
    final String? addedCitiesListString =
        _preferences!.getString('added_cities_list');
    List<AddedCityWeather> addedCityWeatherList;
    if (addedCitiesListString != null) {
      addedCityWeatherList = AddedCityWeather.decode(addedCitiesListString)!;
    } else {
      addedCityWeatherList = [];
    }

    return addedCityWeatherList;
  }

  static Future<void> setLastCityName(String cityName) async {
    await _preferences!.setString('last_city_name', cityName);
  }

  static String getLastCityName() {
    String lastCityName = _preferences!.getString('last_city_name') ?? '';
    return lastCityName;
  }
}
