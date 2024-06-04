import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:hospital_management_app/models/providers/appointment_provider.dart';

// This page displays appointments fetched from AppointmentProvider.

class ViewAppointmentsPage extends StatelessWidget {
  const ViewAppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Appointments',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer<AppointmentProvider>(
        builder: (context, appointmentProvider, child) {
          return FutureBuilder<List<Map<String, dynamic>>>(
            // Fetch appointments from the AppointmentProvider
            future: appointmentProvider.getAppointments(),
            builder: (context, snapshot) {
              // Display loading indicator while fetching data
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: Text(
                        'Error: ${snapshot.error}')); // Display error message if there's an error
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                    child: Text(
                        'No appointments found.')); // Display message if no appointments found
              }

              // Data is successfully fetched
              final appointments = snapshot.data!;

              // Display list of appointments
              return ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final appointment = appointments[index];
                  final Timestamp timestamp = appointment['dateTime'];
                  final DateTime dateTime = timestamp.toDate();
                  final formattedDate =
                      DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);

                  return Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    color: Colors.white,
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      title: Text(
                        'Appointment: ${appointment['reason']}', // Display appointment reason
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      subtitle: Text(
                          'Date: $formattedDate'), // Display appointment date
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // Delete appointment and provide feedback to user
                          appointmentProvider
                              .deleteAppointment(appointment['id'])
                              .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Appointment deleted')), // Show success message
                            );
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Failed to delete appointment: $error')), // Show error message
                            );
                          });
                        },
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
