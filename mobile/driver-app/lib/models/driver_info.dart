// This model holds the driver's data after they log in
class DriverInfo {
  final String uid; // <-- THIS IS THE NEW, REQUIRED FIELD
  final String email;
  final String driverName; // Assuming 'nic' is used as driverName
  final String busNumber;
  final String busRoute;
  final String phone;
  final double creditScore;

  DriverInfo({
    required this.uid,
    required this.email,
    required this.driverName,
    required this.busNumber,
    required this.busRoute,
    required this.phone,
    required this.creditScore,
  });



  // A factory constructor to create DriverInfo from the JSON
  // response from your backend's /api/login
  factory DriverInfo.fromJson(Map<String, dynamic> json) {
    return DriverInfo(
      uid: json['uid'] as String, // <-- PARSE THE UID
      email: json['email'] as String,
      driverName: json['nic'] as String, // Using NIC as the name
      busNumber: json['busNo'] as String,
      busRoute: json['busRoute'] as String,
      phone: json['phoneNo'] as String,
      creditScore: (json['creditScore'] as num).toDouble(),
    );
  }
}