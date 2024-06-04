import 'package:flutter/material.dart';
import 'package:hospital_management_app/models/notification_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

// This page allows the user to add a new notification with content and a date.
// It includes a form for input, a date picker, and submission logic.
class AddNotificationPage extends StatefulWidget {
  const AddNotificationPage({super.key});

  @override
  _AddNotificationPageState createState() => _AddNotificationPageState();
}

class _AddNotificationPageState extends State<AddNotificationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _notificationController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Notification',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _notificationController,
                decoration: const InputDecoration(
                  labelText: 'Notification Content',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please add content for the notification';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  // Show date picker and store selected date
                  _selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(), // Initial date for the picker
                    firstDate: DateTime(2000), // First selectable date
                    lastDate: DateTime(2100), // Last selectable date
                  );
                  setState(
                      () {}); // Update the state to reflect the selected date
                },
                icon: const Icon(Icons.calendar_today),
                label: Text(_selectedDate == null
                    ? 'Pick Date' // If no date is selected, show 'Pick Date'
                    : DateFormat('yyyy-MM-dd').format(_selectedDate!)),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.teal,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  // Validate the form
                  if (_formKey.currentState!.validate()) {
                    if (_selectedDate != null) {
                      try {
                        // add notification using the provider
                        await notificationProvider.addNotification(
                          _notificationController.text,
                          _selectedDate!,
                        );
                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Notification added'),
                          ),
                        );
                      } catch (error) {
                        // Show error message if adding fails
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to add notification: $error'),
                          ),
                        );
                      }
                    } else {
                      // Show message if no date is selected
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a date'),
                        ),
                      );
                    }
                  }
                },
                icon: const Icon(Icons.send),
                label: const Text('Submit'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.teal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
