import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/driver_info.dart';
import '../utils/auth_provider.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  // --- FIX 1: REMOVED ALL CONSTRUCTOR ARGUMENTS ---
  // This screen is now self-sufficient and gets its data from AuthProvider.
  const ProfileScreen({Key? key}) : super(key: key);

  // --- FIX 2: IMPLEMENTED A CORRECT LOGOUT METHOD ---
  Future<void> _logout(BuildContext context) async {
    // This correctly calls the provider to clear the session before navigating.
    await context.read<AuthProvider>().logout();
    if (!context.mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A202C),
      // --- FIX 3: ADDED A PROPER APPBAR FOR BETTER NAVIGATION ---
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D3748),
        elevation: 0,
        title: const Text('My Profile'),
        actions: [
          // Placeholder for future "Edit Profile" functionality
          IconButton(
            icon: const Icon(Icons.edit_note),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Edit profile feature coming soon!'),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          // --- FIX 4: GRACEFULLY HANDLE LOADING/ERROR STATE ---
          // If the driver data isn't available, show a loading indicator.
          if (auth.driver == null) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }
          // Once we have the data, we can use it.
          final driver = auth.driver!;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ),
            child: Column(
              children: [
                _buildProfileHeader(driver),
                const SizedBox(height: 30),
                _buildProfileDetailsCard(context, driver),
                const SizedBox(height: 30),
                _buildLogoutButton(context),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Builds the top section with the profile picture and name.
  Widget _buildProfileHeader(DriverInfo driver) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: const Color(0xFF4263EB),
          child: Text(
            driver.driverName.isNotEmpty
                ? driver.driverName[0].toUpperCase()
                : 'D',
            style: const TextStyle(fontSize: 50, color: Colors.white),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          driver.driverName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          driver.email.isNotEmpty ? driver.email : 'No email provided',
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ],
    );
  }

  /// Builds a card containing the driver's detailed information.
  Widget _buildProfileDetailsCard(BuildContext context, DriverInfo driver) {
    return Card(
      color: const Color(0xFF2D3748),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          _buildDetailRow(
            icon: Icons.phone_outlined,
            title: 'Phone Number',
            value: driver.phoneNo,
          ),
          const Divider(color: Colors.white12, height: 1),
          _buildDetailRow(
            icon: Icons.directions_bus_outlined,
            title: 'Bus Number',
            value: driver.busNo,
          ),
          const Divider(color: Colors.white12, height: 1),
          _buildDetailRow(
            icon: Icons.route_outlined,
            title: 'Route Number',
            value: driver.routeNo,
          ),
        ],
      ),
    );
  }

  /// Helper widget for a single row in the details card.
  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: const TextStyle(color: Colors.white70)),
      subtitle: Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  /// Builds the logout button.
  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.logout),
        label: const Text('Logout'),
        onPressed: () => _logout(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade400,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
