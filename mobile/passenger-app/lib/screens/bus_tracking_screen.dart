// lib/screens/bus_tracking_screen.dart

import 'package:flutter/material.dart';
import 'package:passenger_app/models/live_bus_result.dart';
import 'package:passenger_app/services/tracking_service.dart';
import 'package:passenger_app/widgets/bus_tracking_result_widget.dart';

class BusTrackingScreen extends StatefulWidget {
  const BusTrackingScreen({Key? key}) : super(key: key);

  @override
  _BusTrackingScreenState createState() => _BusTrackingScreenState();
}

class _BusTrackingScreenState extends State<BusTrackingScreen> {
  final _routeController = TextEditingController();
  final _trackingService = TrackingService();

  Future<List<LiveBusResult>>? _resultsFuture;

  void _searchBuses() {
    if (_routeController.text.isNotEmpty) {
      setState(() {
        _resultsFuture = _trackingService.searchLiveBuses(
          startLocation: _routeController.text, // Using startLocation as route
          endLocation: '', // Not used in new logic
          date: '', // Not used in new logic
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111827),
      appBar: AppBar(
        title: const Text('Track Live Bus'),
        backgroundColor: const Color(0xFF1F2937),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchCard(),
            const SizedBox(height: 20),
            _buildResultsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          TextField(
            controller: _routeController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Enter Route No (e.g., 100)',
              hintStyle: TextStyle(color: Colors.grey[400]),
              filled: true,
              fillColor: const Color(0xFF374151),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _searchBuses,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B5CF6),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Search', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList() {
    return Expanded(
      child: FutureBuilder<List<LiveBusResult>>(
        future: _resultsFuture,
        builder: (context, snapshot) {
          if (_resultsFuture == null) {
            return const Center(
              child: Text('Enter a route to find live buses.',
                  style: TextStyle(color: Colors.white70)),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red)),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No live buses found for this route.',
                  style: TextStyle(color: Colors.white70)),
            );
          }

          final buses = snapshot.data!;
          return ListView.builder(
            itemCount: buses.length,
            itemBuilder: (context, index) {
              return BusTrackingResultWidget(bus: buses[index]);
            },
          );
        },
      ),
    );
  }
}