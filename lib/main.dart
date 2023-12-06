import 'package:bibcrush/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:bibcrush/pages/home_screen.dart';
import 'package:bibcrush/pages/opening_page.dart';
import 'package:bibcrush/pages/start_page.dart';
import 'package:bibcrush/pages/login_page.dart';
import 'package:bibcrush/pages/register_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegistrationPage(),
    );
  }
}
