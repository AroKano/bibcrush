import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white, // Weißer Hintergrund
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0, // Kein Schatten
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black), // Zurück-Pfeil
            onPressed: () {
              // Hier können Sie die Logik für das Zurückgehen implementieren
            },
          ),
          title: Text(
            'Anmelden',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Platz für das Logo (fügen Sie Ihr Logo hier ein)

              SizedBox(height: 20), // Platz zwischen Logo und Text Containern

              // Text Container für die E-Mail
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Grauer Rahmen
                  borderRadius: BorderRadius.circular(10.0), // Abgerundete Ecken
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Icon(Icons.mail, color: Colors.grey), // Graues Post Icon
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'E-Mail eingeben',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20), // Platz zwischen den Text Containern

              // Text Container für das Passwort
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Grauer Rahmen
                  borderRadius: BorderRadius.circular(10.0), // Abgerundete Ecken
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Icon(Icons.lock, color: Colors.grey), // Graues Schlüssel Icon
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          obscureText: true, // Passwort wird versteckt
                          decoration: InputDecoration(
                            hintText: 'Passwort eingeben',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20), // Platz zwischen den Text Containern und dem Button

              // Text "Passwort vergessen?" in Orange
              GestureDetector(
                onTap: () {
                  // Hier können Sie die Logik für das Vergessen des Passworts implementieren
                },
                child: Container(
                  width: double.infinity,
                  child: Text(
                    'Passwort vergessen?',
                    style: TextStyle(color: Color(0xFFFF7A00)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              SizedBox(height: 20), // Platz zwischen dem Text und dem Button

              // Button "Bestätigen" mit abgerundeten Ecken in FF7A00
              ElevatedButton(
                onPressed: () {
                  // Hier können Sie die Logik für die Bestätigung implementieren
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFFF7A00), // Orange Farbe
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Abgerundete Ecken
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    'Bestätigen',
                    style: TextStyle(color: Colors.white),
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
