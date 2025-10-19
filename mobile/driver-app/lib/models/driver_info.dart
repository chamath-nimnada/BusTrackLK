class DriverInfo {
  final String driverName;
  final String busNo;
  final String phoneNo;
  final String? token;

  const DriverInfo({
    required this.driverName,
    required this.busNo,
    required this.phoneNo,
    this.token,
  });

  factory DriverInfo.fromJson(Map<String, dynamic> json) {
    return DriverInfo(
      driverName: (json['driverName'] ?? json['name'] ?? '').toString(),
      busNo: (json['busNo'] ?? json['bus_number'] ?? '').toString(),
      phoneNo: (json['phone'] ?? json['phoneNo'] ?? '').toString(),
      token: json['token']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'driverName': driverName,
    'busNo': busNo,
    'phone': phoneNo,
    if (token != null) 'token': token,
  };
}
