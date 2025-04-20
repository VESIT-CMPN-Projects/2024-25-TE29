import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart' as loc;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

import 'accident_reported_page.dart';

class ReportAccidentPage extends StatefulWidget {
  const ReportAccidentPage({Key? key}) : super(key: key);

  @override
  _ReportAccidentPageState createState() => _ReportAccidentPageState();
}

class _ReportAccidentPageState extends State<ReportAccidentPage> {
  String? _selectedSeverity;
  bool _imageUploaded = false;
  bool _locationAccessed = false;
  int _currentStep = 1;
  String? _imageUrl;
  double? _latitude, _longitude;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 1000),
                child: Container(
                  width: 130,
                  height: 130,
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
                      width: 90,
                      height: 90,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _buildStep(
                  1, 'Upload an image of the accident', _buildImageUpload()),
              const SizedBox(height: 30),
              _buildStep(2, 'Rate the severity of the accident',
                  _buildSeverityDropdown()),
              const SizedBox(height: 30),
              _buildStep(3, 'Allow location access', _buildLocationAccess()),
              const SizedBox(height: 30),
              _buildReportButton(),
            ],
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
        if (step < 3)
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

  Widget _buildImageUpload() {
    return _buildActionBox(
      'Upload an Image',
      () async {
        final ImagePicker picker = ImagePicker();
        final XFile? image =
            await picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          File file = File(image.path);
          String fileName =
              'accident_images/${DateTime.now().millisecondsSinceEpoch}.jpg';

          UploadTask uploadTask =
              FirebaseStorage.instance.ref(fileName).putFile(file);
          TaskSnapshot snapshot = await uploadTask;
          String downloadUrl = await snapshot.ref.getDownloadURL();

          setState(() {
            _imageUploaded = true;
            _imageUrl = downloadUrl;
            _currentStep = 2;
          });
        }
      },
      isCompleted: _imageUploaded,
    );
  }

  Widget _buildSeverityDropdown() {
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
            value: _selectedSeverity,
            isExpanded: true,
            dropdownColor: const Color(0xFF002B5B),
            hint: Text('Select Severity',
                style: GoogleFonts.poppins(color: Colors.white)),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            items:
                ['Minor', 'Moderate', 'Severe', 'Critical'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,
                    style: GoogleFonts.poppins(color: Colors.white)),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedSeverity = newValue;
                if (newValue != null) _currentStep = 3;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLocationAccess() {
    return _buildActionBox(
      'Allow Location Access',
      () async {
        loc.Location location = loc.Location();
        loc.LocationData locationData = await location.getLocation();

        setState(() {
          _locationAccessed = true;
          _latitude = locationData.latitude;
          _longitude = locationData.longitude;
          _currentStep = 3;
        });
      },
      isCompleted: _locationAccessed,
    );
  }

  Widget _buildActionBox(String text, VoidCallback onPressed,
      {bool isCompleted = false}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF002B5B),
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(isCompleted ? '$text ✓' : text,
          style: GoogleFonts.poppins(color: Colors.white)),
    );
  }

  // Method to validate inputs
  bool _validateInputs() {
    if (_selectedSeverity == null) {
      Fluttertoast.showToast(
          msg: 'Please select the severity of the accident.');
      return false;
    }
    if (!_locationAccessed) {
      Fluttertoast.showToast(msg: 'Please allow location access.');
      return false;
    }
    return true; // Image upload is no longer mandatory
  }

  Widget _buildReportButton() {
    return ElevatedButton(
      onPressed: () {
        if (_validateInputs()) {
          FirebaseFirestore.instance.collection('accidents').add({
            'imageUrl':
                _imageUploaded ? _imageUrl : null, // Allow null if not uploaded
            'severity': _selectedSeverity,
            'latitude': _latitude,
            'longitude': _longitude,
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AccidentReportedPage()));
        }
      },
      child: Text('REPORT', style: GoogleFonts.poppins(color: Colors.white)),
    );
  }
}
