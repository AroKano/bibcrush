import 'package:flutter/material.dart';

//klasse für aufbau der startseite
class OpeningPageBuilder {
  static Widget build() { //statische methode zum erstellen der seite
    return OpeningPage();
  }
}

//hauptklasse für startseite
class OpeningPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( //WIDGET: grundlegende app-einstellungen + designregeln
      home: Scaffold( //WIDGET: grundlegendes layout (z.b. app bar, navigation)
        body: Container( //WIDGET: "rahmen" um andere widgets anzuordnen (hier gradient)
          decoration: BoxDecoration( //hintergrund mit gradient
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
