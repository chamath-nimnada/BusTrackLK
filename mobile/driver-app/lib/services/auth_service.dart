import 'api_service.dart';

class AuthService {
  // Login
  static Future<bool> login(String phone, String password) async {
    final response = await ApiService.login(phone, password);
    if (response.statusCode == 200) {
      // You can parse and store user/token here
      return true;
    }
    return false;
  }

  // Register
  static Future<bool> register(String phone, String password) async {
    final response = await ApiService.register(phone, password);
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  // Forgot Password
  static Future<bool> forgotPassword(String input) async {
    final response = await ApiService.forgotPassword(input);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
