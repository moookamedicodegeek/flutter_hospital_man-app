
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// This provider class manages the booking, retrieval, and deletion of appointments stored in Firestore.

class AppointmentProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to book a new appointment
  Future<void> bookAppointment(DateTime appointmentDateTime, String reason) async {
    try {
      await _firestore.collection('appointments').add({
        'dateTime': Timestamp.fromDate(appointmentDateTime),
        'reason': reason,
      });
      notifyListeners();
    } catch (e) {
      print('Error booking appointment: $e');
      rethrow;
    }
  }

  // Method to retrieve a list of appointments
  Future<List<Map<String, dynamic>>> getAppointments() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('appointments').get();
      final List<Map<String, dynamic>> appointments = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data(),
        };
      }).toList();
      return appointments;
    } catch (e) {
      print('Error loading appointments: $e');
      rethrow;
    }
  }

  // Method to delete an appointment
  Future<void> deleteAppointment(String appointmentId) async {
    try {
      await _firestore.collection('appointments').doc(appointmentId).delete();
      notifyListeners();
    } catch (e) {
      print('Error deleting appointment: $e');
      rethrow;
    }
  }
}
