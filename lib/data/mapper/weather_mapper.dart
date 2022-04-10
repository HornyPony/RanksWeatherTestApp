import 'package:intl/intl.dart';
import 'package:ranks_test_weather_app/domain/model/daily_weather.dart';
import 'package:ranks_test_weather_app/domain/model/hourly_weather.dart';

import '../api/model/api_weather.dart';
import 'package:ranks_test_weather_app/domain/model/weather.dart';

class WeatherMapper {
  static Weather fromApi(ApiWeather apiWeather) {
    return Weather(
      temperatureFeelsLike: apiWeather.temperatureFeelsLike,
      weatherDescription: apiWeather.weatherDescription,
      temperature: apiWeather.temperature,
      windSpeed: apiWeather.windSpeed,
      humidity: apiWeather.humidity,
      pressure: apiWeather.pressure,
      hourlyWeatherList: apiWeather.hourlyWeatherList
          .map(
            (hourlyWeather) => HourlyWeather(
              time: DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
                  hourlyWeather['dt'] * 1000)),
              temperature: hourlyWeather['temp'],
              weatherDescription: hourlyWeather['weather'][0]['description'],
              windSpeed: hourlyWeather['wind_speed'],
            ),
          )
          .toList(),
      dailyWeatherList: apiWeather.dailyWeatherList
          .map(
            (dailyWeather) => DailyWeather(
                date: DateFormat('dd.MM').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        dailyWeather['dt'] * 1000)),
                maxTemperature: double.parse(
                    dailyWeather['temp']['max'].toStringAsFixed(1)),
                minTemperature: double.parse(
                    dailyWeather['temp']['min'].toStringAsFixed(1)),
                morningTemperature: double.parse(
                    dailyWeather['feels_like']['morn'].toStringAsFixed(1)),
                eveTemperature: double.parse(
                    dailyWeather['feels_like']['eve'].toStringAsFixed(1)),
                windSpeed:
                    double.parse(dailyWeather['wind_speed'].toStringAsFixed(1)),
                weatherIconId: dailyWeather['weather'][0]['icon']),
          )
          .toList(),
    );
  }
}
