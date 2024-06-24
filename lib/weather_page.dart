import 'package:flutter/material.dart';

import 'package:weaterdata/models/services/weather_services.dart';

import 'package:weaterdata/models/weather_models.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key

  final _weatherService = WeatherService('2a22cdb7629aa50e0acef4fe13ef7daa');
  late Weather _weather;

  //fetch weather

  _fetchWeather() async {
    // geht the current city
    String cityName = await _weatherService.getCurrentCity();

    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    // errors
    catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // city name
            Text(_weather.cityName),

            //temperature
            Text('${_weather.temperature.round()} °C')
          ],
        ),
      ),
    );
  }
}
