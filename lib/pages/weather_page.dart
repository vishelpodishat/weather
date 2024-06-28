import 'package:flutter/material.dart';
import 'package:weather/model/forecast_day.dart';
import 'package:weather/model/weather_responce.dart';
import 'package:weather/resources/colors.dart';
import 'package:weather/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherService _weatherService = WeatherService();

  WeatherResponse? _currentWeather;
  WeatherForecast? _weatherForecast;
  String _city = 'Almaty';
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      WeatherResponse weather =
          await _weatherService.fetchCurrentWeather(_city);
      WeatherForecast forecast =
          await _weatherService.fetchWeatherForecast(_city);

      setState(() {
        _currentWeather = weather;
        _weatherForecast = forecast;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  void _updateCity(String city) {
    setState(() {
      _city = city;
    });
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _updateCity(_controller.text);
                  },
                ),
                labelText: 'Enter city name',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            if (_currentWeather != null) ...[
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: AppColors.heavenlyBlue, // Use the defined color
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      _currentWeather!.name,
                      style: const TextStyle(fontSize: 32),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${_currentWeather!.main.temp}°C',
                          style: const TextStyle(fontSize: 32),
                        ),
                        const SizedBox(width: 10),
                        Image.network(
                            'https://openweathermap.org/img/w/${_currentWeather!.weather[0].icon}.png'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text('Humidity: ${_currentWeather!.main.humidity}%'),
                    Text('Wind Speed: ${_currentWeather!.wind.speed} m/s'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '3-Day Forecast',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 10),
              _buildForecast(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildForecast() {
    if (_weatherForecast == null) {
      return const CircularProgressIndicator();
    }

    return Expanded(
      child: ListView(
        children: _weatherForecast!.daily.map((day) {
          String formattedDate = day.date.split(' ')[0];

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppColors.forecastBlue, // Use the defined color
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formattedDate,
                  style: const TextStyle(fontSize: 18),
                ),
                Row(
                  children: [
                    Image.network(
                      'https://openweathermap.org/img/w/${day.weather[0].icon}.png',
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${day.temp.day}°C',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
