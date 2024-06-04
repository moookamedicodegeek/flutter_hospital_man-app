
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hospital_management_app/models/providers/profile_provider.dart';

// This page provides a form for users to update their profile information. It includes fields for name, date of birth, ID number, and contact number.
// The form uses the ProfileProvider to fetch and update user profile data.

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>(); 
  final TextEditingController _nameController = TextEditingController(); 
  final TextEditingController _dobController = TextEditingController(); 
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _contactController = TextEditingController(); 

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
      profileProvider.fetchProfileData().then((_) {
        _nameController.text = profileProvider.name;
        _dobController.text = profileProvider.dateOfBirth;
        _idController.text = profileProvider.idNumber;
        _contactController.text = profileProvider.contactNumber;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _idController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  _buildTextFormField(
                    controller: _nameController,
                    labelText: 'Name',
                    icon: Icons.person,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      profileProvider.updateName(value);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  _buildTextFormField(
                    controller: _dobController,
                    labelText: 'Date of Birth',
                    icon: Icons.calendar_today,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your date of birth';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      profileProvider.updateDateOfBirth(value);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  _buildTextFormField(
                    controller: _idController,
                    labelText: 'ID Number',
                    icon: Icons.perm_identity,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your ID number';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      profileProvider.updateIdNumber(value);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  _buildTextFormField(
                    controller: _contactController,
                    labelText: 'Contact Number',
                    icon: Icons.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your contact number';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      profileProvider.updateContactNumber(value);
                    },
                  ),
                  const SizedBox(height: 40.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        profileProvider.saveProfileChanges();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Profile updated successfully!'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Helper method to build text form fields
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    required String? Function(String?) validator,
    required void Function(String) onChanged,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
