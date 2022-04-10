// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "dialog_add_btn": MessageLookupByLibrary.simpleMessage("Add"),
        "dialog_which_city_text":
            MessageLookupByLibrary.simpleMessage("Enter the name of your city"),
        "form_hint_text":
            MessageLookupByLibrary.simpleMessage("Enter the name of city"),
        "getting_data_text":
            MessageLookupByLibrary.simpleMessage("Getting data..."),
        "home_screen_feels_text":
            MessageLookupByLibrary.simpleMessage("Feels like"),
        "home_screen_forecast_4days_text":
            MessageLookupByLibrary.simpleMessage("Forecast for 4 days"),
        "home_screen_humidity_text":
            MessageLookupByLibrary.simpleMessage("Humidity"),
        "home_screen_pressure_text":
            MessageLookupByLibrary.simpleMessage("Pressure"),
        "home_screen_wind_speed_text":
            MessageLookupByLibrary.simpleMessage("Wind speed"),
        "measure_mbar_text": MessageLookupByLibrary.simpleMessage("mbar"),
        "measure_speed_text": MessageLookupByLibrary.simpleMessage("km/h"),
        "next_4days_text": MessageLookupByLibrary.simpleMessage("NEXT 4 DAYS"),
        "your_cities_text": MessageLookupByLibrary.simpleMessage("Your cities")
      };
}
