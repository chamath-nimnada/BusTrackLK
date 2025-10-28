// mobile/driver-app/lib/main.dart

import 'package:driver_ui/screens/auth_screen.dart'; // <-- Correct starting screen
import 'package:driver_ui/screens/home_screen.dart';
import 'package:driver_ui/models/driver_info.dart';
import 'package:driver_ui/services/auth_service.dart';
import 'package:driver_ui/services/location_service.dart';
import 'package:driver_ui/utils/app_colors.dart';
import 'package:driver_ui/utils/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:driver_ui/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase Initialized Successfully!");
  } catch (e) {
    print("!!!!!!!! FIREBASE INITIALIZATION FAILED !!!!!!!");
    print("Error: $e");
  }

  // This MultiProvider is the key.
  // It provides services to the whole app.
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        Provider(create: (context) => AuthService()),
        Provider(create: (context) => LocationService()), // <-- Provides LocationService
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Driver UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: AppColors.kBackgroundColor,
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ).apply(bodyColor: AppColors.kPrimaryTextColor),
        useMaterial3: true,
      ),
      // AuthScreen is the first screen.
      // When it navigates to HomeScreen, the context will
      // still have access to the services from MultiProvider.
      home: const AuthScreen(),
    );
  }
}