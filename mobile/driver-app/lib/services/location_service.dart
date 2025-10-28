import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_ui/models/driver_info.dart'; // <-- Uses your DriverInfo model
import 'package:flutter/foundation.dart';

class LocationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Timer? _locationTimer; // Timer to simulate location updates

  // The Firestore collection where locations will be stored
  static const String _collectionName = 'live_bus_locations';

  // Starting location for fake data (e.g., Colombo)
  double _fakeLat = 6.9271;
  double _fakeLng = 79.8612;

  /// Starts sharing the driver's location
  Future<bool> startSharing(DriverInfo driverInfo, String routeNo) async {
    try {
      // Stop any existing timers
      _locationTimer?.cancel();

      // Reset fake location on each start
      _fakeLat = 6.9271;
      _fakeLng = 79.8612;

      // 1. Create the initial document in Firestore
      // We use the driver's UID as the document ID for easy access
      await _firestore.collection(_collectionName).doc(driverInfo.uid).set({
        'driverName': driverInfo.driverName, // From your model
        'busNo': driverInfo.busNumber,       // From your model
        'routeNo': routeNo,                  // From the dropdown
        'driverUid': driverInfo.uid,         // From your model
        'location': GeoPoint(_fakeLat, _fakeLng),
        'lastUpdated': FieldValue.serverTimestamp(),
      });

      // 2. Start a timer to update the location every 10 seconds
      _locationTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
        // Simulate movement by slightly changing coordinates
        _fakeLat += 0.0005; // Move slightly north
        _fakeLng += 0.0002;

        // 3. Update the location in Firestore
        _firestore.collection(_collectionName).doc(driverInfo.uid).update({
          'location': GeoPoint(_fakeLat, _fakeLng),
          'lastUpdated': FieldValue.serverTimestamp(),
        });

        if (kDebugMode) {
          print("Updated location for ${driverInfo.uid}: $_fakeLat, $_fakeLng");
        }
      });

      return true;
    } catch (e) {
      if (kDebugMode) {
        print("Error starting sharing: $e");
      }
      return false;
    }
  }

  /// Stops sharing the driver's location
  Future<void> stopSharing(String driverUid) async {
    try {
      // 1. Stop the update timer
      _locationTimer?.cancel();
      _locationTimer = null;

      // 2. Delete the driver's location document from Firestore
      await _firestore.collection(_collectionName).doc(driverUid).delete();

      if (kDebugMode) {
        print("Stopped sharing for $driverUid");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error stopping sharing: $e");
      }
    }
  }
}