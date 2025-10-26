import 'package:flutter/material.dart';
import 'package:driver_ui/utils/app_colors.dart';
import 'package:driver_ui/utils/app_sizes.dart';
import 'package:driver_ui/utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  // Change 1: Make onPressed nullable
  final VoidCallback? onPressed;

  const CustomButton({
    super.key,
    required this.text,
    // Change 2: Remove 'required'
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // The ElevatedButton's onPressed already accepts VoidCallback?
    // so no change needed here. It will correctly handle null (disabled).
    return ElevatedButton(
      onPressed: onPressed, // Pass the potentially null callback directly
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.kDefaultBorderRadius),
        ),
        elevation: 5,
        // Use withAlpha for opacity
        shadowColor: AppColors.kButtonBluePrimary.withAlpha(128),
        // Handle disabled state automatically based on onPressed being null
        disabledBackgroundColor: AppColors.kCardColor.withAlpha(150), // Example disabled color
      ),
      child: Ink(
        decoration: BoxDecoration(
          // Apply gradient only if the button is enabled (onPressed != null)
          gradient: onPressed != null ? const LinearGradient(
            colors: [
              AppColors.kButtonBluePrimary,
              AppColors.kButtonBlueSecondary,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ) : null, // No gradient if disabled
          // Use a solid color if disabled to match disabledBackgroundColor
          color: onPressed == null ? Colors.transparent : null,
          borderRadius: BorderRadius.circular(AppSizes.kDefaultBorderRadius),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: AppSizes.kDefaultPadding * 0.8,
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            // Adjust text style slightly if disabled
            style: onPressed != null
                ? AppTextStyles.kButtonText
                : AppTextStyles.kButtonText.copyWith(color: AppColors.kHintTextColor),
          ),
        ),
      ),
    );
  }
}

