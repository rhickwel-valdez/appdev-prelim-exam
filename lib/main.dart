import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<WeatherData> locations = [
    WeatherData(1, 'Current Location', 'Dhaka', 'Thunder', 20, true),
    WeatherData(2, 'United States', 'California', 'Clear', 6, false),
    WeatherData(3, 'China', 'Beijing', 'Mostly Sunny', 5, false),
    WeatherData(4, 'Russia', 'Moscow', 'Cloudy', -4, false)
  ];

  late WeatherData selectedWeather;

  @override
  void initState() {
    super.initState();
    selectedWeather = locations.firstWhere((location) => location.isSelected);
  }

  void updateSelectedWeather(WeatherData newWeather) {
    setState(() {
      for (var location in locations) {
        location.isSelected = false;
      }
      newWeather.isSelected = true;
      selectedWeather = newWeather;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Weather',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WeatherCard(weatherData: selectedWeather),
              SizedBox(height: 18),
              Text(
                'Around the world',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 14),
              Column(
                children: locations
                    .where((location) => !location.isSelected)
                    .map((location) => Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () => updateSelectedWeather(location),
                            child: WeatherCard(weatherData: location),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherCard extends StatelessWidget {
  final WeatherData weatherData;

  const WeatherCard({super.key, required this.weatherData});

  String getImage(String weather) {
    switch (weather) {
      case 'Thunder':
        return 'assets/img/heavy_rain.png';
      case 'Clear':
        return 'assets/img/snow.png';
      case 'Mostly Sunny':
        return 'assets/img/sunny.png';
      case 'Cloudy':
        return 'assets/img/thunder.png';
      default:
        return 'assets/img/default.png';
    }
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
                    Text(weatherData.country,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.white)),
                    Text(weatherData.city,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                  ],
                ),
                Image.asset(getImage(weatherData.weather)),
              ],
            ),
            SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(weatherData.weather, style: TextStyle(color: Colors.white)),
                Text('${weatherData.temperature}C',
                    style: TextStyle(color: Colors.white)),
              ],
            ),
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

  WeatherData(
    this._locationId, 
    this._country, 
    this._city, 
    this._weather,
    this._temperature, 
    this._isSelected
  );

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
