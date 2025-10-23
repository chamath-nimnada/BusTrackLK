import 'package:driver_ui/utils/app_colors.dart';
import 'package:driver_ui/utils/app_sizes.dart';
import 'package:driver_ui/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextEditingController? controller; // For getting text
  final String? Function(String?)? validator; // For form validation

  const CustomTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    // We use TextFormField to get validation features
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: isPassword,
      // This is the style for the text the user types
      style: AppTextStyles.kTextFieldInputStyle, // <-- THE FIX IS HERE
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.kHintText,
        filled: true,
        fillColor: AppColors.kTextFieldColor,
        contentPadding: const EdgeInsets.symmetric(
          vertical: AppSizes.kDefaultPadding * 0.9, // 18
          horizontal: AppSizes.kDefaultPadding, // 20
        ),

        // --- Border Styles ---
        // We use BorderSide.none to get the clean, borderless look
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.kDefaultBorderRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.kDefaultBorderRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.kDefaultBorderRadius),
          borderSide: BorderSide.none,
        ),
        // --- Error Border Style ---
        // This is important for your validation
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.kDefaultBorderRadius),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.kDefaultBorderRadius),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
      ),
    );
  }
}

