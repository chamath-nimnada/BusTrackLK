import 'package:flutter/material.dart';
import 'home_screen.dart';

/// This screen is shown after a user successfully registers their account.
/// It provides clear visual feedback and a single action to proceed.
class RegistrationSuccessScreen extends StatelessWidget {
  const RegistrationSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The AppBar provides the back button and title, as seen in your design.
        title: const Text('BusTrackLK'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center content vertically
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // Stretch button to full width
          children: [
            const Spacer(), // Pushes content to the center
            // "Registration Success" Text
            const Text(
              'Registration Success',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),

            // Green Checkmark Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF34D399), // A vibrant green
                border: Border.all(
                  color: const Color(0xFFFBBF24),
                  width: 6,
                ), // The yellow border
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 70),
            ),

            const Spacer(), // Pushes the button to the bottom
            // OK Button
            ElevatedButton(
              onPressed: () {
                // When "OK" is pressed, navigate to the HomeScreen.
                // pushAndRemoveUntil clears the navigation history, so the user
                // can't go back to the login or success screen.
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF34D399), // Green button color
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
