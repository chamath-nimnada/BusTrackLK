import 'package:driver_ui/models/driver_info.dart';
import 'package:driver_ui/screens/home_screen.dart';
import 'package:driver_ui/utils/app_localizations.dart';
import 'package:driver_ui/utils/app_sizes.dart';
import 'package:driver_ui/utils/app_text_styles.dart';
import 'package:driver_ui/widgets/custom_button.dart';
import 'package:driver_ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // Controllers to get the text from the fields
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // Clean up controllers when the widget is removed
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _loginUser() {
    // This is where you will call your auth_service.dart
    // For now, we'll just check if the form is valid
    if (_formKey.currentState!.validate()) {
      print("Login Form is Valid");
      print("Username: ${_usernameController.text}");
      print("Password: ${_passwordController.text}");

      // TODO: Call backend logic here
      // For testing, we create a dummy user to pass to the HomeScreen
      final dummyUser = DriverInfo(
        driverName: "Oshan Mendis", // Your test name
        busNumber: "NC-1234", // Your test bus number
        phoneNumber: "+94 77 123 4567", // Your test phone
        creditScore: 4.8, // <-- THIS IS THE NEW LINE WE ADDED
      );

      // Navigate to HomeScreen and pass the dummy user
      // We use pushReplacement so the user can't press "back" to the login screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(driverInfo: dummyUser),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the translations object
    // This will "watch" the provider and rebuild this widget when the
    // language changes.
    final translations = AppLocalizations.of(context);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          // --- Username Field ---
          CustomTextField(
            controller: _usernameController,
            hintText: translations.username,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                // TODO: This string should also be in AppLocalizations
                return 'Please enter a username';
              }
              return null;
            },
          ),

          const SizedBox(height: AppSizes.kDefaultPadding), // 20.0 space

          // --- Password Field ---
          CustomTextField(
            controller: _passwordController,
            hintText: translations.password,
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                // TODO: This string should also be in AppLocalizations
                return 'Please enter a password';
              }
              return null;
            },
          ),

          const SizedBox(height: AppSizes.kDefaultPadding * 0.5), // 10.0 space

          // --- Forgot Password Text ---
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              translations.forgotPassword,
              style: AppTextStyles.kForgotPassword,
            ),
          ),

          const SizedBox(height: AppSizes.kDefaultPadding * 1.5), // 30.0 space

          // --- Login Button ---
          CustomButton(
            text: translations.login,
            onPressed: _loginUser,
          ),
        ],
      ),
    );
  }
}

