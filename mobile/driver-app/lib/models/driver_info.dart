// This class holds the data model for your driver
class DriverInfo {
  final String driverName;
  final String busNumber;
  final String phoneNumber;
  final double creditScore; // <-- 1. ADD THIS NEW LINE

  const DriverInfo({
    required this.driverName,
    required this.busNumber,
    required this.phoneNumber,
    required this.creditScore, // <-- 2. ADD THIS TO THE CONSTRUCTOR
  });
}

