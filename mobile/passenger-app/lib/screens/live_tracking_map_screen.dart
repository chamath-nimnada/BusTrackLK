// lib/screens/live_tracking_map_screen.dart

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:passenger_app/models/live_bus_result.dart';

class LiveTrackingMapScreen extends StatefulWidget {
  final LiveBusResult bus;

  const LiveTrackingMapScreen({Key? key, required this.bus}) : super(key: key);

  @override
  _LiveTrackingMapScreenState createState() => _LiveTrackingMapScreenState();
}

class _LiveTrackingMapScreenState extends State<LiveTrackingMapScreen> {
  GoogleMapController? _mapController;
  BitmapDescriptor? _busIcon;
  Marker? _busMarker;

  // Stream subscription to listen for location changes
  StreamSubscription<DocumentSnapshot>? _busLocationSubscription;

  @override
  void initState() {
    super.initState();
    _loadCustomIcon();
    _setInitialMarker();
    _subscribeToBusLocation();
  }

  @override
  void dispose() {
    // 1. Cancel the stream subscription
    _busLocationSubscription?.cancel();
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _loadCustomIcon() async {
    final icon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/bus_icon.png',
    );
    setState(() {
      _busIcon = icon;
      // Update marker icon if it already exists
      if (_busMarker != null) {
        _busMarker = _busMarker!.copyWith(
          iconParam: _busIcon ?? BitmapDescriptor.defaultMarker,
        );
      }
    });
  }

  // 2. Set the marker to the bus's last known location
  void _setInitialMarker() {
    _busMarker = Marker(
      markerId: MarkerId(widget.bus.driverUid),
      position: widget.bus.location,
      icon: _busIcon ?? BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(
        title: 'Bus: ${widget.bus.busNo}',
        snippet: 'Route: ${widget.bus.routeNo}',
      ),
    );
  }

  // 3. This is the new "live" tracking logic
  void _subscribeToBusLocation() {
    final docRef = FirebaseFirestore.instance
        .collection('live_bus_locations')
        .doc(widget.bus.driverUid);

    _busLocationSubscription = docRef.snapshots().listen((snapshot) {
      if (!snapshot.exists) {
        // Bus has stopped sharing, maybe show a dialog or pop the screen
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Bus has ended its journey.'),
                backgroundColor: Colors.red),
          );
          Navigator.of(context).pop();
        }
        return;
      }

      // 4. Get new location from the snapshot
      final data = snapshot.data() as Map<String, dynamic>;
      final geoPoint = data['location'] as GeoPoint;
      final newLocation = LatLng(geoPoint.latitude, geoPoint.longitude);

      // 5. Update the marker on the map
      setState(() {
        _busMarker = Marker(
          markerId: MarkerId(widget.bus.driverUid),
          position: newLocation,
          icon: _busIcon ?? BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(
            title: 'Bus: ${widget.bus.busNo}',
            snippet: 'Route: ${widget.bus.routeNo}',
          ),
        );
      });

      // 6. Animate the map camera to the new location
      _mapController?.animateCamera(
        CameraUpdate.newLatLng(newLocation),
      );
    }, onError: (error) {
      // Handle error
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tracking Bus: ${widget.bus.busNo}'),
        backgroundColor: const Color(0xFF111827),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: widget.bus.location,
          zoom: 16, // Zoom in a bit closer
        ),
        // 7. Display the single, updating bus marker
        markers: _busMarker == null ? {} : {_busMarker!},
      ),
    );
  }
}