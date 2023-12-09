import 'package:bibcrush/pages/login_page.dart';
import 'package:bibcrush/pages/start_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPage();
}


  class _RegistrationPage extends State<RegistrationPage> {

  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future confirm() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim()
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white, // weißer hintergrund
        appBar: AppBar( //WIDGET: app leiste oben
          backgroundColor: Colors.white,
          elevation: 0, // kein schatten
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black), // zurück-pfeil
            onPressed: () {
              // Navigiere zur Login-Seite
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StartPage()),
              );
            },
          ),
          title: const Text(
            'Registrieren',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
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
                child: const Padding(
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

              const SizedBox(height: 20), // platz zwischen den text containern

              // text container für den nachname
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // grauer rahmen
                  borderRadius:
                      BorderRadius.circular(10.0), // abgerundete ecken
                ),
                child: const Padding(
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

              const SizedBox(height: 20), // platz zwischen den text containern

              // text container für den benutzernamen
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // grauer rahmen
                  borderRadius:
                      BorderRadius.circular(10.0), // abgerundete ecken
                ),
                child: const Padding(
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

              const SizedBox(height: 20),

              // text container für die e-mail
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius:
                      BorderRadius.circular(10.0),
                ),
                child: const Padding(
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

              const SizedBox(height: 20),

              // text container für das passwort
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius:
                      BorderRadius.circular(10.0),
                ),
                child: const Padding(
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

              const SizedBox(
                  height:
                      20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius:
                      BorderRadius.circular(10.0),
                ),
                child: const Padding(
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

              const SizedBox(
                  height:
                      20),

              // text "Du hast bereits ein Konto? Anmelden." in orange
              GestureDetector(
                onTap: () {
                  // Navigiere zur Login-Seite
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Du hast bereits ein Konto? Anmelden.',
                    style: TextStyle(color: Color(0xFFFF7A00)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // button "Bestätigen" mit abgerundeten ecken
              ElevatedButton(
                onPressed: () {
                  // logik für bestätigung
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7A00), // orange farbe
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // abgerundete ecken
                  ),
                ),
                child: GestureDetector(
                  onTap: confirm,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Text(
                      'Bestätigen',
                      style: TextStyle(color: Colors.white),
                    ),
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

