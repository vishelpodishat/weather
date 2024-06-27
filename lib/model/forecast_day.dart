import 'package:weather/model/weather_model.dart';

class WeatherForecast {
  final List<ForecastDay> daily;

  WeatherForecast({
    required this.daily,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    var list = json['list'] as List<dynamic>? ?? [];

    List<ForecastDay> forecastList =
        list.map((i) => ForecastDay.fromJson(i)).toList();

    return WeatherForecast(daily: forecastList);
  }
}

class ForecastDay {
  final Temp temp;
  final List<Weather> weather;
  final String date;

  ForecastDay({
    required this.temp,
    required this.weather,
    required this.date,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    var weatherList = json['weather'] as List<dynamic>? ?? [];
    List<Weather> weatherObjects = weatherList
        .map((weatherJson) => Weather.fromJson(weatherJson))
        .toList();

    return ForecastDay(
      temp: Temp.fromJson(json['main']),
      weather: weatherObjects,
      date: json['dt_txt'] ?? '',
    );
  }
}
