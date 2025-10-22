class Validators {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your user name.';
    }
    if (value.length < 3) {
      return 'User name must be at least 3 characters long.';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number.';
    }
    final phoneRegExp = RegExp(r'^0\d{9}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number.';
    }
    return null;
  }

  static String? validateNic(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your NIC number.';
    }
    final nicRegExp = RegExp(r'^([0-9]{9}[vVxX]|[0-9]{12})$');
    if (!nicRegExp.hasMatch(value)) {
      return 'Please enter a valid NIC number.';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password.';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    return null;
  }

  static String? validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required.';
    }
    return null;
  }

  // --- THIS IS THE MISSING FUNCTION THAT IS CAUSING THE ERROR ---
  // By adding this, the errors in your other files will be fixed.
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username.';
    }
    if (value.length < 4) {
      return 'Username must be at least 4 characters long.';
    }
    final usernameRegExp = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!usernameRegExp.hasMatch(value)) {
      return 'Username can only contain letters, numbers, and underscores.';
    }
    return null;
  }
}
