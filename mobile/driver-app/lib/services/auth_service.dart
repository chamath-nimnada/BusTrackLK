import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:driver_ui/models/driver_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String get _baseUrl {
    if (kDebugMode) {
      if (Platform.isAndroid) {
        // This is the correct IP for the Android Emulator
        return "http://10.0.2.2:8080/api";
      } else {
        // For iOS simulator
        return "http://localhost:8080/api";
      }
    } else {
      return "YOUR_PRODUCTION_BACKEND_URL";
    }
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // --- NEW REGISTER METHOD ---
  // This is the correct version that ONLY calls your backend.
  Future<void> registerDriver({
    required String email,
    required String password,
    required String phoneNo,
    required String nic,
    required String busNo,
    required String routeNo,
  }) async {
    // This is the ONLY path. Send all data to the Spring Boot backend.
    try {
      print("Attempting to register via backend: $_baseUrl/register");
      final response = await http
          .post(
        Uri.parse('$_baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'phoneNo': phoneNo,
          'nic': nic,
          'busNo': busNo,
          'routeNo': routeNo,
        }),
      )
          .timeout(const Duration(seconds: 15));

      print("Backend response status: ${response.statusCode}");
      print("Backend response body: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // HTTP 200-299 means success
        print("Backend registration successful. Returning.");
        return; // Success!
      } else {
        // The backend sent an error (e.g., "email already in use")
        print(
            "Backend registration failed: ${response.statusCode} ${response.body}");
        String errorMessage = response.body;
        try {
          // Try to parse a JSON error message if the backend sends one
          final decoded = jsonDecode(response.body);
          if (decoded is Map && decoded.containsKey('message')) {
            errorMessage = decoded['message'];
          }
        } catch (_) {
          // If the body is just text (like from an exception), use it
          errorMessage = response.body;
        }
        // Throw the error message from the backend
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Error during backend HTTP call: $e');
      if (e is SocketException) {
        throw Exception('Network error: Could not connect to the server.');
      } else if (e is TimeoutException) {
        throw Exception('Network error: The request timed out.');
      }
      // Re-throw the exception to be caught by the UI
      throw Exception(e.toString().replaceFirst("Exception: ", ""));
    }
  }


  // --- LOGIN METHOD (This code is correct) ---
  Future<DriverInfo> loginDriver({
    required String email,
    required String password,
  }) async {
    UserCredential? userCredential;
    try {
      print("Attempting Firebase Auth sign in for: $email");
      userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .timeout(const Duration(seconds: 15));

      String? idToken = await userCredential.user?.getIdToken();

      if (idToken == null) {
        throw Exception('Failed to get ID token from Firebase.');
      }
      print("Got ID Token from Firebase Auth.");

      print("Sending ID token to backend: $_baseUrl/login");
      final response = await http
          .post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'idToken': idToken}),
      )
          .timeout(const Duration(seconds: 15));

      print("Backend response status: ${response.statusCode}");
      print("Backend response body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // This mapping must match your LoginResponse.java
        // Your Java code uses 'nic' for driverName and 'busNo' for busNumber.
        return DriverInfo(
          driverName: responseData['nic'] ?? 'N/A',
          busNumber: responseData['busNo'] ?? 'N/A',
          phoneNumber: responseData['phoneNo'] ?? 'N/A',
          creditScore: (responseData['creditScore'] as num?)?.toDouble() ?? 0.0,
        );
      } else {
        String errorMessage = response.body;
        try {
          final decoded = jsonDecode(response.body);
          if (decoded is Map && decoded.containsKey('message')) {
            errorMessage = decoded['message'];
          }
        } catch (_) {}
        await _firebaseAuth.signOut();
        throw Exception('Login failed: $errorMessage');
      }
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth login failed: ${e.code} ${e.message}");
      String friendlyMessage;
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        friendlyMessage = 'Incorrect email or password.';
      } else if (e.code == 'invalid-email') {
        friendlyMessage = 'Please enter a valid email address.';
      } else {
        friendlyMessage = 'An authentication error occurred. Please try again.';
      }
      throw Exception('Login failed: $friendlyMessage');
    } catch (e) {
      print("Error during login API call or Firebase Auth: $e");
      if (userCredential != null) {
        await _firebaseAuth.signOut();
      }
      if (e is SocketException) {
        throw Exception('Network error: Could not connect to the server.');
      } else if (e is TimeoutException) {
        throw Exception('Network error: The request timed out.');
      }
      throw Exception(
          'Login failed. Please check your connection and try again.');
    }
  }

  // --- LOGOUT METHOD (This code is correct) ---
  Future<void> logoutDriver() async {
    try {
      await _firebaseAuth.signOut();
      print("User signed out from Firebase Auth.");
    } catch (e) {
      print("Error signing out: $e");
    }
  }
}