import 'package:driver_ui/models/driver_info.dart';
import 'package:driver_ui/screens/home_screen.dart';
import 'package:driver_ui/services/auth_service.dart';
import 'package:driver_ui/utils/app_colors.dart';
import 'package:driver_ui/utils/app_localizations.dart';
import 'package:driver_ui/utils/app_sizes.dart';
import 'package:driver_ui/utils/app_text_styles.dart'; // Keep for ForgotPassword if needed
import 'package:driver_ui/widgets/custom_button.dart';
import 'package:driver_ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ** REMOVED LoadingOverlay import **

class LoginForm extends StatefulWidget {
  // ** ADDED: Callback function to notify parent of loading state changes **
  final Function(bool) onLoadingChanged;

  const LoginForm({
    super.key,
    required this.onLoadingChanged, // ** Make sure this is required **
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // Controllers & Key
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  // ** REMOVED _isLoading state variable from here **

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Async function to handle login logic
  Future<void> _loginUser() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    // ** Notify AuthScreen to start loading **
    widget.onLoadingChanged(true);

    AuthService? authService;
    try { authService = Provider.of<AuthService>(context, listen: false); }
    catch (e) {
      print("Error getting AuthService: $e. Make sure it's provided.");
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error: Could not access authentication service.'), backgroundColor: Colors.redAccent),
        );
      }
      if(mounted) widget.onLoadingChanged(false); // Stop loading
      return;
    }

    try {
      print("Calling authService.loginDriver...");
      DriverInfo driverInfo = await authService.loginDriver(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print("authService.loginDriver completed successfully.");

      if (mounted) {
        print("Navigating to HomeScreen...");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen(driverInfo: driverInfo)),
        );
      }
    } catch (e) {
      print("Error during login: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login Failed: ${e.toString().replaceFirst("Exception: ", "")}'), backgroundColor: Colors.redAccent)
        );
      }
    } finally {
      // ** Notify AuthScreen to stop loading **
      if (mounted) widget.onLoadingChanged(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations translations;
    String emailHintText;
    try { translations = AppLocalizations.of(context); emailHintText = translations.email; }
    catch (e) { translations = AppLocalizations('English'); emailHintText = translations.email; }

    // ** REMOVED LoadingOverlay Wrapper from here **
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // --- Email Field ---
          CustomTextField(
            controller: _emailController,
            hintText: emailHintText,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) return translations.validationEnterEmail;
              if (!value.contains('@') || !value.contains('.')) return translations.validationValidEmail;
              return null;
            },
          ),
          const SizedBox(height: AppSizes.kDefaultPadding),
          // --- Password Field ---
          CustomTextField(
            controller: _passwordController,
            hintText: translations.password,
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty) return translations.validationEnterPassword;
              // if (value.length < 6) return translations.validationPasswordLength;
              return null;
            },
          ),
          const SizedBox(height: AppSizes.kDefaultPadding * 0.5),
          // --- Forgot Password Text ---
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              translations.forgotPassword,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.kSecondaryTextColor),
            ),
          ),
          const SizedBox(height: AppSizes.kDefaultPadding * 1.5),
          // --- Login Button ---
          CustomButton(
            text: translations.login,
            // ** Directly call _loginUser via wrapper, no _isLoading check needed here **
            // The button is automatically disabled by AuthScreen's Stack overlay
            onPressed: () { _loginUser(); },
          ),
        ],
      ),
    );
  }
}

