import 'package:driver_ui/utils/app_colors.dart';
import 'package:driver_ui/utils/app_localizations.dart'; // For translations
import 'package:driver_ui/utils/app_sizes.dart';
import 'package:driver_ui/utils/app_text_styles.dart';
import 'package:driver_ui/utils/language_provider.dart'; // For language switching
import 'package:driver_ui/widgets/date_time_badges.dart';
import 'package:driver_ui/widgets/login_form.dart'; // Ensure correct import
import 'package:driver_ui/widgets/register_form.dart'; // Ensure correct import
import 'package:flutter/material.dart';
// import 'package:loading_overlay/loading_overlay.dart'; // <-- REMOVED
import 'package:provider/provider.dart'; // Ensure correct import

class AuthScreen extends StatefulWidget {
  // Add const constructor
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoginView = true; // Default view
  bool _isLoading = false; // State for Stack-based loading indicator

  // Callback function for child forms to update the loading state
  void _setLoading(bool loading) {
    // Use 'mounted' check for safety if callback occurs after widget disposal
    if (mounted) {
      setState(() {
        _isLoading = loading;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get translations - widget rebuilds if language changes
    final translations = AppLocalizations.of(context);

    // Main screen structure
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      // Body is wrapped in a Stack to manage the loading indicator overlay
      body: Stack( // <-- Use Stack for overlay
        children: [
          // --- Main Content ---
          // Placed as the first child, it's at the bottom of the stack
          SafeArea(
            child: SingleChildScrollView( // Allows scrolling
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Header ---
                    _buildHeader(translations),
                    const SizedBox(height: AppSizes.kDefaultPadding),
                    // --- Info Bar ---
                    _buildInfoBar(),
                    const SizedBox(height: AppSizes.kDefaultPadding * 1.5),
                    // --- Tab Toggles ---
                    _buildTabToggle(translations),
                    // --- Form Container ---
                    _buildFormContainer(), // Correctly passes _setLoading
                  ],
                ),
              ),
            ),
          ),
          // --- End Main Content ---

          // --- Loading Indicator Layer ---
          // Conditionally display this overlay on top if _isLoading is true
          if (_isLoading)
          // Container covers the whole screen with a semi-transparent color
            Container(
              color: Colors.black.withAlpha(128), // Adjust transparency (0-255)
              // Center the loading spinner within the overlay
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.kButtonBluePrimary),
                ),
              ),
            ),
          // --- End Loading Indicator Layer ---
        ],
      ), // End Stack
    ); // End Scaffold
  }

  // --- Helper Widgets ---
  // (Keep _buildHeader, _buildInfoBar, _buildLanguageDropdown, _buildTabToggle, _buildTabOption)

  Widget _buildHeader(AppLocalizations translations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("BusTrackLK", style: AppTextStyles.kTitle),
        const SizedBox(height: AppSizes.kDefaultPadding * 0.25),
        Text(translations.appSubtitle, style: AppTextStyles.kSubtitle),
      ],
    );
  }

  Widget _buildInfoBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const DateTimeBadges(),
        _buildLanguageDropdown(),
      ],
    );
  }

  Widget _buildLanguageDropdown() {
    final languageProvider = context.watch<LanguageProvider>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.kDefaultPadding * 0.75, vertical: AppSizes.kDefaultPadding * 0.2),
      decoration: BoxDecoration(
        color: AppColors.kTextFieldColor,
        borderRadius: BorderRadius.circular(AppSizes.kDefaultBorderRadius * 0.75),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: languageProvider.currentLanguage,
          items: ["English", "Sinhala", "Tamil"]
              .map((lang) => DropdownMenuItem(value: lang, child: Text(lang)))
              .toList(),
          onChanged: _isLoading ? null : (value) { // Disable while loading
            if (value != null) context.read<LanguageProvider>().setLanguage(value);
          },
          style: AppTextStyles.kLanguageDropdown,
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.kPrimaryTextColor),
          dropdownColor: AppColors.kCardColor,
        ),
      ),
    );
  }

  Widget _buildTabToggle(AppLocalizations translations) {
    return Row(
      children: [
        GestureDetector(
          onTap: () { if (!_isLoading) setState(() { _isLoginView = false; }); }, // Prevent switch if loading
          child: _buildTabOption( text: translations.register, isSelected: !_isLoginView,),
        ),
        GestureDetector(
          onTap: () { if (!_isLoading) setState(() { _isLoginView = true; }); }, // Prevent switch if loading
          child: _buildTabOption(text: translations.login, isSelected: _isLoginView,),
        ),
      ],
    );
  }

  Widget _buildTabOption({required String text, required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.kDefaultPadding * 0.75, horizontal: AppSizes.kDefaultPadding * 1.5),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.kCardColor : Colors.transparent,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSizes.kDefaultBorderRadius),
          topRight: Radius.circular(AppSizes.kDefaultBorderRadius),
        ),
      ),
      child: Text(text, style: isSelected ? AppTextStyles.kTabTitleActive : AppTextStyles.kTabTitleInactive),
    );
  }

  // Helper widget for the container holding the active form
  Widget _buildFormContainer() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Container(
        key: ValueKey<bool>(_isLoginView), // Key for AnimatedSwitcher
        padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
        decoration: BoxDecoration(
          color: AppColors.kCardColor,
          // Adjust top border radius to blend with the active tab
          borderRadius: BorderRadius.only(
            topLeft: _isLoginView ? const Radius.circular(AppSizes.kDefaultBorderRadius) : Radius.zero,
            topRight: !_isLoginView ? const Radius.circular(AppSizes.kDefaultBorderRadius) : Radius.zero,
            bottomLeft: const Radius.circular(AppSizes.kDefaultBorderRadius),
            bottomRight: const Radius.circular(AppSizes.kDefaultBorderRadius),
          ),
        ),
        // Conditionally display LoginForm or RegisterForm
        // Pass the _setLoading callback to the required 'onLoadingChanged' parameter
        child: _isLoginView
            ? LoginForm(onLoadingChanged: _setLoading) // Pass callback
            : RegisterForm(onLoadingChanged: _setLoading), // Pass callback
      ),
    );
  }
}