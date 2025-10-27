import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:driver_ui/models/driver_info.dart'; //
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthService { //
  String get _baseUrl { //
    if (kDebugMode) { //
      if (Platform.isAndroid) { //
        // Use the driver-service port (default 8080 or what you set)
        return "http://10.0.2.2:8081/api"; // Ensure this port is correct!
      } else { //
        // For iOS simulator
        return "http://localhost:8080/api"; // Ensure this port is correct!
      }
    } else { //
      return "YOUR_PRODUCTION_BACKEND_URL"; // Remember to set this for production
    }
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance; //

  // --- Register Method ---
  Future<void> registerDriver({ //
    required String email, //
    required String password, //
    required String phoneNo, //
    required String nic, //
    required String busNo, //
    required String routeNo, //
  }) async { //
    try { //
      print("Attempting to register via backend: $_baseUrl/register"); //
      final response = await http //
          .post( //
        Uri.parse('$_baseUrl/register'), //
        headers: {'Content-Type': 'application/json'}, //
        body: json.encode({ //
          'email': email, //
          'password': password, //
          'phoneNo': phoneNo, //
          'nic': nic, //
          'busNo': busNo, //
          'routeNo': routeNo, //
        }), //
      ) //
          .timeout(const Duration(seconds: 15)); // Add a timeout

      print("Backend register response status: ${response.statusCode}"); //
      print("Backend register response body: ${response.body}"); //

      if (response.statusCode == 200) { //
        print("Backend registration successful."); //
      } else { //
        String errorMessage = "Registration failed. Status code: ${response.statusCode}"; //
        try { //
          // Try to parse error message from backend body
          errorMessage = response.body.isNotEmpty ? response.body : errorMessage; //
        } catch (_) {} // Ignore parsing errors
        throw Exception(errorMessage); //
      }
    } on SocketException { //
      print("Network error during registration."); //
      throw Exception("Network error: Could not connect to the server."); //
    } on TimeoutException { //
      print("Timeout during registration."); //
      throw Exception("Network error: The request timed out."); //
    } catch (e) { //
      print("Error during registration: $e"); //
      throw Exception("Registration failed: ${e.toString().replaceFirst("Exception: ", "")}"); //
    }
  }

  // --- Login Method (Corrected) ---
  Future<DriverInfo> loginDriver({ //
    required String email, //
    required String password, //
  }) async { //
    UserCredential? userCredential; //
    try { //
      // 1. Sign in with Firebase Auth first
      print("Attempting Firebase Auth sign in for: $email"); //
      userCredential = await _firebaseAuth.signInWithEmailAndPassword( //
        email: email, //
        password: password, //
      ); //
      print("Firebase Auth sign in successful. UID: ${userCredential.user?.uid}"); //

      if (userCredential.user == null) { //
        throw FirebaseAuthException(code: 'user-credential-error', message: 'Failed to get user details from Firebase.'); //
      } //

      // 2. Get the ID Token from Firebase
      String? idToken = await userCredential.user!.getIdToken(true); // Force refresh
      if (idToken == null) { //
        throw FirebaseAuthException(code: 'id-token-error', message: 'Failed to get Firebase ID token.'); //
      } //
      print("Successfully obtained Firebase ID Token."); //

      // 3. Send the ID Token to your backend /login endpoint
      print("Calling backend login: $_baseUrl/login"); //
      final response = await http //
          .post( //
        Uri.parse('$_baseUrl/login'), //
        headers: {'Content-Type': 'application/json'}, //
        body: json.encode({'idToken': idToken}), //
      ) //
          .timeout(const Duration(seconds: 15)); // Add a timeout

      print("Backend login response status: ${response.statusCode}"); //
      print("Backend login response body: ${response.body}"); //

      // --- HANDLE DIFFERENT STATUS CODES ---
      if (response.statusCode == 200) { //
        final responseData = json.decode(response.body); //
        final driverInfo = DriverInfo.fromJson(responseData); //
        print("Backend login successful. Driver Name: ${driverInfo.driverName}"); //
        return driverInfo; // Return the parsed DriverInfo object
      } else if (response.statusCode == 403) { // 403 Forbidden - Account not approved
        await _firebaseAuth.signOut(); // Sign out from Firebase
        // Use the reason from the backend if available, otherwise a default message
        String reason = response.body.isNotEmpty ? response.body : "Account pending approval or rejected."; //
        throw Exception(reason); // Throw specific exception for UI
      } else { // Handle other backend errors (401 Unauthorized, 500 Internal Server Error, etc.)
        await _firebaseAuth.signOut(); // Sign out from Firebase
        String errorMessage = "Login failed on backend. Status: ${response.statusCode}"; //
        if(response.body.isNotEmpty) { //
          errorMessage = response.body; // Use backend message if available
        } //
        throw Exception('Login failed: $errorMessage'); //
      }
      // --- END STATUS CODE HANDLING ---

    } on FirebaseAuthException catch (e) { //
      print("Firebase Auth login failed: ${e.code} ${e.message}"); //
      String friendlyMessage; //
      if (e.code == 'user-not-found' || //
          e.code == 'wrong-password' || //
          e.code == 'invalid-credential') { //
        friendlyMessage = 'Incorrect email or password.'; //
      } else if (e.code == 'invalid-email') { //
        friendlyMessage = 'Please enter a valid email address.'; //
      } else { //
        friendlyMessage = 'An authentication error occurred. Please try again.'; //
      } //
      throw Exception('Login failed: $friendlyMessage'); //
    } catch (e) { //
      print("Error during login API call or Firebase Auth: $e"); //
      // Ensure user is signed out from Firebase if any error occurs after sign-in attempt
      if (userCredential != null) { //
        try { await _firebaseAuth.signOut(); } catch (_) {} //
      } //
      // Handle network errors specifically
      if (e is SocketException) { //
        throw Exception('Network error: Could not connect to the server.'); //
      } else if (e is TimeoutException) { //
        throw Exception('Network error: The request timed out.'); //
      } //
      // Rethrow specific backend messages or provide a general error
      if (e is Exception && e.toString().contains("Account not approved")) { //
        throw e; // Rethrow the specific "Account not approved" message
      } //
      throw Exception( //
          'Login failed: ${e.toString().replaceFirst("Exception: ", "")}'); // More generic message
    }
  }

  // --- Logout Method ---
  Future<void> logoutDriver() async { //
    try { //
      await _firebaseAuth.signOut(); //
      print("User signed out successfully from Firebase."); //
    } catch (e) { //
      print("Error signing out: $e"); //
    }
  }

  // --- Helper to get current user ---
  User? getCurrentUser() { //
    return _firebaseAuth.currentUser; //
  }

  // --- Stream to listen for auth state changes ---
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges(); //
}