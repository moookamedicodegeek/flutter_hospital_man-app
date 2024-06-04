import 'package:flutter/material.dart';
import 'package:hospital_management_app/views/pages/add_notifications.dart';
import 'package:hospital_management_app/views/pages/view_notifications.dart';
import 'package:hospital_management_app/views/pages/welcome_page.dart';
import 'package:hospital_management_app/views/pages/adminlogin_page.dart';
import 'package:hospital_management_app/views/pages/appointments_page.dart';

import 'package:hospital_management_app/views/pages/myprofile_page.dart';
import 'package:hospital_management_app/views/pages/patient_mainpage.dart';
import 'package:hospital_management_app/views/pages/patientlogin_page.dart';
import 'package:hospital_management_app/views/pages/review_page.dart';
import 'package:hospital_management_app/views/pages/registration_page.dart';
import 'package:hospital_management_app/views/pages/viewappointments_page.dart';
import 'package:hospital_management_app/views/pages/viewreviews_page.dart';
import 'package:hospital_management_app/widgets/admin_loginform.dart';
import 'package:hospital_management_app/widgets/patient_loginform.dart';
import 'package:hospital_management_app/views/pages/adminpanelpage.dart';

// Class Routes to manage route generation for different pages in the application
class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const WelcomePage());

      case '/welcome':
        return MaterialPageRoute(builder: (context) => const WelcomePage());

      case '/register':
        return MaterialPageRoute(
            builder: (context) => const RegistrationPage());

      case '/adminloginpage':
        return MaterialPageRoute(builder: (context) => const AdminLoginPage());

      case '/patientloginpage':
        return MaterialPageRoute(
            builder: (context) => const PatientLoginPage());

      case '/patientloginform':
        return MaterialPageRoute(
            builder: (context) => const PatientLoginForm());

      case '/adminloginform':
        return MaterialPageRoute(builder: (context) => const AdminLoginForm());

      case '/main':
        return MaterialPageRoute(builder: (context) => const PatientMainPage());

      case '/appointments':
        return MaterialPageRoute(
            builder: (context) => const AppointmentsPage());

      case '/profile':
        return MaterialPageRoute(builder: (context) => const ProfilePage());

      case '/review':
        return MaterialPageRoute(builder: (context) => ReviewPage());

      case '/adminpanel':
        return MaterialPageRoute(builder: (context) => const AdminPanelPage());

      case '/viewappointments':
        return MaterialPageRoute(
            builder: (context) => const ViewAppointmentsPage());

      case '/viewreviews':
        return MaterialPageRoute(builder: (context) => const ViewReviewsPage());

      case '/addnotifications':
        return MaterialPageRoute(
            builder: (context) => const AddNotificationPage());

      case '/viewnotifications':
        return MaterialPageRoute(
            builder: (context) => const ViewNotificationsPage());

      // Default case for handling unknown routes, returns an error route
      default:
        return _errorRoute();
    }
  }

  // Static method to generate an error route for unknown routes
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error: Page not found!'),
        ),
      );
    });
  }
}
