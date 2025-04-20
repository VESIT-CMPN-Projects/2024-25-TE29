import 'package:flutter/material.dart';
import 'hospital1.dart';

class HospitalPage extends StatelessWidget {
  const HospitalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Hospital Icon
                  Image.asset(
                    'assets/hospitalicon.png',
                    height: 100,
                    width: 100,
                    errorBuilder: (context, error, stackTrace) {
                      print('Error loading image: \$error');
                      return const Icon(Icons.local_hospital,
                          size: 100, color: Colors.red);
                    },
                  ),
                  const SizedBox(height: 30),
                  // Hospital ID Field
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter your hospital ID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Password Field
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Enter your password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Login Button
                  SizedBox(
                    width: 140,
                    height: 51,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Hospital00(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFAF00),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
