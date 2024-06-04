
import 'package:flutter/material.dart'; 
import 'package:firebase_auth/firebase_auth.dart'; 

// This file manages the login process using Firebase authentication.


// LoginProvider class to handle login functionality
class LoginProvider extends ChangeNotifier {
  // Firebase authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // GlobalKey to manage the login form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Variables to store email and password
  String? _email; 
  String? _password; 

  // Getter for formKey
  GlobalKey<FormState> get formKey => _formKey;

  // Method to set email entered by user
  void setEmail(String email) {
    _email = email;
  }

  // Method to set password entered by user
  void setPassword(String password) {
    _password = password;
  }

  // Method to handle user login
  Future<void> login(BuildContext context) async {
    try {
      // Sign in user with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _email!, 
        password: _password!, 
      );

      // If login successful, navigate to the main page
      print('User logged in successfully: ${userCredential.user!.uid}');
      Navigator.pushNamed(context, '/main');
    } catch (e) {
      // If login fails, handle the error
      print('Login failed: $e');
      
      // Show error message to user using SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: $e'), // Display error message
        ),
      );
    }
  }
}
