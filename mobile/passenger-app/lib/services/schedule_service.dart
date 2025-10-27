// lib/services/schedule_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:passenger_app/models/schedule_result.dart'; // Assuming you have this model

class ScheduleService {
  final String _baseUrl = "http://10.0.2.2:8080/api/schedule";

  Future<List<String>> getLocations() async {
    final response = await http.get(Uri.parse('$_baseUrl/locations'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((location) => location.toString()).toList();
    } else {
      throw Exception('Failed to load locations');
    }
  }

  Future<List<ScheduleResult>> searchSchedules({
    required String startLocation,
    required String endLocation,
    required String date,
  }) async {
    final uri = Uri.parse('$_baseUrl/search').replace(queryParameters: {
      'startLocation': startLocation,
      'endLocation': endLocation,
      'date': date,
    });
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ScheduleResult.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search schedules: ${response.body}');
    }
  }

  // --- THIS FUNCTION MUST BE PRESENT ---
  Future<List<String>> getFormattedRouteNames() async {
    final response = await http.get(Uri.parse('$_baseUrl/routes'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((route) => route.toString()).toList();
    } else {
      throw Exception('Failed to load formatted routes: ${response.body}');
    }
  }
// --- END OF FUNCTION ---
}