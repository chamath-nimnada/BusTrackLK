import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_localizations.dart';
import '../utils/language_provider.dart';
import '../widgets/date_time_badges.dart';
import '../widgets/login_form.dart';
import '../widgets/register_form.dart';

/// This screen is the main entry point for an unauthenticated user.
/// It displays the tabbed interface for Login and Register.
class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // This boolean controls which tab is currently active.
  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The SafeArea ensures your UI doesn't get blocked by the phone's status bar or notch.
      body: SafeArea(
        child: Column(
          children: [
            // 1. The Header section
            _buildHeader(context),
            // 2. The main content area (the card with forms)
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  physics:
                      const BouncingScrollPhysics(), // Nice scrolling effect
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: _buildAuthCard(),
                ),
              ),
            ),
            // 3. The Footer section
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  /// Builds the top section of the screen with title, date/time, and language dropdown.
  Widget _buildHeader(BuildContext context) {
    final langProvider = context.watch<LanguageProvider>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'BusTrackLK',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'The All-in-One Bus Travel Companion',
            style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const DateTimeBadges(), // The widget we created earlier
              _buildLanguageDropdown(langProvider),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds the language selection dropdown menu.
  Widget _buildLanguageDropdown(LanguageProvider langProvider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF333F54),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: langProvider.localeCode,
          dropdownColor: const Color(0xFF333F54),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          style: const TextStyle(color: Colors.white, fontSize: 14),
          items: AppLocalizations.supportedLanguages
              .map(
                (lang) =>
                    DropdownMenuItem(value: lang.code, child: Text(lang.name)),
              )
              .toList(),
          onChanged: (String? newCode) {
            if (newCode != null) langProvider.setLanguage(newCode);
          },
        ),
      ),
    );
  }

  /// Builds the main card that holds the tabs and the login/register forms.
  Widget _buildAuthCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF4A5568), // The grey background of the card
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _buildTabs(), // The Register/Login tabs at the top of the card
          Padding(
            padding: const EdgeInsets.all(24),
            // AnimatedSwitcher provides a smooth fade transition when switching forms.
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _isLogin
                  ? const LoginForm(
                      key: ValueKey('login'),
                    ) // If _isLogin is true, show LoginForm
                  : const RegisterForm(
                      key: ValueKey('register'),
                    ), // Otherwise, show RegisterForm
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the row containing the two tab items.
  Widget _buildTabs() {
    return Row(
      children: [
        _buildTabItem(
          'Register',
          !_isLogin,
          () => setState(() => _isLogin = false),
        ),
        _buildTabItem('Login', _isLogin, () => setState(() => _isLogin = true)),
      ],
    );
  }

  /// Builds a single tab item with the custom "folder" shape.
  Widget _buildTabItem(String title, bool isActive, VoidCallback onTap) {
    final isRegister = title == 'Register';
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isActive
                ? const Color(0xFF6B7280)
                : Colors.transparent, // Active tab is darker
            // This logic creates the unique folder shape for the active tab.
            borderRadius: isActive
                ? (isRegister
                      ? const BorderRadius.only(topLeft: Radius.circular(20))
                      : const BorderRadius.only(topRight: Radius.circular(20)))
                : (isRegister
                      ? const BorderRadius.only(
                          bottomRight: Radius.circular(20),
                        )
                      : const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                        )),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the copyright footer text.
  Widget _buildFooter(BuildContext context) {
    final langCode = context.watch<LanguageProvider>().localeCode;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        AppLocalizations.get('copyright', langCode),
        style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
      ),
    );
  }
}
