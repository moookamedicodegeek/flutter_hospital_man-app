import 'package:flutter/material.dart';
import 'package:hospital_management_app/widgets/appointmentsform.dart';

class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Appointment',
        ),
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const AppointmentForm(), // Display the appointment form widget
    );
  }
}
