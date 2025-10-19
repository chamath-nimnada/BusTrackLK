import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/language_provider.dart';
import 'utils/auth_provider.dart';
import 'screens/splash_screen.dart';

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
      theme: ThemeData(fontFamily: 'Roboto', primarySwatch: Colors.blue),
      home: const SplashScreen(),
    );
  }
}
