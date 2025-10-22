import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/registration_success_screen.dart';
import '../utils/auth_provider.dart';
import '../utils/validators.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nicController = TextEditingController();
  final _passwordController = TextEditingController();
  final _busNoController = TextEditingController();
  final _routeNoController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _nicController.dispose();
    _passwordController.dispose();
    _busNoController.dispose();
    _routeNoController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;
    final auth = context.read<AuthProvider>();
    final success = await auth.register({
      'fullName': _nameController.text.trim(),
      'username': _usernameController.text.trim(),
      'phone': _phoneController.text.trim(),
      'nic': _nicController.text.trim(),
      'password': _passwordController.text,
      'busNo': _busNoController.text.trim(),
      'routeNo': _routeNoController.text.trim(),
    });
    if (!mounted) return;
    if (success) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const RegistrationSuccessScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(auth.error ?? 'Registration failed.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: _buildInputDecoration(
              hintText: 'User Name (Full Name)',
            ),
            validator: Validators.validateName,
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _usernameController,
            decoration: _buildInputDecoration(hintText: 'Username (for login)'),
            validator: Validators.validateUsername,
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _phoneController,
            decoration: _buildInputDecoration(hintText: 'Phone No'),
            validator: Validators.validatePhone,
            keyboardType: TextInputType.phone,
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _nicController,
            decoration: _buildInputDecoration(hintText: 'NIC'),
            validator: Validators.validateNic,
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: _buildInputDecoration(hintText: 'Password'),
            validator: Validators.validatePassword,
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 16),
          Divider(color: Colors.grey.shade400),
          const SizedBox(height: 16),
          TextFormField(
            controller: _busNoController,
            decoration: _buildInputDecoration(hintText: 'Bus No'),
            validator: Validators.validateRequired,
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _routeNoController,
            decoration: _buildInputDecoration(hintText: 'Route No'),
            validator: Validators.validateRequired,
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 24),
          Consumer<AuthProvider>(
            builder: (_, auth, __) => ElevatedButton(
              onPressed: auth.isLoading ? null : _handleRegister,
              style: _buildButtonStyle(),
              child: auth.isLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Register'),
            ),
          ),
        ],
      ),
    );
  }
}

InputDecoration _buildInputDecoration({required String hintText}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: Colors.grey.shade600),
    filled: true,
    fillColor: const Color(0xFFE2E8F0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
  );
}

ButtonStyle _buildButtonStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF4263EB),
    padding: const EdgeInsets.symmetric(vertical: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
}
