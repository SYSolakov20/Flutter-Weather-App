
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
            if (snapshot.hasData) {
              Weather _weather = snapshot.data;
              if (_weather != null) {
                return weatherBox(_weather);
              } 
            } 
            return CircularProgressIndicator();
          },
          future: getCurrentWeather(),
        ),
      ),
    );
  }
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
        "http://api.openweathermap.org/geo/1.0/reverse?lat=51.5098&lon=-0.1180&limit=5&appid=230a8144b2272a1e71dc0aaa1cea83e7";

    final response = await http.get(url as Uri);

    if (response.statusCode == 200) {
      weather = Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
    return weather;
  }

