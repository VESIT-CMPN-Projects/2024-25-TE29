import 'package:flutter/material.dart';

class Hospital3 extends StatefulWidget {
  const Hospital3({super.key});

  @override
  State<Hospital3> createState() => _Hospital3State();
}

class _Hospital3State extends State<Hospital3> {
  // Form controllers
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _expenseController = TextEditingController();
  final _contactNumberController = TextEditingController();
  DateTime _selectedTime = DateTime.now();

  // Checkbox states
  bool _ngoChecked = false;
  bool _insuranceChecked = false;
  bool _findYourLostOnesChecked = false;
  bool _policeChecked = false;

  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notify'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _firstNameController,
                            decoration: const InputDecoration(
                              labelText: 'First Name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: TextFormField(
                            controller: _lastNameController,
                            decoration: const InputDecoration(
                              labelText: 'Last Name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      value: _selectedGender,
                      decoration: const InputDecoration(
                        labelText: 'Gender',
                        border: OutlineInputBorder(),
                      ),
                      items: ['Male', 'Female', 'Other']
                          .map((gender) => DropdownMenuItem(
                                value: gender,
                                child: Text(gender),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Contact Number',
                        border: OutlineInputBorder(),
                        prefixText: '+91 ', // Adding Indian country code prefix
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a contact number';
                        }
                        if (value.length != 10) {
                          return 'Contact number should be 10 digits';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _expenseController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Estimated Expense',
                        prefixText: '₹ ',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ListTile(
                      title: const Text('Time of Report'),
                      subtitle: Text(
                        '${_selectedTime.toLocal()}'.split('.')[0],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.access_time),
                        onPressed: () async {
                          final TimeOfDay? time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(_selectedTime),
                          );
                          if (time != null) {
                            setState(() {
                              _selectedTime = DateTime(
                                _selectedTime.year,
                                _selectedTime.month,
                                _selectedTime.day,
                                time.hour,
                                time.minute,
                              );
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            const Text(
              'UPLOAD TO:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            CheckboxListTile(
              title: const Text('NGO'),
              value: _ngoChecked,
              onChanged: (bool? value) {
                setState(() {
                  _ngoChecked = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('INSURANCE'),
              value: _insuranceChecked,
              onChanged: (bool? value) {
                setState(() {
                  _insuranceChecked = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('FIND YOUR LOST ONES'),
              value: _findYourLostOnesChecked,
              onChanged: (bool? value) {
                setState(() {
                  _findYourLostOnesChecked = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('POLICE'),
              value: _policeChecked,
              onChanged: (bool? value) {
                setState(() {
                  _policeChecked = value ?? false;
                });
              },
            ),
            const SizedBox(height: 24.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Show success notification
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Form submitted successfully!'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ),
                    );

                    // Clear all form fields
                    _firstNameController.clear();
                    _lastNameController.clear();
                    _ageController.clear();
                    _expenseController.clear();
                    setState(() {
                      _selectedGender = null;
                      _selectedTime = DateTime.now();
                      _ngoChecked = false;
                      _insuranceChecked = false;
                      _findYourLostOnesChecked = false;
                      _policeChecked = false;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _expenseController.dispose();
    _contactNumberController.dispose();
    super.dispose();
  }
}
