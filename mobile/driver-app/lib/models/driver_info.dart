/// Represents the data model for a driver.
/// This class includes methods for converting to/from JSON for API communication
/// and local storage.
class DriverInfo {
  final String id; // Unique ID from the database
  final String driverName;
  final String email;
  final String phoneNo;
  final String busNo;
  final String routeNo;

  const DriverInfo({
    required this.id,
    required this.driverName,
    required this.email,
    required this.phoneNo,
    required this.busNo,
    required this.routeNo,
  });

  /// --- FIX: Updated fromJson factory ---
  /// Creates a DriverInfo object from a JSON map.
  /// This is more robust and handles various possible keys from your API.
  factory DriverInfo.fromJson(Map<String, dynamic> json) {
    return DriverInfo(
      id: json['_id'] ?? json['id'] ?? '', // Common keys for database IDs
      driverName: json['driverName'] ?? json['fullName'] ?? '',
      email: json['email'] ?? '',
      phoneNo: json['phoneNo'] ?? json['phone'] ?? '',
      busNo: json['busNo'] ?? '',
      routeNo: json['routeNo'] ?? '',
    );
  }

  /// --- FIX: Updated toJson method ---
  /// Converts the DriverInfo object into a JSON map.
  /// This is essential for saving the user's session to the device.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'driverName': driverName,
      'email': email,
      'phoneNo': phoneNo,
      'busNo': busNo,
      'routeNo': routeNo,
    };
  }
}
