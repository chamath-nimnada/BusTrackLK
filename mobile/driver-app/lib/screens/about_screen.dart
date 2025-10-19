import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_localizations.dart';
import '../utils/language_provider.dart';

class AboutScreen extends StatefulWidget {
  final String driverName;
  final String busNo;

  const AboutScreen({Key? key, required this.driverName, required this.busNo})
    : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  // Remove local selectedLanguage; use Provider instead

  @override
  Widget build(BuildContext context) {
    final selectedLanguage = Provider.of<LanguageProvider>(context).language;
    return Scaffold(
      backgroundColor: const Color(0xFF1A202C),
      body: SafeArea(
        child: Column(
          children: [
            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      // About Us Card
                      Container(
                        width: double.infinity,
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
                            // Title
                            Text(
                              AppLocalizations.get(
                                'about_us',
                                selectedLanguage,
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Bus Icon
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
                            // Description
                            Text(
                              AppLocalizations.get(
                                'about_description',
                                selectedLanguage,
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                height: 1.6,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            // Version Info
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(
                                  red: 255,
                                  green: 255,
                                  blue: 255,
                                  alpha: 51,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    AppLocalizations.get(
                                      'version',
                                      selectedLanguage,
                                    ),
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    '1.0',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Developer Info
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(
                                  red: 255,
                                  green: 255,
                                  blue: 255,
                                  alpha: 51,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    AppLocalizations.get(
                                      'developed_by',
                                      selectedLanguage,
                                    ),
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Group 20',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Released Date
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(
                                  red: 255,
                                  green: 255,
                                  blue: 255,
                                  alpha: 51,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    AppLocalizations.get(
                                      'released_date',
                                      selectedLanguage,
                                    ),
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'November 2025',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Copyright
                      Text(
                        AppLocalizations.get('copyright', selectedLanguage),
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
