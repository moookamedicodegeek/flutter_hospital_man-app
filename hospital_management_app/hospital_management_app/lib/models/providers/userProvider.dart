
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider extends ChangeNotifier {
  late User? _user;

  User? get user => _user;

  // Loads current user data from Firebase Authentication.
  void loadUserData() async {
    _user = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }
}
