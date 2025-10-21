import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/driver_info.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  DriverInfo? _driver;
  String? _token;
  bool _isLoading = false;
  String? _error;

  DriverInfo? get driver => _driver;
  String? get token => _token;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _token != null && _driver != null;

  /// --- FIX 1: ADDED FULL REGISTRATION FLOW ---
  /// Handles the registration logic.
  Future<bool> register(Map<String, dynamic> registrationData) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await AuthService.register(registrationData);
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        // HTTP 201 Created for success
        // Many APIs log the user in automatically after registration.
        // If your API does, it will return driver data and a token here.
        // If not, you can just return true and prompt them to log in.

        // This example assumes auto-login after register.
        _driver = DriverInfo.fromJson(responseData['driver']);
        _token = responseData['token'];

        // Save session
        await _saveSession();

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        // Use the error message from the server
        _error = responseData['message'] ?? 'Registration failed.';
      }
    } catch (e) {
      _error = 'An unexpected error occurred during registration: $e';
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  /// --- IMPROVED LOGIN FLOW ---
  /// Handles the login logic and saves the user's session.
  Future<bool> login(String phone, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await AuthService.login(phone, password);
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // --- FIX 2: IMPLEMENTED TOKEN-BASED AUTHENTICATION ---
        // Expecting the API to return the driver's info and an auth token.
        _driver = DriverInfo.fromJson(responseData['driver']);
        _token = responseData['token'];

        // Save session
        await _saveSession();

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        // --- FIX 3: IMPROVED ERROR HANDLING ---
        // Use the specific error message from the server if available.
        _error = responseData['message'] ?? 'Invalid phone number or password.';
      }
    } catch (e) {
      _error = 'An unexpected error occurred: $e';
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  /// --- FIX 4: ADDED AUTO-LOGIN ON APP STARTUP ---
  /// Checks for a saved session token and attempts to log the user in automatically.
  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }

    final extractedUserData =
        jsonDecode(prefs.getString('userData')!) as Map<String, dynamic>;

    // Here you would typically also check if the token is expired.
    // For simplicity, we are just reloading the data.
    _token = extractedUserData['token'];
    _driver = DriverInfo.fromJson(extractedUserData['driver']);

    notifyListeners();

    // You might want to add a call here to verify the token with the server
    // to ensure it's still valid, but for now, this restores the state.
    return true;
  }

  /// --- FIX 5: ADDED LOGOUT AND SESSION CLEARING ---
  Future<void> logout() async {
    _driver = null;
    _token = null;
    _error = null;
    notifyListeners();

    // Clear saved session data from the device
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }

  /// Saves the current user's token and profile to the device's local storage.
  Future<void> _saveSession() async {
    if (_token == null || _driver == null) return;
    final prefs = await SharedPreferences.getInstance();
    final userData = jsonEncode({
      'token': _token,
      'driver': _driver!
          .toJson(), // Assuming you have a toJson() method in DriverInfo
    });
    await prefs.setString('userData', userData);
  }

  // Add this method inside your AuthProvider class in auth_provider.dart

  Future<bool> forgotPassword(String phoneOrEmail) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await AuthService.forgotPassword(phoneOrEmail);
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _isLoading = false;
        notifyListeners();
        return true; // Request was successful
      } else {
        _error = responseData['message'] ?? 'Password reset request failed.';
      }
    } catch (e) {
      _error = 'An unexpected error occurred: $e';
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }
}
