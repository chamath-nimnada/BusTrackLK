import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111827),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Navigates back to the home screen
          },
        ),
        title: Column(
          children: [
            Text(
              'BusTrackLK',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'The All-in-One Bus Travel Companion',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20), // Space from app bar
                      Container(
                        padding: const EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFEF4444), // Red color
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'About Us',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            Icon(
                              Icons.directions_bus,
                              color: Colors.white,
                              size: 80,
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Tired of the endless waiting and uncertainty of bus travel? We are too.\n\nAs daily commuters and software engineering students, we’re building Lanka Ride Connect—the app we’ve always wanted. Our mission is to put real-time information in your hands, from live bus tracking and schedules to easy seat booking, making travel in Sri Lanka simple and predictable for our entire community.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 15,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        decoration: BoxDecoration(
                          color: Color(0xFF374151), // Gray color
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            _buildInfoRow('Version', '1.0'),
                            _buildInfoRow('Developed by', 'Group 20'),
                            _buildInfoRow('Released Date', 'September 2025', hasDivider: false),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  '© 2025 BusTrackLK App. All Rights Reserved.',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value, {bool hasDivider = true}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(color: Colors.white70, fontSize: 14)),
            Text(value, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
        if (hasDivider)
          Divider(color: Colors.white24, height: 25),
      ],
    );
  }
}