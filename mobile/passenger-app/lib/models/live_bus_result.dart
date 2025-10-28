import 'package:google_maps_flutter/google_maps_flutter.dart';

class LiveBusResult {
  final String driverUid;
  final String driverName;
  final String busNo;
  final String routeNo;
  final LatLng location;
  final DateTime lastUpdated;

  LiveBusResult({
    required this.driverUid,
    required this.driverName,
    required this.busNo,
    required this.routeNo,
    required this.location,
    required this.lastUpdated,
  });

  factory LiveBusResult.fromJson(Map<String, dynamic> json) {
    // Parse the GeoPoint from Firestore
    final geoPoint = json['location'] as Map<String, dynamic>;
    final lat = geoPoint['latitude'] as double;
    final lng = geoPoint['longitude'] as double;

    return LiveBusResult(
      driverUid: json['driverUid'] ?? '',
      driverName: json['driverName'] ?? 'N/A',
      busNo: json['busNo'] ?? 'N/A',
      routeNo: json['routeNo'] ?? 'N/A',
      location: LatLng(lat, lng),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }
}