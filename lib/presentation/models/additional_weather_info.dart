import 'package:flutter/cupertino.dart';
import 'package:ranks_test_weather_app/domain/state/home/home_state.dart';
import 'package:ranks_test_weather_app/generated/l10n.dart';

class AdditionalWeatherInfo {
  final String title;
  final String info;

  AdditionalWeatherInfo({
    required this.title,
    required this.info,
  });

  static List<AdditionalWeatherInfo> getAllAdditionalWeatherInfo(
      {required HomeState homeState, required BuildContext context}) {
    return [
      AdditionalWeatherInfo(
        title: S.of(context).home_screen_feels_text,
        info: '${homeState.weather!.temperatureFeelsLike} °C',
      ),
      AdditionalWeatherInfo(
        title: S.of(context).home_screen_humidity_text,
        info: '${homeState.weather!.humidity}%',
      ),
      AdditionalWeatherInfo(
        title: S.of(context).home_screen_pressure_text,
        info:
            '${homeState.weather!.pressure}${S.of(context).measure_mbar_text}',
      ),
      AdditionalWeatherInfo(
        title: S.of(context).home_screen_wind_speed_text,
        info:
            '${homeState.weather!.windSpeed} ${S.of(context).measure_speed_text}',
      ),
    ];
  }
}
