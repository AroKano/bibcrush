import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'forgot_pw_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});


  @override
  State<LoginPage> createState() => _LoginPageState();
}

  class _LoginPageState extends State<LoginPage> {
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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white, // Weißer Hintergrund
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0, // Kein Schatten
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black), // Zurück-Pfeil
            onPressed: () {
              // Hier können Sie die Logik für das Zurückgehen implementieren
            },
          ),
          title: const Text(
            'Anmelden',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Platz für das Logo (fügen Sie Ihr Logo hier ein)

              const SizedBox(height: 20), // Platz zwischen Logo und Text Containerns

              // Text Container für die E-Mail
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Grauer Rahmen
                  borderRadius: BorderRadius.circular(10.0), // Abgerundete Ecken
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.mail, color: Colors.grey), // Graues Post Icon
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: 'E-Mail eingeben',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20), // Platz zwischen den Text Containern

              // Text Container für das Passwort
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Grauer Rahmen
                  borderRadius: BorderRadius.circular(10.0), // Abgerundete Ecken
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.lock, color: Colors.grey), // Graues Schlüssel Icon
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true, // Passwort wird versteckt
                          decoration: const InputDecoration(
                            hintText: 'Passwort eingeben',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20), // Platz zwischen den Text Containern und dem Button

              // Text "Passwort vergessen?" in Orange
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const ForgotPasswordPage();
                        },
                      ),
                  );
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Passwort vergessen?',
                    style: TextStyle(color: Color(0xFFFF7A00)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              const SizedBox(height: 20), // Platz zwischen dem Text und dem Button

              // Button "Bestätigen" mit abgerundeten Ecken in FF7A00
              ElevatedButton(
                onPressed: () {
                  // Hier können Sie die Logik für die Bestätigung implementieren
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7A00), // Orange Farbe
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Abgerundete Ecken
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
