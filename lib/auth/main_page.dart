import 'package:bibcrush/auth/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/home_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // User is logged in, show HomePage
            return HomePage();
            // Navigate to StartPage or handle as neede);
          } else {
            // User is not logged in, show AuthPage
            return AuthPage();
          }
        },
      ),
    );
  }
}
