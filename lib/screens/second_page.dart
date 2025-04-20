import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

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
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // App Logo
                FadeInDown(
                  duration: const Duration(milliseconds: 1000),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(top: 40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/logo.png',
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                // Option Boxes
                Expanded(
                  child: Container(
                    height: 60,
                    width: 340,
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildOptionBox('Report a road accident', context),
                        const SizedBox(height: 20),
                        _buildOptionBox('Report a health emergency', context),
                      ],
                    ),
                  ),
                ),
                // Contact and Donate
                FadeInUp(
                  duration: const Duration(milliseconds: 1000),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            // Handle Contact Us
                          },
                          child: Text(
                            'Contact Us',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF002B5B),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Text(' | ',
                            style: TextStyle(color: Color(0xFF002B5B))),
                        TextButton(
                          onPressed: () {
                            // Handle Donate Us
                          },
                          child: Text(
                            'Donate Us',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF002B5B),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionBox(String text, BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 1000),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF159895),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextButton(
          onPressed: () {
            if (text == 'Report a road accident') {
              Navigator.pushNamed(context, '/reportAccident');
            } else if (text == 'Report a health emergency') {
              Navigator.pushNamed(context, '/reportHealthEmergency');
            } else {
              // Handle other options
              print('Option not implemented yet: $text');
            }
          },
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
