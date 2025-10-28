import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:passenger_app/widgets/bus_tracking_result_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart'; // <-- 1. IMPORT LOCATION
import 'package:passenger_app/services/tracking_service.dart'; // <-- 2. IMPORT NEW SERVICE
import 'package:passenger_app/models/live_bus_result.dart'; // <-- 3. IMPORT NEW MODEL
import 'package:flutter/services.dart'; // For rootBundle

class BusTrackingScreen extends StatefulWidget {
  @override
  _BusTrackingScreenState createState() => _BusTrackingScreenState();
}

class _BusTrackingScreenState extends State<BusTrackingScreen> {
  // --- 4. UPDATE STATE VARIABLES ---
  final TrackingService _trackingService = TrackingService();
  final Location _location = Location();

  bool _isSearched = false;
  bool _isSearching = false; // Loading state
  String? _searchErrorMessage; // Error state

  List<LiveBusResult> _trackingResults = []; // Use new model
  DateTime _selectedDate = DateTime.now();

  // Mock locations for dropdowns.
  final List<String> _locations = ['100', '101', '122', '138', '17'];
  String? _startLocation; // This will be used as the Route No
  // --- REMOVED _endLocation ---

  // --- Map-specific variables
  GoogleMapController? _mapController;
  LocationData? _currentUserLocation;
  BitmapDescriptor? _busIcon;
  Set<Marker> _mapMarkers = {};

  @override
  void initState() {
    super.initState();
    _loadCustomIcon();
    _getUserLocation();
  }

