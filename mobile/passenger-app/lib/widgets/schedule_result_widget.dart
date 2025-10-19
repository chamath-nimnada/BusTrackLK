import 'package:flutter/material.dart';

class ScheduleResultWidget extends StatelessWidget {
  final String route;
  final String startLocation;
  final String startTime;
  final String endLocation;
  final String endTime;

  const ScheduleResultWidget({
    Key? key,
    required this.route,
    required this.startLocation,
    required this.startTime,
    required this.endLocation,
    required this.endTime,
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
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline Column
              Column(
                children: [
                  Icon(Icons.circle, color: Color(0xFF8B5CF6), size: 16),
                  Container(
                    height: 40,
                    width: 2,
                    color: Colors.white24,
                  ),
                  Icon(Icons.circle, color: Color(0xFF10B981), size: 16),
                ],
              ),
              SizedBox(width: 15),
              // Details Column
              Expanded(
                child: Column(
                  children: [
                    _buildLocationRow(startLocation, startTime),
                    SizedBox(height: 25),
                    _buildLocationRow(endLocation, endTime),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationRow(String location, String time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(location, style: TextStyle(color: Colors.white70, fontSize: 15)),
        Text(time, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
      ],
    );
  }
}