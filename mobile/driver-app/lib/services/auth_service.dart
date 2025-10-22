import 'package:http/http.dart' as http;
import 'api_service.dart';

class AuthService {
  // --- THIS IS THE CHANGE ---
  // The login method now accepts a 'username' to pass along to the ApiService.
  static Future<http.Response> login(String username, String password) async {
    try {
      return await ApiService.login(username, password);
    } catch (e) {
      // This handles network errors, like if the user has no internet.
      print('Network error in AuthService.login: $e');
      return http.Response(
        '{"message": "Network error. Please check connection."}',
        503,
      );
    }
  }

  static Future<http.Response> register(
    Map<String, dynamic> registrationData,
  ) async {
    try {
      return await ApiService.register(registrationData);
    } catch (e) {
      print('Network error in AuthService.register: $e');
      return http.Response(
        '{"message": "Network error. Please check connection."}',
        503,
      );
    }
  }
}
