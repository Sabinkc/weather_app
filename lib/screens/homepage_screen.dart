
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/screens/help_screen.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/services/shared_pref.dart';
import '../models/weather_model.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final _weatherService = WeatherService('d1d30e22d8947d6b9a2d3a7d74191780');
  Weather? _weather;
  TextEditingController searchController = TextEditingController();
  String? savedLocation;
  bool isLocationEmpty = true;

  @override
  void initState() {
    super.initState();
    _loadSavedLocation();
  }

  _loadSavedLocation() async {
    String? savedLoc = await SharedPrefs.getLocation();
    if (savedLoc != null && savedLoc.isNotEmpty) {
      setState(() {
        savedLocation = savedLoc;
        isLocationEmpty = false;
      });
      _fetchWeather(savedLoc);
    } else {
      _fetchWeatherForCurrentLocation(); // Load weather based on current location
    }
  }

  _fetchWeather(String location) async {
    try {
      final weather = await _weatherService.getWeather(location);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching weather data')),
      );
    }
  }

  _fetchWeatherForCurrentLocation() async {
    try {
      String currentLocation = await _weatherService.getCurrentCity();
      _fetchWeather(currentLocation);
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching current location')),
      );
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'lib/assets/sunny.json.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'lib/assets/cloudy.json.json';
      case 'rain':
      case 'dizzle':
        return 'lib/assets/rainy.json.json';
      case 'thunderstorm':
        return 'lib/assets/thunder.json.json';
      case 'clear':
        return 'lib/assets/sunny.json.json';
      default:
        return 'lib/assets/sunny.json.json';
    }
  }

  void _onSaveOrUpdate() {
    String location = searchController.text;
    if (location.isEmpty) {
      _fetchWeatherForCurrentLocation();
      SharedPrefs.saveLocation("");
      setState(() {
        isLocationEmpty = true;
      });
    } else {
      _fetchWeather(location);
      SharedPrefs.saveLocation(location);
      setState(() {
        isLocationEmpty = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HelpScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Enter location',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onSaveOrUpdate,
              child: Text(isLocationEmpty ? 'Save' : 'Update'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            if (_weather != null)
              Column(
                children: [
                  Icon(Icons.place, color: Colors.grey, size: 40),
                  Text(
                    _weather!.cityName,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Lottie.asset(
                    getWeatherAnimation(_weather!.mainCondition),
                    height: 200,
                  ),
                  SizedBox(height: 20),
                  Text(
                    '${_weather!.temperature.round()}°C',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            else
              Text(
                'Loading...',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 24,
                ),
              ),
          ],
        ),
      ),
    );
  }
}



