import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This class manages the app's currently selected language.
/// It uses the Provider package to notify the UI when the language changes,
/// and it uses SharedPreferences to save the user's choice permanently.
class LanguageProvider extends ChangeNotifier {
  // A key to find the saved language preference on the device.
  static const String _languagePrefKey = 'selectedLanguageCode';
  String _localeCode = 'en'; // Default to English.

  /// Public getter to safely access the current language code.
  String get localeCode => _localeCode;

  /// The constructor is called when the provider is first created.
  /// It immediately tries to load the user's previously saved language.
  LanguageProvider() {
    _loadLanguage();
  }

  /// Loads the language code from the device's local storage.
  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    // Get the saved code. If it's null (first time running), default to 'en'.
    _localeCode = prefs.getString(_languagePrefKey) ?? 'en';
    notifyListeners(); // Notify widgets that the initial language has been loaded.
  }

  /// Sets the new language and saves it.
  void setLanguage(String newLocaleCode) {
    if (_localeCode == newLocaleCode) return; // No change needed.

    _localeCode = newLocaleCode;
    notifyListeners(); // Notify the UI to rebuild with the new language.
    _saveLanguage(); // Save the new choice.
  }

  /// Saves the current language code to the device's local storage.
  Future<void> _saveLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languagePrefKey, _localeCode);
  }
}
