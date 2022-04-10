class ApiWeather {
  late final double temperature;
  late final double temperatureFeelsLike;
  late final int pressure;
  late final int humidity;
  late final String weatherDescription;
  late final double windSpeed;
  late final List hourlyWeatherList;
  late final List dailyWeatherList;

  ApiWeather.fromApi(Map<String, dynamic> map) {
    temperature = map['current']['temp'];
    temperatureFeelsLike = map['current']['feels_like'];

    pressure = map['current']['pressure'];
    humidity = map['current']['humidity'];
    windSpeed = map['current']['wind_speed'];

    weatherDescription = map['current']['weather'][0]['description'];
    hourlyWeatherList = map['hourly'];
    dailyWeatherList = map['daily'];
  }
}
