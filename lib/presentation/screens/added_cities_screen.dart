import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocode/geocode.dart';
import 'package:ranks_test_weather_app/domain/model/user_shared_preferences.dart';
import 'package:ranks_test_weather_app/domain/state/home/home_state.dart';
import 'package:ranks_test_weather_app/generated/l10n.dart';
import 'package:ranks_test_weather_app/presentation/constants/styling.dart';
import 'package:ranks_test_weather_app/presentation/models/added_city_weather.dart';

import '../widgets/search_widget.dart';

class AddedCitiesScreen extends StatelessWidget {
  final HomeState homeState;

  const AddedCitiesScreen({Key? key, required this.homeState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          S.of(context).your_cities_text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Styling.screenGradient(
        context,
        SafeArea(
          child: _AddedCitiesScreenBody(
            homeState: homeState,
          ),
        ),
      ),
    );
  }
}

class _AddedCitiesScreenBody extends StatefulWidget {
  final HomeState homeState;

  const _AddedCitiesScreenBody({required this.homeState});

  @override
  State<_AddedCitiesScreenBody> createState() => _AddedCitiesScreenBodyState();
}

class _AddedCitiesScreenBodyState extends State<_AddedCitiesScreenBody> {
  List<AddedCityWeather> addedCitiesWeather =
      UserSharedPreferences.getAddedCities();
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Styling.screenPadding()),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearch(),
            Column(
              children: addedCitiesWeather
                  .map((addedCity) => _AddedCityContainer(
                        cityName: addedCity.cityName,
                        cityWeather: addedCity.cityWeather,
                        cityTemperature: addedCity.cityCurrentTemperature,
                        homeState: widget.homeState,
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return SearchWidget(
      text: query,
      hintText: S.of(context).form_hint_text,
      onChanged: _searchCity,
    );
  }

  void _searchCity(String query) {
    final cities = UserSharedPreferences.getAddedCities().where((city) {
      final cityNameLower = city.cityName.toLowerCase();
      final searchLower = query.toLowerCase();

      return (cityNameLower.contains(searchLower));
    }).toList();

    setState(() {
      this.query = query;
      addedCitiesWeather = cities;
    });
  }
}

class _AddedCityContainer extends StatelessWidget {
  final String cityName;
  final String cityWeather;
  final num cityTemperature;
  final HomeState homeState;

  const _AddedCityContainer({
    Key? key,
    required this.cityName,
    required this.cityWeather,
    required this.cityTemperature,
    required this.homeState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        GeoCode geoCode = GeoCode();
        Coordinates _coordinates =
            await geoCode.forwardGeocoding(address: cityName);
        await homeState.getWeather(
            latitude: _coordinates.latitude!,
            longitude: _coordinates.longitude!);
        homeState.setCityName(cityName: cityName);
        Navigator.of(context).pop();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: Colors.white
              .withOpacity(Styling.almostTransparentContainerOpacity()),
        ),
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 16.w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _cityNameText(context, cityName),
                _cityWeatherText(context, cityWeather),
              ],
            ),
            _cityTemperatureText(context, cityTemperature),
          ],
        ),
      ),
    );
  }

  Widget _cityNameText(BuildContext context, String name) {
    return Text(
      name,
      style: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w700,
        fontSize: 16.sp,
      ),
    );
  }

  Widget _cityWeatherText(BuildContext context, String weather) {
    return Text(
      weather,
      style: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontSize: 12.sp,
      ),
    );
  }

  Widget _cityTemperatureText(BuildContext context, num temperature) {
    return Text(
      '$temperature °C',
      style: TextStyle(
        fontSize: 26.sp,
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
