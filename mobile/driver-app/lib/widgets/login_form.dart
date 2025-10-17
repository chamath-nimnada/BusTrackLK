import 'package:flutter/material.dart';
import '../utils/validators.dart';
import 'custom_text_field.dart';
import 'custom_button.dart';

class LoginForm extends StatefulWidget {
  final void Function(String phone, String password)? onLogin;
  final bool isLoading;

  const LoginForm({Key? key, this.onLogin, this.isLoading = false})
    : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onLogin?.call(_phoneController.text, _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: _phoneController,
            hintText: 'Phone Number',
            keyboardType: TextInputType.phone,
            validator: Validators.validatePhone,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _passwordController,
            hintText: 'Password',
            obscureText: true,
            validator: Validators.validatePassword,
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Login',
            onPressed: _submit,
            isLoading: widget.isLoading,
          ),
        ],
      ),
    );
  }
}
