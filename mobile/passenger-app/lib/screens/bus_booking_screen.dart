// lib/screens/bus_booking_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// Import the WIDGET used to display results
import 'package:passenger_app/widgets/bus_booking_result_widget.dart';
// Import the new SERVICE and MODEL
import 'package:passenger_app/services/booking_service.dart';
import 'package:passenger_app/models/booking_result.dart';

class BusBookingScreen extends StatefulWidget {
  @override
  _BusBookingScreenState createState() => _BusBookingScreenState();
}

class _BusBookingScreenState extends State<BusBookingScreen> {
  // Use the new BookingService
  final BookingService _bookingService = BookingService();

  // State variables
  bool _isSearched = false;
  bool _isSearching = false; // Loading state for search process
  bool _isLoadingLocations = true; // Loading state for dropdowns

  // Use the new BookingResult model for results
  List<BookingResult> _busResults = [];
  DateTime _selectedDate = DateTime.now();

  List<String> _locations = []; // To be loaded from backend
  String? _startLocation;
  String? _endLocation;
  String? _searchErrorMessage; // To display search errors

  @override
  void initState() {
    super.initState();
    _loadLocations(); // Load locations when the screen starts
  }

  // Fetch locations for dropdowns
  Future<void> _loadLocations() async {
    if (!mounted) return;
    setState(() { _isLoadingLocations = true; _searchErrorMessage = null; });
    try {
      final locations = await _bookingService.getLocations();
      if (mounted) {
        setState(() {
          _locations = locations;
          _isLoadingLocations = false;
        });
      }
    } catch (e) {
      print("Error loading locations: $e");
      if (mounted) {
        setState(() {
          _isLoadingLocations = false;
          _searchErrorMessage = "Could not load locations."; // Show error
        });
      }
    }
  }

