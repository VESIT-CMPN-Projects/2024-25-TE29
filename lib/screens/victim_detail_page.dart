import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VictimDetailPage extends StatelessWidget {
  final String name;
  final String id;
  final String location;
  final String hospital;
  final String timeOfReport;
  final String gender;
  final String age;
  final String height;
  final String imageUrl;
  final String contactNumber;

  VictimDetailPage({
    Key? key,
    required this.name,
    required this.id,
    required this.location,
    required this.hospital,
    required this.timeOfReport,
    required this.gender,
    required this.age,
    required this.height,
    required this.imageUrl,
    required this.contactNumber,
  }) : super(key: key);

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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'Find Your Lost Ones',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF159895),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: imageUrl.isNotEmpty
                        ? Image.asset(
                            imageUrl,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: const Color(0xFF159895),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFF159895), width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailText('Name:', name),
                    _buildDetailText('Unique ID:', id),
                    _buildDetailText('Contact Number:', contactNumber),
                    _buildDetailText('Location of the accident:', location),
                    _buildDetailText('Hospital admitted to:', hospital),
                    _buildDetailText('Time of the report:', timeOfReport),
                    _buildDetailText('Gender:', gender),
                    _buildDetailText('Approximate age:', age),
                    _buildDetailText('Height:', height),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Implement call functionality here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[800], // Dark yellow background
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'CALL NOW',
                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0), // Add spacing between text fields
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.poppins(color: Colors.black), // Default text style
          children: [
            TextSpan(
              text: '$label ', // Label
              style: const TextStyle(fontWeight: FontWeight.bold), // Bold label
            ),
            TextSpan(
              text: value, // Value
              style: const TextStyle(fontWeight: FontWeight.normal), // Normal value
            ),
          ],
        ),
      ),
    );
  }
}
