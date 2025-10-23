import 'dart:async';
import 'package:driver_ui/utils/app_colors.dart';
import 'package:driver_ui/utils/app_sizes.dart';
import 'package:driver_ui/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeBadges extends StatefulWidget {
  const DateTimeBadges({super.key});

  @override
  State<DateTimeBadges> createState() => _DateTimeBadgesState();
}

class _DateTimeBadgesState extends State<DateTimeBadges> {
  late DateTime _currentTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Set the initial time
    _currentTime = DateTime.now();

    // Create a timer that updates the time every second
    // We check `if (mounted)` to ensure we don't try to update state
    // after the widget has been removed from the screen.
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _currentTime = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is removed to prevent memory leaks
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Format the date and time strings using the 'intl' package
    // e.g., "22 October 2025"
    final String dateString = DateFormat('d MMMM y').format(_currentTime);
    // e.g., "11:10 PM"
    final String timeString = DateFormat('h:mm a').format(_currentTime);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.kDefaultPadding * 0.75, // 15
        vertical: AppSizes.kDefaultPadding * 0.5, // 10
      ),
      decoration: BoxDecoration(
        color: AppColors.kDateBadgeColor,
        borderRadius:
        BorderRadius.circular(AppSizes.kDefaultBorderRadius * 0.75), // 15
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Take only needed space
        children: [
          // --- Date Badge ---
          Text(
            dateString,
            style: AppTextStyles.kDateText, // This style is now defined
          ),

          // --- Divider ---
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.kDefaultPadding * 0.5), // 10
            child: Text(
              "|",
              style: AppTextStyles.kDateText.copyWith(
                color: AppColors.kDateBadgeTextColor, // This color is now defined
              ),
            ),
          ),

          // --- Time Badge ---
          Text(
            timeString,
            style: AppTextStyles.kDateBadgeText, // This style is now defined
          ),
        ],
      ),
    );
  }
}

