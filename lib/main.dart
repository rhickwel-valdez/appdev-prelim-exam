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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Weather',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 12),
              WeatherCard(weatherData: locations.first),
              SizedBox(height: 12),
              Text(
                'Around the world',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 12),
              for (var location in locations)
                if (!location.isSelected)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: WeatherCard(weatherData: location),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class WeatherCard extends StatefulWidget {
  WeatherCard({super.key, this.weatherData});

  WeatherData? weatherData;

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
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

  Text displayText(String text, double fs, FontWeight fw, TextAlign alignText) {
    return Text(
      text,
      style: TextStyle(fontSize: fs, fontWeight: fw, color: Color(0xFFFFFFFF)),
      textAlign: alignText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: EdgeInsets.all(15),
        color: Color(0xFF6051c3),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    displayText(widget.weatherData!.country, 14,
                        FontWeight.normal, TextAlign.start),
                    displayText(widget.weatherData!.city, 22, FontWeight.w500,
                        TextAlign.start),
                  ],
                ),
                Image.asset(getImage(widget.weatherData!.weather))
              ],
            ),
            SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.weatherData!.weather,
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
                Text(
                  '${widget.weatherData!.temperature}C',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class WeatherData {
  final int _locationId;
  final String _country;
  final String _city;
  final String _weather;
  final int _temperature;
  bool _isSelected;

  WeatherData(this._locationId, this._country, this._city, this._weather,
      this._temperature, this._isSelected);

  int get locationId => _locationId;
  String get country => _country;
  String get city => _city;
  String get weather => _weather;
  int get temperature => _temperature;
  bool get isSelected => _isSelected;

  set isSelected(bool value) {
    _isSelected = value;
  }
}
