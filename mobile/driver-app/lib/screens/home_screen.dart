import 'package:driver_ui/models/driver_info.dart';
import 'package:driver_ui/screens/about_screen.dart';
import 'package:driver_ui/screens/profile_screen.dart';
import 'package:driver_ui/utils/app_colors.dart';
import 'package:driver_ui/utils/app_localizations.dart'; // <-- 1. IMPORT
import 'package:driver_ui/utils/app_sizes.dart';
import 'package:driver_ui/utils/app_text_styles.dart';
import 'package:driver_ui/utils/language_provider.dart';
import 'package:driver_ui/widgets/home_nav_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final DriverInfo driverInfo;

  const HomeScreen({
    super.key,
    required this.driverInfo,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isJourneyStarted = false;
  String? _startLocation;
  String? _endLocation;

  final List<String> _locations = ["Kandy", "Colombo", "Galle", "Jaffna"];

  @override
  Widget build(BuildContext context) {
    // 2. Get the translations object
    final translations = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
            child: Column(
              children: [
                _buildHeader(translations), // <-- Pass translations
                const SizedBox(height: AppSizes.kDefaultPadding),
                _buildInfoBar(context), // No text to translate here
                const SizedBox(height: AppSizes.kDefaultPadding * 1.5),
                _buildJourneyCard(translations), // <-- Pass translations
                const SizedBox(height: AppSizes.kDefaultPadding),
                _buildNavGrid(translations), // <-- Pass translations
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations translations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("BusTrackLK", style: AppTextStyles.kTitle),
        const SizedBox(height: AppSizes.kDefaultPadding * 0.25),
        Text(
          translations.appSubtitle, // <-- 3. USE TRANSLATION
          style: AppTextStyles.kSubtitle,
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
              Text(widget.driverInfo.driverName, style: AppTextStyles.kDateText),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.kDefaultPadding * 0.5),
                child: Text("|", style: AppTextStyles.kDateText),
              ),
              Text(widget.driverInfo.busNumber, style: AppTextStyles.kDateText),
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

  Widget _buildJourneyCard(AppLocalizations translations) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(AppSizes.kDefaultBorderRadius),
        border: _isJourneyStarted
            ? Border.all(color: AppColors.kButtonGreen, width: 2)
            : null,
      ),
      child: Column(
        children: [
          _buildLocationDropdown(
            hint: translations.startLocation, // <-- 3. USE TRANSLATION
            value: _startLocation,
            onChanged: (val) {
              setState(() {
                _startLocation = val;
              });
            },
          ),
          const SizedBox(height: AppSizes.kDefaultPadding * 0.75),
          const Icon(Icons.swap_vert, color: AppColors.kPrimaryTextColor),
          const SizedBox(height: AppSizes.kDefaultPadding * 0.75),
          _buildLocationDropdown(
            hint: translations.endLocation, // <-- 3. USE TRANSLATION
            value: _endLocation,
            onChanged: (val) {
              setState(() {
                _endLocation = val;
              });
            },
          ),
          const SizedBox(height: AppSizes.kDefaultPadding * 1.5),
          if (!_isJourneyStarted)
            _buildStartJourneyButton(translations) // <-- Pass translations
          else
            _buildEndJourneyButtons(translations), // <-- Pass translations
        ],
      ),
    );
  }

  Widget _buildLocationDropdown(
      {required String hint,
        String? value,
        required ValueChanged<String?> onChanged}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.kTextFieldColor,
        borderRadius: BorderRadius.circular(AppSizes.kDefaultBorderRadius),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(hint, style: AppTextStyles.kHintText),
          dropdownColor: AppColors.kCardColor,
          icon: const Icon(Icons.keyboard_arrow_down,
              color: AppColors.kHintTextColor),
          style: AppTextStyles.kTextFieldInputStyle,
          onChanged: onChanged,
          items: _locations.map((loc) {
            return DropdownMenuItem(value: loc, child: Text(loc));
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildStartJourneyButton(AppLocalizations translations) {
    return ElevatedButton(
      onPressed: () {
        if (_startLocation != null && _endLocation != null) {
          setState(() {
            _isJourneyStarted = true;
          });
          // TODO: Call backend service to start journey
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Please select start and end locations."),
              backgroundColor: AppColors.kButtonRedStop,
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.kButtonGreen,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.kDefaultBorderRadius),
        ),
      ),
      child: Center(
        child: Text(
          translations.startJourney, // <-- 3. USE TRANSLATION
          style: AppTextStyles.kButtonText.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildEndJourneyButtons(AppLocalizations translations) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kButtonGreen,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(AppSizes.kDefaultBorderRadius),
              ),
            ),
            child: Center(
              child: Text(
                translations.started, // <-- 3. USE TRANSLATION
                style: AppTextStyles.kButtonText.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSizes.kDefaultPadding),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _isJourneyStarted = false;
              });
              // TODO: Call backend service to STOP journey
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kButtonRedStop,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(AppSizes.kDefaultBorderRadius),
              ),
            ),
            child: const Center(
              child: Icon(Icons.close, color: Colors.white, size: 28),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavGrid(AppLocalizations translations) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: AppSizes.kDefaultPadding,
      mainAxisSpacing: AppSizes.kDefaultPadding,
      childAspectRatio: 0.9,
      children: [
        // --- Profile Card ---
        HomeNavCard(
          title: translations.profile, // <-- 3. USE TRANSLATION
          subtitle: translations.profileSubtitle, // <-- 3. USE TRANSLATION
          icon: Icons.person_outline,
          color: AppColors.kCardPurple,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(
                  driverInfo: widget.driverInfo,
                ),
              ),
            );
          },
        ),
        // --- About Card ---
        HomeNavCard(
          title: translations.about, // <-- 3. USE TRANSLATION
          subtitle: translations.aboutSubtitle, // <-- 3. USE TRANSLATION
          icon: Icons.info_outline,
          color: AppColors.kCardBlue,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AboutScreen(
                  driverInfo: widget.driverInfo,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

