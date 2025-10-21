import 'dart:async';
import 'dart:convert';
// --- FIX: The import was incorrect. This is the proper way to import the http package. ---
import 'package:http/http.dart' as http;

/// ApiService handles the direct communication with the backend REST API.
/// It is responsible for creating and sending HTTP requests and returning the raw response.
class ApiService {
  // --- IMPORTANT: Replace this with your actual backend URL ---
  static const String _baseUrl = 'https://your-api-url.com/api/driver';

  // --- Best Practice: Define a standard timeout for all network requests ---
  static const Duration _timeoutDuration = Duration(seconds: 15);

  /// Helper method for making POST requests to avoid code duplication.
  /// It includes standard headers, request body encoding, and a timeout.
  static Future<http.Response> _postRequest(
    String endpoint,
    Map<String, dynamic> body,
  ) {
    final url = Uri.parse('$_baseUrl/$endpoint');

    // This now works because 'http' is correctly defined from the import.
    return http
        .post(
          url,
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode(body),
        )
        .timeout(_timeoutDuration);
  }

  /// Sends login credentials to the /login endpoint.
  static Future<http.Response> login(String phone, String password) {
    return _postRequest('login', {'phone': phone, 'password': password});
  }

  /// Sends the complete driver profile to the /register endpoint.
  static Future<http.Response> register(Map<String, dynamic> registrationData) {
    return _postRequest('register', registrationData);
  }

  /// Sends a password reset request to the /forgot-password endpoint.
  static Future<http.Response> forgotPassword(String phoneOrEmail) {
    return _postRequest('forgot-password', {'phone': phoneOrEmail});
  }
}
