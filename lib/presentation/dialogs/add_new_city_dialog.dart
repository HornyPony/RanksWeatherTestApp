import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocode/geocode.dart';
import 'package:ranks_test_weather_app/domain/model/user_shared_preferences.dart';
import 'package:ranks_test_weather_app/domain/state/home/home_state.dart';
import 'package:ranks_test_weather_app/generated/l10n.dart';
import 'package:ranks_test_weather_app/presentation/models/added_city_weather.dart';

import '../constants/colors.dart';
import '../constants/styling.dart';

class AddNewCityDialog extends StatelessWidget {
  final HomeState homeState;

  AddNewCityDialog({Key? key, required this.homeState}) : super(key: key);
  final TextEditingController _cityNameFormController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.95),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Container(
        height: 180.h,
        width: 300.w,
        padding: EdgeInsets.symmetric(
          vertical: 20.h,
          horizontal: 8.w,
        ),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).dialog_which_city_text,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  _CityNameForm(
                    controller: _cityNameFormController,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: _saveCityNameBtn(context),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _saveCityNameBtn(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        String enteredCityName = _cityNameFormController.text;
        if (UserSharedPreferences.getAddedCities().isEmpty) {
          await _getWeatherForEnteredCity(context, enteredCityName);
        } else {
          List<AddedCityWeather> addedCityWeatherWithSameName = [];
          _checkIsCityAlreadyExist(
              addedCityWeatherWithSameName, enteredCityName);
          if (addedCityWeatherWithSameName.isEmpty) {
            await _getWeatherForEnteredCity(context, enteredCityName);
          }
        }
        Navigator.of(context).pop();
      },
      child: Text(
        S.of(context).dialog_add_btn,
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.white
            .withOpacity(Styling.almostTransparentContainerOpacity()),
        elevation: 0,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.r),
        ),
      ),
    );
  }

  void _checkIsCityAlreadyExist(
      List<AddedCityWeather> addedCityWeatherWithSameName,
      String enteredCityName) {
    for (AddedCityWeather addedCityWeather
        in UserSharedPreferences.getAddedCities()) {
      if (addedCityWeather.cityName == enteredCityName) {
        addedCityWeatherWithSameName.add(addedCityWeather);
      }
    }
  }

  Future<void> _getWeatherForEnteredCity(
      BuildContext context, String enteredCityName) async {
    GeoCode geoCode = GeoCode();

    try {
      Coordinates _coordinates =
          await geoCode.forwardGeocoding(address: enteredCityName);
      await homeState.getWeather(
          latitude: _coordinates.latitude!, longitude: _coordinates.longitude!);
      homeState.addCityWeather(
        cityName: enteredCityName,
        cityWeather: homeState.weather!.weatherDescription,
        cityCurrentTemp: homeState.weather!.temperature,
      );
      homeState.setCityName(cityName: enteredCityName);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Адрес не найден',
          ),
        ),
      );
    }
  }
}

class _CityNameForm extends StatelessWidget {
  final TextEditingController controller;
  const _CityNameForm({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.name,
        decoration: _getDecoration(context),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16.sp,
          color: Theme.of(context).primaryColor,
        ),
        textInputAction: TextInputAction.done,
      ),
    );
  }

  InputDecoration _getDecoration(BuildContext context) {
    return InputDecoration(
      hintStyle: TextStyle(
        color: Colors.grey[500],
        fontSize: 16.sp,
      ),
      fillColor: CustomColors.inputGreyColor,
      filled: true,
      isDense: true,
      contentPadding: EdgeInsets.symmetric(
        vertical: 8.h,
        horizontal: 14.w,
      ),
      hintText: S.of(context).form_hint_text,
      suffixIconConstraints: BoxConstraints(
        minWidth: 42.w,
        minHeight: 27.h,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Styling.roundedBorderRadius()),
        borderSide: BorderSide(
          color: CustomColors.inputGreyColor,
          width: 3.w,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Styling.roundedBorderRadius()),
        borderSide: BorderSide(
          color: CustomColors.inputGreyColor,
          width: 3.w,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Styling.roundedBorderRadius()),
        borderSide: BorderSide(
          color: CustomColors.inputGreyColor,
          width: 3.w,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Styling.roundedBorderRadius()),
        borderSide: BorderSide(
          color: CustomColors.inputGreyColor,
          width: 3.w,
        ),
      ),
    );
  }
}
