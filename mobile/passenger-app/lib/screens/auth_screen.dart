import 'package:flutter/material.dart';
import 'package:passenger_app/screens/registration_success_screen.dart';
import 'package:passenger_app/screens/profile_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // true for Login view, false for Register view
  bool _isLoginView = true;

  void _toggleView() {
    setState(() {
      _isLoginView = !_isLoginView;
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
            Navigator.pop(context); // Navigates back to the home screen
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
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: _isLoginView ? _buildLoginForm() : _buildRegisterForm(),
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

  // Widget for the Register/Login toggle buttons
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

  // Widget for the Login Form
  Widget _buildLoginForm() {
    return Column(
      key: ValueKey('login'),
      children: [
        _buildTextField(hint: 'Email'),
        SizedBox(height: 15),
        _buildTextField(hint: 'Password', obscureText: true),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: Text('Forgot Password?', style: TextStyle(color: Colors.white70, fontSize: 12)),
        ),
        SizedBox(height: 25),
        _buildAuthButton(label: 'Login', onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen(isPremium: false)),
          );
        }),
      ],
    );
  }

  // Widget for the Register Form
  Widget _buildRegisterForm() {
    return Column(
      key: ValueKey('register'),
      children: [
        _buildTextField(hint: 'User Name'),
        SizedBox(height: 15),
        _buildTextField(hint: 'Birthday (dd/mm/yyyy)'),
        SizedBox(height: 15),
        _buildTextField(hint: 'Phone Number'),
        SizedBox(height: 15),
        _buildTextField(hint: 'Email'),
        SizedBox(height: 15),
        _buildTextField(hint: 'Password', obscureText: true),
        SizedBox(height: 25),
        _buildAuthButton(label: 'Register', onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegistrationSuccessScreen()),
          );
        }),
      ],
    );
  }

  // Reusable TextField widget
  Widget _buildTextField({required String hint, bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
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

  // Reusable blue button
  Widget _buildAuthButton({required String label, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF3B82F6),
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}