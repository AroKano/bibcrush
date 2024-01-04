/* 
FileName: opening_page.dart
Authors: Yudum Yilmaz(UI),
Last Modified on: 04.01.2024
Description: SplashScreen with gradient.
*/

import 'package:flutter/material.dart';

class OpeningPageBuilder {
  static Widget build() {
    return OpeningPage();
  }
}

class OpeningPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFF7A00), Color(0xFFFFE500)],
            ),
          ),
        ),
      ),
    );
  }
}
