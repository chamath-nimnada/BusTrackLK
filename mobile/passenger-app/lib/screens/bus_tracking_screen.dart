import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:passenger_app/widgets/bus_tracking_result_widget.dart';

// IMPORTANT: For the map to work, you will need a package.
// For now, I've commented out the import. When you're ready, uncomment it.
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusTrackingScreen extends StatefulWidget {
  @override
  _BusTrackingScreenState createState() => _BusTrackingScreenState();
}

class _BusTrackingScreenState extends State<BusTrackingScreen> {
  bool _isSearched = false;
  List<Map<String, dynamic>> _trackingResults = [];
  DateTime _selectedDate = DateTime.now();

  final List<String> _locations = ['Colombo', 'Kandy', 'Galle', 'Jaffna', 'Matara'];
  String? _startLocation;
  String? _endLocation;

  void _performSearch() {
    setState(() {
      _isSearched = true;
      _trackingResults = [
        {'route': 'Route 01', 'start': 'Colombo Fort', 'end': 'Kandy', 'busNo': 'ABC 4578'},
        {'route': 'Route 01', 'start': 'Colombo Fort', 'end': 'Kandy', 'busNo': 'AC 3378'},
        {'route': 'Route 01', 'start': 'Colombo Fort', 'end': 'Kandy', 'busNo': 'WC 1578'},
      ];
    });
  }

  void _clearSearch() {
    setState(() {
      _isSearched = false;
      _trackingResults = [];
      _startLocation = null;
      _endLocation = null;
      _selectedDate = DateTime.now();
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

  // This function was likely missing from your file
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

  // This function was likely missing from your file
  Widget _buildLocationDropdown({required bool isStart}) {
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
          height: 400,
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

  Widget _buildListView() {
    if (!_isSearched || _trackingResults.isEmpty) {
      return Center(child: Text('No Available Buses', style: TextStyle(color: Colors.white54, fontSize: 16)));
    }
    return ListView.builder(
      itemCount: _trackingResults.length,
      itemBuilder: (context, index) {
        final bus = _trackingResults[index];
        return BusTrackingResultWidget(
          route: bus['route']!,
          startLocation: bus['start']!,
          endLocation: bus['end']!,
          busNumber: bus['busNo']!,
        );
      },
    );
  }

  Widget _buildMapView() {
    if (!_isSearched || _trackingResults.isEmpty) {
      return Center(child: Text('No Available Buses', style: TextStyle(color: Colors.white54, fontSize: 16)));
    }

    // This is the real Google Map implementation
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GoogleMap(
        mapType: MapType.normal,
        // The initial camera position will be centered on Sri Lanka.
        initialCameraPosition: CameraPosition(
          target: LatLng(7.8731, 80.7718), // Centered on Sri Lanka
          zoom: 7.5, // Zoom level to see the whole country
        ),
        // To show the user's current location blue dot (requires location permissions)
        myLocationEnabled: true,
        myLocationButtonEnabled: true,

        // In the future, you will get bus locations from your backend
        // and add them here as a Set<Marker>.
        // markers: {
        //   Marker(
        //     markerId: MarkerId('bus_1'),
        //     position: LatLng(6.9271, 79.8612), // Example bus location in Colombo
        //     infoWindow: InfoWindow(title: 'Bus: ABC 4578'),
        //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        //   ),
        // },
      ),
    );
  }
}