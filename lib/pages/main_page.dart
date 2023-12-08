import 'package:bibcrush/pages/profile_page.dart';
import 'package:bibcrush/pages/register_page.dart';
import 'package:bibcrush/pages/start_page.dart';

import 'home_page.dart';
import 'login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'opening_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData) {
            return HomePage();
          } else {
            return StartPage();
          }
        },
      ),
    );
  }
}
