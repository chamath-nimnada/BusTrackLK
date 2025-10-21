import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passenger_app/screens/registration_success_screen.dart';
import 'package:passenger_app/screens/profile_screen.dart';
import 'package:passenger_app/services/auth_service.dart';

// This is the Date Formatter class (Part 5)
class DateTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 10) {
      return oldValue;
    }
    var text = newValue.text;
    if (text.length == 2 && oldValue.text.length == 1) {
      text += '/';
    } else if (text.length == 5 && oldValue.text.length == 4) {
      text += '/';
    }
    return newValue.copyWith(
        text: text,
        selection: TextSelection.collapsed(offset: text.length));
  }
}

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthService _authService = AuthService();

  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _contactNoController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _birthdayController.dispose();
    _contactNoController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    // --- START OF VALIDATION LOGIC ---
    // Email Validation using a simple Regular Expression
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegExp.hasMatch(_emailController.text)) {
      setState(() {
        _errorMessage = "Please enter a valid email address.";
      });
      return; // Stop the function if validation fails
    }

    // Phone Number Validation (must be 10 digits)
    if (_contactNoController.text.length != 10) {
      setState(() {
        _errorMessage = "Phone number must be 10 digits.";
      });
      return; // Stop the function if validation fails
    }
    // --- END OF VALIDATION LOGIC ---

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _authService.register(
        userName: _userNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        birthday: _birthdayController.text,
        contactNo: _contactNoController.text,
      );

      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegistrationSuccessScreen()),
      );
      if (result == true) {
        _toggleView();
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst("Exception: ", "");
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _handleLogin() async {
    // --- START OF VALIDATION LOGIC ---
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegExp.hasMatch(_emailController.text)) {
      setState(() {
        _errorMessage = "Please enter a valid email address.";
      });
      return;
    }
    // --- END OF VALIDATION LOGIC ---

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await _authService.login(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // --- CLEAR FIELDS ON SUCCESS ---
      _emailController.clear();
      _passwordController.clear();
      // --- END OF CLEAR FIELDS ---

      bool isPremium = response['userDetails']['premium'] ?? false;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen(isPremium: isPremium)),
      );
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst("Exception: ", "");
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool _isLoginView = true;

  void _toggleView() {
    setState(() {
      _isLoginView = !_isLoginView;
      _errorMessage = null;
      _userNameController.clear();
      _emailController.clear();
      _passwordController.clear();
      _birthdayController.clear();
      _contactNoController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111827),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          children: [
            Text(
              'BusTrackLK',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'The All-in-One Bus Travel Companion',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                _buildAuthToggle(),
                SizedBox(height: 0),
                Container(
                  padding: const EdgeInsets.all(25.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF374151).withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                      topLeft: _isLoginView ? Radius.circular(20) : Radius.zero,
                      topRight: _isLoginView ? Radius.zero : Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: _isLoginView ? _buildLoginForm() : _buildRegisterForm(),
                  ),
                ),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.redAccent, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: Text(
          '© 2025 BusTrackLK App. All Rights Reserved.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white54,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildAuthToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (_isLoginView) _toggleView();
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 62),
            decoration: BoxDecoration(
              color: !_isLoginView ? Color(0xFF374151).withOpacity(0.5) : Colors.transparent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Text(
              'Register',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: !_isLoginView ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (!_isLoginView) _toggleView();
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 62),
            decoration: BoxDecoration(
              color: _isLoginView ? Color(0xFF374151).withOpacity(0.5) : Colors.transparent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: _isLoginView ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Column(
      key: ValueKey('login'),
      children: [
        _buildTextField(hint: 'Email', controller: _emailController, keyboardType: TextInputType.emailAddress),
        SizedBox(height: 15),
        _buildTextField(hint: 'Password', obscureText: true, controller: _passwordController),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: Text('Forgot Password?', style: TextStyle(color: Colors.white70, fontSize: 12)),
        ),
        SizedBox(height: 25),
        _buildAuthButton(label: 'Login', onPressed: _handleLogin),
      ],
    );
  }

  Widget _buildRegisterForm() {
    return Column(
      key: ValueKey('register'),
      children: [
        _buildTextField(hint: 'User Name', controller: _userNameController),
        SizedBox(height: 15),
        _buildTextField(
          hint: 'Birthday (dd/mm/yyyy)',
          controller: _birthdayController,
          keyboardType: TextInputType.number,
          inputFormatters: [DateTextFormatter()], // Applying the date formatter
        ),
        SizedBox(height: 15),
        _buildTextField(hint: 'Phone Number', controller: _contactNoController, keyboardType: TextInputType.phone),
        SizedBox(height: 15),
        _buildTextField(hint: 'Email', controller: _emailController, keyboardType: TextInputType.emailAddress),
        SizedBox(height: 15),
        _buildTextField(hint: 'Password', obscureText: true, controller: _passwordController),
        SizedBox(height: 25),
        _buildAuthButton(label: 'Register', onPressed: _handleRegister),
      ],
    );
  }

  Widget _buildTextField({
    required String hint,
    TextEditingController? controller,
    bool obscureText = false,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.black38),
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
    );
  }

  Widget _buildAuthButton({required String label, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF3B82F6),
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isLoading
            ? SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
        )
            : Text(
          label,
          style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
