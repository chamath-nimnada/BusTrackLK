import 'package:flutter/material.dart';
import 'package:passenger_app/models/live_bus_result.dart'; // <-- 1. IMPORT NEW MODEL
import 'package:passenger_app/screens/live_tracking_map_screen.dart'; // <-- 2. IMPORT NEW SCREEN

class BusTrackingResultWidget extends StatelessWidget {
  // 3. Use the new LiveBusResult model
  final LiveBusResult bus;

  const BusTrackingResultWidget({
    Key? key,
    required this.bus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xFF374151).withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Route ${bus.routeNo} - ${bus.busNo}', // <-- 4. Use live data
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.person, color: Colors.white70, size: 16),
                    SizedBox(width: 5),
                    Text(
                      bus.driverName, // <-- 4. Use live data
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.white70, size: 16),
                    SizedBox(width: 5),
                    Text(
                      'Last seen: ${bus.lastUpdated.toLocal().hour}:${bus.lastUpdated.minute.toString().padLeft(2, '0')}', // <-- 4. Use live data
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          // --- 5. ADD THE TRACK BUTTON ---
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LiveTrackingMapScreen(bus: bus),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF8B5CF6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: Text(
              'Track',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}