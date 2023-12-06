import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( //WIDGET: grundeinstellungen, designregeln für app
      home: Scaffold( //grundlayout der seite
        backgroundColor: Colors.white, // weißer hintergrund
        
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // platz für das logo

              SizedBox(height: 20), // platz zwischen logo und button

              ElevatedButton(
                onPressed: () {
                  // anmeldelogik
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFFF7A00), // orange farbe
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // abgerundete ecken
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    'Anmelden',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: 20), // platz zwischen button und textfeld

              // textfeld für "Kein Konto? Registrieren."
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    // registrierlogik
                  },
                  child: Text(
                    'Kein Konto? Hier registrieren!',
                    style: TextStyle(color: Color(0xFFFF7A00)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
