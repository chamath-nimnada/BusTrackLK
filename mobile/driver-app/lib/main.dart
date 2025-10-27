// Imports (ensure these are present)
import 'package:driver_ui/screens/auth_screen.dart'; // Keep this import for now
import 'package:driver_ui/screens/home_screen.dart'; // <-- 1. IMPORT HomeScreen
import 'package:driver_ui/models/driver_info.dart'; // <-- 2. IMPORT DriverInfo
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
  FirebaseApp? firebaseApp;
  try {
    firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase Initialized Successfully!");
  } catch (e) {
    print("!!!!!!!! FIREBASE INITIALIZATION FAILED !!!!!!!");
    print("Error: $e");
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        Provider(create: (context) => AuthService()),
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
    // --- 3. CREATE TEMPORARY DRIVER INFO ---
    // Replace these values with realistic mock data for testing
    final mockDriverInfo = DriverInfo(
      uid: "mock_uid_123",
      email: "test@example.com",
      driverName: "Test Driver", // Using NIC in model, but display name here
      busNumber: "ND-1234",
      busRoute: "138",
      phone: "0712345678",
      creditScore: 0.0,
    );
    // --- END MOCK DATA ---

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
      // --- 4. CHANGE THE HOME SCREEN ---
      // Replace AuthScreen() with HomeScreen() and pass the mock data
      home: HomeScreen(driverInfo: mockDriverInfo),
      // home: const AuthScreen(), // This was the original line
      // --- END CHANGE ---
    );
  }
}