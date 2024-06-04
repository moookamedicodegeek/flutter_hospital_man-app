import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// This provider manages reviews, including adding, fetching, and deleting reviews from Firestore.
// It includes methods to add a new review, fetch all existing reviews, and delete a review by its ID.
// The provider utilizes TextEditingController instances to handle user input for hospital names and feedback.

class ReviewProvider extends ChangeNotifier {
  final TextEditingController _hospitalNameController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController get hospitalNameController => _hospitalNameController;
  TextEditingController get feedbackController => _feedbackController;

  // Adds a new review to Firestore and clears the input controllers.
  Future<void> addReview() async {
    try {
      final String hospitalName = _hospitalNameController.text;
      final String feedback = _feedbackController.text;

      await _firestore.collection('reviews').add({
        'hospitalName': hospitalName,
        'feedback': feedback,
        'timestamp': DateTime.now(),
      });

      _hospitalNameController.clear();
      _feedbackController.clear();

      notifyListeners();
    } catch (error) {
      print('Error adding review: $error');
      rethrow;
    }
  }

  // Fetches all reviews from Firestore.
  Future<List<Map<String, dynamic>>> getReviews() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('reviews').get();
      final List<Map<String, dynamic>> reviews = snapshot.docs.map((doc) {
        print('Review data: ${doc.data()}');
        return {
          'id': doc.id,
          ...doc.data(),
        };
      }).toList();
      return reviews;
    } catch (error) {
      print('Error loading reviews: $error');
      rethrow;
    }
  }

  // Deletes a review from Firestore by its ID.
  Future<void> deleteReview(String reviewId) async {
    try {
      await _firestore.collection('reviews').doc(reviewId).delete();
      notifyListeners();
    } catch (error) {
      print('Error deleting review: $error');
      rethrow;
    }
  }
}
