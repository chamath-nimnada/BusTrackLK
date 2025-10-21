import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DateTimeBadges extends StatefulWidget {
  final Axis axis;
  final Color backgroundColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double spacing;
  // If true, attempts to sync with an internet time source and updates periodically.
  final bool useNetworkTime;
  // Optional IANA timezone (e.g., 'Asia/Colombo'). If null, uses IP-based timezone.
  final String? timeZone;
  // How often to resync from the network to keep drift minimal.
  final Duration resyncInterval;

  const DateTimeBadges({
    Key? key,
    this.axis = Axis.horizontal,
    this.backgroundColor = Colors.white10,
    this.textStyle = const TextStyle(color: Colors.white, fontSize: 12),
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    this.borderRadius = 20,
    this.spacing = 8,
    this.useNetworkTime = true,
    this.timeZone,
    this.resyncInterval = const Duration(minutes: 10),
  }) : super(key: key);

  @override
  State<DateTimeBadges> createState() => _DateTimeBadgesState();
}

class _DateTimeBadgesState extends State<DateTimeBadges> {
  late Timer _timer;
  Timer? _resyncTimer;
  late DateTime _now;
  bool _synced = false;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    // Start ticking locally (we'll replace with network time once synced).
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _now = _now.add(const Duration(seconds: 1));
      });
    });
    if (widget.useNetworkTime) {
      _syncTime();
      _resyncTimer = Timer.periodic(widget.resyncInterval, (_) => _syncTime());
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _resyncTimer?.cancel();
    super.dispose();
  }

  Future<void> _syncTime() async {
    try {
      // Prefer specific timezone if provided, else use IP-based timezone.
      final url = widget.timeZone == null
          ? Uri.parse('https://worldtimeapi.org/api/ip')
          : Uri.parse(
              'https://worldtimeapi.org/api/timezone/${widget.timeZone}',
            );
      final resp = await http.get(url).timeout(const Duration(seconds: 6));
      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body) as Map<String, dynamic>;
        // worldtimeapi returns 'datetime' in ISO 8601 (UTC offset included) and 'unixtime'.
        final iso = data['datetime'] as String?;
        final unix = data['unixtime'];
        DateTime networkNow;
        if (iso != null) {
          networkNow = DateTime.parse(iso);
        } else if (unix is int) {
          networkNow = DateTime.fromMillisecondsSinceEpoch(
            unix * 1000,
            isUtc: true,
          ).toLocal();
        } else {
          throw Exception('Invalid time payload');
        }
        setState(() {
          _now = networkNow;
          _synced = true;
        });
      } else {
        throw Exception('HTTP ${resp.statusCode}');
      }
    } catch (e) {
      // On error, fallback silently to device time, but keep ticking.
      debugPrint('DateTimeBadges: time sync failed: $e');
      setState(() {
        _synced = false;
        _now = DateTime.now();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use current locale if available
    final locale = Localizations.maybeLocaleOf(context)?.toLanguageTag();
    final dateFmt = DateFormat('dd MMMM yyyy', locale);
    final timeFmt = DateFormat('hh:mm a', locale);
    final dateStr = dateFmt.format(_now);
    final timeStr = timeFmt.format(_now);

    Container badge(String text) => Container(
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Text(text, style: widget.textStyle),
    );

    if (widget.axis == Axis.vertical) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          badge(dateStr),
          SizedBox(height: widget.spacing),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              badge(timeStr),
              if (!_synced) const SizedBox(width: 4),
              if (!_synced)
                const Icon(Icons.sync_problem, size: 12, color: Colors.white38),
            ],
          ),
        ],
      );
    }

    return Row(
      children: [
        badge(dateStr),
        SizedBox(width: widget.spacing),
        badge(timeStr),
        if (!_synced) const SizedBox(width: 4),
        if (!_synced)
          const Icon(Icons.sync_problem, size: 12, color: Colors.white38),
      ],
    );
  }
}
