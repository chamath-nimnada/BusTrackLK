// lib/models/live_bus_result.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LiveBusResult {
  final String driverUid;
  final String routeNo;
  final String busNo;
  final String driverName;
  final DateTime lastUpdated;
  final LatLng location;

  LiveBusResult({
    required this.driverUid,
    required this.routeNo,
    required this.busNo,
    required this.driverName,
    required this.lastUpdated,
    required this.location,
  });

  // Factory constructor to create instance from a Firestore document
  factory LiveBusResult.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // 1. Convert Firestore GeoPoint to Google Maps LatLng
    final GeoPoint geoPoint = data['location'] ?? const GeoPoint(0, 0);
    final LatLng latLng = LatLng(geoPoint.latitude, geoPoint.longitude);

    // 2. Convert Firestore Timestamp to DateTime
    final Timestamp timestamp = data['lastUpdated'] ?? Timestamp.now();
    final DateTime lastUpdated = timestamp.toDate();

    return LiveBusResult(
      driverUid: data['driverUid'] ?? '',
      routeNo: data['routeNo'] ?? 'N/A',
      busNo: data['busNo'] ?? 'N/A',
      driverName: data['driverName'] ?? 'N/A',
      lastUpdated: lastUpdated,
      location: latLng,
    );
  }
}