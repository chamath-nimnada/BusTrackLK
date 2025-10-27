import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:passenger_app/widgets/schedule_result_widget.dart';
// 1. Add new imports
import 'package:passenger_app/models/schedule_result.dart';
import 'package:passenger_app/services/schedule_service.dart';

class BusScheduleScreen extends StatefulWidget {
  @override
  _BusScheduleScreenState createState() => _BusScheduleScreenState();
}

class _BusScheduleScreenState extends State<BusScheduleScreen> {
  // 2. State variables are updated
  final ScheduleService _scheduleService = ScheduleService();
  bool _isSearched = false;
  bool _isSearching = false; // To show loading spinner
  bool _isLoadingLocations = true; // To load dropdowns

  List<ScheduleResult> _scheduleResults = []; // Use our new model
  DateTime _selectedDate = DateTime.now();

  List<String> _locations = []; // This will be loaded from the backend
  String? _startLocation;
  String? _endLocation;

  // 3. initState is updated
  @override
  void initState() {
    super.initState();
    _loadLocations(); // Call the new function
  }

  // 4. New function to load locations from backend
  Future<void> _loadLocations() async {
    try {
      final locations = await _scheduleService.getLocations();
      if (mounted) {
        setState(() {
          _locations = locations;
          _isLoadingLocations = false;
        });
      }
    } catch (e) {
      print(e); // Handle error
      if (mounted) {
        setState(() {
          _isLoadingLocations = false;
        });
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  // 5. performSearch is updated to call the backend
  Future<void> _performSearch() async {
    if (_startLocation == null || _endLocation == null) {
      // You can add an error message here if you want
      return;
    }

    setState(() {
      _isSearching = true;
      _isSearched = true;
      _scheduleResults = [];
    });

    try {
      final results = await _scheduleService.searchSchedules(
        startLocation: _startLocation!,
        endLocation: _endLocation!,
        date: DateFormat('yyyy.MM.dd').format(_selectedDate),
      );
      if (mounted) {
        setState(() {
          _scheduleResults = results;
        });
      }
    } catch (e) {
      print(e);
      // Handle search error
    } finally {
      if (mounted) {
        setState(() {
          _isSearching = false;
        });
      }
    }
  }

  // 6. clearSearch is updated
  void _clearSearch() {
    setState(() {
      _isSearched = false;
      _isSearching = false; // Make sure to reset this
      _scheduleResults = [];
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
              _buildResultsArea(), // This widget is now fully dynamic
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
          _buildLocationDropdown(isStart: true), // This widget is now dynamic
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Icon(Icons.swap_vert, color: Colors.white70),
          ),
          _buildLocationDropdown(isStart: false), // This widget is now dynamic
          Divider(color: Colors.white24, height: 30),
          Row(
            children: [
              InkWell(
                onTap: () => _selectDate(context),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white30)),
                  child: Text(DateFormat('yyyy.MM.dd').format(_selectedDate), style: TextStyle(color: Colors.white)),
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

  // 7. buildLocationDropdown is updated
  Widget _buildLocationDropdown({required bool isStart}) {
    return DropdownButtonFormField<String>(
      value: isStart ? _startLocation : _endLocation,
      onChanged: (value) {
        setState(() {
          if (isStart)
            _startLocation = value;
          else
            _endLocation = value;
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
      // Items are now built dynamically
      items: _isLoadingLocations
          ? [
        DropdownMenuItem(
          child: Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator())),
        )
      ]
          : _locations.map((location) {
        return DropdownMenuItem(value: location, child: Text(location));
      }).toList(),
    );
  }

  // 8. buildResultsArea is updated
  Widget _buildResultsArea() {
    if (!_isSearched) {
      return Container(height: 300, alignment: Alignment.center, child: Text('Select locations and search', style: TextStyle(color: Colors.white54, fontSize: 16)));
    }
    // Show loading spinner while searching
    if (_isSearching) {
      return Container(height: 300, alignment: Alignment.center, child: CircularProgressIndicator());
    }

    if (_scheduleResults.isEmpty) {
      return Container(height: 300, alignment: Alignment.center, child: Text('No Available Buses', style: TextStyle(color: Colors.white54, fontSize: 16)));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Available Buses', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 15),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _scheduleResults.length,
          itemBuilder: (context, index) {
            final bus = _scheduleResults[index];
            // Use the data from our new ScheduleResult object
            return ScheduleResultWidget(
              route: bus.route,
              startLocation: bus.startLocation,
              startTime: bus.startTime,
              endLocation: bus.endLocation,
              endTime: bus.endTime,
            );
          },
        ),
      ],
    );
  }
}
