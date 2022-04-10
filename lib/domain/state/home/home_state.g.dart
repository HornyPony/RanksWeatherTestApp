// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeState on HomeStateBase, Store {
  final _$weatherAtom = Atom(name: 'HomeStateBase.weather');

  @override
  Weather? get weather {
    _$weatherAtom.reportRead();
    return super.weather;
  }

  @override
  set weather(Weather? value) {
    _$weatherAtom.reportWrite(value, super.weather, () {
      super.weather = value;
    });
  }

  final _$selectedCityNameAtom = Atom(name: 'HomeStateBase.selectedCityName');

  @override
  String? get selectedCityName {
    _$selectedCityNameAtom.reportRead();
    return super.selectedCityName;
  }

  @override
  set selectedCityName(String? value) {
    _$selectedCityNameAtom.reportWrite(value, super.selectedCityName, () {
      super.selectedCityName = value;
    });
  }

  final _$isLoadingAtom = Atom(name: 'HomeStateBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$getWeatherAsyncAction = AsyncAction('HomeStateBase.getWeather');

  @override
  Future<void> getWeather(
      {required double latitude, required double longitude}) {
    return _$getWeatherAsyncAction
        .run(() => super.getWeather(latitude: latitude, longitude: longitude));
  }

  final _$addCityWeatherAsyncAction =
      AsyncAction('HomeStateBase.addCityWeather');

  @override
  Future<void> addCityWeather(
      {required String cityName,
      required String cityWeather,
      required num cityCurrentTemp}) {
    return _$addCityWeatherAsyncAction.run(() => super.addCityWeather(
        cityName: cityName,
        cityWeather: cityWeather,
        cityCurrentTemp: cityCurrentTemp));
  }

  final _$HomeStateBaseActionController =
      ActionController(name: 'HomeStateBase');

  @override
  void setCityName({required String cityName}) {
    final _$actionInfo = _$HomeStateBaseActionController.startAction(
        name: 'HomeStateBase.setCityName');
    try {
      return super.setCityName(cityName: cityName);
    } finally {
      _$HomeStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
weather: ${weather},
selectedCityName: ${selectedCityName},
isLoading: ${isLoading}
    ''';
  }
}
