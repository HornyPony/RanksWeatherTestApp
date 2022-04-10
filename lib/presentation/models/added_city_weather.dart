import 'dart:convert';

class AddedCityWeather {
  final String cityName;
  final String cityWeather;
  final num cityCurrentTemperature;

  AddedCityWeather(
      {required this.cityName,
      required this.cityWeather,
      required this.cityCurrentTemperature});

  factory AddedCityWeather.fromJson(Map<String, dynamic> jsonData) {
    return AddedCityWeather(
      cityName: jsonData['cityName'],
      cityWeather: jsonData['cityWeather'],
      cityCurrentTemperature: jsonData['temperature'],
    );
  }

  static Map<String, dynamic> toMap(AddedCityWeather addedCityWeather) => {
        'cityName': addedCityWeather.cityName,
        'cityWeather': addedCityWeather.cityWeather,
        'temperature': addedCityWeather.cityCurrentTemperature,
      };

  static String encode(List<AddedCityWeather> addedCityWeatherList) =>
      json.encode(
        addedCityWeatherList
            .map<Map<String, dynamic>>(
                (addedCityWeather) => AddedCityWeather.toMap(addedCityWeather))
            .toList(),
      );

  static List<AddedCityWeather>? decode(String addedCityWeatherList) =>
      (json.decode(addedCityWeatherList) as List<dynamic>)
          .map<AddedCityWeather>((item) => AddedCityWeather.fromJson(item))
          .toList();
}
