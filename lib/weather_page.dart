import 'package:flutter/material.dart';

import 'package:weaterdata/models/services/weather_services.dart';

import 'package:weaterdata/models/weather_models.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late Future<String> _getCurrentCity;
  // api key

  final _weatherService = WeatherService('2a22cdb7629aa50e0acef4fe13ef7daa');
  Weather? _weather;

  //fetch weather

  _fetchWeather() async {
    // geht the current city

    _getCurrentCity = _weatherService.getCurrentCity();
    String cityName = await _getCurrentCity;

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
            FutureBuilder(
                future: _getCurrentCity,
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    //final _weather = snapshot.data;
                    return Column(
                      children: [
                        Text('${_weather!.cityName}'),
                        Text('${_weather!.temperature.round()} °C'),
                      ],
                    );
                  } else if (snapshot.connectionState != ConnectionState.done) {
                    return const CircularProgressIndicator();
                  } else {
                    return const Icon(Icons.error);
                  }
                }),
            // city name

            //temperature
          ],
        ),
      ),
    );
  }
}
