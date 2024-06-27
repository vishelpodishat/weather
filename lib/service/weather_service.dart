import 'dart:convert';
import 'package:weather/model/forecast_day.dart';
import 'package:weather/model/weather_responce.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '77adacf19d7858a5d14fe6f784e9478b';
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/';

  Future<WeatherResponse> fetchCurrentWeather(String city) async {
    final responce = await http
        .get(Uri.parse('${baseUrl}weather?q=$city&appid=$apiKey&units=metric'));

    if (responce.statusCode == 200) {
      return WeatherResponse.fromJson(jsonDecode(responce.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<WeatherForecast> fetchWeatherForecast(String city) async {
    final response = await http.get(
        Uri.parse('${baseUrl}forecast/?q=$city&units=metric&appid=$apiKey'));

    if (response.statusCode == 200) {
      WeatherForecast forecast =
          WeatherForecast.fromJson(jsonDecode(response.body));

      List<ForecastDay> dailyForecasts = [];
      String previousDate = '';
      for (var day in forecast.daily) {
        String currentDate = day.date.split(' ')[0];
        if (currentDate != previousDate && day.date.contains('12:00:00')) {
          dailyForecasts.add(day);
          previousDate = currentDate;
        }
        if (dailyForecasts.length == 3) break;
      }
      return WeatherForecast(daily: dailyForecasts);
    } else {
      throw Exception('Failed to load forecast');
    }
  }
}
