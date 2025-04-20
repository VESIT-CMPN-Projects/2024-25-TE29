import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/second_page.dart';
import 'screens/report_accident_page.dart';
import 'screens/accident_reported_page.dart';
import 'screens/report_health_emergency_page.dart';
import 'screens/emergency_reported_page.dart';
import 'screens/unrecognized_victims_page.dart';
import 'screens/citizen1.dart';
import 'screens/police.dart';
import 'screens/ngo1.dart';
import 'screens/insurance_company.dart';
import 'screens/hospital.dart';
import 'screens/map_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const RescueNowApp());
}

class RescueNowApp extends StatelessWidget {
  const RescueNowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RescueNow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF1A5F7A),
        scaffoldBackgroundColor: const Color(0xFFE8F6EF),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF159895),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF002B5B)),
          bodyMedium: TextStyle(color: Color(0xFF002B5B)),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const FirstPage(),
        '/second': (context) => const SecondPage(),
        '/reportAccident': (context) => const ReportAccidentPage(),
        '/reportHealthEmergency': (context) => const ReportHealthEmergencyPage(),
        '/accidentReported': (context) => const AccidentReportedPage(),
        '/emergencyReported': (context) => const EmergencyReportedPage(),
        '/unrecognizedVictims': (context) => const UnrecognizedVictimsPage(),
        '/citizen1': (context) => const CitizenLoginPage(),
        '/police': (context) => const PolicePage(),
        '/hospital': (context) => const HospitalPage(),
        '/ngo': (context) => const NGO1Page(victimId: '123'),
        '/insurance_company': (context) => const InsuranceCompanyPage(),
        '/map_page': (context) => const MapPage(),
      },
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String? _selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo
              Container(
                padding: const EdgeInsets.all(20),
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
              const SizedBox(height: 40),
              // Choose a Language Dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedLanguage,
                    isExpanded: true,
                    hint: const Text('English'),
                    icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF1A5F7A)),
                    items: const ['English', 'Hindi', 'Marathi'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedLanguage = newValue;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // User Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/second');
                  },
                  child: const Text(
                    'Click here to report an accident/emergency',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Stakeholder Selection
              const Text(
                'For Stakeholders',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF002B5B)),
              ),
              const SizedBox(height: 20),
              Column(
                children: const [
                  StakeholderButton('Citizen Login', '/citizen1'),
                  SizedBox(height: 10),
                  StakeholderButton('Police', '/police'),
                  SizedBox(height: 10),
                  StakeholderButton('Hospital', '/hospital'),
                  SizedBox(height: 10),
                  StakeholderButton('NGO', '/ngo'),
                  SizedBox(height: 10),
                  StakeholderButton('Insurance Company', '/insurance_company'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StakeholderButton extends StatelessWidget {
  final String stakeholder;
  final String route;

  const StakeholderButton(this.stakeholder, this.route, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        child: Text(stakeholder, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
