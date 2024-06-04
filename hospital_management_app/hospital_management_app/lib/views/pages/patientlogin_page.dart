import 'package:flutter/material.dart';
import 'package:hospital_management_app/widgets/patient_loginform.dart';

// This page provides a login interface for patients.

class PatientLoginPage extends StatelessWidget {
  const PatientLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: const PatientLoginForm(), 
    );
  }
}
