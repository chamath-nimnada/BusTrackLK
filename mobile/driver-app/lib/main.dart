// mobile/driver-app/lib/main.dart

import 'package:driver_ui/screens/auth_screen.dart';
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
  // 1. Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Initialize Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase Initialized Successfully!");
  } catch (e) {
    print("!!!!!!!! FIREBASE INITIALIZATION FAILED !!!!!!!");
    print("Error: $e");
  }

  // 3. Run the app with MultiProvider
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        Provider(create: (context) => AuthService()),
        // This provides the new Firestore-based service
        Provider(create: (context) => LocationService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // This mock data will be used to test the home screen
    final mockDriverInfo = DriverInfo(
      uid: "mock_uid_123", // A unique ID for this driver
      email: "test@example.com",
      driverName: "Test Driver",
      busNumber: "ND-1234",
      busRoute: "138",
      phone: "0712345678",
      creditScore: 0.0,
    );

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
      // This correctly launches the app straight into the HomeScreen for testing
      home: HomeScreen(driverInfo: mockDriverInfo),
    );
  }
}