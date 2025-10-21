import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages the app's currently selected language and persists the choice.
class LanguageProvider extends ChangeNotifier {
  static const String _languagePrefKey = 'selectedLanguageCode';
  String _localeCode = 'en'; // Default to English

  String get localeCode => _localeCode;

  LanguageProvider() {
    _loadLanguage();
  }

  /// --- FIX 1: ADDED A METHOD TO LOAD SAVED LANGUAGE ---
  /// Loads the user's preferred language from the device storage.
  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    // Get the saved code, or if it's null, use the default 'en'.
    _localeCode = prefs.getString(_languagePrefKey) ?? 'en';
    notifyListeners();
  }

  /// --- FIX 2: ADDED A METHOD TO SAVE LANGUAGE PREFERENCE ---
  /// Saves the user's selected language code to the device storage.
  Future<void> _saveLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languagePrefKey, _localeCode);
  }

  /// --- FIX 3: UPDATED METHOD TO USE LANGUAGE CODES ---
  /// Sets the new language, notifies listeners, and saves the preference.
  void setLanguage(String newLocaleCode) {
    if (_localeCode == newLocaleCode) return; // No change needed

    _localeCode = newLocaleCode;
    notifyListeners();
    _saveLanguage();
  }
}
