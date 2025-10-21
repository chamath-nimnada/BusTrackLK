import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../utils/language_provider.dart';
import '../utils/constants.dart';
import '../utils/app_localizations.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // FIX: Use the corrected LanguageProvider property 'localeCode'
    final langCode = context.watch<LanguageProvider>().localeCode;

    final now = DateTime.now();
    final dateStr = DateFormat(AppConstants.dateFormat).format(now);
    final timeStr = DateFormat(AppConstants.timeFormat).format(now);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'BusTrackLK',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                dateStr,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              Text(
                timeStr,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
