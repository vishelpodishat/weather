import 'dart:convert';
import 'package:weather/model/weather_responce.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = "d2da00195ccc1c907eaa5e9ff848e91a";
  final String baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<WeatherResponse> fetchCurrentWeather(String city) async {
    final responce =
        await http.get(Uri.parse("$baseUrl/weather?q=$city&appid=$apiKey"));

    if (responce.statusCode == 200) {
      return WeatherResponse.fromJson(jsonDecode(responce.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
