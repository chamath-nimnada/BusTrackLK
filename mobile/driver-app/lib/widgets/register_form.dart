import 'package:driver_ui/screens/registration_success_screen.dart';
import 'package:driver_ui/services/auth_service.dart';
import 'package:driver_ui/utils/app_colors.dart';
import 'package:driver_ui/utils/app_localizations.dart';
import 'package:driver_ui/utils/app_sizes.dart';
import 'package:driver_ui/widgets/custom_button.dart';
import 'package:driver_ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ** REMOVED LoadingOverlay import **

class RegisterForm extends StatefulWidget {
  // ** ADDED: Callback function to notify parent of loading state changes **
  final Function(bool) onLoadingChanged;

  const RegisterForm({
    super.key,
    required this.onLoadingChanged, // ** Make sure this is required **
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  // Controllers & Key
  late final TextEditingController _userNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _nicController;
  late final TextEditingController _passwordController;
  late final TextEditingController _busNoController;
  late final TextEditingController _routeNoController;
  final _formKey = GlobalKey<FormState>();
  // ** REMOVED _isLoading state variable from here **


  @override
  void initState() {
    super.initState();
    // ... initialize all controllers ...
    _userNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _nicController = TextEditingController();
    _passwordController = TextEditingController();
    _busNoController = TextEditingController();
    _routeNoController = TextEditingController();
  }

  @override
  void dispose() {
    // ... dispose all controllers ...
    _userNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nicController.dispose();
    _passwordController.dispose();
    _busNoController.dispose();
    _routeNoController.dispose();
    super.dispose();
  }

  // Async function to handle registration logic
  Future<void> _registerUser() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      print("Register Form validation failed.");
      return;
    }
    print("Register Form validation passed.");

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
      print("Calling authService.registerDriver...");
      await authService.registerDriver(
        email: _emailController.text,
        password: _passwordController.text,
        phoneNo: _phoneController.text,
        nic: _nicController.text,
        busNo: _busNoController.text,
        routeNo: _routeNoController.text,
      );
      print("authService.registerDriver completed successfully.");

      if (mounted) {
        print("Navigating to RegistrationSuccessScreen...");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const RegistrationSuccessScreen()),
        );
      }
    } catch (e) {
      print("Error during registration: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration Failed: ${e.toString().replaceFirst("Exception: ", "")}'), backgroundColor: Colors.redAccent)
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
    try { translations = AppLocalizations.of(context); emailHintText = translations.email;}
    catch (e) { translations = AppLocalizations('English'); emailHintText = translations.email;}

    // ** REMOVED LoadingOverlay Wrapper from here **
    return Form(
      key: _formKey,
      child: Column( // Direct child is Column
        children: [
          // --- User Name Field ---
          CustomTextField(controller: _userNameController, hintText: translations.username, keyboardType: TextInputType.name, validator: (v){if(v==null||v.isEmpty)return translations.validationEnterUsername; return null;}),
          const SizedBox(height: AppSizes.kDefaultPadding),
          // --- Email Field ---
          CustomTextField(controller: _emailController, hintText: emailHintText, keyboardType: TextInputType.emailAddress, validator: (v){if(v==null||v.isEmpty)return translations.validationEnterEmail; if(!v.contains('@')||!v.contains('.')) return translations.validationValidEmail; return null;}),
          const SizedBox(height: AppSizes.kDefaultPadding),
          // --- Phone No Field ---
          CustomTextField(controller: _phoneController, hintText: translations.phoneNo, keyboardType: TextInputType.phone, validator: (v){if(v==null||v.isEmpty) return translations.validationEnterPhone; return null;}),
          const SizedBox(height: AppSizes.kDefaultPadding),
          // --- NIC Field ---
          CustomTextField(controller: _nicController, hintText: translations.nic, keyboardType: TextInputType.text, validator: (v){if(v==null||v.isEmpty) return translations.validationEnterNIC; return null;}),
          const SizedBox(height: AppSizes.kDefaultPadding),
          // --- Password Field ---
          CustomTextField(controller: _passwordController, hintText: translations.password, isPassword: true, validator: (v){if(v==null||v.isEmpty) return translations.validationEnterPassword; if(v.length<6)return translations.validationPasswordLength; return null;}),
          // --- Divider ---
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSizes.kDefaultPadding * 1.25),
            child: Divider(color: AppColors.kHintTextColor.withAlpha(128), thickness: 1),
          ),
          // --- Bus No Field ---
          CustomTextField(controller: _busNoController, hintText: translations.busNo, keyboardType: TextInputType.text, validator: (v){if(v==null||v.isEmpty) return translations.validationEnterBusNo; return null;}),
          const SizedBox(height: AppSizes.kDefaultPadding),
          // --- Route No Field ---
          CustomTextField(controller: _routeNoController, hintText: translations.routeNo, keyboardType: TextInputType.text, validator: (v){if(v==null||v.isEmpty) return translations.validationEnterRouteNo; return null;}),
          const SizedBox(height: AppSizes.kDefaultPadding * 1.5),

          // --- Register Button ---
          // ** Directly call _registerUser via wrapper, no _isLoading check needed here **
          // The button is automatically disabled by AuthScreen's Stack overlay if _isLoading is true there
          CustomButton(
            text: translations.register,
            onPressed: () { _registerUser(); },
          ),
        ],
      ),
    );
  }
}

