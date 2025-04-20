import 'package:flutter/material.dart';

class Police1 extends StatelessWidget {
  const Police1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Police Dashboard'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Row(
              children: [
                Text(
                  'First Name: Eshan',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 20),
                Text(
                  'Last Name: Vijay',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              'Age: 20',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              'Gender: Male',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              'Phone Number: +91 1234567890',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              'Time of Report: 2025-04-01 13:30',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
