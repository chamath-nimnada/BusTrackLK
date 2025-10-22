import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/driver_info.dart';
import '../services/auth_service.dart';

/// This is the main "brain" for authentication.
/// It manages the user's login state, handles API calls via AuthService,
/// and notifies the UI of any changes (like login success or loading state).
class AuthProvider extends ChangeNotifier {
  DriverInfo? _driver;
  String? _token;
  bool _isLoading = false;
  String? _error;

  /// Public getters to access the state from the UI safely.
  DriverInfo? get driver => _driver;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// A computed property to easily check if the user is logged in.
  bool get isLoggedIn => _token != null && _driver != null;

  /// Handles the entire registration process.
  Future<bool> register(Map<String, dynamic> registrationData) async {
    _isLoading = true;
    _error = null;
    notifyListeners(); // Tell the UI we are now loading.

    try {
      final response = await AuthService.register(registrationData);
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        // 201 Created = Success
        _driver = DriverInfo.fromJson(responseData['driver']);
        _token = responseData['token'];
        await _saveSession();
        return true;
      } else {
        _error = responseData['message'] ?? 'Registration failed.';
      }
    } catch (e) {
      _error = 'An unexpected error occurred during registration.';
    } finally {
      _isLoading = false;
      notifyListeners(); // Tell the UI we are done loading.
    }
    return false;
  }

  /// Handles the entire login process using username and password.
  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // This now correctly calls the AuthService with a 'username'.
      final response = await AuthService.login(username, password);
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // 200 OK = Success
        _driver = DriverInfo.fromJson(responseData['driver']);
        _token = responseData['token'];
        await _saveSession();
        return true;
      } else {
        _error = responseData['message'] ?? 'Invalid username or password.';
      }
    } catch (e) {
      _error = 'An unexpected error occurred during login.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return false;
  }

  /// Checks for a saved session when the app starts.
  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false; // No saved session.
    }

    final extractedUserData =
        jsonDecode(prefs.getString('userData')!) as Map<String, dynamic>;
    _token = extractedUserData['token'];
    _driver = DriverInfo.fromJson(extractedUserData['driver']);

    notifyListeners();
    return true; // Successfully restored session.
  }

  /// Logs the user out and clears their data from the device.
  Future<void> logout() async {
    _driver = null;
    _token = null;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userData');
  }

  /// Saves the current driver's data and token to the device's local storage.
  Future<void> _saveSession() async {
    if (_token == null || _driver == null) return;

    final prefs = await SharedPreferences.getInstance();
    final userData = jsonEncode({'token': _token, 'driver': _driver!.toJson()});
    await prefs.setString('userData', userData);
  }
}
