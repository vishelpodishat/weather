import 'package:flutter/material.dart';
import 'package:weather/model/weather_responce.dart';
import 'package:weather/service/weather_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WeatherService weatherService = WeatherService();

  WeatherResponse? weather;
  try {
    weather = await weatherService.fetchCurrentWeather('Almaty');
  } catch (e) {
    print(e);
  }

  runApp(MyApp(weather: weather));
}

class MyApp extends StatelessWidget {
  final WeatherResponse? weather;

  const MyApp({super.key, this.weather});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Weather App"),
        ),
        body: Center(
          child: weather != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Location: ${weather!.name}'),
                    Text('Temperature: ${weather!.main.temp}°K'),
                  ],
                )
              : const Text('Failed to fetch weather data'),
        ),
      ),
    );
  }
}
