
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// This provider class manages the retrieval and deletion of feedback (reviews) stored in Firestore.
// It provides functionality to fetch all feedbacks and delete specific feedbacks,
// intended to be used in an admin panel for managing reviews.

class AdminPanelProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to retrieve a list of feedbacks (reviews) from Firestore
  Future<List<Map<String, dynamic>>> getFeedbacks() async {
    try {
      // Fetch the feedbacks from the 'reviews' collection in Firestore
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('reviews').get();
      
      // Convert the fetched documents into a list of maps
      final List<Map<String, dynamic>> feedbacks =
          snapshot.docs.map((doc) => doc.data()).toList();
      
      return feedbacks;
    } catch (e) {
      // Print error message and rethrow the exception
      print('Error loading feedbacks: $e');
      rethrow;
    }
  }

  // Method to delete a specific feedback (review) from Firestore
  Future<void> deleteFeedback(String feedbackId) async {
    try {
      // Delete the feedback document with the specified ID from Firestore
      await _firestore.collection('reviews').doc(feedbackId).delete();
      
      // Notify listeners after the feedback is deleted
      notifyListeners();
    } catch (e) {
      
      print('Error deleting feedback: $e');
      rethrow;
    }
  }
}
