import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_localizations.dart';
import '../utils/language_provider.dart';
import 'Login_screen.dart';
import '../utils/auth_provider.dart';

class ProfileScreen extends StatefulWidget {
  final String driverName;
  final String busNo;
  final String phoneNo;

  const ProfileScreen({
    Key? key,
    this.driverName = "Driver Name",
    this.busNo = "ABC-4768",
    this.phoneNo = "+94 78 123 1234",
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Remove local selectedLanguage; use Provider instead

  @override
  Widget build(BuildContext context) {
    final selectedLanguage = Provider.of<LanguageProvider>(context).language;
    final auth = Provider.of<AuthProvider>(context, listen: true);
    final driverName = auth.driver?.driverName ?? widget.driverName;
    final phoneNo = auth.driver?.phoneNo ?? widget.phoneNo;
    return Scaffold(
      backgroundColor: const Color(0xFF1A202C),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Profile Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D3748),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    // Profile Avatar
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 60,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Driver Name
                    Text(
                      driverName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Phone Number
                    Text(
                      phoneNo,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Logout Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEF4444),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.get('logout', selectedLanguage),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            // Footer
            Padding(
              padding: const EdgeInsets.only(bottom: 12, top: 8),
              child: Text(
                AppLocalizations.get('copyright', selectedLanguage),
                style: const TextStyle(color: Colors.white54, fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
