import 'package:flutter/material.dart';
import '../screens/Login_screen.dart';
import '../screens/home_screen.dart';
// Add other screens as needed

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  // Add more route names as needed

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      // Add more cases for other screens
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('No route defined'))),
        );
    }
  }
}
