import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:passenger_app/models/schedule_result.dart'; // Import our new model

class ScheduleService {
  final String _baseUrl = "http://10.0.2.2:8080/api/schedule";

  // Calls the GET /locations endpoint
  Future<List<String>> getLocations() async {
    final response = await http.get(Uri.parse('$_baseUrl/locations'));

    if (response.statusCode == 200) {
      // The response body is a JSON list of strings, e.g., ["Colombo", "Kandy"]
      List<dynamic> data = jsonDecode(response.body);
      // Convert the dynamic list to a List<String>
      return data.map((location) => location.toString()).toList();
    } else {
      throw Exception('Failed to load locations');
    }
  }

  // Calls the GET /search endpoint
  Future<List<ScheduleResult>> searchSchedules({
    required String startLocation,
    required String endLocation,
    required String date,
  }) async {
    // Build the URL with query parameters
    final uri = Uri.parse('$_baseUrl/search').replace(queryParameters: {
      'startLocation': startLocation,
      'endLocation': endLocation,
      'date': date,
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // The response is a JSON list of schedule objects
      List<dynamic> data = jsonDecode(response.body);

      // Map each JSON object to our ScheduleResult class
      return data.map((json) => ScheduleResult.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search schedules');
    }
  }
}