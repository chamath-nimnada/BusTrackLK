import 'package:http/http.dart' as http;
import 'api_service.dart';

/// AuthService is a simple wrapper around the ApiService.
/// Its only job is to call the appropriate ApiService method and return the
/// raw http.Response. This delegates the responsibility of parsing success data
/// or handling errors to the AuthProvider, which is where state is managed.
class AuthService {
  /// Attempts to log the user in.
  /// Returns the full server response for the AuthProvider to handle.
  static Future<http.Response> login(String phone, String password) async {
    // The try-catch block handles network errors (e.g., no internet connection).
    try {
      final response = await ApiService.login(phone, password);
      return response;
    } catch (e) {
      // If a network error occurs, we create a fake server error response.
      // This allows the AuthProvider to handle all errors in a consistent way.
      print('Network error in AuthService.login: $e');
      return http.Response(
        '{"message": "Network error. Please check your connection."}',
        503,
      ); // Service Unavailable
    }
  }

  /// Attempts to register a new user.
  /// We pass a Map<String, dynamic> which is more scalable than many individual parameters.
  static Future<http.Response> register(
    Map<String, dynamic> registrationData,
  ) async {
    try {
      final response = await ApiService.register(registrationData);
      return response;
    } catch (e) {
      print('Network error in AuthService.register: $e');
      return http.Response(
        '{"message": "Network error. Please check your connection."}',
        503,
      );
    }
  }

  /// Sends a request to reset the password.
  static Future<http.Response> forgotPassword(String phoneOrEmail) async {
    try {
      final response = await ApiService.forgotPassword(phoneOrEmail);
      return response;
    } catch (e) {
      print('Network error in AuthService.forgotPassword: $e');
      return http.Response(
        '{"message": "Network error. Please check your connection."}',
        503,
      );
    }
  }
}
