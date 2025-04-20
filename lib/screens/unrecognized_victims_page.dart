import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'victim_detail_page.dart'; // Import the VictimDetailPage

class UnrecognizedVictimsPage extends StatefulWidget {
  const UnrecognizedVictimsPage({Key? key}) : super(key: key);

  @override
  _UnrecognizedVictimsPageState createState() =>
      _UnrecognizedVictimsPageState();
}

class _UnrecognizedVictimsPageState extends State<UnrecognizedVictimsPage> {
  String _filterBy = 'All';
  String _sortBy = 'Date';

  final List<Map<String, String>> victims = [
    {
      'name': 'Eshan',
      'id': 'UV001',
      'location': 'near VESIT',
      'hospital': 'Apollo',
      'image': 'assets/victim_placeholder.png', // Placeholder image
      'contact': '+91 1234567890',
    }
  ];

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
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDropdown('Filter by', ['All', 'Hospital', 'Location'],
                        (value) {
                      setState(() => _filterBy = value!);
                    }),
                    _buildDropdown('Sort by', ['Date', 'Name', 'Location'],
                        (value) {
                      setState(() => _sortBy = value!);
                    }),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(24.0),
                  itemCount: victims.length,
                  itemBuilder: (context, index) {
                    return _buildVictimCard(victims[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(
      String label, List<String> items, void Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF159895),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: label == 'Filter by' ? _filterBy : _sortBy,
          dropdownColor: const Color(0xFF159895),
          style: GoogleFonts.poppins(color: Colors.white),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildVictimCard(Map<String, String> victim) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VictimDetailPage(
              name: victim['name']!,
              id: victim['id']!,
              location: victim['location']!,
              hospital: victim['hospital']!,
              timeOfReport: '1:30 PM', // Example time
              gender: 'Male', // Example gender
              age: '20', // Example age
              height: '5\'8"', // Example height
              imageUrl: '',
              contactNumber:
                  '+91 1234567890', // Pass an empty string to test the icon
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFF159895),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${victim['name']}',
                        style:
                            GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    Text('Unique ID: ${victim['id']}',
                        style: GoogleFonts.poppins()),
                    Text('Location: ${victim['location']}',
                        style: GoogleFonts.poppins()),
                    Text('Hospital: ${victim['hospital']}',
                        style: GoogleFonts.poppins()),
                    Text('Contact: ${victim['contact']}',
                        style: GoogleFonts.poppins()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
