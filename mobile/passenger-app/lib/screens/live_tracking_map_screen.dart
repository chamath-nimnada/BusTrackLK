import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:passenger_app/models/live_bus_result.dart';
import 'package:flutter/services.dart'; // For rootBundle

class LiveTrackingMapScreen extends StatefulWidget {
  final LiveBusResult bus;

  const LiveTrackingMapScreen({Key? key, required this.bus}) : super(key: key);

  @override
  _LiveTrackingMapScreenState createState() => _LiveTrackingMapScreenState();
}

class _LiveTrackingMapScreenState extends State<LiveTrackingMapScreen> {
  GoogleMapController? _mapController;
  Location _location = Location();
  StreamSubscription<LocationData>? _locationSubscription;

  Marker? _userMarker;
  Marker? _busMarker;
  BitmapDescriptor? _busIcon;

  @override
  void initState() {
    super.initState();
    _loadCustomIcon();
    _startLocationTracking();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _loadCustomIcon() async {
    final icon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)),
      'assets/bus_icon.png', // Make sure this asset exists
    );
    setState(() {
      _busIcon = icon;
      // Set initial bus marker
      _busMarker = Marker(
        markerId: MarkerId(widget.bus.driverUid),
        position: widget.bus.location,
        icon: _busIcon ?? BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: 'Bus: ${widget.bus.busNo}',
          snippet: 'Route: ${widget.bus.routeNo}',
        ),
      );
    });
  }

  void _startLocationTracking() async {
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

    // Start listening for user's location
    _locationSubscription = _location.onLocationChanged.listen((LocationData currentLocation) {
      if (!mounted) return;
      setState(() {
        final userLatLng = LatLng(currentLocation.latitude!, currentLocation.longitude!);
        _userMarker = Marker(
          markerId: MarkerId('user_location'),
          position: userLatLng,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          infoWindow: InfoWindow(title: 'Your Location'),
        );
      });

      // Animate camera to fit both markers
      _animateCameraToFit();
    });

    // TODO: In a real app, you would also use a Stream/Timer to
    // re-fetch the bus's location, as its initial location will become stale.
    // For this simple example, we only show the initial bus location.
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _animateCameraToFit();
  }

  void _animateCameraToFit() {
    if (_mapController == null || _userMarker == null || _busMarker == null) {
      return;
    }

    final userPos = _userMarker!.position;
    final busPos = _busMarker!.position;

    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        userPos.latitude < busPos.latitude ? userPos.latitude : busPos.latitude,
        userPos.longitude < busPos.longitude ? userPos.longitude : busPos.longitude,
      ),
      northeast: LatLng(
        userPos.latitude > busPos.latitude ? userPos.latitude : busPos.latitude,
        userPos.longitude > busPos.longitude ? userPos.longitude : busPos.longitude,
      ),
    );

    _mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 100.0), // 100.0 padding
    );
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = {};
    if (_userMarker != null) markers.add(_userMarker!);
    if (_busMarker != null) markers.add(_busMarker!);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tracking Bus: ${widget.bus.busNo}'),
        backgroundColor: Color(0xFF111827),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: widget.bus.location,
          zoom: 14,
        ),
        markers: markers,
      ),
    );
  }
}