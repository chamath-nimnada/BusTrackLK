import 'package:driver_ui/screens/auth_screen.dart';
import 'package:driver_ui/utils/app_colors.dart';
import 'package:driver_ui/utils/language_provider.dart';
import 'package:flutter/material.dart';
// This is the import that was missing
import 'package:google_fonts/google_fonts.dart'; // <-- ADDED THIS LINE
import 'package:provider/provider.dart';

void main() {
  runApp(
    // We create the provider *ABOVE* the entire application.
    // This ensures all routes can access it.
    ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
      child: const MyApp(), // Run the app as a child of the provider
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // The MaterialApp is now a DESCENDANT of the provider.
    return MaterialApp(
      title: 'Driver UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: AppColors.kBackgroundColor,
        // This line will now work because 'GoogleFonts' is imported
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ).apply(bodyColor: AppColors.kPrimaryTextColor),
      ),
      // AuthScreen is the home page
      home: const AuthScreen(),
    );
  }
}

