// lib/main.dart
import 'package:flutter/material.dart';
import 'package:passenger_app/screens/splash_screen.dart'; // Import your splash screen
import 'package:passenger_app/screens/home_screen.dart'; // Import your home screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BusTrackLK',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(), // Start with the SplashScreen
    );
  }
}