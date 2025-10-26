// Ensure AuthScreen is imported for navigation back
import 'package:driver_ui/screens/auth_screen.dart';
import 'package:driver_ui/utils/app_colors.dart';
import 'package:driver_ui/utils/app_localizations.dart'; // For translations
import 'package:driver_ui/utils/app_sizes.dart';
import 'package:driver_ui/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class RegistrationSuccessScreen extends StatelessWidget {
  // Ensure const constructor
  const RegistrationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get translations for text elements
    final translations = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch header
            children: [
              // --- Header ---
              // Minimal header reusing styles from AuthScreen
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "BusTrackLK", // Brand name
                    style: AppTextStyles.kTitle,
                  ),
                  const SizedBox(height: AppSizes.kDefaultPadding * 0.25),
                  Text(
                    translations.appSubtitle, // Translated subtitle
                    style: AppTextStyles.kSubtitle,
                  ),
                ],
              ),
              const Spacer(), // Pushes the success card to the vertical center

              // --- Success Card ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSizes.kDefaultPadding * 2), // Generous padding
                decoration: BoxDecoration(
                  color: AppColors.kCardColor, // Card background
                  borderRadius:
                  BorderRadius.circular(AppSizes.kDefaultBorderRadius), // Rounded corners
                ),
                child: Column(
                  children: [
                    // Title: "Registration Success"
                    Text(
                      translations.registrationSuccess, // Translated title
                      style: AppTextStyles.kTitle.copyWith(fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSizes.kDefaultPadding * 2), // Spacing
                    // Checkmark Icon
                    const CircleAvatar(
                      radius: 50, // Icon size
                      backgroundColor: AppColors.kSuccessIconBackground, // Yellow background
                      child: Icon(
                        Icons.check, // Checkmark
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: AppSizes.kDefaultPadding * 2), // Spacing
                    // OK Button
                    ElevatedButton(
                      onPressed: () {
                        // Navigate back to the AuthScreen and remove all screens behind it
                        // (Prevents user pressing 'back' to get to success screen again)
                        if (context.mounted) { // Check mounted before navigation
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => const AuthScreen()),
                                (Route<dynamic> route) => false, // Remove all previous routes
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.kSuccessGreen, // Green color
                        padding: const EdgeInsets.symmetric(vertical: 16), // Button padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              AppSizes.kDefaultBorderRadius), // Rounded corners
                        ),
                      ),
                      child: Center(
                        child: Text(
                          translations.ok, // Translated "OK" text
                          style: AppTextStyles.kButtonText
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(), // Pushes the success card to the vertical center

              // --- Footer ---
              Center( // Center the footer text
                child: Text(
                  "© 2025 BusTrackLK App. All Rights Reserved.",
                  style: AppTextStyles.kFooterText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

