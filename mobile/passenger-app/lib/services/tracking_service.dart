import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:passenger_app/models/live_bus_result.dart';

class TrackingService {
  // TODO: Replace with your actual passenger-service IP/domain
  final String _baseUrl = "http://10.0.2.2:8081/api";

  // Searches for buses on a specific route
  Future<List<LiveBusResult>> searchLiveBuses({
    required String startLocation,
    required String endLocation,
    required String date,
  }) async {
    // For simplicity, we pass startLocation as the route number
    // A real app would have a mapping: (start, end) -> routeNo
    final routeNo = startLocation;

    final url = Uri.parse(
        '$_baseUrl/tracking/search?startLocation=$routeNo&endLocation=$endLocation&date=$date');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => LiveBusResult.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load bus results');
      }
    } catch (e) {
      print("Error in searchLiveBuses: $e");
      throw Exception('Error connecting to server.');
    }
  }

  // Gets ALL active buses (for the "near me" map view)
  Future<List<LiveBusResult>> getAllLiveBuses() async {
    final url = Uri.parse('$_baseUrl/tracking/all');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => LiveBusResult.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load all live buses');
      }
    } catch (e) {
      print("Error in getAllLiveBuses: $e");
      throw Exception('Error connecting to server.');
    }
  }
}