  // Show date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(), // Can only book from today onwards
      lastDate: DateTime.now().add(Duration(days: 30)), // Allow booking up to 30 days ahead
    );
    if (picked != null && picked != _selectedDate && mounted) {
      setState(() { _selectedDate = picked; });
    }
  }

  // Perform search for bookable buses
  Future<void> _performSearch() async {
    // Basic validation
    if (_startLocation == null || _endLocation == null) {
      setState(() => _searchErrorMessage = 'Please select start and end locations.');
      return;
    }
    if (_startLocation == _endLocation) {
      setState(() => _searchErrorMessage = 'Start and end locations cannot be the same.');
      return;
    }

    if (!mounted) return;
    setState(() {
      _isSearching = true; // Show loading
      _isSearched = true; // Mark that a search has been attempted
      _busResults = []; // Clear previous results
      _searchErrorMessage = null; // Clear previous errors
    });

    try {
      // Call the booking service search method
      final results = await _bookingService.searchBookableTrips(
        startLocation: _startLocation!,
        endLocation: _endLocation!,
        date: DateFormat('yyyy.MM.dd').format(_selectedDate), // Send date in correct format
      );
      if (mounted) {
        setState(() { _busResults = results; });
      }
    } catch (e) {
      print("Error performing booking search: $e");
      if (mounted) {
        // Display the error from the service
        setState(() => _searchErrorMessage = e.toString().replaceFirst("Exception: ", ""));
      }
    } finally {
      if (mounted) {
        // Hide loading indicator
        setState(() { _isSearching = false; });
      }
    }
  }

  // Clear search results and reset form
  void _clearSearch() {
    if (!mounted) return;
    setState(() {
      _isSearched = false;
      _isSearching = false;
      _busResults = [];
      _startLocation = null;
      _endLocation = null;
      _selectedDate = DateTime.now();
      _searchErrorMessage = null;
    });
  }

  // --- Build Method ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111827),
      appBar: AppBar(
        backgroundColor: Colors.transparent, elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.of(context).pop()),
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
              _buildSearchCard(), // Contains dropdowns, date, search button
              SizedBox(height: 30),
              _buildResultsArea(), // Displays results or messages
            ],
          ),
        ),
      ),
    );
  }

  // --- Search Card Widget ---
  Widget _buildSearchCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Color(0xFF374151).withOpacity(0.5), borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          _buildLocationDropdown(isStart: true),
          Padding(padding: const EdgeInsets.symmetric(vertical: 8.0), child: Icon(Icons.swap_vert, color: Colors.white70)),
          _buildLocationDropdown(isStart: false),
          Divider(color: Colors.white24, height: 30),
          Row(
            children: [
              // Date Picker Button
              InkWell(
                onTap: () => _selectDate(context),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white30)),
                  child: Row( // Add icon to indicate tappability
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(DateFormat('yyyy.MM.dd').format(_selectedDate), style: TextStyle(color: Colors.white)),
                      SizedBox(width: 8),
                      Icon(Icons.calendar_month_outlined, color: Colors.white70, size: 18),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              // Search / Clear Button
              Expanded(
                child: ElevatedButton(
                  onPressed: (_isSearching || _isLoadingLocations) ? null : (_isSearched ? _clearSearch : _performSearch),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isSearched ? Color(0xFFEF4444) : Color(0xFF8B5CF6),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    disabledBackgroundColor: Colors.grey.shade600, // Indicate disabled state
                  ),
                  child: _isSearching
                      ? SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : Text(_isSearched ? 'Clear' : 'Search', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
          // Display Search Error Message within the card
          if (_searchErrorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(_searchErrorMessage!, style: TextStyle(color: Colors.redAccent, fontSize: 14), textAlign: TextAlign.center),
            ),
        ],
      ),
    );
  }

  // --- Location Dropdown Widget (Handles Loading) ---
  Widget _buildLocationDropdown({required bool isStart}) {
    return DropdownButtonFormField<String>(
      value: isStart ? _startLocation : _endLocation,
      onChanged: _isLoadingLocations ? null : (value) {
        setState(() {
          if (isStart) _startLocation = value; else _endLocation = value;
          _searchErrorMessage = null; // Clear error when selection changes
        });
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        isDense: true, // Make dropdown slightly smaller
      ),
      hint: Text(isStart ? 'Start Location' : 'End Location', style: TextStyle(color: Colors.black54)),
      dropdownColor: Colors.white,
      style: TextStyle(color: Colors.black87),
      isExpanded: true, // Important for fitting text
      icon: _isLoadingLocations
          ? Container(padding: EdgeInsets.only(right: 10), height: 15, width: 25, child: CircularProgressIndicator(strokeWidth: 2))
          : Icon(Icons.arrow_drop_down, color: Colors.black54),
      items: _isLoadingLocations
          ? [ DropdownMenuItem(child: Text("Loading locations...", style: TextStyle(color: Colors.grey)), value: null, enabled: false) ]
          : _locations.map((location) => DropdownMenuItem(value: location, child: Text(location))).toList(),
    );
  }

  // --- Results Area Widget (Handles Loading and Displays Results) ---
  Widget _buildResultsArea() {
    // State 1: Before first search
    if (!_isSearched) {
      return Container(height: 200, alignment: Alignment.center, child: Text('Select locations, date and search', style: TextStyle(color: Colors.white54, fontSize: 16)));
    }
    // State 2: Currently searching
    if (_isSearching) {
      return Container(height: 200, alignment: Alignment.center, child: CircularProgressIndicator());
    }
    // State 3: Search complete, but no results found
    // Combine error display here
    if (_busResults.isEmpty) {
      String message = _searchErrorMessage ?? 'No Available Bookings Found for Intercity buses on this route/date.';
      return Container(height: 200, alignment: Alignment.center, padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(message, style: TextStyle(color: _searchErrorMessage != null ? Colors.redAccent : Colors.white54, fontSize: 16), textAlign: TextAlign.center )
      );
    }
    // State 4: Search complete, results found
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Available Intercity Buses', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 15),
        ListView.builder(
          shrinkWrap: true, // Important inside SingleChildScrollView
          physics: NeverScrollableScrollPhysics(), // Disable ListView's own scrolling
          itemCount: _busResults.length,
          itemBuilder: (context, index) {
            final bus = _busResults[index];
            // Pass the data to your result widget
            // Ensure BusResultWidget exists and accepts these parameters
            return BusResultWidget(
              tripId: bus.tripId, // Pass tripId if needed by the widget
              route: bus.route,
              startLocation: bus.startLocation, // Route's start
              endLocation: bus.endLocation,     // Route's end
              availableSeats: bus.availableSeats,
              // Add other fields needed by BusResultWidget if they exist in BookingResult
              // e.g., departureTime: bus.departureTime,
              //       busNumber: bus.busNumber,
            );
          },
        ),
      ],
    );
  }
}
