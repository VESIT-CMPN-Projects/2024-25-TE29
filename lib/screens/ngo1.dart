import 'package:flutter/material.dart';

class NGO1Page extends StatelessWidget {
  final String victimId;

  const NGO1Page({Key? key, required this.victimId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Victim $victimId Details'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      'https://example.com/placeholder_image_$victimId.jpg',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildDetailRow('Name', 'Eshan Vijay'),
                _buildDetailRow('Age', '20'),
                _buildDetailRow('Gender', 'Male'),
                _buildDetailRow('Contact Number', '+91 1234567890'),
                _buildDetailRow('Estimated expense', '₹50000'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
