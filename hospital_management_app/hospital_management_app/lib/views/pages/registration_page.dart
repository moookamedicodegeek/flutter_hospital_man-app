import 'package:flutter/material.dart';
import 'package:hospital_management_app/widgets/registrationform.dart';

// This page provides a registration form for users.

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: RegistrationForm(),
    );
  }
}
