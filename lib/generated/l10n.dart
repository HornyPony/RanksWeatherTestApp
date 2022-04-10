// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Enter the name of your city`
  String get dialog_which_city_text {
    return Intl.message(
      'Enter the name of your city',
      name: 'dialog_which_city_text',
      desc: '',
      args: [],
    );
  }

  /// `Enter the name of city`
  String get form_hint_text {
    return Intl.message(
      'Enter the name of city',
      name: 'form_hint_text',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get dialog_add_btn {
    return Intl.message(
      'Add',
      name: 'dialog_add_btn',
      desc: '',
      args: [],
    );
  }

  /// `Feels like`
  String get home_screen_feels_text {
    return Intl.message(
      'Feels like',
      name: 'home_screen_feels_text',
      desc: '',
      args: [],
    );
  }

  /// `Humidity`
  String get home_screen_humidity_text {
    return Intl.message(
      'Humidity',
      name: 'home_screen_humidity_text',
      desc: '',
      args: [],
    );
  }

  /// `Pressure`
  String get home_screen_pressure_text {
    return Intl.message(
      'Pressure',
      name: 'home_screen_pressure_text',
      desc: '',
      args: [],
    );
  }

  /// `Wind speed`
  String get home_screen_wind_speed_text {
    return Intl.message(
      'Wind speed',
      name: 'home_screen_wind_speed_text',
      desc: '',
      args: [],
    );
  }

  /// `Forecast for 4 days`
  String get home_screen_forecast_4days_text {
    return Intl.message(
      'Forecast for 4 days',
      name: 'home_screen_forecast_4days_text',
      desc: '',
      args: [],
    );
  }

  /// `Your cities`
  String get your_cities_text {
    return Intl.message(
      'Your cities',
      name: 'your_cities_text',
      desc: '',
      args: [],
    );
  }

  /// `mbar`
  String get measure_mbar_text {
    return Intl.message(
      'mbar',
      name: 'measure_mbar_text',
      desc: '',
      args: [],
    );
  }

  /// `km/h`
  String get measure_speed_text {
    return Intl.message(
      'km/h',
      name: 'measure_speed_text',
      desc: '',
      args: [],
    );
  }

  /// `Getting data...`
  String get getting_data_text {
    return Intl.message(
      'Getting data...',
      name: 'getting_data_text',
      desc: '',
      args: [],
    );
  }

  /// `NEXT 4 DAYS`
  String get next_4days_text {
    return Intl.message(
      'NEXT 4 DAYS',
      name: 'next_4days_text',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
