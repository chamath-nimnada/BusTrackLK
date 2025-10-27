import 'package:flutter/material.dart';

class BusTrackingResultWidget extends StatelessWidget {
  final String route;
  final String startLocation;
  final String endLocation;
  final String busNumber;

  const BusTrackingResultWidget({
    Key? key,
    required this.route,
    required this.startLocation,
    required this.endLocation,
    required this.busNumber,
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
      child: Row(
        children: [
          // Timeline Column
          Column(
            children: [
              Icon(Icons.circle, color: Color(0xFF8B5CF6), size: 16),
              Container(height: 50, width: 2, color: Colors.white24),
            ],
          ),
          SizedBox(width: 15),
          // Details Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(route, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.circle, color: Color(0xFF10B981), size: 12),
                        SizedBox(width: 8),
                        Text(startLocation, style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(height: 2, color: Colors.white24),
                      ),
                    ),
                    Text(endLocation, style: TextStyle(color: Colors.white70)),
                    Icon(Icons.circle, color: Color(0xFF10B981), size: 12),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white30),
                      ),
                      child: Row(
                        children: [
                          Text('Bus', style: TextStyle(color: Colors.white70, fontSize: 12)),
                          SizedBox(width: 8),
                          Text(busNumber, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF8B5CF6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      ),
                      child: Text('Track', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}