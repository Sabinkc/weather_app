import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weather_app/screens/homepage_screen.dart';

class HelpScreen extends StatefulWidget {
  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  void initState() {
    _navigateToHomePageScreen();
    super.initState();
  }

  Future<void> _navigateToHomePageScreen() async {
    await Future.delayed(Duration(seconds: 5));
    if (mounted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePageScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'lib/assets/splash_background.png',
              fit: BoxFit.cover,
            ),
          ),
          //  Background Image Frame
          Positioned.fill(
            child: Image.asset(
              'lib/assets/background_frame.png',
              fit: BoxFit.fill,
            ),
          ),
          // Contents
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Heading text
                Text(
                  'WE SHOW',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'WEATHER',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'FOR YOU',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 50),
                // Skip button
                ElevatedButton(
                  onPressed: () {
                    _skipSplash();
                  },
                  child: Text(
                    "SKIP",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    elevation: 3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _skipSplash() {
    if (mounted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePageScreen()));
    }
  }
}
