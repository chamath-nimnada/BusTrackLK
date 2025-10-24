// lib/services/lost_item_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
// Removed AuthService import as token is not needed

class LostItemService {
  final String _baseUrl = "http://10.0.2.2:8080/api/lost-items";

  Future<String> submitReport({
    // --- ADDED ---
    required String reporterName,
    // --- END ADDITION ---
    required String contactNo,
    required String itemName,
    required String busRouteInfo,
    required String dateTimeLost,
    String? additionalInfo,
  }) async {
    // --- REMOVED: Token fetching logic ---

    final response = await http.post(
      Uri.parse('$_baseUrl/report'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // --- REMOVED: Authorization header ---
      },
      body: jsonEncode(<String, dynamic>{
        // --- ADDED ---
        'reporterName': reporterName,
        // --- END ADDITION ---
        'contactNo': contactNo,
        'itemName': itemName,
        'busRouteInfo': busRouteInfo,
        'dateTimeLost': dateTimeLost,
        'additionalInfo': additionalInfo ?? '',
      }),
    );

    if (response.statusCode == 200) {
      print("SubmitReport Success: ${response.body}"); // Log success
      return response.body; // Success message from server
    } else {
      print("SubmitReport Failed: ${response.statusCode} - ${response.body}"); // Log failure
      throw Exception('Failed to submit report: ${response.body}');
    }
  }
}