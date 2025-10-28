import 'package:driver_ui/models/driver_info.dart';
import 'package:driver_ui/screens/about_screen.dart';
import 'package:driver_ui/screens/profile_screen.dart';
import 'package:driver_ui/services/location_service.dart';
import 'package:driver_ui/utils/app_colors.dart';
import 'package:driver_ui/utils/app_localizations.dart';
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
  String? _selectedRoute; // <-- 2. ADD STATE FOR ROUTE NO

  // Mock list of routes. In a real app, this might come from driverInfo
  final List<String> _routes = ["100", "101", "122", "138"];

  // 3. GET THE LOCATION SERVICE
  late LocationService _locationService;

  @override
  void initState() {
    super.initState();
    // 4. INITIALIZE THE SERVICE
    _locationService = Provider.of<LocationService>(context, listen: false);
  }

  // 5. ADD A HELPER TO SHOW SNACKBARS
  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.kButtonRedStop : AppColors.kButtonGreen,
      ),
    );
  }

  // 6. UPDATE JOURNEY START/STOP LOGIC
  Future<void> _startJourney() async {
    if (_selectedRoute == null) {
      _showSnackBar("Please select a route.", isError: true);
      return;
    }

    // Call the service to start sharing
    bool success = await _locationService.startSharing(widget.driverInfo, _selectedRoute!);

    if (success) {
      setState(() {
        _isJourneyStarted = true;
      });
      _showSnackBar("Journey started. Location sharing is active.");
    } else {
      _showSnackBar("Could not start journey. Please check location permissions and service.", isError: true);
    }
  }

  Future<void> _stopJourney() async {
    // Call the service to stop sharing
    // We need the driver's Firebase UID for this
    await _locationService.stopSharing(widget.driverInfo.uid);

    setState(() {
      _isJourneyStarted = false;
    });
    _showSnackBar("Journey stopped. Location sharing is inactive.");
  }


  @override
  Widget build(BuildContext context) {
    // ... (existing build method up to _buildJourneyCard)
    final translations = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
            child: Column(
              children: [
                _buildHeader(translations),
                const SizedBox(height: AppSizes.kDefaultPadding),
                _buildInfoBar(context),
                const SizedBox(height: AppSizes.kDefaultPadding * 1.5),
                _buildJourneyCard(translations), // <-- 7. THIS WIDGET IS NOW UPDATED
                const SizedBox(height: AppSizes.kDefaultPadding),
                _buildNavGrid(translations),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ... (keep _buildHeader, _buildInfoBar, _buildLanguageDropdown)
  Widget _buildHeader(AppLocalizations translations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("BusTrackLK", style: AppTextStyles.kTitle),
        const SizedBox(height: AppSizes.kDefaultPadding * 0.25),
        Text(
          translations.appSubtitle,
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

  // 8. UPDATE JOURNEY CARD to use Route No instead of Start/End
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
          // --- THIS IS THE MAIN CHANGE ---
          // Use a single dropdown for the Route Number
          _buildLocationDropdown(
            hint: "Select Route", // <-- Use route hint
            value: _selectedRoute,
            locations: _routes, // <-- Use the routes list
            onChanged: (val) {
              setState(() {
                _selectedRoute = val;
              });
            },
          ),
          // --- END OF MAIN CHANGE ---
          const SizedBox(height: AppSizes.kDefaultPadding * 1.5),
          if (!_isJourneyStarted)
            _buildStartJourneyButton(translations)
          else
            _buildEndJourneyButtons(translations),
        ],
      ),
    );
  }

  Widget _buildLocationDropdown(
      {required String hint,
        String? value,
        required List<String> locations, // <-- 9. Pass the list of routes
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
          onChanged: _isJourneyStarted ? null : onChanged, // <-- 10. Disable if journey started
          items: locations.map((loc) { // <-- 11. Use the passed list
            return DropdownMenuItem(value: loc, child: Text(loc));
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildStartJourneyButton(AppLocalizations translations) {
    return ElevatedButton(
      onPressed: _startJourney, // <-- 12. CALL THE NEW FUNCTION
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.kButtonGreen,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.kDefaultBorderRadius),
        ),
      ),
      child: Center(
        child: Text(
          translations.startJourney,
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
            onPressed: null, // Button is disabled, just shows "STARTED"
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kButtonGreen,
              disabledBackgroundColor: AppColors.kButtonGreen.withOpacity(0.7),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(AppSizes.kDefaultBorderRadius),
              ),
            ),
            child: Center(
              child: Text(
                translations.started,
                style: AppTextStyles.kButtonText.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSizes.kDefaultPadding),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: _stopJourney, // <-- 13. CALL THE NEW FUNCTION
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

  // ... (keep _buildNavGrid)
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
          title: translations.profile,
          subtitle: translations.profileSubtitle,
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
          title: translations.about,
          subtitle: translations.aboutSubtitle,
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