import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'models/weather.dart';

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({Key? key}) : super(key: key);

  @override
  _CurrentWeatherPageState createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Weather>(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Weather _weather = snapshot.data!;
              return weatherBox(_weather);
            } else if (snapshot.hasError) {
              return Text("Error fetching weather");
            } else {
              return CircularProgressIndicator(); // Show a loading indicator while fetching data
            }
          },
          future: getCurrentWeather(),
        ),
      ),
    );
  }

  Widget weatherBox(Weather _weather) {
    return Column(
      children: <Widget>[
        Text("${_weather.temp}"),
        Text("${_weather.description}"),
        Text("${_weather.feelsLike}"),
        Text("${_weather.low}"),
        Text("${_weather.high}"),
      ],
    );
  }

  Future<Weather> getCurrentWeather() async {
    String apiKey = "230a8144b2272a1e71dc0aaa1cea83e7";
    double latitude = 33.44;
    double longitude = -94.04;
    String exclude = "hourly,daily";

    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=42.510578&lon=-27.461014&exclude=hourly&appid=230a8144b2272a1e71dc0aaa1cea83e7");

    final response = await http.get(url);

    if (response.statusCode == 200) {
  Map<String, dynamic> json = jsonDecode(response.body);
  print(json); // Log the JSON response
  Weather weather = Weather.fromJson(json);
  print(weather); // Log the Weather object
  return weather;
} else {
  print('Failed to load weather. Status code: ${response.statusCode}');
  throw Exception('Failed to load weather');
}
  }
  
}

