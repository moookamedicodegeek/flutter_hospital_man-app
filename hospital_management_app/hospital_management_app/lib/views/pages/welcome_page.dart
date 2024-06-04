import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  WelcomePageState createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {
  String? _selectedLoginType;

  // Method to navigate to the login page based on the selected login type
  void _navigateToLogin(BuildContext context) {
    if (_selectedLoginType == 'Patient') {
      Navigator.pushNamed(
          context, '/patientloginform'); // Navigate to patient login form
    } else if (_selectedLoginType == 'Admin') {
      Navigator.pushNamed(
          context, '/adminloginform'); // Navigate to admin login form
    } else {
      // If no option is selected, show a snackbar message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a login type')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hospital Management App',
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                heightFactor: 0.4,
                child: Image.asset('lib/images/logo.jpg'),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Hospital Management App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context,
                      '/register'); // Navigate to the registration page
                },
                icon: const Icon(Icons.app_registration),
                label: const Text('Register'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.login),
                  border: OutlineInputBorder(),
                  labelText: 'Login as',
                ),
                value: _selectedLoginType,
                items: ['Patient', 'Admin']
                    .map((type) => DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedLoginType = value; // Set the selected login type
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  _navigateToLogin(
                      context); // Navigate to the appropriate login page
                },
                icon: const Icon(Icons.login),
                label: const Text('Login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
