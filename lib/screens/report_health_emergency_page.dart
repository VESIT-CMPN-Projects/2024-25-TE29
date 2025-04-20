import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart' as loc;

// Add this to your state class
String _selectedCountryCode = '+91';

// Update this list with full country names
final List<Map<String, String>> countryCodes = [
  {'code': '+1', 'country': 'United States'},
  {'code': '+44', 'country': 'United Kingdom'},
  {'code': '+91', 'country': 'India'},
  {'code': '+86', 'country': 'China'},
  {'code': '+81', 'country': 'Japan'},
  // Add more country codes as needed
];

class ReportHealthEmergencyPage extends StatefulWidget {
  const ReportHealthEmergencyPage({Key? key}) : super(key: key);

  @override
  _ReportHealthEmergencyPageState createState() =>
      _ReportHealthEmergencyPageState();
}

class _ReportHealthEmergencyPageState extends State<ReportHealthEmergencyPage> {
  String? _selectedCause;
  String? _selectedCriticalness;
  bool _locationAccessed = false;
  String _phoneNumber = '';
  int _currentStep = 1;
  double _latitude = 0.0;
  double _longitude = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFE8F6EF),
                const Color(0xFF1A5F7A).withOpacity(0.3),
              ],
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // App Logo
                FadeInDown(
                  duration: const Duration(milliseconds: 1000),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/logo.png',
                        width: 70,
                        height: 70,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                _buildStep(1, 'Cause of the current health condition',
                    _buildCauseDropdown()),
                const SizedBox(height: 30),
                _buildStep(2, 'Rate the level of criticalness',
                    _buildCriticalnessDropdown()),
                const SizedBox(height: 30),
                _buildStep(3, 'Allow location access', _buildLocationAccess()),
                const SizedBox(height: 30),
                _buildStep(4, 'Enter your phone number for urgent contact',
                    _buildPhoneNumberInput()),
                const SizedBox(height: 30),
                _buildReportButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStep(int step, String title, Widget content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProgressIndicator(step),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildStepBox(title, step),
              const SizedBox(height: 15),
              content,
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressIndicator(int step) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentStep >= step ? const Color(0xFF159895) : Colors.grey,
          ),
          child: Center(
            child: Text(
              '$step',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        if (step < 4)
          Container(
            width: 2,
            height: 100,
            color: _currentStep > step ? const Color(0xFF159895) : Colors.grey,
          ),
      ],
    );
  }

  Widget _buildStepBox(String text, int step) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 1000),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: _currentStep >= step ? const Color(0xFF159895) : Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildCauseDropdown() {
    return _buildDropdown(
      value: _selectedCause,
      hint: 'Select Cause',
      items: [
        'Heart Attack',
        'Stroke',
        'Severe Injury',
        'Allergic Reaction',
        'Other'
      ],
      onChanged: (String? newValue) {
        setState(() {
          _selectedCause = newValue;
          if (newValue != null) {
            _currentStep = 2;
          }
        });
      },
    );
  }

  Widget _buildCriticalnessDropdown() {
    return _buildDropdown(
      value: _selectedCriticalness,
      hint: 'Select Criticalness Level',
      items: ['Low', 'Moderate', 'High', 'Critical'],
      onChanged: (String? newValue) {
        setState(() {
          _selectedCriticalness = newValue;
          if (newValue != null) {
            _currentStep = 3;
          }
        });
      },
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return FadeInRight(
      duration: const Duration(milliseconds: 1000),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: const Color(0xFF002B5B),
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            dropdownColor: const Color(0xFF002B5B),
            hint: Text(hint, style: GoogleFonts.poppins(color: Colors.white)),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,
                    style: GoogleFonts.poppins(color: Colors.white)),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

  Widget _buildLocationAccess() {
    return _buildActionBox(
      'Give Location Access',
      () async {
        loc.Location location = loc.Location();
        loc.LocationData locationData = await location.getLocation();

        setState(() {
          _locationAccessed = true;
          _latitude = locationData.latitude!;
          _longitude = locationData.longitude!;
          _currentStep = 4;
        });
      },
      isCompleted: _locationAccessed,
    );
  }

  Widget _buildPhoneNumberInput() {
    return FadeInRight(
      duration: const Duration(milliseconds: 1000),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF002B5B),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCountryCode,
                dropdownColor: const Color(0xFF002B5B),
                icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                style: GoogleFonts.poppins(color: Colors.white),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCountryCode = newValue!;
                  });
                },
                selectedItemBuilder: (BuildContext context) {
                  return countryCodes.map<Widget>((Map<String, String> item) {
                    return Container(
                      alignment: Alignment.center,
                      width: 60,
                      child: Text(
                        item['code']!,
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                    );
                  }).toList();
                },
                items: countryCodes
                    .map<DropdownMenuItem<String>>((Map<String, String> value) {
                  return DropdownMenuItem<String>(
                    value: value['code'],
                    child: Text(
                      '${value['country']} (${value['code']})',
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                  );
                }).toList(),
                padding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 50,
              child: TextFormField(
                style: GoogleFonts.poppins(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF002B5B),
                  hintText: 'Enter 10-digit number',
                  hintStyle:
                      GoogleFonts.poppins(color: Colors.white.withOpacity(0.7)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  counterText: '', // This hides the built-in character counter
                ),
                keyboardType: TextInputType.phone,
                maxLength: 10,
                onChanged: (value) {
                  setState(() {
                    _phoneNumber = value;
                  });
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone number is required';
                  }
                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBox(String text, VoidCallback onPressed,
      {bool isCompleted = false}) {
    return FadeInRight(
      duration: const Duration(milliseconds: 1000),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF002B5B),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          isCompleted ? '$text ✓' : text,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildReportButton() {
    return FadeInUp(
      duration: const Duration(milliseconds: 1000),
      child: ElevatedButton(
        onPressed: () {
          if (_selectedCause == null ||
              _selectedCriticalness == null ||
              _phoneNumber.isEmpty) {
            // Show an error message or a dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Please fill all mandatory fields')),
            );
            return;
          }
          Navigator.pushNamed(context, '/emergencyReported');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF006400),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'REPORT',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
