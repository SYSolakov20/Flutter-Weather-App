import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'models/weather.dart';

class CurrentWeatherPage extends StatefulWidget {

  @override
  _CurrentWeatherPageState createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Current Weather Page'),
      ),
    );
  }

  Widget weatherBox(Weather _weather){
    reuturn Column(
      Children: <Widget>[
        Text("${_weather.temp}"),
        Text("${_weather.description}"),
        Text("${_weather.feelsLike}"),
        Text("${_weather.low}"),
        Text("${_weather.high}"),
      ]
    )
  }
}

// 6:00

