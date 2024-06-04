import 'package:flutter/material.dart';
import 'package:hospital_management_app/models/providers/profile_provider.dart';
import 'package:hospital_management_app/widgets/profileform.dart';
import 'package:provider/provider.dart';

// This page allows users to edit their profile information.

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the ProfileProvider to manage profile data
    return ChangeNotifierProvider(
      create: (context) => ProfileProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Profile',
          ),
          backgroundColor: Colors.teal,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: ProfileForm(), // Displaying the profile editing form
      ),
    );
  }
}
