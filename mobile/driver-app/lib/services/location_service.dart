import 'dart:async';
import 'package:driver_ui/models/driver_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:location/location.dart';

class LocationService {
  Location _location = Location();
  StreamSubscription<LocationData>? _locationSubscription;
  bool _isServiceEnabled = false;
  PermissionStatus _permissionStatus = PermissionStatus.denied;

  // TODO: Replace with your actual backend IP/domain
  final String _baseUrl = "http://10.0.2.2:8081/api/location";

  // Call this to start sharing location
  Future<bool> startSharing(DriverInfo driverInfo, String routeNo) async {
    // 1. Check if location service is enabled
    _isServiceEnabled = await _location.serviceEnabled();
    if (!_isServiceEnabled) {
      _isServiceEnabled = await _location.requestService();
      if (!_isServiceEnabled) {
        print("Location service is not enabled.");
        return false;
      }
    }

    // 2. Check for location permission
    _permissionStatus = await _location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await _location.requestPermission();
      if (_permissionStatus != PermissionStatus.granted && _permissionStatus != PermissionStatus.grantedLimited) {
        print("Location permission not granted.");
        return false;
      }
    }

    // 3. Try to enable background mode
    if (_permissionStatus == PermissionStatus.granted || _permissionStatus == PermissionStatus.grantedLimited) {
      try {
        await _location.enableBackgroundMode(enable: true);
        print("Background mode successfully enabled.");
      } catch (e) {
        print("--- EMULATOR WARNING ---");
        print("Failed to enable background mode: $e");
        print("This is expected on an emulator and will be ignored. ");
        print("Proceeding with foreground/mock location for testing. ");
        // DO NOT return false. We catch and continue as per the guide.
      }
    }

    // 4. Start listening to location changes
    // This will now pick up mock locations from the emulator
    _locationSubscription = _location.onLocationChanged.listen((LocationData currentLocation) {
      print("New Location: ${currentLocation.latitude}, ${currentLocation.longitude}");
      // Send this update to the backend
      _updateLocationOnBackend(currentLocation, driverInfo, routeNo);
    });

    print("Location sharing started.");
    return true;
  }

  // Call this to stop sharing location
  Future<void> stopSharing(String driverUid) async {
    // 1. Stop the location stream
    if (_locationSubscription != null) {
      _locationSubscription!.cancel();
      _locationSubscription = null;
    }

    // 2. Disable background mode
    try {
      await _location.enableBackgroundMode(enable: false);
    } catch (e) {
      print("Failed to disable background mode: $e");
    }

    // 3. Tell the backend to delete the location document
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/stop"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'driverUid': driverUid}),
      );

      if (response.statusCode == 200) {
        print("Successfully stopped location sharing on backend.");
      } else {
        print("Failed to stop location sharing on backend: ${response.body}");
      }
    } catch (e) {
      print("Error calling /stop endpoint: $e");
    }
  }

  // Private method to send data to the backend
  Future<void> _updateLocationOnBackend(
      LocationData locationData, DriverInfo driverInfo, String routeNo) async {
    try {
      // Note: driverInfo.uid should be the Firebase UID
      final body = {
        'driverUid': driverInfo.uid, // <-- THIS LINE IS NOW CORRECT
        'driverName': driverInfo.driverName,
        'busNo': driverInfo.busNumber,
        'routeNo': routeNo,
        'location': {
          'latitude': locationData.latitude,
          'longitude': locationData.longitude,
        },
      };

      final response = await http.post(
        Uri.parse("$_baseUrl/update"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode != 200) {
        print("Failed to update location to backend: ${response.body}");
      }
    } catch (e) {
      print("Error calling /update endpoint: $e");
    }
  }
}