import 'package:flutter/material.dart';

class BusResultWidget extends StatelessWidget {
  final String route;
  final String startLocation;
  final String endLocation;
  final int availableSeats;

  const BusResultWidget({
    Key? key,
    required this.route,
    required this.startLocation,
    required this.endLocation,
    required this.availableSeats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          SizedBox(height: 15),
          Row(
            children: [
              Icon(Icons.circle, color: Color(0xFF8B5CF6), size: 16),
              SizedBox(width: 8),
              Text(startLocation, style: TextStyle(color: Colors.white70)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(height: 2, color: Colors.white24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.circle, color: Color(0xFF10B981), size: 12),
                          Icon(Icons.circle, color: Color(0xFF10B981), size: 12),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Text(endLocation, style: TextStyle(color: Colors.white70)),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white30)
                    ),
                    child: Text('Available Seats', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ),
                  SizedBox(width: 8),
                  Text(availableSeats.toString(), style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF8B5CF6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
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