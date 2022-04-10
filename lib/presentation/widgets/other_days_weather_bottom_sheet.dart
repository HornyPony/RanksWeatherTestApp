import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ranks_test_weather_app/domain/model/daily_weather.dart';
import 'package:ranks_test_weather_app/generated/l10n.dart';
import 'package:ranks_test_weather_app/presentation/constants/colors.dart';

class OtherDaysWeatherBottomSheet {
  static Widget otherDaysWeatherBottomSheet(
      context, List<DailyWeather> dailyWeatherList) {
    return Container(
      height: 240.h,
      padding: EdgeInsets.only(
        left: 15.w,
        right: 15.w,
        top: 16.h,
      ),
      child: _OtherDayWeatherBottomSheetBody(
        dailyWeatherList: dailyWeatherList,
      ),
    );
  }
}

class _OtherDayWeatherBottomSheetBody extends StatelessWidget {
  final List<DailyWeather> dailyWeatherList;
  const _OtherDayWeatherBottomSheetBody({required this.dailyWeatherList});

  List<Widget> otherDaysWeatherList() {
    List<Widget> list = [];
    for (int i = 1; i < 5; i++) {
      list.add(
        _OneDayInfoColumn(
          date: dailyWeatherList[i].date,
          maxTemperature: dailyWeatherList[i].maxTemperature,
          minTemperature: dailyWeatherList[i].minTemperature,
          morningTemperature: dailyWeatherList[i].morningTemperature,
          eveTemperature: dailyWeatherList[i].eveTemperature,
          windSpeed: dailyWeatherList[i].windSpeed,
          weatherIconId: dailyWeatherList[i].weatherIconId,
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _nextFourDaysText(context),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: otherDaysWeatherList(),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _nextFourDaysText(BuildContext context) {
    return Text(
      S.of(context).next_4days_text,
      style: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w100,
        color: Colors.black,
      ),
    );
  }
}

class _OneDayInfoColumn extends StatelessWidget {
  final String date;
  final num maxTemperature;
  final num minTemperature;
  final num morningTemperature;
  final num eveTemperature;
  final num windSpeed;
  final String weatherIconId;

  const _OneDayInfoColumn({
    Key? key,
    required this.date,
    required this.maxTemperature,
    required this.minTemperature,
    required this.morningTemperature,
    required this.eveTemperature,
    required this.windSpeed,
    required this.weatherIconId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _MaxMinTempInfo(
          maxTemperature: maxTemperature,
          minTemperature: minTemperature,
        ),
        _AdditionalInfoColumn(
          morningTemperature: morningTemperature,
          eveTemperature: eveTemperature,
          windSpeed: windSpeed,
          date: date,
          weatherIconId: weatherIconId,
        ),
      ],
    );
  }
}

class _MaxMinTempInfo extends StatelessWidget {
  final num maxTemperature;
  final num minTemperature;

  const _MaxMinTempInfo(
      {Key? key, required this.maxTemperature, required this.minTemperature})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _WeatherInfoText(info: '$maxTemperature°C'),
        SizedBox(
          height: 2.h,
        ),
        maxMinTempGradientContainer(),
        SizedBox(
          height: 2.h,
        ),
        _WeatherInfoText(info: '$minTemperature°C'),
      ],
    );
  }

  Widget maxMinTempGradientContainer() {
    return Container(
      width: 8.w,
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF3366FF),
            Color(0xFF00CCFF),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}

class _AdditionalInfoColumn extends StatelessWidget {
  final String date;
  final num morningTemperature;
  final num eveTemperature;
  final num windSpeed;
  final String weatherIconId;

  const _AdditionalInfoColumn({
    Key? key,
    required this.date,
    required this.morningTemperature,
    required this.eveTemperature,
    required this.windSpeed,
    required this.weatherIconId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _additionalInfoRow(
          image: 'assets/images/sunrise_icon.png',
          info: '$morningTemperature °C',
        ),
        _additionalInfoRow(
          image: 'assets/images/sunset_icon.png',
          info: '$eveTemperature °C',
        ),
        _additionalInfoRow(
          image: 'assets/images/wind_speed_icon.png',
          info: '$windSpeed ${S.of(context).measure_speed_text}',
        ),
        SizedBox(
            width: 30.w,
            height: 30.w,
            child: Image.network(
                'http://openweathermap.org/img/w/$weatherIconId.png')),
        _WeatherInfoText(info: date),
      ],
    );
  }

  Widget _additionalInfoRow({required String image, required String info}) {
    return Row(
      children: [
        Container(
          width: 20.w,
          height: 20.w,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
            image,
          ))),
        ),
        SizedBox(
          width: 2.w,
        ),
        _WeatherInfoText(info: info),
      ],
    );
  }
}

class _WeatherInfoText extends StatelessWidget {
  final String info;

  const _WeatherInfoText({required this.info});
  @override
  Widget build(BuildContext context) {
    return Text(
      info,
      style: TextStyle(
        fontSize: 12.sp,
        color: CustomColors.homeScreenGradientStartColor,
      ),
    );
  }
}
