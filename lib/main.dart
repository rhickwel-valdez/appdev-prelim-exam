import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    List<WeatherData> locations = [
      WeatherData(1, 'Current Location', 'Dhaka', 'Thunder', 20, true),
      WeatherData(2, 'United States', 'California', 'Clear', 6, false),
      WeatherData(3, 'China', 'Beijing', 'Mostly Sunny', 5, false),
      WeatherData(4, 'Russia', 'Moscow', 'Cloudy', -04, false)
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 35, right: 15, bottom: 35, left: 15),
          child: Column(
            children: [
              Text(
                'Weather',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 12),
              Card(weatherData: locations.first) // change
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Card extends StatefulWidget {
  Card({super.key, this.weatherData});

  WeatherData? weatherData;

  @override
  State<Card> createState() => _CardState();
}

class _CardState extends State<Card> {
  String getImage(String weather) {
    late String imgPath;

    switch (weather) {
      case 'Thunder':
        imgPath = 'assets/img/heavy_rain.png';
        break;
      case 'Clear':
        imgPath = 'assets/img/snow.png';
        break;
      case 'Mostly Sunny':
        imgPath = 'assets/img/sunny.png';
        break;
      case 'Cloudy':
        imgPath = 'assets/img/thunder.png';
        break;
    }

    return imgPath;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text(widget.weatherData!._country),
                  Text(widget.weatherData!._city),
                ],
              ),
              Image.asset(getImage(widget.weatherData!._weather))
            ],
          ),
          Row(
            children: [
                Text(widget.weatherData!.weather),
                Text('${widget.weatherData!.temperature}C')
            ],
          )
        ],
      ),
    );
  }
}

class WeatherData {
  late final int _locationId;
  late final String _country;
  late final String _city;
  late final String _weather;
  late final int _temperature;
  late final bool _isSelected;

  WeatherData(this._locationId, this._country, this._city, this._weather,
      this._temperature, this._isSelected);

  // getters

  int get locationId => _locationId;
  String get country => _country;
  String get city => _city;
  String get weather => _weather;
  int get temperature => _temperature;
  bool get isSelected => _isSelected;
}
