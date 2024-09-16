import 'package:flutter/material.dart';
import 'package:library_management_system/screens/admin_dashboard_screen.dart';
import 'package:library_management_system/screens/get_started_screen.dart';
import 'package:library_management_system/screens/login_screen.dart';
import 'package:library_management_system/screens/student_dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckScreen extends StatefulWidget {
  const CheckScreen({super.key});

  @override
  State<CheckScreen> createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void checkPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? checkPref = sharedPreferences.getBool("notFirstTime");
    String? userRole = sharedPreferences.getString("role");

    if (checkPref == true) {
      if (userRole == "admin") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminDashboardScreen(),
            ));
      } else if (userRole == "student") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const StudentDashboardScreen(),
            ));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ));
      }
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const GetStartedScreen(),
          ));
    }
  }
}
