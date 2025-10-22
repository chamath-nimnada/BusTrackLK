class DriverInfo {
  final String id;
  final String driverName; // This is the "User Name" (full name)
  final String username; // This is the new field for login
  final String phoneNo;
  final String nic;
  final String busNo;
  final String routeNo;

  const DriverInfo({
    required this.id,
    required this.driverName,
    required this.username, // Added
    required this.phoneNo,
    required this.nic,
    required this.busNo,
    required this.routeNo,
  });

  factory DriverInfo.fromJson(Map<String, dynamic> json) {
    return DriverInfo(
      id: json['_id'] ?? json['id'] ?? '',
      driverName: json['driverName'] ?? json['fullName'] ?? '',
      username: json['username'] ?? '', // Added
      phoneNo: json['phoneNo'] ?? json['phone'] ?? '',
      nic: json['nic'] ?? '',
      busNo: json['busNo'] ?? '',
      routeNo: json['routeNo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'driverName': driverName,
      'username': username, // Added
      'phoneNo': phoneNo,
      'nic': nic,
      'busNo': busNo,
      'routeNo': routeNo,
    };
  }
}
