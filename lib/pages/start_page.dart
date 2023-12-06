import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( //WIDGET: grundlegende app-einstellungen, designregeln für app
      home: Scaffold( //WIDGET: grundlayout der seite
        backgroundColor: Colors.white, // weißer hintergrund

        body: Padding( //WIDGET: abstand zwischen anderen widgets
          padding: EdgeInsets.all(16.0),
          child: Column( //WIDGET: ordnet widgets vertikal an
            mainAxisAlignment: MainAxisAlignment.center, //widget zentriert anzeigen
            children: [
              // hier logo einfügen??? code fehlt

              SizedBox(height: 20), // WIDGET: abstand zwischen logo und button(widgets)

              ElevatedButton( //WIDGET: erhöhte schaltfläche
                onPressed: () {
                  // anmeldelogik fehlt!!! firebase!!!
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF7A00), // orange farbe für button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // abgerundete ecken
                  ),
                ),
                child: Container( //WIDGET: anordnung von widgets, container für anmelden
                  width: double.infinity, //breite
                  alignment: Alignment.center, //ausrichtung
                  child: Text( //WIDGET: zeigt statischen text an
                    'Anmelden',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: 20), // abstand zwischen button und textfeld

              // textfeld für "Kein Konto? Registrieren."
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: TextButton( //WIDGET: textschaltfläche, benutzerinteraktion
                  onPressed: () {
                    // registrierlogik fehlt!!!
                  },
                  child: Text( 
                    'Kein Konto? Hier registrieren!',
                    style: TextStyle(color: Color(0xFFFF7A00)), //textfarbe
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
