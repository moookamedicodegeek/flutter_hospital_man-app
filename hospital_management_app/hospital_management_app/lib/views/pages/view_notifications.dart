import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hospital_management_app/models/notification_provider.dart';
import 'package:provider/provider.dart';

// This page allows users to view notifications.

class ViewNotificationsPage extends StatelessWidget {
  const ViewNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, notificationProvider, child) {
          return FutureBuilder<List<Map<String, dynamic>>>(
            future: notificationProvider
                .getNotifications(), // Fetch notifications from the provider
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: Text(
                        'Error: ${snapshot.error}')); // Show error message if there's an error
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                    child: Text(
                        'No Notifications found.')); // Show message if no notifications found
              }

              // Extracting notifications from the snapshot data
              final notifications = snapshot.data!;
              // Building a ListView to display notifications
              return ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  // Extracting timestamp and formatting it to display the date and time
                  final DateTime dateTime = notification['timestamp'].toDate();
                  final formattedDate =
                      DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);

                  // Creating a Card to display each notification
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    color: Colors.white,
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      title: Text(
                        'Notification: ${notification['notification']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      subtitle: Text('Date: $formattedDate'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          notificationProvider.deleteNotifications(notification[
                              'id']); // Delete notification when icon is pressed
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
