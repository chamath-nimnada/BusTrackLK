import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Make sure you have the 'intl' package
import 'package:passenger_app/widgets/bus_booking_result_widget.dart';

class BusBookingScreen extends StatefulWidget {
  @override
  _BusBookingScreenState createState() => _BusBookingScreenState();
}

class _BusBookingScreenState extends State<BusBookingScreen> {
  bool _isSearched = false;
  List<Map<String, dynamic>> _busResults = [];

  // --- CHANGE 1: Added state for the selected date ---
  DateTime _selectedDate = DateTime.now();

  final List<String> _locations = ['Colombo', 'Kandy', 'Galle', 'Jaffna', 'Matara'];
  String? _startLocation;
  String? _endLocation;

  // --- CHANGE 2: Added function to show the date picker ---
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _performSearch() {
    setState(() {
      _isSearched = true;
      _busResults = [
        {'route': 'Route 01', 'start': 'Colombo Fort', 'end': 'Kandy', 'seats': 21},
        {'route': 'Route 01-Express', 'start': 'Colombo', 'end': 'Kandy', 'seats': 5},
      ];
    });
  }

  void _clearSearch() {
    setState(() {
      _isSearched = false;
      _busResults = [];
      _startLocation = null;
      _endLocation = null;
      _selectedDate = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111827),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          children: [
            Text('BusTrackLK', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            Text('The All-in-One Bus Travel Companion', style: TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchCard(),
              SizedBox(height: 30),
              // --- CHANGE 4: The results area now handles all states ---
              _buildResultsArea(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF374151).withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          _buildLocationDropdown(isStart: true),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Icon(Icons.swap_vert, color: Colors.white70),
          ),
          _buildLocationDropdown(isStart: false),
          Divider(color: Colors.white24, height: 30),
          Row(
            children: [
              // --- CHANGE 3: The hardcoded date is now a button ---
              InkWell(
                onTap: () => _selectDate(context),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white30),
                  ),
                  child: Text(
                    DateFormat('yyyy.MM.dd').format(_selectedDate),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: _isSearched ? _clearSearch : _performSearch,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isSearched ? Color(0xFFEF4444) : Color(0xFF8B5CF6),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(_isSearched ? 'Clear' : 'Search', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationDropdown({required bool isStart}) {
    // ... (This function remains unchanged)
    return DropdownButtonFormField<String>(
      value: isStart ? _startLocation : _endLocation,
      onChanged: (value) {
        setState(() {
          if (isStart) _startLocation = value;
          else _endLocation = value;
        });
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      ),
      hint: Text(isStart ? 'Start Location' : 'End Location', style: TextStyle(color: Colors.black54)),
      dropdownColor: Colors.white,
      style: TextStyle(color: Colors.black87),
      items: _locations.map((location) {
        return DropdownMenuItem(value: location, child: Text(location));
      }).toList(),
    );
  }

  // --- CHANGE 4: This new widget handles all 3 states for the results area ---
  Widget _buildResultsArea() {
    // State 1: Before searching
    if (!_isSearched) {
      return Container(
        height: 300,
        alignment: Alignment.center,
        child: Text(
          'Select locations and search',
          style: TextStyle(color: Colors.white54, fontSize: 16),
        ),
      );
    }

    // State 2: After searching, but no results found
    if (_busResults.isEmpty) {
      return Container(
        height: 200,
        alignment: Alignment.center,
        child: Text('No Available Bookings', style: TextStyle(color: Colors.white54, fontSize: 16)),
      );
    }

    // State 3: After searching, and results are found
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Available Buses', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 15),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _busResults.length,
          itemBuilder: (context, index) {
            final bus = _busResults[index];
            return BusResultWidget(
              route: bus['route']!,
              startLocation: bus['start']!,
              endLocation: bus['end']!,
              availableSeats: bus['seats']!,
            );
          },
        ),
      ],
    );
  }
}