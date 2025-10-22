import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/driver_info.dart';
import '../utils/app_localizations.dart';
import '../utils/auth_provider.dart';
import '../utils/language_provider.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the driver and language data from providers.
    final driver = context.watch<AuthProvider>().driver;
    final langCode = context.watch<LanguageProvider>().localeCode;

    // A safety check in case this screen is ever accessed without a logged-in user.
    if (driver == null) {
      return const Scaffold(
        body: Center(child: Text('Error: Could not load driver data.')),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // This header is consistent with your Profile Screen design.
            _buildHeader(context, driver),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                // This builds the main red card with all the "About Us" info.
                child: _buildAboutCard(langCode),
              ),
            ),
            // The standard copyright footer.
            _buildFooter(context, langCode),
          ],
        ),
      ),
    );
  }

  /// Builds the top header section, including the back button and driver info.
  Widget _buildHeader(BuildContext context, DriverInfo driver) {
    final langProvider = context.watch<LanguageProvider>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 24, 16),
      child: Column(
        children: [
          Row(
            children: [
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
              const SizedBox(width: 40), // Balances the back button
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

  /// Builds the main red card with the app's description and version info.
  Widget _buildAboutCard(String langCode) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEF4444), Color(0xFFF87171)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            AppLocalizations.get('about_us', langCode),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.directions_bus,
              size: 80,
              color: Color(0xFFEF4444),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.get('about_description', langCode),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          _buildVersionInfoCard(langCode),
        ],
      ),
    );
  }

  /// Builds the nested light grey card with version details.
  Widget _buildVersionInfoCard(String langCode) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildInfoRow(AppLocalizations.get('version', langCode), '1.0'),
          const SizedBox(height: 8),
          _buildInfoRow(
            AppLocalizations.get('developed_by', langCode),
            'Group 20',
          ),
          const SizedBox(height: 8),
          _buildInfoRow(
            AppLocalizations.get('released_date', langCode),
            'September 2025',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$title : ',
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context, String langCode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        AppLocalizations.get('copyright', langCode),
        style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
      ),
    );
  }
}