  // --- 5. NEW FUNCTIONS TO PREPARE THE MAP ---
  Future<void> _loadCustomIcon() async {
    final icon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)),
      'assets/bus_icon.png', // Make sure this asset exists
    );
    setState(() {
      _busIcon = icon;
    });
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permission = await _location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await _location.requestPermission();
      if (permission != PermissionStatus.granted) return;
    }

    final locationData = await _location.getLocation();
    setState(() {
      _currentUserLocation = locationData;
    });
    // Animate map to user's location
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(locationData.latitude!, locationData.longitude!),
        14.0, // Zoom level
      ),
    );
  }

  // --- 6. UPDATE SEARCH/CLEAR FUNCTIONS ---
  Future<void> _performSearch() async {
    if (_startLocation == null) {
      setState(() => _searchErrorMessage = 'Please select a route.');
      return;
    }

    setState(() {
      _isSearched = true;
      _isSearching = true;
      _searchErrorMessage = null;
      _trackingResults = [];
    });

    try {
      // Call the new service. We use startLocation as the route number.
      final results = await _trackingService.searchLiveBuses(
        startLocation: _startLocation!,
        endLocation: "", // --- REMOVED _endLocation ---
        date: DateFormat('yyyy.MM.dd').format(_selectedDate),
      );

      if (!mounted) return;
      setState(() {
        _trackingResults = results;
        // Update the map markers
        _updateMapMarkers(results);
      });

    } catch (e) {
      if (mounted) {
        setState(() => _searchErrorMessage = e.toString().replaceFirst("Exception: ", ""));
      }
    } finally {
      if (mounted) {
        setState(() => _isSearching = false);
      }
    }
  }

  void _clearSearch() {
    setState(() {
      _isSearched = false;
      _isSearching = false;
      _searchErrorMessage = null;
      _trackingResults = [];
      _startLocation = null;
      // --- REMOVED _endLocation ---
      _selectedDate = DateTime.now();
      _mapMarkers = {}; // Clear map markers
    });
  }

  // --- 7. NEW FUNCTION TO UPDATE MAP MARKERS ---
  void _updateMapMarkers(List<LiveBusResult> buses) {
    Set<Marker> markers = {};
    if (_busIcon == null) {
      print("Bus icon not loaded yet");
      return; // Don't build markers if icon isn't ready
    }

    for (final bus in buses) {
      markers.add(
        Marker(
          markerId: MarkerId(bus.driverUid),
          position: bus.location,
          icon: _busIcon!,
          infoWindow: InfoWindow(
            title: 'Bus: ${bus.busNo}',
            snippet: 'Route: ${bus.routeNo}',
          ),
        ),
      );
    }
    setState(() {
      _mapMarkers = markers;
    });
  }

  // This function was likely missing from your file
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
              children: [
                _buildSearchCard(),
                SizedBox(height: 20),
                _buildResultsArea(),
              ],
            ),
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
          // --- 8. MODIFIED: ONLY SHOW ONE DROPDOWN ---
          _buildLocationDropdown(),
          // --- REMOVED SWAP ICON ---
          // --- REMOVED SECOND DROPDOWN ---
          SizedBox(height: 15), // Added space to replace the removed dropdown
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
                  onPressed: _isSearching ? null : (_isSearched ? _clearSearch : _performSearch),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isSearched ? Color(0xFFEF4444) : Color(0xFF8B5CF6),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: _isSearching
                      ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : Text(_isSearched ? 'Clear' : 'Search', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
          // Show error message
          if (_searchErrorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(_searchErrorMessage!, style: TextStyle(color: Colors.redAccent, fontSize: 14), textAlign: TextAlign.center),
            ),
        ],
      ),
    );
  }

  // --- 9. MODIFIED: SIMPLIFIED DROPDOWN WIDGET ---
  Widget _buildLocationDropdown() {
    return DropdownButtonFormField<String>(
      value: _startLocation,
      onChanged: (value) {
        setState(() {
          _startLocation = value;
          _searchErrorMessage = null; // Clear error on change
        });
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      ),
      hint: Text('Select Route (e.g., 100)', style: TextStyle(color: Colors.black54)),
      dropdownColor: Colors.white,
      style: TextStyle(color: Colors.black87),
      items: _locations.map((location) {
        return DropdownMenuItem(value: location, child: Text(location));
      }).toList(),
    );
  }

  Widget _buildResultsArea() {
    return Column(
      children: [
        TabBar(
          indicatorColor: Color(0xFF8B5CF6),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white54,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 3.0, color: Color(0xFF8B5CF6)),
            insets: EdgeInsets.symmetric(horizontal: 50.0),
          ),
          tabs: [
            Tab(text: 'Map View'),
            Tab(text: 'List View'),
          ],
        ),
        SizedBox(height: 20),
        Container(
          height: 400, // Fixed height for the TabBarView
          child: TabBarView(
            children: [
              _buildMapView(),
              _buildListView(),
            ],
          ),
        ),
      ],
    );
  }

  // 10. UPDATE LIST VIEW to handle new states
  Widget _buildListView() {
    if (_isSearching) {
      return Center(child: CircularProgressIndicator());
    }
    if (!_isSearched) {
      return Center(child: Text('Search for a route to see live buses.', style: TextStyle(color: Colors.white54, fontSize: 16)));
    }
    if (_searchErrorMessage != null) {
      return Center(child: Text(_searchErrorMessage!, style: TextStyle(color: Colors.redAccent, fontSize: 16), textAlign: TextAlign.center,));
    }
    if (_trackingResults.isEmpty) {
      return Center(child: Text('No live buses found for this route.', style: TextStyle(color: Colors.white54, fontSize: 16)));
    }

    return ListView.builder(
      itemCount: _trackingResults.length,
      itemBuilder: (context, index) {
        final bus = _trackingResults[index];
        return BusTrackingResultWidget(
          bus: bus, // Pass the full LiveBusResult object
        );
      },
    );
  }

  // 11. UPDATE MAP VIEW to show user and buses
  Widget _buildMapView() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GoogleMap(
        onMapCreated: (controller) {
          _mapController = controller;
        },
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _currentUserLocation != null
              ? LatLng(_currentUserLocation!.latitude!, _currentUserLocation!.longitude!)
              : LatLng(6.9271, 79.8612), // Default to Colombo if no location
          zoom: 12.0,
        ),
        myLocationEnabled: true, // Shows the blue dot for user
        myLocationButtonEnabled: true,
        markers: _mapMarkers, // Use the markers from our state
      ),
    );
  }
}