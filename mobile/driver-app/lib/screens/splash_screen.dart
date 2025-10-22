import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/auth_provider.dart';
import 'auth_screen.dart';
import 'home_screen.dart';

/// This screen is the first thing the user sees. Its only job is to
/// determine the user's authentication state and navigate them to the correct screen.
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // This function is called once when the screen is first created.
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    // Wait for 2 seconds to show the splash screen animation/logo.
    await Future.delayed(const Duration(seconds: 2));

    // Safety check: ensure the widget is still on screen before navigating.
    if (!mounted) return;

    // Get the AuthProvider without listening for changes (one-time check).
    final authProvider = context.read<AuthProvider>();
    // Call the method that checks for a saved session on the device.
    final isLoggedIn = await authProvider.tryAutoLogin();

    if (!mounted) return;

    // Navigate to the correct screen based on the result.
    // pushReplacement prevents the user from going back to the splash screen.
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        // If logged in, go to HomeScreen. Otherwise, go to AuthScreen.
        builder: (context) =>
            isLoggedIn ? const HomeScreen() : const AuthScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // A simple UI for the splash screen.
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.directions_bus, color: Color(0xFF4263EB), size: 80),
            SizedBox(height: 20),
            Text(
              'BusTrackLK',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 40),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
