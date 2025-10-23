import 'package:driver_ui/screens/registration_success_screen.dart';
import 'package:driver_ui/utils/app_colors.dart';
import 'package:driver_ui/utils/app_localizations.dart'; // <-- 1. IMPORT
import 'package:driver_ui/utils/app_sizes.dart';
import 'package:driver_ui/utils/app_text_styles.dart';
import 'package:driver_ui/widgets/custom_button.dart';
import 'package:driver_ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  // One controller for each text field
  late final TextEditingController _userNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _nicController;
  late final TextEditingController _passwordController;
  late final TextEditingController _busNoController;
  late final TextEditingController _routeNoController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _phoneController = TextEditingController();
    _nicController = TextEditingController();
    _passwordController = TextEditingController();
    _busNoController = TextEditingController();
    _routeNoController = TextEditingController();
  }

  @override
  void dispose() {
    // Clean up all controllers
    _userNameController.dispose();
    _phoneController.dispose();
    _nicController.dispose();
    _passwordController.dispose();
    _busNoController.dispose();
    _routeNoController.dispose();
    super.dispose();
  }

  void _registerUser() {
    // This is where you will call your auth_service.dart
    if (_formKey.currentState!.validate()) {
      print("Register Form is Valid");
      // TODO: Call backend logic here
      // ...

      // After backend logic is successful, navigate to success screen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const RegistrationSuccessScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // 2. Get the translations object
    final translations = AppLocalizations.of(context);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          // --- User Name Field ---
          CustomTextField(
            controller: _userNameController,
            hintText: translations.username, // <-- 3. USE TRANSLATION
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a user name'; // TODO: Translate
              }
              return null;
            },
          ),
          const SizedBox(height: AppSizes.kDefaultPadding), // 20.0 space

          // --- Phone No Field ---
          CustomTextField(
            controller: _phoneController,
            hintText: translations.phoneNo, // <-- 3. USE TRANSLATION
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a phone number'; // TODO: Translate
              }
              return null;
            },
          ),
          const SizedBox(height: AppSizes.kDefaultPadding), // 20.0 space

          // --- NIC Field ---
          CustomTextField(
            controller: _nicController,
            hintText: translations.nic, // <-- 3. USE TRANSLATION
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an NIC'; // TODO: Translate
              }
              return null;
            },
          ),
          const SizedBox(height: AppSizes.kDefaultPadding), // 20.0 space

          // --- Password Field ---
          CustomTextField(
            controller: _passwordController,
            hintText: translations.password, // <-- 3. USE TRANSLATION
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password'; // TODO: Translate
              }
              return null;
            },
          ),

          // --- Divider ---
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppSizes.kDefaultPadding * 1.25), // 25.0 space
            child: Divider(
              color: AppColors.kHintTextColor.withOpacity(0.5),
              thickness: 1,
            ),
          ),

          // --- Bus No Field ---
          CustomTextField(
            controller: _busNoController,
            hintText: translations.busNo, // <-- 3. USE TRANSLATION
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a bus number'; // TODO: Translate
              }
              return null;
            },
          ),
          const SizedBox(height: AppSizes.kDefaultPadding), // 20.0 space

          // --- Route No Field ---
          CustomTextField(
            controller: _routeNoController,
            hintText: translations.routeNo, // <-- 3. USE TRANSLATION
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a route number'; // TODO: Translate
              }
              return null;
            },
          ),
          const SizedBox(height: AppSizes.kDefaultPadding * 1.5), // 30.0 space

          // --- Register Button ---
          CustomButton(
            text: translations.register, // <-- 3. USE TRANSLATION
            onPressed: _registerUser,
          ),
        ],
      ),
    );
  }
}

