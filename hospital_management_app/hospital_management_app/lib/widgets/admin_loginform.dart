import 'package:flutter/material.dart';
import 'package:hospital_management_app/models/providers/authentication-provider.dart';
import 'package:provider/provider.dart';

// This page defines a login form for admin users. It includes fields for email and password,
// validation for these fields, and handles login functionality through the AuthenticationProvider.

class AdminLoginForm extends StatefulWidget {
  const AdminLoginForm({super.key});

  @override
  AdminLoginFormState createState() => AdminLoginFormState();
}

class AdminLoginFormState extends State<AdminLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  // Function to handle admin login
  Future<void> _loginAdmin(BuildContext context) async {
    try {
      final authProvider =
          Provider.of<AuthenticationProvider>(context, listen: false);
      await authProvider.loginAdmin(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      // Navigate to admin main page upon successful login
      Navigator.pushNamed(context, '/adminpanel');
    } catch (e) {
      // Show error message if login fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: ${e.toString()}'),
          backgroundColor: Colors.red, // Set snackbar background color to red
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login as Admin",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Admin Email',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!value.contains('@')) {
                    return 'Email must contain the "@" symbol';
                  }
                  return null;
                },
                style: const TextStyle(color: Colors.teal),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Admin Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_isPasswordVisible,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }
                  return null;
                },
                style: const TextStyle(color: Colors.teal),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _loginAdmin(context);
                  }
                },
                icon: const Icon(Icons.login),
                label: const Text('Login as Admin'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.teal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
