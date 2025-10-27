// lib/models/booking_result.dart
class BookingResult {
  final String tripId;
  final String route;
  final String startLocation;
  final String endLocation;
  final String departureTime;
  final String arrivalTime;
  final String busNumber;
  final String busType;
  final int availableSeats;

  BookingResult({
    required this.tripId,
    required this.route,
    required this.startLocation,
    required this.endLocation,
    required this.departureTime,
    required this.arrivalTime,
    required this.busNumber,
    required this.busType,
    required this.availableSeats,
  });

  factory BookingResult.fromJson(Map<String, dynamic> json) {
    return BookingResult(
      tripId: json['tripId'] ?? '',
      route: json['route'] ?? 'N/A',
      startLocation: json['startLocation'] ?? 'N/A',
      endLocation: json['endLocation'] ?? 'N/A',
      departureTime: json['departureTime'] ?? 'N/A',
      arrivalTime: json['arrivalTime'] ?? 'N/A',
      busNumber: json['busNumber'] ?? 'N/A',
      busType: json['busType'] ?? 'N/A',
      availableSeats: json['availableSeats'] ?? 0,
    );
  }
}