import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hospital_management_app/models/notification_provider.dart';
import 'package:hospital_management_app/models/providers/authentication-provider.dart';
import 'package:hospital_management_app/models/providers/appointment_provider.dart';
import 'package:hospital_management_app/models/providers/review_provider.dart';
import 'package:hospital_management_app/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  // Flutter bindinging are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialized Firebase with provided options
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      appId:
          '1:1039325544402:web:1:1039325544402:android:e360a2808895a5e23f120b',
      apiKey: '',
      projectId: 'hospitalmanagement-app-5116f',
      messagingSenderId: '1039325544402',
      authDomain: 'hospitalmanagement-app-5116f.firebaseapp.com',
      databaseURL: 'https://hospitalmanagement-app-5116f.firebaseio.com',
      storageBucket: 'hospitalmanagement-app-5116f.appspot.com',
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MultiProvider to provide multiple providers for state management
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentProvider()),
        ChangeNotifierProvider(create: (_) => ReviewProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hospital Management App',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        initialRoute: '/welcome', // Initial route of the application
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
