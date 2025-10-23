import 'package:driver_ui/screens/auth_screen.dart';
import 'package:driver_ui/utils/app_colors.dart';
import 'package:driver_ui/utils/app_localizations.dart'; // <-- 1. IMPORT
import 'package:driver_ui/utils/app_sizes.dart';
import 'package:driver_ui/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class RegistrationSuccessScreen extends StatelessWidget {
  const RegistrationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Get the translations object
    final translations = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch header
            children: [
              // --- 1. Header (Title & Subtitle) ---
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "BusTrackLK", // Brand name, no translation
                    style: AppTextStyles.kTitle,
                  ),
                  const SizedBox(height: AppSizes.kDefaultPadding * 0.25),
                  Text(
                    translations.appSubtitle, // <-- 3. USE TRANSLATION
                    style: AppTextStyles.kSubtitle,
                  ),
                ],
              ),
              const Spacer(), // Pushes content to the center

              // --- 2. Success Card ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSizes.kDefaultPadding * 2),
                decoration: BoxDecoration(
                  color: AppColors.kCardColor,
                  borderRadius:
                  BorderRadius.circular(AppSizes.kDefaultBorderRadius),
                ),
                child: Column(
                  children: [
                    Text(
                      translations.registrationSuccess, // <-- 3. USE TRANSLATION
                      style: AppTextStyles.kTitle.copyWith(fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSizes.kDefaultPadding * 2),
                    // Checkmark Icon
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.kSuccessIconBackground,
                      child: Icon(
                        Icons.check,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: AppSizes.kDefaultPadding * 2),
                    // OK Button
                    ElevatedButton(
                      onPressed: () {
                        // Navigate back to the AuthScreen
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const AuthScreen()),
                              (Route<dynamic> route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.kSuccessGreen,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              AppSizes.kDefaultBorderRadius),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          translations.ok, // <-- 3. USE TRANSLATION
                          style: AppTextStyles.kButtonText
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(), // Pushes content to the center

              // --- 3. Footer ---
              Center(
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

