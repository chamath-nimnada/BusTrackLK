import 'package:driver_ui/utils/app_colors.dart';
import 'package:driver_ui/utils/app_localizations.dart'; // <-- 1. IMPORT
import 'package:driver_ui/utils/app_sizes.dart';
import 'package:driver_ui/utils/app_text_styles.dart';
import 'package:driver_ui/utils/language_provider.dart'; // <-- 2. IMPORT
import 'package:driver_ui/widgets/date_time_badges.dart';
import 'package:driver_ui/widgets/login_form.dart';
import 'package:driver_ui/widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // <-- 3. IMPORT

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // This boolean controls which view is visible
  // false = Register, true = Login
  bool _isLoginView = true; // Default to Login

  @override
  Widget build(BuildContext context) {
    // 4. Get the translations object
    // We use context.watch() here so that if the language changes,
    // this whole build method runs again
    final translations = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: SafeArea(
        // Use SingleChildScrollView to prevent overflow when keyboard appears
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- 1. Header (Title & Subtitle) ---
                _buildHeader(translations), // <-- 5. Pass translations
                const SizedBox(height: AppSizes.kDefaultPadding),

                // --- 2. Info Bar (Date/Time & Language) ---
                _buildInfoBar(),
                const SizedBox(height: AppSizes.kDefaultPadding * 1.5),

                // --- 3. Custom Tab Toggles ---
                _buildTabToggle(translations), // <-- 5. Pass translations

                // --- 4. Form Container ---
                _buildFormContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Header Widget ---
  Widget _buildHeader(AppLocalizations translations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "BusTrackLK", // Brand name, no translation needed
          style: AppTextStyles.kTitle,
        ),
        const SizedBox(height: AppSizes.kDefaultPadding * 0.25),
        Text(
          translations.appSubtitle, // <-- 6. USE TRANSLATION
          style: AppTextStyles.kSubtitle,
        ),
      ],
    );
  }

  // --- Info Bar Widget ---
  Widget _buildInfoBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Live date/time widget
        const DateTimeBadges(),

        // Language Dropdown
        _buildLanguageDropdown(),
      ],
    );
  }

  // --- Language Dropdown Widget ---
  Widget _buildLanguageDropdown() {
    // 7. Get the provider using 'watch'
    // This tells the widget to rebuild ONLY when the provider changes
    final languageProvider = context.watch<LanguageProvider>();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.kDefaultPadding * 0.75, // 15
        vertical: AppSizes.kDefaultPadding * 0.2, // 4
      ),
      decoration: BoxDecoration(
        color: AppColors.kTextFieldColor,
        borderRadius:
        BorderRadius.circular(AppSizes.kDefaultBorderRadius * 0.75), // 15
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: languageProvider.currentLanguage, // Use provider's value
          items: ["English", "Sinhala", "Tamil"]
              .map((lang) => DropdownMenuItem(
            value: lang,
            child: Text(lang),
          ))
              .toList(),
          onChanged: (value) {
            // 8. This now fully works. It updates the provider,
            // which forces all listening widgets to rebuild.
            // We use 'read' here because we are in an 'onChanged' callback
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

  // --- Custom Tab Toggle ---
  Widget _buildTabToggle(AppLocalizations translations) {
    return Row(
      children: [
        // Tab 1: Register
        GestureDetector(
          onTap: () {
            // More robust: just set the boolean directly
            setState(() {
              _isLoginView = false;
            });
          },
          child: _buildTabOption(
            text: translations.register, // <-- 9. USE TRANSLATION
            isSelected: !_isLoginView,
          ),
        ),
        // Tab 2: Login
        GestureDetector(
          onTap: () {
            // More robust: just set the boolean directly
            setState(() {
              _isLoginView = true;
            });
          },
          child: _buildTabOption(
            text: translations.login, // <-- 9. USE TRANSLATION
            isSelected: _isLoginView,
          ),
        ),
      ],
    );
  }

  // This is now a "dumb" widget that just displays the text and style
  Widget _buildTabOption({required String text, required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.kDefaultPadding * 0.75, // 15
        horizontal: AppSizes.kDefaultPadding * 1.5, // 30
      ),
      decoration: BoxDecoration(
        // The active tab has the card color
        color: isSelected ? AppColors.kCardColor : Colors.transparent,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSizes.kDefaultBorderRadius),
          topRight: Radius.circular(AppSizes.kDefaultBorderRadius),
        ),
      ),
      child: Text(
        text, // This text now comes from the 'translations' object
        style: isSelected
            ? AppTextStyles.kTabTitleActive
            : AppTextStyles.kTabTitleInactive,
      ),
    );
  }

  // --- Form Container ---
  Widget _buildFormContainer() {
    // This container holds the active form
    // It cleverly changes its top border radius to match the active tab
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Container(
        key: ValueKey<bool>(_isLoginView), // Important for AnimatedSwitcher
        padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
        decoration: BoxDecoration(
          color: AppColors.kCardColor,
          borderRadius: BorderRadius.only(
            // This logic creates the "blended tab" effect
            topLeft: _isLoginView
                ? const Radius.circular(AppSizes.kDefaultBorderRadius)
                : Radius.zero,
            topRight: !_isLoginView
                ? const Radius.circular(AppSizes.kDefaultBorderRadius)
                : Radius.zero,
            bottomLeft: const Radius.circular(AppSizes.kDefaultBorderRadius),
            bottomRight: const Radius.circular(AppSizes.kDefaultBorderRadius),
          ),
        ),
        // Show the correct form based on state
        child: _isLoginView ? const LoginForm() : const RegisterForm(),
      ),
    );
  }
}

