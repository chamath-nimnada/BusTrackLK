// lib/services/booking_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:passenger_app/models/booking_result.dart';
import 'package:passenger_app/services/schedule_service.dart';

class BookingService {
  final String _baseUrl = "http://10.0.2.2:8080/api/booking";
  final ScheduleService _scheduleService = ScheduleService(); // Re-use for locations

  // Re-use getLocations from ScheduleService
  Future<List<String>> getLocations() async {
    return await _scheduleService.getLocations();
  }

  // Search for bookable trips (only Intercity)
  Future<List<BookingResult>> searchBookableTrips({
    required String startLocation,
    required String endLocation,
    required String date,
  }) async {
    final uri = Uri.parse('$_baseUrl/search').replace(queryParameters: {
      'startLocation': startLocation,
      'endLocation': endLocation,
      'date': date,
    });

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => BookingResult.fromJson(json)).toList();
      } else {
        print("Booking search failed: ${response.statusCode} - ${response.body}");
        throw Exception('Failed to search bookable trips: ${response.body}');
      }
    } catch (e) {
      print("Error during booking search HTTP call: $e");
      throw Exception('Could not connect to server or search failed.');
    }
  }
}