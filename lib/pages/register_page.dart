import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white, // weißer hintergrund
        appBar: AppBar( //WIDGET: app leiste oben
          backgroundColor: Colors.white,
          elevation: 0, // kein schatten
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black), // zurück-pfeil
            onPressed: () {
              // zurückgehen logik!!!
            },
          ),
          title: Text(
            'Registrieren',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // text container für den vorname
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // grauer rahmen
                  borderRadius:
                      BorderRadius.circular(10.0), // abgerundete ecken
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Vorname',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20), // platz zwischen den text containern

              // text container für den nachname
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // grauer rahmen
                  borderRadius:
                      BorderRadius.circular(10.0), // abgerundete ecken
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Nachname',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20), // platz zwischen den text containern

              // text container für den benutzernamen
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // grauer rahmen
                  borderRadius:
                      BorderRadius.circular(10.0), // abgerundete ecken
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Benutzername',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20), 

              // text container für die e-mail
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), 
                  borderRadius:
                      BorderRadius.circular(10.0), 
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'E-Mail Adresse',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20), 

              // text container für das passwort
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), 
                  borderRadius:
                      BorderRadius.circular(10.0), 
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Passwort',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                  height:
                      20), 
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), 
                  borderRadius:
                      BorderRadius.circular(10.0), 
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          obscureText: true, 
                          decoration: InputDecoration(
                            hintText: 'Passwort bestätigen',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                  height:
                      20), 

              // text "Du hast bereits ein Konto? Anmelden." in orange
              GestureDetector(
                onTap: () {
                  // logik für auf anmeldeseite gehen fehlt!!!
                },
                child: Container(
                  width: double.infinity,
                  child: Text(
                    'Du hast bereits ein Konto? Anmelden.',
                    style: TextStyle(color: Color(0xFFFF7A00)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              SizedBox(height: 20), 

              // button "Bestätigen" mit abgerundeten ecken
              ElevatedButton(
                onPressed: () {
                  // logik für bestätigung fehlt!!!
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF7A00), // orange farbe
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // abgerundete ecken
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
