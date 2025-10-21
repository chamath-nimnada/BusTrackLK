import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_localizations.dart';
import '../utils/language_provider.dart';

class AboutScreen extends StatelessWidget {
  // --- FIX: REMOVED CONSTRUCTOR ARGUMENTS ---
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the language code directly from the provider.
    final langCode = context.watch<LanguageProvider>().localeCode;

    return Scaffold(
      backgroundColor: const Color(0xFF1A202C),
      appBar: AppBar(
        title: Text(AppLocalizations.get('about_us', langCode)),
        backgroundColor: const Color(0xFF2D3748),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildAboutCard(langCode),
            const SizedBox(height: 24),
            _buildVersionCard(langCode),
            const SizedBox(height: 48),
            Text(
              AppLocalizations.get('copyright', langCode),
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the main card with the app description.
  Widget _buildAboutCard(String langCode) {
    return Card(
      color: const Color(0xFF2D3748),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(
              Icons.directions_bus,
              size: 60,
              color: Color(0xFF4263EB),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.get('app_name', langCode),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.get('about_description', langCode),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a card with version and developer info.
  Widget _buildVersionCard(String langCode) {
    return Card(
      color: const Color(0xFF2D3748),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          _buildInfoTile(
            title: AppLocalizations.get('version', langCode),
            subtitle:
                '1.0.0', // It's better to manage this with a package like `package_info_plus` later
            icon: Icons.info_outline,
          ),
          const Divider(height: 1, color: Colors.white12),
          _buildInfoTile(
            title: AppLocalizations.get('developed_by', langCode),
            subtitle: 'Group 20',
            icon: Icons.code,
          ),
          const Divider(height: 1, color: Colors.white12),
          _buildInfoTile(
            title: AppLocalizations.get('released_date', langCode),
            subtitle: 'October 2025',
            icon: Icons.calendar_today_outlined,
          ),
        ],
      ),
    );
  }

  /// Helper widget for a single row of info.
  Widget _buildInfoTile({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: const TextStyle(color: Colors.white70)),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
