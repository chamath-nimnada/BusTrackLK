// lib/services/tracking_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passenger_app/models/live_bus_result.dart';
import 'package:flutter/foundation.dart';

class TrackingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collectionName = 'live_bus_locations';

  // Searches for buses on a specific route
  Future<List<LiveBusResult>> searchLiveBuses({
    required String startLocation, // This is used as the route number
    required String endLocation,
    required String date,
  }) async {
    final routeNo = startLocation;

    try {
      // 1. Query the 'live_bus_locations' collection
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .where('routeNo', isEqualTo: routeNo) // 2. Filter by route number
          .get();

      // 3. Map the documents to LiveBusResult objects
      final buses = querySnapshot.docs
          .map((doc) => LiveBusResult.fromFirestore(doc))
          .toList();

      return buses;
    } catch (e) {
      if (kDebugMode) {
        print("Error in searchLiveBuses: $e");
      }
      throw Exception('Error connecting to server.');
    }
  }

  // Gets ALL active buses (for the "near me" map view)
  Future<List<LiveBusResult>> getAllLiveBuses() async {
    try {
      // 1. Get all documents from the collection
      final querySnapshot =
      await _firestore.collection(_collectionName).get();

      // 2. Map the documents to LiveBusResult objects
      final buses = querySnapshot.docs
          .map((doc) => LiveBusResult.fromFirestore(doc))
          .toList();

      return buses;
    } catch (e) {
      if (kDebugMode) {
        print("Error in getAllLiveBuses: $e");
      }
      throw Exception('Error connecting to server.');
    }
  }
}