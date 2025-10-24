// lib/screens/lost_item_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For input formatters
import 'package:intl/intl.dart'; // For date formatting
import 'package:passenger_app/services/lost_item_service.dart'; // Your service to call the backend
import 'package:passenger_app/screens/lost_item_success_screen.dart';
import 'package:passenger_app/services/schedule_service.dart'; // To load routes/locations

class LostItemScreen extends StatefulWidget {
  @override
  _LostItemScreenState createState() => _LostItemScreenState();
}

class _LostItemScreenState extends State<LostItemScreen> {
  // Services
  final LostItemService _lostItemService = LostItemService();
  final ScheduleService _scheduleService = ScheduleService(); // Assuming this service exists and has getFormattedRouteNames

  // Controllers for text fields
  final _reporterNameController = TextEditingController(); // <-- Controller for Name
  final _itemNameController = TextEditingController();
  final _dateTimeController = TextEditingController(); // For displaying selected date/time
  final _contactNoController = TextEditingController();
  final _additionalInfoController = TextEditingController();

  // State Variables
  String? _selectedRoute; // Selected value from dropdown
  List<String> _busRoutes = []; // List of routes for dropdown
  bool _isLoadingRoutes = true; // Loading state for dropdown
  DateTime? _selectedDateTime; // Stores the actual selected DateTime object

  bool _isLoading = false; // Loading state for submit button
  String? _errorMessage; // To display errors

  @override
  void initState() {
    super.initState();
    _loadRoutes(); // Fetch routes when the screen initializes
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources
    _reporterNameController.dispose();
    _itemNameController.dispose();
    _dateTimeController.dispose();
    _contactNoController.dispose();
    _additionalInfoController.dispose();
    super.dispose();
  }

  // Fetch formatted route names from the backend
  Future<void> _loadRoutes() async {
    print("Attempting to load routes..."); // Log start
    if (!mounted) return;
    setState(() {
      _isLoadingRoutes = true;
      _errorMessage = null; // Clear previous errors
    });
    try {
      final formattedRoutes = await _scheduleService.getFormattedRouteNames();
      print("Routes fetched successfully: ${formattedRoutes.length} routes found."); // Log success and count

      if (mounted) {
        setState(() {
          _busRoutes = ['Other (Specify in Additional Info)', ...formattedRoutes];
          _isLoadingRoutes = false;
          print("State updated with routes."); // Log state update
        });
      }
    } catch (e, stacktrace) { // Catch stacktrace too
      print("Error loading formatted routes: $e"); // Log the error
      print("Stacktrace: $stacktrace"); // Log stacktrace
      if (mounted) {
        setState(() {
          _isLoadingRoutes = false;
          // Make the error message more prominent
          _errorMessage = "Could not load routes. Please check connection and try again.";
          _busRoutes = ['Other (Specify in Additional Info)'];
        });
      }
    }
  }

