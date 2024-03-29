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
            image: _getBackgroundImage(),
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

ImageProvider _getBackgroundImage() {
  if (_weather != null && _weather!.temp < 20) {
    return AssetImage('assets/images/background-cold.png');
  } else {
    return AssetImage('assets/images/background-worm.png');
  }
}

  Widget weatherBox(Weather _weather) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 150),
            child: Text(
              "${_weather.description}",
              style: TextStyle(fontSize: 17),
            ),
          ),
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin:EdgeInsets.only(right: 15, top: 55),
            child:Text(
              ("${_weather.temp}°"),
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin:EdgeInsets.only(right: 45, top: 155),
            child:Text(
              ("${_weather.pressure} Pa"),
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin:EdgeInsets.only(right: 45, top: 85),
            child:Text(
              ("${_weather.windSpeed} kt"),
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin:EdgeInsets.only(right: 45, top: 85),
            child:Text(
              ("${_weather.humidity} g.m"),
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }

  Weather? _weather;

  Future<Weather> getCurrentWeather() async {
    String apiKey = "230a8144b2272a1e71dc0aaa1cea83e7";
    double latitude = 42.510578;
    double longitude = 27.461014;
    String exclude = "hourly";

    var url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&exclude=$exclude&appid=$apiKey",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      Weather weather = Weather.fromJson(json);
      _weather = weather;
      return weather;
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
