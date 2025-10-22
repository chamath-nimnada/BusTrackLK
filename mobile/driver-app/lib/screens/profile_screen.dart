import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/driver_info.dart';
import '../utils/app_localizations.dart';
import '../utils/auth_provider.dart';
import '../utils/language_provider.dart';
import 'auth_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  /// Handles the logout process.
  Future<void> _logout(BuildContext context) async {
    final authProvider = context.read<AuthProvider>();
    await authProvider.logout();
    // After logging out, navigate back to the AuthScreen and clear all previous screens.
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const AuthScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the necessary providers. We use `watch` here so the UI can rebuild
    // if the language changes.
    final authProvider = context.watch<AuthProvider>();
    final driver = authProvider.driver;

    // Show a loading indicator if driver data isn't available for any reason.
    if (driver == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 1. A reusable header, consistent with the Home Screen design.
            _buildHeader(context, driver),
            // 2. The main profile card.
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 32.0,
                ),
                child: _buildProfileCard(context, driver),
              ),
            ),
            // 3. The copyright footer.
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  /// Builds the top section of the screen, including a back button and title.
  Widget _buildHeader(BuildContext context, DriverInfo driver) {
    final langProvider = context.watch<LanguageProvider>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 24, 16),
      child: Column(
        children: [
          Row(
            children: [
              // Back Button - uses a custom low-padding IconButton
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
                splashRadius: 24,
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(8),
              ),
              const Expanded(
                child: Column(
                  children: [
                    Text(
                      'BusTrackLK',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'The All-in-One Bus Travel Companion',
                      style: TextStyle(color: Colors.white70, fontSize: 10),
                    ),
                  ],
                ),
              ),
              // A SizedBox to balance the back button and keep the title centered.
              const SizedBox(width: 40),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _buildInfoBadge(driver.driverName),
                  const SizedBox(width: 8),
                  _buildInfoBadge(driver.busNo),
                ],
              ),
              _buildLanguageDropdown(langProvider),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF333F54),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  Widget _buildLanguageDropdown(LanguageProvider langProvider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF333F54),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: langProvider.localeCode,
          dropdownColor: const Color(0xFF333F54),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          style: const TextStyle(color: Colors.white, fontSize: 14),
          items: AppLocalizations.supportedLanguages
              .map(
                (lang) =>
                    DropdownMenuItem(value: lang.code, child: Text(lang.name)),
              )
              .toList(),
          onChanged: (String? newCode) {
            if (newCode != null) langProvider.setLanguage(newCode);
          },
        ),
      ),
    );
  }

  /// Builds the main card containing the profile details and logout button.
  Widget _buildProfileCard(BuildContext context, DriverInfo driver) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize:
            MainAxisSize.min, // Make the card only as tall as its content
        children: [
          // Profile Avatar
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 60, color: Color(0xFF2D3748)),
          ),
          const SizedBox(height: 24),
          // Driver Name
          Text(
            driver.driverName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          // Phone Number
          Text(
            driver.phoneNo,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 32),
          // Logout Button
          ElevatedButton(
            onPressed: () => _logout(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final langCode = context.watch<LanguageProvider>().localeCode;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        AppLocalizations.get('copyright', langCode),
        style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
      ),
    );
  }
}
