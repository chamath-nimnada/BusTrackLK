import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/driver_info.dart';
import '../utils/auth_provider.dart';
import 'login_screen.dart';
import 'profile_screen.dart';
// Note: You might need to adjust the import for AboutScreen if you have it
// import 'about_screen.dart';

class HomeScreen extends StatefulWidget {
  // --- FIX 1: REMOVED ALL CONSTRUCTOR ARGUMENTS ---
  // The screen will now get all its data directly from the AuthProvider.
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // --- Local state for the journey planner ---
  final List<String> _locations = [
    'Colombo',
    'Kandy',
    'Galle',
    'Jaffna',
    'Matara',
  ];
  String? _startLocation;
  String? _endLocation;
  bool _isJourneyActive = false;

  // --- FIX 2: IMPLEMENTED CORRECT LOGOUT ---
  Future<void> _logout() async {
    // This function now correctly calls the provider to clear the session
    // before navigating to the login screen.
    await context.read<AuthProvider>().logout();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  void _startJourney() {
    if (_startLocation != null && _endLocation != null) {
      if (_startLocation == _endLocation) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Start and end locations cannot be the same.'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }
      setState(() {
        _isJourneyActive = true;
      });
      // TODO: Add logic to start GPS tracking and notify the backend.
      debugPrint('Starting journey from $_startLocation to $_endLocation...');
    }
  }

  void _endJourney() {
    setState(() {
      _isJourneyActive = false;
      _startLocation = null;
      _endLocation = null;
    });
    // TODO: Add logic to stop GPS tracking and notify the backend.
    debugPrint('Journey ended.');
  }

  @override
  Widget build(BuildContext context) {
    // --- FIX 3: USE A CONSUMER FOR ROBUST STATE MANAGEMENT ---
    // This ensures the UI rebuilds when the auth state changes and
    // handles the loading state gracefully.
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        final driver = auth.driver;

        // --- Show a loading screen if driver data is not yet available ---
        if (driver == null) {
          return const Scaffold(
            backgroundColor: Color(0xFF1A202C),
            body: Center(child: CircularProgressIndicator(color: Colors.white)),
          );
        }

        // --- Main UI ---
        return Scaffold(
          backgroundColor: const Color(0xFF1A202C),
          // --- FIX 4: ADDED AN APPBAR AND A DRAWER FOR NAVIGATION ---
          // This is a more standard and user-friendly UI pattern.
          appBar: AppBar(
            title: Text('Welcome, ${driver.driverName.split(' ')[0]}'),
            backgroundColor: const Color(0xFF2D3748),
            elevation: 0,
          ),
          drawer: _buildDrawer(driver),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildStatusCard(driver),
                const SizedBox(height: 24),
                // --- FIX 5: DYNAMIC JOURNEY CARD ---
                // The UI now changes depending on whether a journey is active.
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _isJourneyActive
                      ? _buildJourneyInProgressCard()
                      : _buildJourneyPlannerCard(),
                ),
                // You can add more widgets here like a map preview in the future
              ],
            ),
          ),
        );
      },
    );
  }

  /// Builds the side navigation drawer.
  Widget _buildDrawer(DriverInfo driver) {
    return Drawer(
      child: Container(
        color: const Color(0xFF2D3748),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                driver.driverName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              accountEmail: Text(
                driver.email.isNotEmpty ? driver.email : driver.phoneNo,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: const Color(0xFF4263EB),
                child: Text(
                  driver.driverName.isNotEmpty ? driver.driverName[0] : 'D',
                  style: const TextStyle(fontSize: 40.0, color: Colors.white),
                ),
              ),
              decoration: const BoxDecoration(color: Color(0xFF1A202C)),
            ),
            ListTile(
              leading: const Icon(Icons.person_outline, color: Colors.white70),
              title: const Text(
                'My Profile',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // --- FIX 6: DON'T PASS DATA, LET PROFILE SCREEN FETCH IT ---
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline, color: Colors.white70),
              title: const Text(
                'About App',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Navigator.pop(context);
                // Navigator.of(context).push(
                //   MaterialPageRoute(builder: (context) => const AboutScreen()),
                // );
              },
            ),
            const Divider(color: Colors.white24),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.redAccent),
              ),
              onTap: _logout,
            ),
          ],
        ),
      ),
    );
  }

  /// Card showing the driver's current status.
  Widget _buildStatusCard(DriverInfo driver) {
    return Card(
      color: const Color(0xFF2D3748),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.directions_bus, color: Colors.white, size: 40),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    driver.busNo,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Route: ${driver.routeNo}',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _isJourneyActive ? Colors.green : Colors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _isJourneyActive ? 'LIVE' : 'OFFLINE',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Card for planning a new journey.
  Widget _buildJourneyPlannerCard() {
    return Card(
      key: const ValueKey('planner'),
      color: const Color(0xFF2D3748),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Start a New Journey',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _buildDropdown('Start Location', _startLocation, (val) {
              setState(() => _startLocation = val);
            }),
            const SizedBox(height: 16),
            _buildDropdown('End Location', _endLocation, (val) {
              setState(() => _endLocation = val);
            }),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _startJourney,
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start Journey'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10B981),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Card displaying the currently active journey.
  Widget _buildJourneyInProgressCard() {
    return Card(
      key: const ValueKey('in_progress'),
      color: const Color(0xFF2D3748),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Journey in Progress',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '$_startLocation  ➔  $_endLocation',
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _endJourney,
              icon: const Icon(Icons.stop),
              label: const Text('End Journey'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper to build a styled dropdown.
  Widget _buildDropdown(
    String hint,
    String? value,
    void Function(String?) onChanged,
  ) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(hint, style: const TextStyle(color: Colors.white70)),
      dropdownColor: const Color(0xFF4A5568),
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF4A5568),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      items: _locations
          .map((loc) => DropdownMenuItem(value: loc, child: Text(loc)))
          .toList(),
      onChanged: onChanged,
    );
  }
}
