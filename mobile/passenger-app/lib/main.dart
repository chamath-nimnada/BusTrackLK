// lib/main.dart

import 'package:flutter/material.dart';
import 'package:passenger_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart'; // <-- 1. IMPORT
// You will need to create a firebase_options.dart for the passenger app
// using the `flutterfire` CLI tool.
// import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // --- ADD THIS LINE ---
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform, // <-- 2. INITIALIZE
  );
  // --- END ---

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BusTrackLK',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Your existing entry point
    );
  }
}