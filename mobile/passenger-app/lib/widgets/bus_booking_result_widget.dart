import 'package:flutter/material.dart';

class BusResultWidget extends StatelessWidget {
  final String tripId;
  final String route;
  final String startLocation;
  final String endLocation;
  final int availableSeats;
  // Add other fields like departureTime, busNumber if needed

  const BusResultWidget({
    Key? key,
    required this.tripId,
    required this.route,
    required this.startLocation,
    required this.endLocation,
    required this.availableSeats,
    // Add other fields to constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Build the UI for the result card using the passed data
    // (Similar to the ScheduleResultWidget but with available seats and Book Now button)
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF374151).withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(route, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          // Display start/end locations, maybe times
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Available Seats display
              Row(
                children: [
                  Container( /* ... decoration ... */ child: Text('Available Seats', style: TextStyle(color: Colors.white70, fontSize: 12))),
                  SizedBox(width: 8),
                  Text(availableSeats.toString(), style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
              // Book Now Button
              ElevatedButton(
                onPressed: () {
                  print("Book Now tapped for Trip ID: $tripId");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: Text('Book Now', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}