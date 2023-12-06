import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( //WIDGET
      home: Scaffold( //WIDGET
        backgroundColor: Colors.white, // weißer hintergrund
        appBar: AppBar( //WIDGET: 1. app leiste oben 2. pfeil
          backgroundColor: Colors.white,
          elevation: 0, // kein Schatten
          leading: IconButton( //WIDGET: (attribut)
            icon: Icon(Icons.arrow_back, color: Colors.black), // zurück-pfeil links
            onPressed: () {
              // logik für zurückgehen fehlt!!!
            },
          ),
          title: Text( //WIDGET: für text oben
            'Anmelden',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding( //WIDGET: polsterung um inhalt
          padding: EdgeInsets.all(16.0),
          child: Column( //WIDGET
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // logo code einfügen!!!

              SizedBox(height: 20), // WIDGET: platz zwischen logo und text containern

              // text container für die e-mail
              Container( 
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // grauer rahmen
                  borderRadius: BorderRadius.circular(10.0), // abgerundete ecken
                ),
                child: Padding( //WIDGET
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row( //reihe
                    children: [
                      Icon(Icons.mail, color: Colors.grey), // WIDGET: graues post icon
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField( //WIDGET: eingabe von text
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

              SizedBox(height: 20), //WIDGET: platz zwischen text containern

              // text container für passwort
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // grauer rahmen
                  borderRadius: BorderRadius.circular(10.0), // abgerundete ecken
                ),
                child: Padding( //WIDGET
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row( //reihe
                    children: [
                      Icon(Icons.lock, color: Colors.grey), // WIDGET: graues schlüssel icon
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          obscureText: true, // passwort verstecken
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

              SizedBox(height: 20), // widget: platz zwischen den text containern und dem button

              // text "Passwort vergessen?" in orange
              GestureDetector( //WIDGET und klasse, benutzerinteraktion
                onTap: () {
                  // logik für passwort einfügen!!!
                },
                child: Container(
                  width: double.infinity,
                  child: Text( //widget statischer text
                    'Passwort vergessen?',
                    style: TextStyle(color: Color(0xFFFF7A00)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              SizedBox(height: 20), // platz zwischen dem text und dem button

              // button "Bestätigen" mit abgerundeten ecken
              ElevatedButton( //widget
                onPressed: () {
                  // logik für bestätigung
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF7A00), // orange farbe
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // abgerundete ecken
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
