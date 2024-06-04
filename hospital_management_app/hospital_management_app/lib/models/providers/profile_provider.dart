

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// This provider class manages the user's profile data, including fetching, updating, and saving changes to the Firestore database.

class ProfileProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String name = '';
  String dateOfBirth = '';
  String idNumber = '';
  String contactNumber = '';

  // Fetches profile data from Firestore database
  Future<void> fetchProfileData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        name = userDoc['name'] as String;
        dateOfBirth = userDoc['dob'] as String;
        idNumber = userDoc['id'] as String;
        contactNumber = userDoc['contact'] as String;
        notifyListeners();
      }
    }
  }

  // Updates profile data in memory
  void updateProfile(Map<String, String> userData) {
    name = userData['name']!;
    dateOfBirth = userData['dob']!;
    idNumber = userData['id']!;
    contactNumber = userData['contact']!;
    notifyListeners();
  }

  // Updates name in memory
  void updateName(String newName) {
    name = newName;
    notifyListeners();
  }

  // Updates date of birth in memory
  void updateDateOfBirth(String newDob) {
    dateOfBirth = newDob;
    notifyListeners();
  }

  // Updates ID number in memory
  void updateIdNumber(String newId) {
    idNumber = newId;
    notifyListeners();
  }

  // Updates contact number in memory
  void updateContactNumber(String newContact) {
    contactNumber = newContact;
    notifyListeners();
  }

  // Saves profile changes to Firestore database
  Future<void> saveProfileChanges() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'name': name,
        'dob': dateOfBirth,
        'id': idNumber,
        'contact': contactNumber,
      });
    }
  }
}
