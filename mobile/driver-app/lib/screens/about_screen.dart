// FIX #1: Removed "package:package:..." typo
import 'package:driver_ui/models/driver_info.dart';
import 'package:driver_ui/utils/app_colors.dart';
import 'package:driver_ui/utils/app_sizes.dart';
import 'package:driver_ui/utils/app_text_styles.dart';
// FIX #1: Removed "package:package:..." typo
import 'package:driver_ui/utils/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutScreen extends StatelessWidget {
  final DriverInfo driverInfo;

  const AboutScreen({
    super.key,
    required this.driverInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
            child: Column(
              children: [
                _buildHeader(context),
                const SizedBox(height: AppSizes.kDefaultPadding),
                _buildInfoBar(context),
                const SizedBox(height: AppSizes.kDefaultPadding * 1.5),
                _buildAboutBody(context),
                const SizedBox(height: AppSizes.kDefaultPadding),
                _buildVersionBox(context),
                const SizedBox(height: AppSizes.kDefaultPadding * 2),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
            Text("The All-in-One Bus Travel Companion",
                style: AppTextStyles.kSubtitle),
          ],
        ),
      ],
    );
  }

  // FIX #3: Changed 'BuildContextContext' to 'BuildContext'
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
    // FIX #2: This will now work because the import is fixed
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
              languageProvider.setLanguage(value);
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

  Widget _buildAboutBody(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.kDefaultPadding * 1.5),
      decoration: BoxDecoration(
        color: AppColors.kCardRed,
        borderRadius: BorderRadius.circular(AppSizes.kDefaultBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("About Us", style: AppTextStyles.kTitle.copyWith(fontSize: 22)),
          const SizedBox(height: AppSizes.kDefaultPadding),
          const Center(
              child: Icon(Icons.directions_bus, size: 80, color: Colors.white)),
          const SizedBox(height: AppSizes.kDefaultPadding),
          Text(
            "Tired of the endless waiting and uncertainty of bus travel? We are too.",
            style: AppTextStyles.kBodyText,
          ),
          const SizedBox(height: AppSizes.kDefaultPadding),
          Text(
            "As daily commuters and software engineering students, we're building Lanka Ride Connect—the app we've always wanted. Our mission is to put real-time information in your hands, from live bus tracking and schedules to easy seat booking, making travel in Sri Lanka simple and predictable for our entire community.",
            style: AppTextStyles.kBodyText,
          ),
        ],
      ),
    );
  }

  Widget _buildVersionBox(BuildContext context) {
    final style =
    AppTextStyles.kSubtitle.copyWith(color: AppColors.kBackgroundColor);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.kDefaultPadding * 1.5),
      decoration: BoxDecoration(
        color: AppColors.kCardVersionGrey,
        borderRadius: BorderRadius.circular(AppSizes.kDefaultBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Version : 1.0", style: style),
          const SizedBox(height: AppSizes.kDefaultPadding * 0.25),
          Text("Developed by : Group 20", style: style),
          const SizedBox(height: AppSizes.kDefaultPadding * 0.25),
          Text("Released Date : September 2025", style: style),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Text(
      "© 2025 BusTrackLK App. All Rights Reserved.",
      style: AppTextStyles.kFooterText,
    );
  }
}

