import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hospital_management_app/models/providers/appointment_provider.dart';
import 'package:provider/provider.dart';

// This page provides a form for booking appointments. It includes fields for selecting date and time,
// entering the reason for the appointment, and handles appointment booking functionality through the AppointmentProvider.

class AppointmentForm extends StatefulWidget {
  const AppointmentForm({super.key});

  @override
  AppointmentFormState createState() => AppointmentFormState();
}

class AppointmentFormState extends State<AppointmentForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _reasonController = TextEditingController();

  DateTime? pickedDate;
  TimeOfDay? pickedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () async {
                  pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
                  );
                  if (pickedDate != null) {
                    pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    setState(() {});
                  }
                },
                icon: const Icon(Icons.calendar_today),
                label: const Text('Select Date and Time'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
              if (pickedDate != null && pickedTime != null) ...[
                const SizedBox(height: 20.0),
                Text(
                  'Selected Date and Time: ${DateFormat('yyyy-MM-dd').format(pickedDate!)} ${pickedTime!.format(context)}',
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _reasonController,
                decoration: const InputDecoration(
                  labelText: 'Reason',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.note, color: Colors.teal),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter appointment reason';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (pickedDate != null && pickedTime != null) {
                      // Combine picked date and time into a single DateTime object
                      DateTime appointmentDateTime = DateTime(
                        pickedDate!.year,
                        pickedDate!.month,
                        pickedDate!.day,
                        pickedTime!.hour,
                        pickedTime!.minute,
                      );

                      AppointmentProvider appointmentProvider =
                          Provider.of<AppointmentProvider>(context,
                              listen: false);
                      appointmentProvider
                          .bookAppointment(
                              appointmentDateTime, _reasonController.text)
                          .then((_) {
                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Appointment booked successfully!'),
                          ),
                        );
                      }).catchError((error) {
                        // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to book appointment: $error'),
                          ),
                        );
                      });
                    } else {
                      // Show error message if date and time are not selected
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select date and time'),
                        ),
                      );
                    }
                  }
                },
                icon: const Icon(Icons.book),
                label: const Text('Book Appointment'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
