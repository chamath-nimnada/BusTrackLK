class ScheduleResult {
  final String route;
  final String startLocation;
  final String startTime;
  final String endLocation;
  final String endTime;
  final String busNumber;

  ScheduleResult({
    required this.route,
    required this.startLocation,
    required this.startTime,
    required this.endLocation,
    required this.endTime,
    required this.busNumber,
  });

  // This is a "factory constructor" that knows how to create a
  // ScheduleResult object from the JSON data we get from the server.
  factory ScheduleResult.fromJson(Map<String, dynamic> json) {
    return ScheduleResult(
      route: json['route'] ?? 'N/A',
      startLocation: json['startLocation'] ?? 'N/A',
      startTime: json['startTime'] ?? 'N/A',
      endLocation: json['endLocation'] ?? 'N/A',
      endTime: json['endTime'] ?? 'N/A',
      busNumber: json['busNumber'] ?? 'N/A',
    );
  }
}