import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ranks_test_weather_app/domain/model/user_shared_preferences.dart';
import 'package:ranks_test_weather_app/internal/application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await UserSharedPreferences.init();
  runApp(const Application());
}
