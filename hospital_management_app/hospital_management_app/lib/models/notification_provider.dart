

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// This provider manages notifications, including adding, fetching, and deleting notifications from Firestore.
class NotificationProvider extends ChangeNotifier {
  final TextEditingController _notificationController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController get notificationController => _notificationController;

  // Adds a new notification to Firestore and clears the input controller.
  Future<void> addNotification(String content, DateTime date) async {
    try {
      await _firestore.collection('notifications').add({
        'notification': content,
        'timestamp': date,
      });
      _notificationController.clear();
      notifyListeners();
    } catch (error) {
      print('Error adding notification: $error');
      rethrow;
    }
  }

  // Fetches all notifications from Firestore.
  Future<List<Map<String, dynamic>>> getNotifications() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('notifications').get();
      final List<Map<String, dynamic>> notifications = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data(),
        };
      }).toList();
      return notifications;
    } catch (error) {
      print('Error loading notifications: $error');
      rethrow;
    }
  }

  // Deletes a notification from Firestore by its ID.
  Future<void> deleteNotifications(String notificationId) async {
    try {
      await _firestore.collection('notifications').doc(notificationId).delete();
      notifyListeners();
    } catch (error) {
      print('Error deleting notification: $error');
      rethrow;
    }
  }
}
