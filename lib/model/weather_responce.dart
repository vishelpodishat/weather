import 'package:weather/model/coordinate_model.dart';
import 'package:weather/model/weather_model.dart';

class WeatherResponse {
  final CoordinateModel coord;
  final List<Weather> weather;
  final MainWeather main;
  final int visibility;
  final Wind wind;
  final Clouds clouds;
  final int dt;
  final Sys sys;
  final String name;
  final int timezone;

  WeatherResponse({
    required this.coord,
    required this.weather,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.name,
    required this.timezone,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    var weatherList = json['weather'] as List;
    List<Weather> weatherObjects = weatherList
        .map((weatherJson) => Weather.fromJson(weatherJson))
        .toList();

    return WeatherResponse(
      coord: CoordinateModel.fromJson(json['coord']),
      weather: weatherObjects,
      main: MainWeather.fromJson(json['main']),
      visibility: json['visibility'],
      wind: Wind.fromJson(json['wind']),
      clouds: Clouds.fromJson(json['clouds']),
      dt: json['dt'],
      sys: Sys.fromJson(json['sys']),
      name: json['name'],
      timezone: json['timezone'],
    );
  }
}
