import 'dart:html';
import 'dart:convert';
import 'models/weather.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CurrentWeatherPage extends StatefulWidget {
  @override
  _CurrentWeatherPageState createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot != null) {
              Weather _weather = snapshot.data;
              if (_weather == null) {
                return Text("Error getting data from API");
              } else {
                return weatherBox(_weather);
              }
            } else {
              return CircularProgressIndicator();
            }
          },
          future: getCurrentWeather(),
        ),
      ),
    );
  }

  Widget weatherBox(Weather _weather) {
    return Column(children: <Widget>[
      Text("${_weather.temp}"),
      Text("${_weather.description}"),
      Text("${_weather.feelsLike}"),
      Text("${_weather.low}"),
      Text("${_weather.high}"),
    ]);
  }

  Future getCurrentWeather() async {
    Weather weather;
    String city = "calgary";
    String apiKey = "230a8144b2272a1e71dc0aaa1cea83e7";
    var url =
        "https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid=230a8144b2272a1e71dc0aaa1cea83e7";

    final response = await http.get(url as Uri);

    if (response.statusCode == 200) {
      weather = Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
    return weather;
  }
}
