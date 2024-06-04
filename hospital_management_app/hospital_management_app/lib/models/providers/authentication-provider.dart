
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// This provider class manages user authentication, including registration, login, logout, and fetching user data from Firestore.

enum UserType {
  patient,
  admin,
}

class AuthenticationProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserType? userType;
  User? _user;
  String? _userName;

  AuthenticationProvider() {
    _initAuthState();
  }

  String? get userName => _userName;
  User? get user => _user;
  bool get isAuthenticated => _user != null;

  Future<void> _initAuthState() async {
    _user = _auth.currentUser;
    if (_user != null) {
      await _fetchUserData();
      notifyListeners();
    }
  }

  Future<void> registerPatient(String email, String password, Map<String, dynamic> userData) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;

      await _firestore.collection('users').doc(_user!.uid).set({
        'name': userData['name'],
        'dob': userData['dob'],
        'id': userData['id'],
        'contact': userData['contact'],
        'userType': 'patient',
      });

      await _fetchUserData();
      print('Patient registered successfully');
    } catch (e) {
      print('Patient registration failed: $e');
      rethrow;
    }
  }

  Future<void> registerAdmin(String email, String password, Map<String, dynamic> userData) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;

      await _firestore.collection('users').doc(_user!.uid).set({
        'name': userData['name'],
        'dob': userData['dob'],
        'id': userData['id'],
        'contact': userData['contact'],
        'userType': 'admin',
      });

      await _fetchUserData();
      print('Admin registered successfully');
    } catch (e) {
      print('Admin registration failed: $e');
      rethrow;
    }
  }

  Future<void> loginPatient(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        _user = userCredential.user;
        userType = UserType.patient;
        await _fetchUserData();
        notifyListeners();
        print('Patient logged in successfully');
      }
    } catch (e) {
      print('Patient login failed: $e');
      rethrow;
    }
  }

  Future<void> loginAdmin(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        _user = userCredential.user;
        userType = UserType.admin;
        await _fetchUserData();
        notifyListeners();
        print('Admin logged in successfully');
      }
    } catch (e) {
      print('Admin login failed: $e');
      rethrow;
    }
  }

  Future<void> _fetchUserData() async {
    if (_user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(_user!.uid).get();
      if (userDoc.exists) {
        _userName = userDoc['name'] as String?;
        notifyListeners();
      } else {
        print('User document does not exist');
      }
    }
  }

  Future<void> updateUserProfile(Map<String, dynamic> userData) async {
    if (_user != null) {
      await _firestore.collection('users').doc(_user!.uid).update({
        'name': userData['name'],
        'dob': userData['dob'],
        'id': userData['id'],
        'contact': userData['contact'],
      });
      _userName = userData['name'];
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _user = null;
    _userName = null;
    userType = null;
    notifyListeners();
  }
}