  // Function to show Date Picker then Time Picker
  Future<void> _selectDateTimeLost(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5), // Allow reporting for past 5 years
      lastDate: DateTime.now(), // Cannot be in the future
    );

    // Check if the widget is still mounted after awaiting the picker
    if (!mounted || pickedDate == null) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime ?? DateTime.now()),
    );

    // Check if mounted again after awaiting the time picker
    if (!mounted || pickedTime == null) return;

    setState(() {
      _selectedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      // Format the selected date/time for display in the TextField
      _dateTimeController.text = DateFormat('yyyy-MM-dd hh:mm a').format(_selectedDateTime!);
    });
  }

  // Function to handle the submit button press
  Future<void> _handleSubmitReport() async {
    // --- Input Validation ---
    setState(() { _errorMessage = null; }); // Clear previous error
    if (_reporterNameController.text.trim().isEmpty) {
      setState(() => _errorMessage = "Please enter your name."); return;
    }
    if (_itemNameController.text.trim().isEmpty) {
      setState(() => _errorMessage = "Please enter the lost item name."); return;
    }
    if (_selectedRoute == null) {
      setState(() => _errorMessage = "Please select the bus number or route."); return;
    }
    if (_dateTimeController.text.isEmpty) {
      setState(() => _errorMessage = "Please select the date and time the item was lost."); return;
    }
    final contactNumber = _contactNoController.text.replaceAll(RegExp(r'\D'), ''); // Remove non-digits
    if (contactNumber.isEmpty) {
      setState(() => _errorMessage = "Please enter your contact number."); return;
    }
    if (contactNumber.length != 10) { // Check exactly 10 digits
      setState(() => _errorMessage = "Contact number must be exactly 10 digits."); return;
    }
    // --- End Validation ---

    // Show loading indicator
    setState(() { _isLoading = true; });

    try {
      // Call the service to submit the report (no token needed now)
      await _lostItemService.submitReport(
        reporterName: _reporterNameController.text.trim(),
        contactNo: contactNumber, // Send cleaned number
        itemName: _itemNameController.text.trim(),
        busRouteInfo: _selectedRoute!,
        dateTimeLost: _dateTimeController.text, // Send the formatted string
        additionalInfo: _additionalInfoController.text.trim(),
      );

      // Navigate to success screen if submission worked
      if (!mounted) return; // Check if still mounted
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LostItemSuccessScreen()),
      );
      // If user clicks OK on success screen, pop this screen too
      if (result == true && mounted) {
        Navigator.pop(context);
      }

    } catch (e) {
      // Show error message if submission failed
      if (mounted) {
        setState(() {
          _errorMessage = e.toString().replaceFirst("Exception: ", "");
        });
      }
    } finally {
      // Hide loading indicator regardless of success/failure
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // --- Build Method (Main UI Structure) ---
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
        child: SingleChildScrollView( // Allows scrolling if content overflows
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0, top: 0), // Adjusted padding
                  child: Text(
                    'Report a Lost Item',
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                // Main form container
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFF374151).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      // --- Your Name Field ---
                      _buildTextField(
                        icon: Icons.person,
                        hint: 'Your Name',
                        controller: _reporterNameController,
                      ),
                      SizedBox(height: 15),
                      // --- Lost Item Field ---
                      _buildTextField(
                        icon: Icons.card_travel,
                        hint: 'Lost Item Name',
                        controller: _itemNameController,
                      ),
                      SizedBox(height: 15),
                      // --- Route Dropdown ---
                      _buildDropdownField(),
                      SizedBox(height: 15),
                      // --- Date & Time Field (Tappable) ---
                      GestureDetector(
                        onTap: () => _selectDateTimeLost(context),
                        child: AbsorbPointer( // Prevents direct typing
                          child: _buildTextField(
                            icon: Icons.calendar_today,
                            hint: 'Date & Time Lost',
                            controller: _dateTimeController, // Shows formatted selection
                            isDatePicker: true,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      // --- Contact No Field ---
                      _buildTextField(
                        icon: Icons.phone,
                        hint: 'Contact No (10 digits)',
                        controller: _contactNoController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly, // Allow only numbers
                          LengthLimitingTextInputFormatter(10),   // Limit to 10 digits
                        ],
                      ),
                      SizedBox(height: 15),
                      // --- Additional Info Field ---
                      _buildTextField(
                        hint: 'Additional Information (Bus No., Seats, etc.)',
                        controller: _additionalInfoController,
                        maxLines: 4,
                      ),
                    ],
                  ),
                ),
                // --- Error Message Display ---
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Center(
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(color: Colors.redAccent, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                SizedBox(height: 30),
                // --- Submit Button ---
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
      // --- Copyright Footer ---
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(40.0), // Adjusted padding
        child: Text(
          '© 2025 BusTrackLK App. All Rights Reserved.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white54, fontSize: 12),
        ),
      ),
    );
  }

  // --- Helper Widget for TextFields ---
  Widget _buildTextField({
    IconData? icon,
    required String hint,
    TextEditingController? controller,
    int maxLines = 1,
    TextInputType? keyboardType,
    bool isDatePicker = false,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.black87),
      maxLines: maxLines,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.black45), // Slightly darker hint
        filled: true,
        fillColor: Colors.white.withOpacity(0.9), // Slightly more opaque
        prefixIcon: icon != null ? Icon(icon, color: Colors.black54) : null,
        suffixIcon: isDatePicker ? Icon(Icons.calendar_month, color: Colors.black54) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        isDense: true, // Make field slightly smaller vertically
      ),
    );
  }

  // --- Helper Widget for Dropdown ---
  Widget _buildDropdownField() {
    return DropdownButtonFormField<String>(
      value: _selectedRoute,
      onChanged: (newValue) { setState(() { _selectedRoute = newValue; }); },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        prefixIcon: Icon(Icons.directions_bus, color: Colors.black54),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20), // Adjusted padding
        isDense: true,
      ),
      hint: Text('Bus Number / Route', style: TextStyle(color: Colors.black45)),
      dropdownColor: Colors.grey[200],
      style: TextStyle(color: Colors.black87, fontSize: 14), // Slightly smaller font
      isExpanded: true, // Allows long text to fit
      icon: Icon(Icons.arrow_drop_down, color: Colors.black54),
      items: _isLoadingRoutes
          ? [ // Show loading indicator item
        DropdownMenuItem(
          child: Center(child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))),
          value: null, // Assign a unique value if needed, or handle null selection
          enabled: false, // Disable selection while loading
        ),
      ]
          : _busRoutes.map((route) { // Build items from fetched data
        return DropdownMenuItem(
          value: route,
          child: Text(route, overflow: TextOverflow.ellipsis), // Prevent long text overflow
        );
      }).toList(),
    );
  }

  // --- Helper Widget for Submit Button ---
  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleSubmitReport, // Disable when loading, call handler on press
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF8B5CF6), // Purple
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        // Show spinner or text based on loading state
        child: _isLoading
            ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
            : Text('Submit Report', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}