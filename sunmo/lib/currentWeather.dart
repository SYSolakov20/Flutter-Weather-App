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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background-worm.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<Weather>(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Weather _weather = snapshot.data!;
              return weatherBox(_weather);
            } else if (snapshot.hasError) {
              return Text("Error fetching weather");
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
          future: getCurrentWeather(),
        ),
      ),
    );
  }

  Widget weatherBox(Weather _weather) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("${_weather.temp}"),
          Text("${_weather.description}"),
          Text("${_weather.feelsLike}"),
          Text("${_weather.low}"),
          Text("${_weather.high}"),
        ],
      ),
    );
  }

  Future<Weather> getCurrentWeather() async {
    String apiKey = "230a8144b2272a1e71dc0aaa1cea83e7";
    double latitude = 42.510578;
    double longitude = 27.461014;
    String exclude = "hourly";

    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&exclude=$exclude&appid=$apiKey");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      Weather weather = Weather.fromJson(json);
      return weather;
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
