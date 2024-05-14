import 'package:flutter/material.dart';
import 'package:weather_app/screens/help_screen.dart';
import 'package:weather_app/screens/homepage_screen.dart';

 void main(List<String> args) {
 runApp(MyApplication()); 
}

class MyApplication extends StatelessWidget {
  const MyApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HelpScreen(),
    );
  }
}


