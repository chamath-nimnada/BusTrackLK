import 'package:driver_ui/utils/app_sizes.dart';
import 'package:driver_ui/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class HomeNavCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color; // <-- This is the corrected parameter name
  final VoidCallback onTap;

  const HomeNavCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color, // <-- Corrected
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.kDefaultPadding * 0.75),
        decoration: BoxDecoration(
          color: color, // <-- Corrected
          borderRadius: BorderRadius.circular(AppSizes.kDefaultBorderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, size: 36, color: Colors.white),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.kTitle.copyWith(fontSize: 20)),
                Text(subtitle, style: AppTextStyles.kSubtitle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

