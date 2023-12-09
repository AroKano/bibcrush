import 'package:flutter/material.dart';
import 'register_page.dart';
import 'login_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( //WIDGET: grundlegende app-einstellungen, designregeln für app
      debugShowCheckedModeBanner: false,
      home: Scaffold( //WIDGET: grundlayout der seite
        backgroundColor: Colors.white, // weißer hintergrund

        body: Padding( //WIDGET: abstand zwischen anderen widgets
          padding: const EdgeInsets.all(16.0),
          child: Column( //WIDGET: ordnet widgets vertikal an
            mainAxisAlignment: MainAxisAlignment.center, //widget zentriert anzeigen
            children: [
              Image.asset(
                'assets/bibcrush_logo_orange.png', // Der Pfad zu deinem Logo-Bild in deinem Projekt
                width: 100, // Passe die Breite nach Bedarf an
                height: 100, // Passe die Höhe nach Bedarf an
              ),

              const SizedBox(height: 20), // WIDGET: abstand zwischen logo und button(widgets)

              ElevatedButton(
                onPressed: () {
                  // Navigiere zur Login-Seite
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7A00), // orange farbe
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // abgerundete ecken
                  ),
                ),
                child: GestureDetector(
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Text(
                      'Anmelden',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20), // abstand zwischen button und textfeld

              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: TextButton( //WIDGET: textschaltfläche, benutzerinteraktion
                  onPressed: () {
                    // Navigiere zur Registrierungsseite
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegistrationPage()),
                    );
                  },
                  child: const Text(
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
