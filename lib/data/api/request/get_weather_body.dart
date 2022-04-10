import 'package:intl/intl.dart';

class GetWeatherBody {
  final double lat;
  final double lon;
  final String language = Intl.getCurrentLocale();
  //TODO: API KEY HERE
  final String API_KEY = '';

  GetWeatherBody({
    required this.lat,
    required this.lon,
  });

  Map<String, dynamic> toApi() {
    return {
      'lat': lat,
      'lon': lon,
      'units': 'metric',
      'lang': language,
      'appid': API_KEY,
    };
  }
}
