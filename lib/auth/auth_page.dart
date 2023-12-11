import 'package:bibcrush/pages/login_page.dart';
import 'package:bibcrush/pages/start_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);


  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // initially, show the login page
  bool showLoginPage = true;
  bool showStartPage = true;

  void toggleScreens() {
    if (mounted) {
      setState(() {
        showLoginPage = !showLoginPage;
      });
    }
  }

  void showStarterPage() {
    if (mounted) {
      setState(() {
        showStartPage = !showStartPage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return StartPage(showRegisterPage: toggleScreens);
    } else {
      // Handle other cases here
      return LoginPage(showStartPage: showStarterPage);
    }
  }
}
