import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// This is a stateful widget because it needs to update its own state
/// every second to show the correct time in real-time.
class DateTimeBadges extends StatefulWidget {
  const DateTimeBadges({Key? key}) : super(key: key);

  @override
  State<DateTimeBadges> createState() => _DateTimeBadgesState();
}

class _DateTimeBadgesState extends State<DateTimeBadges> {
  late Timer _timer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    // This timer will fire every second.
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Check if the widget is still on screen before updating.
      if (mounted) {
        // Update the _now variable, which will cause the UI to rebuild.
        setState(() {
          _now = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    // It's crucial to cancel the timer when the widget is removed
    // to prevent memory leaks.
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF333F54), // A dark grey color from your design
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Keep the row's width to a minimum
        children: [
          // Left badge for the date
          _buildBadge(
            DateFormat('d MMMM yyyy').format(_now),
          ), // e.g., "21 October 2025"
          // A thin vertical line to separate the badges
          Container(height: 20, width: 1, color: Colors.white24),
          // Right badge for the time
          _buildBadge(DateFormat('hh:mm a').format(_now)), // e.g., "04:03 PM"
        ],
      ),
    );
  }

  /// A helper method to build the individual styled text containers.
  Widget _buildBadge(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
