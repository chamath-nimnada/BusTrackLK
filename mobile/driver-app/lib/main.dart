import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// --- This line is correct: Import the SplashScreen ---
import 'screens/splash_screen.dart';
import 'utils/auth_provider.dart';
import 'utils/language_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BusTrackLK',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1A202C),
        primaryColor: const Color(0xFF4263EB),
        fontFamily: 'Roboto',
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black, // Makes text inside fields visible
              displayColor: Colors.black,
            ),
      ),
      // --- This line is correct: Set home to SplashScreen ---
      home: const SplashScreen(),
    );
  }
}

