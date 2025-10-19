import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/driver_info.dart';
import '../services/api_service.dart';

class AuthProvider extends ChangeNotifier {
  DriverInfo? _driver;
  bool _loading = false;
  String? _error;

  DriverInfo? get driver => _driver;
  bool get isLoading => _loading;
  String? get error => _error;
  bool get isLoggedIn => _driver != null;

  Future<bool> login(String phone, String password) async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      final resp = await ApiService.login(phone, password);
      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body);
        // Expecting driver info + optional token
        _driver = DriverInfo.fromJson(data as Map<String, dynamic>);
        _loading = false;
        notifyListeners();
        return true;
      } else {
        _error = 'Login failed: ${resp.statusCode}';
      }
    } catch (e) {
      _error = 'Login error: $e';
    }
    _loading = false;
    notifyListeners();
    return false;
  }

  void logout() {
    _driver = null;
    notifyListeners();
  }
}
