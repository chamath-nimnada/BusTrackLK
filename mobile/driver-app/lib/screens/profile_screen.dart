import 'package:driver_ui/models/driver_info.dart';
import 'package:driver_ui/screens/auth_screen.dart';
import 'package:driver_ui/utils/app_colors.dart';
import 'package:driver_ui/utils/app_localizations.dart';
import 'package:driver_ui/utils/app_sizes.dart';
import 'package:driver_ui/utils/app_text_styles.dart';
import 'package:driver_ui/utils/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  final DriverInfo driverInfo;

  const ProfileScreen({
    super.key,
    required this.driverInfo,
  });

  @override
  Widget build(BuildContext context) {
    // Get the translations object for this screen
    final translations = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
            child: Column(
              children: [
                _buildHeader(context, translations), // Pass translations
                const SizedBox(height: AppSizes.kDefaultPadding),
                _buildInfoBar(context), // No text to translate here
                const SizedBox(height: AppSizes.kDefaultPadding * 1.5),
                _buildProfileBody(context, translations), // Pass translations
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations translations) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        const SizedBox(width: AppSizes.kDefaultPadding * 0.5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("BusTrackLK", style: AppTextStyles.kTitle),
            Text(
              translations.appSubtitle,
              style: AppTextStyles.kSubtitle,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
        _buildLanguageDropdown(context),
      ],
    );
  }

  Widget _buildLanguageDropdown(BuildContext context) {
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
          items: ["English", "Sinhala", "Tamil"]
              .map((lang) => DropdownMenuItem(
            value: lang,
            child: Text(lang),
          ))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              context.read<LanguageProvider>().setLanguage(value);
            }
          },
          style: AppTextStyles.kLanguageDropdown,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.kPrimaryTextColor,
          ),
          dropdownColor: AppColors.kCardColor,
        ),
      ),
    );
  }

  // This is the main body of the profile card
  Widget _buildProfileBody(
      BuildContext context, AppLocalizations translations) {
    // Calculate score percentage (e.g., 4.8 / 5.0 = 0.96)
    // We use clamp to make sure the value is safe (between 0.0 and 1.0)
    final double scorePercentage =
    (driverInfo.creditScore / 5.0).clamp(0.0, 1.0);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.kDefaultPadding * 1.5),
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(AppSizes.kDefaultBorderRadius),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.person_pin_circle,
            size: 100,
            color: Colors.white,
          ),
          const SizedBox(height: AppSizes.kDefaultPadding),
          Text(
            driverInfo.driverName,
            style: AppTextStyles.kTitle.copyWith(fontSize: 22),
          ),
          const SizedBox(height: AppSizes.kDefaultPadding * 0.25),
          Text(
            driverInfo.phoneNumber,
            style: AppTextStyles.kSubtitle.copyWith(fontSize: 16),
          ),

          // --- THIS IS THE NEW CREDIT SCORE PANEL ---
          const SizedBox(height: AppSizes.kDefaultPadding * 1.5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title: "Credit Score"
              Text(
                translations.creditScore, // <-- Uses new translation
                style: AppTextStyles.kSubtitle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSizes.kDefaultPadding * 0.5),
              // Progress Bar and Text
              Row(
                children: [
                  // The bar
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          AppSizes.kDefaultBorderRadius * 0.5),
                      child: LinearProgressIndicator(
                        value: scorePercentage, // The score
                        minHeight: 12,
                        backgroundColor: AppColors.kBackgroundColor,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.kSuccessGreen, // Use our existing green
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSizes.kDefaultPadding),
                  // The text: "4.8 / 5.0"
                  Text(
                    "${driverInfo.creditScore} / 5.0",
                    style: AppTextStyles.kTitle.copyWith(fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
          // --- END OF NEW PANEL ---

          const SizedBox(height: AppSizes.kDefaultPadding * 2),
          // Logout Button
          ElevatedButton(
            onPressed: () {
              // Navigate back to AuthScreen and remove all other screens
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const AuthScreen()),
                    (Route<dynamic> route) => false, // This removes all routes
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kButtonLogoutRed,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(AppSizes.kDefaultBorderRadius),
              ),
            ),
            child: Center(
              child: Text(
                translations.logout,
                style: AppTextStyles.kButtonText.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

