import 'package:flutter/material.dart'; //import von packages

//Main Funktion, ruft runApp Funktion auf, übergibt MyApp als Hauptwidget
void main() {
  runApp(MyApp());
}
//Klasse definiert, erbt von StatelessWidget ok
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( //MyApp gint MaterialApp zurück, hat als ahuptwidget die LoginPage
      home: LoginPage(),
    );
  }
}
//StatefulWidget (zustand derseite kann sich ändern)
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState(); //erstellt zugehöriges state-objekt, verwaltet zustand der seite
}
//zustand für loginPage wird definiert
class _LoginPageState extends State<LoginPage> {
  bool isAnmeldenTab = true; //damit kann man den ausgewählten tab verfolgen

  //build methode, erstellt ui der seite
  @override
  Widget build(BuildContext context) {
    return Scaffold( //grundgerüst???
      appBar: AppBar( //app leiste
        title: const
        Text(
          'BibCrush', //titel code card
          style: TextStyle(color: Colors.black), //weisser text
        ),
        backgroundColor: Colors.white, //hintergrundfarbe
        elevation: 0,
      ),
      body: Container( //body container, hauptinhalt der seite
        color: Colors.white, //hintergrundfarbe
        padding: const EdgeInsets.all(16.0), //abstand zwischen ui elementen
        child: Column( //widget wird verwendet um widgets vertikal anzuordnen
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row( //buttons für anmelden und registrieren
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildTabButton('Anmelden', true),
                buildTabButton('Registrieren', false),
              ],
            ),
            const SizedBox(height: 20),
            TextField( //textfeld für email
              style: const TextStyle(color: Colors.grey), // Textfarbe weiß setzen
              decoration: InputDecoration(
                labelText: 'E-mail Adresse',
                prefixIcon: const Icon(Icons.mail, color: Colors.grey),
                labelStyle: const TextStyle(color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField( //textfeld für passwort
              style: const TextStyle(color: Colors.grey), // Textfarbe weiß setzen
              decoration: InputDecoration(
                labelText: 'Passwort',
                prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                labelStyle: const TextStyle(color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              obscureText: true, //passwort verbergen
            ),
            const SizedBox(height: 20),
            ElevatedButton( //erhebener button für bestätigung
              onPressed: () { //
                // ANMELDELOGIK FEHLT!!! FIREBASE!!!
                print('Bestätigen erfolgreich');
              },
              style: ElevatedButton.styleFrom( //button stil
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: const Color(0xFFFF7A00), //farbe
              ),
              child: const SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Bestätigen',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTabButton(String text, bool isSelected) { //funktion für tab buttons
    return ElevatedButton( //tab wird hervorgehoben
      onPressed: () {
        setState(() {
          isAnmeldenTab = isSelected;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor : isSelected ? const Color(0xFFFF7A00) : const Color(0xFFFF7A00),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.white,
        ),
      ),
    );
  }
}
