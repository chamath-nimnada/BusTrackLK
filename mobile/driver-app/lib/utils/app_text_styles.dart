import 'package:driver_ui/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// This class holds all the TextStyles for your app's design
// This is the single source of truth for all text styles.
class AppTextStyles {
  // Make constructor private to prevent instantiation
  AppTextStyles._();

  // --- Base Styles ---
  // Base style for most text, using GoogleFonts.inter
  static final TextStyle _inter = GoogleFonts.inter(
    color: AppColors.kPrimaryTextColor, // Default text color is white
  );

  // Base bold style
  static final TextStyle _interBold = _inter.copyWith(
    fontWeight: FontWeight.bold,
  );

  // Base hint style (dark grey)
  static final TextStyle _interHint = _inter.copyWith(
    color: AppColors.kHintTextColor,
    fontSize: 15,
  );

  // --- Specific Styles ---

  // For "BusTrackLK"
  static final TextStyle kTitle = _interBold.copyWith(
    fontSize: 28,
    letterSpacing: -0.5,
  );

  // For "The All-in-One..." and other subtitles
  static final TextStyle kSubtitle = _inter.copyWith(
    fontSize: 14,
    color: AppColors.kSecondaryTextColor,
  );

  // For "Register" / "Login" tabs (Active)
  static final TextStyle kTabTitleActive = _interBold.copyWith(
    fontSize: 16,
  );

  // For "Register" / "Login" tabs (Inactive)
  static final TextStyle kTabTitleInactive = _inter.copyWith(
    fontSize: 16,
    color: AppColors.kSecondaryTextColor,
  );

  // For "Forgot Password?"
  static final TextStyle kForgotPassword = _inter.copyWith(
    fontSize: 13,
    color: AppColors.kSecondaryTextColor,
  );

  // For text *inside* a CustomTextField (dark text)
  static final TextStyle kTextFieldInputStyle = GoogleFonts.inter(
    color: AppColors.kBackgroundColor, // Dark text on light field
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  // For hint text *inside* a CustomTextField
  static final TextStyle kHintText = _interHint;

  // For text on blue/green/red buttons
  static final TextStyle kButtonText = _interBold.copyWith(
    fontSize: 18,
    color: AppColors.kPrimaryTextColor,
  );

  // For "English" dropdown text
  static final TextStyle kLanguageDropdown = _inter.copyWith(
    fontSize: 14,
  );

  // For "20 August..." / "Driver Name" in the date badge
  static final TextStyle kDateText = _interBold.copyWith(
    fontSize: 13,
    color: AppColors.kPrimaryTextColor,
  );

  // For "10:30 AM" in the date badge
  static final TextStyle kDateBadgeText = _inter.copyWith(
    fontSize: 13,
    color: AppColors.kDateBadgeTextColor, // Uses the specific badge text color
  );

  // For "Profile" / "About" card titles on home screen
  static final TextStyle kNavCardTitle = _interBold.copyWith(
    fontSize: 18,
  );

  // For "Your account details..." card subtitles on home screen
  static final TextStyle kNavCardSubtitle = _inter.copyWith(
    fontSize: 12,
    color: AppColors.kSecondaryTextColor.withOpacity(0.9),
  );

  // For "Tired of the endless waiting..." text in About screen
  static final TextStyle kBodyText = _inter.copyWith(
    fontSize: 15,
    height: 1.4, // Adds line spacing for readability
  );

  // For "© 2025 BusTrackLK App..." footer text
  static final TextStyle kFooterText = _inter.copyWith(
    fontSize: 12,
    color: AppColors.kSecondaryTextColor,
  );
}

