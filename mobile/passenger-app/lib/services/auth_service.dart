import 'dart:convert';
import 'package:http/http.dart' as http;
// 1. Import the shared_preferences package
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String _baseUrl = "http://10.0.2.2:8080/api/auth";

  // 2. Add a constant key for storing the token
  static const String _tokenKey = 'auth_token';

  Future<String> register({
    required String userName,
    required String email,
    required String password,
    required String birthday,
    required String contactNo,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userName': userName,
        'email': email,
        'password': password,
        'birthday': birthday,
        'contactNo': contactNo,
      }),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to register: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final String token = data['customToken'];

      // 3. Save the token after a successful login
      await _saveToken(token);

      return data;
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  // 4. NEW: Function to save the token to local storage
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // 5. NEW: Function to get the token from local storage
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // 6. NEW: Function to check if a user is currently logged in
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }

  // 7. NEW: Function to delete the token on logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}
