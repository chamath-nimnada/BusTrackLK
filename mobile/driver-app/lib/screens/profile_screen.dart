import 'package:driver_ui/models/driver_info.dart';
// Ensure AuthScreen is imported for navigation
import 'package:driver_ui/screens/auth_screen.dart'; // <-- THIS IMPORT IS CRUCIAL
import 'package:driver_ui/utils/app_colors.dart';
import 'package:driver_ui/utils/app_localizations.dart';
import 'package:driver_ui/utils/app_sizes.dart';
import 'package:driver_ui/utils/app_text_styles.dart';
import 'package:driver_ui/utils/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Import AuthService if you want to call logoutDriver() on logout
// import 'package:driver_ui/services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  // Receives driver info from HomeScreen
  final DriverInfo driverInfo;

  // Ensure const constructor
  const ProfileScreen({
    super.key,
    required this.driverInfo,
  });

  @override
  Widget build(BuildContext context) {
    // Get translations
    final translations = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView( // Allow scrolling if content overflows
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
            child: Column(
              children: [
                _buildHeader(context, translations), // Header with Back button
                const SizedBox(height: AppSizes.kDefaultPadding),
                _buildInfoBar(context), // Driver Name/Bus No + Language
                const SizedBox(height: AppSizes.kDefaultPadding * 1.5),
                _buildProfileBody(context, translations), // Main card content
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper: Header with Back Button and Title/Subtitle
  Widget _buildHeader(BuildContext context, AppLocalizations translations) {
    return Row(
      children: [
        // Back Button
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () {
            // Simply pop the current screen to go back to HomeScreen
            Navigator.of(context).pop();
          },
        ),
        const SizedBox(width: AppSizes.kDefaultPadding * 0.5),
        // Title and Subtitle
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("BusTrackLK", style: AppTextStyles.kTitle), // Brand name
            Text(translations.appSubtitle, style: AppTextStyles.kSubtitle), // Translated
          ],
        ),
      ],
    );
  }

  // Helper: Info Bar (Driver Name/Bus No + Language Dropdown)
  Widget _buildInfoBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Driver Name / Bus Number Badge
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.kDefaultPadding * 0.75,
            vertical: AppSizes.kDefaultPadding * 0.5,
          ),
          decoration: BoxDecoration(
            color: AppColors.kDateBadgeColor,
            borderRadius:
            BorderRadius.circular(AppSizes.kDefaultBorderRadius * 0.75),
          ),
          child: Row(
            children: [
              Text(driverInfo.driverName, style: AppTextStyles.kDateText),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.kDefaultPadding * 0.5),
                child: Text("|", style: AppTextStyles.kDateText),
              ),
              Text(driverInfo.busNumber, style: AppTextStyles.kDateText),
            ],
          ),
        ),
        // Language Dropdown
        _buildLanguageDropdown(context),
      ],
    );
  }

  // Helper: Language Dropdown
  Widget _buildLanguageDropdown(BuildContext context) {
    // Watch provider for changes
    final languageProvider = context.watch<LanguageProvider>();
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.kDefaultPadding * 0.75,
        vertical: AppSizes.kDefaultPadding * 0.2,
      ),
      decoration: BoxDecoration(
        color: AppColors.kTextFieldColor,
        borderRadius:
        BorderRadius.circular(AppSizes.kDefaultBorderRadius * 0.75),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: languageProvider.currentLanguage,
          items: ["English", "Sinhala", "Tamil"] // Available languages
              .map((lang) => DropdownMenuItem(value: lang, child: Text(lang)))
              .toList(),
          onChanged: (value) {
            // Update provider on change - use 'read' in callbacks
            if (value != null) {
              context.read<LanguageProvider>().setLanguage(value);
            }
          },
          style: AppTextStyles.kLanguageDropdown,
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.kPrimaryTextColor),
          dropdownColor: AppColors.kCardColor,
        ),
      ),
    );
  }

  // Helper: Main Profile Card Content
  Widget _buildProfileBody(BuildContext context, AppLocalizations translations) {
    // Calculate score percentage (0.0 to 1.0) for the progress bar
    final double scorePercentage = (driverInfo.creditScore / 5.0).clamp(0.0, 1.0);

    return Container(
      width: double.infinity, // Take full width
      padding: const EdgeInsets.all(AppSizes.kDefaultPadding * 1.5), // Inner padding
      decoration: BoxDecoration(
        color: AppColors.kCardColor, // Card background color
        borderRadius: BorderRadius.circular(AppSizes.kDefaultBorderRadius), // Rounded corners
      ),
      child: Column(
        children: [
          // Profile Icon
          const Icon(
            Icons.person_pin_circle, // Profile icon
            size: 100,
            color: Colors.white,
          ),
          const SizedBox(height: AppSizes.kDefaultPadding), // Spacing
          // Driver Name
          Text(
            driverInfo.driverName,
            style: AppTextStyles.kTitle.copyWith(fontSize: 22),
          ),
          const SizedBox(height: AppSizes.kDefaultPadding * 0.25), // Spacing
          // Phone Number
          Text(
            driverInfo.phone,
            style: AppTextStyles.kSubtitle.copyWith(fontSize: 16),
          ),
          const SizedBox(height: AppSizes.kDefaultPadding * 1.5), // Spacing

          // --- Credit Score Panel ---
          Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align title left
            children: [
              // Title: "Credit Score" (translated)
              Text(
                translations.creditScore,
                style: AppTextStyles.kSubtitle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSizes.kDefaultPadding * 0.5), // Spacing
              // Progress Bar and Text Label
              Row(
                children: [
                  // Linear Progress Bar
                  Expanded(
                    child: ClipRRect( // Clip for rounded corners on the bar
                      borderRadius: BorderRadius.circular(AppSizes.kDefaultBorderRadius * 0.5),
                      child: LinearProgressIndicator(
                        value: scorePercentage, // Value from 0.0 to 1.0
                        minHeight: 12, // Bar thickness
                        backgroundColor: AppColors.kBackgroundColor, // Background of the bar track
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.kSuccessGreen, // Color of the progress itself
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSizes.kDefaultPadding), // Spacing
                  // Text Label: "4.8 / 5.0"
                  Text(
                    "${driverInfo.creditScore.toStringAsFixed(1)} / 5.0", // Format to one decimal place
                    style: AppTextStyles.kTitle.copyWith(fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
          // --- END OF Credit Score Panel ---

          const SizedBox(height: AppSizes.kDefaultPadding * 2), // Spacing

          // --- Logout Button ---
          ElevatedButton(
            onPressed: () async { // Make async if calling logoutDriver
              // Optional: Call AuthService to sign out from Firebase Auth
              // try {
              //   // Use Provider.of for safety in async gaps if needed, ensure listen: false
              //   await Provider.of<AuthService>(context, listen: false).logoutDriver();
              // } catch (e) {
              //   print("Error during Firebase sign out: $e");
              //   // Optionally show a SnackBar error here
              // }

              // Navigate back to AuthScreen and remove all screens behind it
              // Check mounted after async gap if logoutDriver is awaited
              if (context.mounted) { // Use context.mounted check
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const AuthScreen()),
                      (Route<dynamic> route) => false, // Removes all previous routes
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kButtonLogoutRed, // Red color
              padding: const EdgeInsets.symmetric(vertical: 16), // Button padding
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(AppSizes.kDefaultBorderRadius), // Rounded corners
              ),
            ),
            child: Center(
              child: Text(
                translations.logout, // Translated button text
                style: AppTextStyles.kButtonText.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

