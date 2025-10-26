import 'package:flutter/material.dart';

// This class holds all the colors for your app's design
// This is the single source of truth for all colors.
class AppColors {
  // Make constructor private to prevent instantiation
  AppColors._();

  // --- Main App Colors ---
  // Used for the main background of all screens
  static const Color kBackgroundColor = Color(0xFF1C2333);
  // Used for the main login/register/profile/about cards
  static const Color kCardColor = Color(0xFF4A4E5A);
  // Used for text fields and dropdowns
  static const Color kTextFieldColor = Color(0xFFD9D9D9);
  // Used for the date/time/driver info badge
  static const Color kDateBadgeColor = Color(0xFF3F3F51);

  // --- Button Colors ---
  // Gradient start for "Login" / "Register" buttons
  static const Color kButtonBluePrimary = Color(0xFF3A79F8);
  // Gradient end for "Login" / "Register" buttons
  static const Color kButtonBlueSecondary = Color(0xFF3127F8);
  // Green for "Start Journey" and "OK" buttons
  static const Color kButtonGreen = Color(0xFF8BC540);
  // Red for the "Stop (X)" button on home screen
  static const Color kButtonRedStop = Color(0xFFC70039);
  // Red for the "Logout" button on profile screen
  static const Color kButtonLogoutRed = Color(0xFFE53935);
  // Green for "OK" button on success screen (same as Start Journey)
  static const Color kSuccessGreen = Color(0xFF8BC540);

  // --- Text Colors ---
  // Pure white for titles, button text
  static const Color kPrimaryTextColor = Color(0xFFFAFAFA);
  // Light grey for subtitles, inactive tabs
  static const Color kSecondaryTextColor = Color(0xFFBDBDBD);
  // Dark grey for hint text inside text fields
  static const Color kHintTextColor = Color(0xFF6F6F6F);
  // Text color for the date/time badge
  static const Color kDateBadgeTextColor = Color(0xFFFAFAFA);

  // --- Card & Misc Colors ---
  // Purple for "Profile" card on home screen
  static const Color kCardPurple = Color(0xFF8E44AD);
  // Blue for "About" card on home screen
  static const Color kCardBlue = Color(0xFF2980B9);
  // Red for the main "About Us" card
  static const Color kCardRed = Color(0xFFC0392B);
  // Light grey for the "Version" card on about screen
  static const Color kCardVersionGrey = Color(0xFFBDBDBD);
  // Yellow background for the success checkmark icon
  static const Color kSuccessIconBackground = Color(0xFFFDD835);
}

