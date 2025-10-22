import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://your-api-url.com/api/driver';
  static const Duration _timeoutDuration = Duration(seconds: 20);

  static Future<http.Response> _postRequest(
    String endpoint,
    Map<String, dynamic> body,
  ) {
    final url = Uri.parse('$_baseUrl/$endpoint');
    return http
        .post(
          url,
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode(body),
        )
        .timeout(_timeoutDuration);
  }

  // --- THIS IS THE CHANGE ---
  // The login method now accepts and sends 'username' instead of 'phone'.
  static Future<http.Response> login(String username, String password) {
    return _postRequest('login', {'username': username, 'password': password});
  }

  static Future<http.Response> register(Map<String, dynamic> registrationData) {
    return _postRequest('register', registrationData);
  }
}
