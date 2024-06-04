import 'package:flutter/material.dart';
import 'package:hospital_management_app/widgets/admin_loginform.dart';

// This page provides a login interface for administrators,

class AdminLoginPage extends StatelessWidget {
  const AdminLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login as Admin'),
        backgroundColor: Colors.teal,
      ),
      body: const AdminLoginForm(), // Display the admin login form
    );
  }
}
