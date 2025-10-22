import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/driver_info.dart';
import '../utils/app_localizations.dart';
import '../utils/auth_provider.dart';
import '../utils/language_provider.dart';
import 'about_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // --- NEW: A state variable to track if a journey is active ---
  bool _isJourneyActive = false;

  final List<String> _locations = [
    'Colombo',
    'Kandy',
    'Galle',
    'Jaffna',
    'Matara',
    'Batticaloa',
  ];
  String? _startLocation;
  String? _endLocation;

  void _swapLocations() {
    if (_startLocation == null && _endLocation == null) return;
    setState(() {
      final temp = _startLocation;
      _startLocation = _endLocation;
      _endLocation = temp;
    });
  }

  // --- UPDATED: This function now changes the state ---
  void _startJourney() {
    if (_startLocation == null || _endLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a start and end location.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    if (_startLocation == _endLocation) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Start and end locations cannot be the same.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // TODO: Add backend logic to start GPS tracking.
    debugPrint('Starting journey from $_startLocation to $_endLocation');

    // This is the key change: update the state to show the new UI.
    setState(() {
      _isJourneyActive = true;
    });
  }

  // --- NEW: A function to stop the journey and reset the UI ---
  void _stopJourney() {
    // TODO: Add backend logic to stop GPS tracking.
    debugPrint('Journey stopped.');

    // Reset the state to show the planner UI again.
    setState(() {
      _isJourneyActive = false;
      // Optional: Clear the locations after stopping.
      // _startLocation = null;
      // _endLocation = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final driver = context.watch<AuthProvider>().driver;
    if (driver == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, driver),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Column(
                  children: [
                    // --- NEW: Use an AnimatedSwitcher for a smooth UI transition ---
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: _isJourneyActive
                          ? _buildJourneyInProgressCard() // Show this if journey is active
                          : _buildJourneyPlannerCard(), // Show this if not
                    ),
                    const SizedBox(height: 24),
                    _buildNavigationCards(context),
                  ],
                ),
              ),
            ),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  // --- BUILDER METHODS (Header, Footer, Nav Cards are the same) ---

  Widget _buildHeader(BuildContext context, DriverInfo driver) {
    final langProvider = context.watch<LanguageProvider>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'BusTrackLK',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'The All-in-One Bus Travel Companion',
            style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
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

  // --- This is the original card for planning a journey ---
  Widget _buildJourneyPlannerCard() {
    return Container(
      key: const ValueKey('planner'), // Key for the AnimatedSwitcher
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildLocationDropdown(
            'Start Location',
            _startLocation,
            (val) => setState(() => _startLocation = val),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: IconButton(
              icon: const Icon(Icons.swap_vert, color: Colors.white70),
              onPressed: _swapLocations,
            ),
          ),
          _buildLocationDropdown(
            'End Location',
            _endLocation,
            (val) => setState(() => _endLocation = val),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _startJourney,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF34D399),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Text('Start Journey'),
          ),
        ],
      ),
    );
  }

  // --- NEW: This is the card that shows when the journey is in progress ---
  Widget _buildJourneyInProgressCard() {
    return Container(
      key: const ValueKey('in_progress'), // Key for the AnimatedSwitcher
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(16),
        // This creates the glowing green border from your design
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.5),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          // The dropdowns are now disabled to prevent changes during a journey.
          _buildLocationDropdown('Start Location', _startLocation, null),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: IconButton(
              icon: const Icon(
                Icons.swap_vert,
                color: Colors.white30,
              ), // Dim the icon
              onPressed: null, // Disable the swap button
            ),
          ),
          _buildLocationDropdown('End Location', _endLocation, null),
          const SizedBox(height: 24),
          // "Started" status indicator button (not clickable)
          ElevatedButton.icon(
            onPressed: null, // Not clickable
            icon: const Icon(Icons.check_circle, color: Colors.white),
            label: const Text('Started'),
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: const Color(0xFF34D399),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Red "Stop Journey" button
          ElevatedButton(
            onPressed: _stopJourney,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Icon(Icons.close, color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }

  // This helper method is updated to handle being disabled.
  Widget _buildLocationDropdown(
    String hint,
    String? value,
    ValueChanged<String?>? onChanged,
  ) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(
        hint,
        style: TextStyle(
          color: onChanged == null ? Colors.white30 : Colors.white70,
        ),
      ),
      dropdownColor: const Color(0xFF333F54),
      style: TextStyle(
        color: onChanged == null ? Colors.white70 : Colors.white,
        fontSize: 16,
      ),
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: onChanged == null ? Colors.white30 : Colors.white,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF1A202C),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      items: _locations
          .map((loc) => DropdownMenuItem(value: loc, child: Text(loc)))
          .toList(),
      onChanged: onChanged, // If onChanged is null, the dropdown is disabled.
    );
  }

  Widget _buildNavigationCards(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildNavCard(
            context: context,
            title: 'Profile',
            subtitle: 'Your account details',
            icon: Icons.person_outline,
            color: const Color(0xFF7C3AED),
            onTap: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const ProfileScreen())),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildNavCard(
            context: context,
            title: 'About',
            subtitle: 'Learn more about us',
            icon: Icons.info_outline,
            color: const Color(0xFF2563EB),
            onTap: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const AboutScreen())),
          ),
        ),
      ],
    );
  }

  Widget _buildNavCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 150,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: Colors.white, size: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
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
