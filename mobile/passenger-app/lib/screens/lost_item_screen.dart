import 'package:flutter/material.dart';

import 'lost_item_success_screen.dart';

class LostItemScreen extends StatefulWidget {
  @override
  _LostItemScreenState createState() => _LostItemScreenState();
}

class _LostItemScreenState extends State<LostItemScreen> {
  String? _selectedRoute;
  final List<String> _busRoutes = ['Route 17 - Panadura', 'Route 122 - Avissawella', 'Route 138 - Homagama', 'Route 99 - Badulla'];

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 15), // adjust as needed
                  child: Text(
                    'Report a Lost Item',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // The "Ex. Black Backpack" text field has been removed from here.
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFF374151).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      _buildTextField(icon: Icons.card_travel, hint: 'Lost Item Name'),
                      SizedBox(height: 15),
                      _buildDropdownField(),
                      SizedBox(height: 15),
                      _buildTextField(icon: Icons.calendar_today, hint: 'Date & Time Lost', isDatePicker: true),
                      SizedBox(height: 15),
                      _buildTextField(icon: Icons.phone, hint: 'Contact No', keyboardType: TextInputType.phone),
                      SizedBox(height: 15),
                      _buildTextField(hint: 'Additional Information', maxLines: 4),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Text(
          '© 2025 BusTrackLK App. All Rights Reserved.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white54,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({IconData? icon, required String hint, int maxLines = 1, TextInputType? keyboardType, bool isDatePicker = false}) {
    return TextFormField(
      style: TextStyle(color: Colors.black87),
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.black38),
        filled: true,
        fillColor: Colors.white.withOpacity(0.85),
        prefixIcon: icon != null ? Icon(icon, color: Colors.black54) : null,
        suffixIcon: isDatePicker ? Icon(Icons.calendar_month, color: Colors.black54) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
    );
  }

  Widget _buildDropdownField() {
    return DropdownButtonFormField<String>(
      value: _selectedRoute,
      onChanged: (newValue) {
        setState(() {
          _selectedRoute = newValue;
        });
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.85),
        prefixIcon: Icon(Icons.directions_bus, color: Colors.black54),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
      hint: Text('Bus Number / Route', style: TextStyle(color: Colors.black38)),
      dropdownColor: Colors.grey[200],
      style: TextStyle(color: Colors.black87),
      items: _busRoutes.map((route) {
        return DropdownMenuItem(
          value: route,
          child: Text(route),
        );
      }).toList(),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LostItemSuccessScreen()),
          );
          if (result == true) {
            Navigator.pop(context);
          }
          // Logic to submit the report
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF8B5CF6), // Purple
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text('Submit Report', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}