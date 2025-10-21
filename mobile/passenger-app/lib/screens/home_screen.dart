import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//screens
import 'package:passenger_app/screens/about_screen.dart';
import 'package:passenger_app/screens/auth_screen.dart';
import 'package:passenger_app/screens/lost_item_screen.dart';
import 'package:passenger_app/screens/bus_booking_screen.dart';
import 'package:passenger_app/screens/bus_schedule_screen.dart';
import 'package:passenger_app/screens/profile_screen.dart';
import 'package:passenger_app/services/auth_service.dart'; // 1. Import the AuthService

import 'bus_tracking_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 2. Add state management variables
  final AuthService _authService = AuthService();
  bool _isLoggedIn = false;

  String _selectedLanguage = 'English';
  late String _currentDate;
  late String _currentTime;

  @override
  void initState() {
    super.initState();
    _updateDateTime();
    _checkLoginStatus(); // 3. Check login status when the screen loads
  }

  // 4. New function to check for a saved token
  Future<void> _checkLoginStatus() async {
    final loggedIn = await _authService.isLoggedIn();
    if (mounted) { // Check if the widget is still in the tree
      setState(() {
        _isLoggedIn = loggedIn;
      });
    }
  }

  void _updateDateTime() {
    setState(() {
      _currentDate = DateFormat('dd MMMM yyyy').format(DateTime.now());
      _currentTime = DateFormat('hh.mm a').format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111827),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BusTrackLK',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 1),
              Text(
                'The All-in-One Bus Travel Companion',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Color(0xFF374151),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _currentDate,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Color(0xFF374151),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _currentTime,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                    decoration: BoxDecoration(
                      color: Color(0xFFBCBCBC),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedLanguage,
                        icon: Icon(Icons.arrow_drop_down, color: Colors.black54),
                        dropdownColor: Color(0xFFBCBCBC),
                        style: TextStyle(color: Colors.black87, fontSize: 14),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedLanguage = newValue!;
                          });
                        },
                        items: <String>['English', 'Sinhala', 'Tamil']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: [
                    _buildFeatureCard(context, 'Bus Tracking', 'Real-time location', Icons.directions_bus, Color(0xFF3B82F6)),
                    _buildFeatureCard(context, 'Bus Schedule', 'Timetables & Routes', Icons.schedule, Color(0xFF10B981)),
                    _buildFeatureCard(context, 'Ticket Booking', 'Book your seats', Icons.airplane_ticket, Color(0xFF6D28D9)),
                    _buildFeatureCard(context, 'Packages', 'Track your items', Icons.luggage, Color(0xFFF59E0B)),
                    // 5. This card is now dynamic
                    _buildFeatureCard(
                      context,
                      _isLoggedIn ? 'Profile' : 'Login / Register',
                      _isLoggedIn ? 'Your account details' : 'Access your account',
                      _isLoggedIn ? Icons.person : Icons.login,
                      Color(0xFF8B5CF6),
                    ),
                    _buildFeatureCard(context, 'About', 'Learn more about\nus', Icons.info, Color(0xFFEF4444)),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    '© 2025 BusTrackLK App. All Rights Reserved.',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
      BuildContext context, String title, String subtitle, IconData icon, Color color) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: InkWell(
        onTap: () {
          // 6. This is the updated navigation logic
          if (title == 'Profile' || title == 'Login / Register') {
            if (_isLoggedIn) {
              // If logged in, go to profile.
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(isPremium: false)))
                  .then((_) => _checkLoginStatus()); // Re-check login status when returning
            } else {
              // If not logged in, go to the Auth screen
              Navigator.push(context, MaterialPageRoute(builder: (context) => AuthScreen()))
                  .then((_) => _checkLoginStatus()); // Re-check login status when returning
            }
          } else if (title == 'About') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AboutScreen()));
          } else if (title == 'Packages') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LostItemScreen()));
          } else if (title == 'Bus Schedule') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => BusScheduleScreen()));
          } else if (title == 'Ticket Booking') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => BusBookingScreen()));
          } else if (title == 'Bus Tracking') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => BusTrackingScreen()));
          } else {
            print('$title tapped!');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
