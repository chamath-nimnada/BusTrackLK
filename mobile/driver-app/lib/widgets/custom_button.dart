import 'package:flutter/material.dart';
import 'package:driver_ui/utils/app_colors.dart';
import 'package:driver_ui/utils/app_sizes.dart';
import 'package:driver_ui/utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero, // Remove default padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.kDefaultBorderRadius),
        ),
        elevation: 5, // Optional: adds a nice shadow
        shadowColor: AppColors.kButtonBluePrimary.withOpacity(0.5),
      ),
      child: Ink(
        // The Ink widget allows us to display a gradient
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              AppColors.kButtonBluePrimary,
              AppColors.kButtonBlueSecondary,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(AppSizes.kDefaultBorderRadius),
        ),
        child: Container(
          // Define button size/padding
          width: double.infinity, // Make button stretch full width
          padding: const EdgeInsets.symmetric(
            vertical: AppSizes.kDefaultPadding * 0.8, // 16.0
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: AppTextStyles.kButtonText,
          ),
        ),
      ),
    );
  }
}

