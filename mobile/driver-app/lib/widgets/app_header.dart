import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/language_provider.dart';

class AppHeader extends StatelessWidget {
  final DateTime? dateTime;
  final String? language;
  final ValueChanged<String?>? onLanguageChanged;

  const AppHeader({
    Key? key,
    this.dateTime,
    this.language,
    this.onLanguageChanged,
  }) : super(key: key);

  String _normalizeLanguage(String? value) {
    switch (value) {
      case 'සිංහල':
        return 'Sinhala';
      case 'தமிழ்':
        return 'Tamil';
      default:
        return value ?? 'English';
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLang = language != null
        ? _normalizeLanguage(language)
        : languageProvider.language;
    final now = dateTime ?? DateTime.now();
    final dateStr = DateFormat(AppConstants.dateFormat).format(now);
    final timeStr = DateFormat(AppConstants.timeFormat).format(now);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                AppConstants.appName,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'The All-in-One Bus Travel Companion',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 10),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  dateStr,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  timeStr,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: currentLang,
                  dropdownColor: AppColors.card,
                  style: const TextStyle(color: AppColors.textPrimary),
                  items: const [
                    DropdownMenuItem(value: 'English', child: Text('English')),
                    DropdownMenuItem(value: 'Sinhala', child: Text('සිංහල')),
                    DropdownMenuItem(value: 'Tamil', child: Text('தமிழ்')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      languageProvider.setLanguage(value);
                      onLanguageChanged?.call(value);
                    }
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
