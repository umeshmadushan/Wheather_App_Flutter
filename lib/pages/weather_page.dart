import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wheather_app_flutter/models/wheather_model.dart';
import 'package:wheather_app_flutter/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherService _weatherService =
      WeatherService('3ede3c8d842d083dc0710c926ca765e3');
  WeatherModel? _weather;

  Future<void> _fetchWeather() async {
    try {
      String cityName = await _weatherService.getCurrentCity();
      WeatherModel weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print('Error fetching weather: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  String _getLottieAnimation(String? mainCondition) {
    if (mainCondition == null)
      return 'https://lottie.host/05aaeceb-f49a-48c3-8688-21574661c1e1/oQDAqDGkbg.json'; // Loading animation URL
    if (mainCondition.contains('Rain'))
      return 'https://lottie.host/66f2f46b-4f58-4722-9792-1b925fc8cda2/f8mMOG1cV7.json'; // Rain animation URL
    if (mainCondition.contains('Cloud'))
      return 'https://lottie.host/7cccb2a6-09f6-434a-881e-8020f9a59bdc/4SUS7VtS7X.json'; // Cloudy animation URL
    if (mainCondition.contains('Clear'))
      return 'https://lottie.host/2ad86b16-7239-4e68-94fa-83ab2cca58a2/YydWAuquXJ.json'; // Clear/Sunny animation URL
    return 'https://lottie.host/2ad86b16-7239-4e68-94fa-83ab2cca58a2/YydWAuquXJ.json'; // Default/fallback animation URL
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Center(
        child: _weather == null
            ? Lottie.network(
                'https://lottie.host/05aaeceb-f49a-48c3-8688-21574661c1e1/oQDAqDGkbg.json') // Loading animation
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.network(
                    _getLottieAnimation(_weather
                        ?.mainCondition), // Fetch appropriate animation from the web
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _weather?.cityName ?? "Loading city...",
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "${_weather?.temparature?.round()}°C",
                    style: const TextStyle(fontSize: 48),
                  ),
                ],
              ),
      ),
    );
  }
}
