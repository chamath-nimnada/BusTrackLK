import 'package:flutter/material.dart';

// This class will manage the app's current language
class LanguageProvider with ChangeNotifier {
  // Default language is English
  String _currentLanguage = "English";

  String get currentLanguage => _currentLanguage;

  void setLanguage(String language) {
    _currentLanguage = language;
    // This notifies all widgets listening to this provider to rebuild
    notifyListeners();
  }
}

