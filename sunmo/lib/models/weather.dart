class Weather {
  final double temp;
  final double feelsLike;
  final double low;
  final double high;
  final String description;
  final double windSpeed;
  final double humidity;
  final double pressure;

  Weather({
    required this.temp,
    required this.feelsLike,
    required this.low,
    required this.high,
    required this.description,
    required this.windSpeed,
    required this.humidity,
    required this.pressure,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    double kelvinToCelsius(double kelvin) {
      return kelvin - 273.15;
    }

    Map<String, dynamic> main = json['main'];
    List<dynamic> weatherData = json['weather'];
    Map<String, dynamic> weather = weatherData[0];

    double tempKelvin = main['temp'].toDouble();
    double feelsLikeKelvin = main['feels_like'].toDouble();
    double lowKelvin = main['temp_min'].toDouble();
    double highKelvin = main['temp_max'].toDouble();
    double windSpeed = json['wind']['speed'].toDouble();
    double humidity = main['humidity'].toDouble();
    double pressure = main['pressure'].toDouble();

    double tempCelsius = kelvinToCelsius(tempKelvin);
    double feelsLikeCelsius = kelvinToCelsius(feelsLikeKelvin);
    double lowCelsius = kelvinToCelsius(lowKelvin);
    double highCelsius = kelvinToCelsius(highKelvin);

    return Weather(
      temp: double.parse(tempCelsius.toStringAsFixed(2)),
      feelsLike: double.parse(feelsLikeCelsius.toStringAsFixed(2)),
      low: double.parse(lowCelsius.toStringAsFixed(2)),
      high: double.parse(highCelsius.toStringAsFixed(2)),
      description: weather['description'],
      windSpeed: windSpeed,
      humidity: humidity,
      pressure: pressure,
    );
  }
}
