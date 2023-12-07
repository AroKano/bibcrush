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
        backgroundColor: Colors.white, // weißer hintergrund
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0, // Kein Schatten
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black), // zurück-pfeil
            onPressed: () {
              // logik für zurückgehen
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
              // platz für logo

              const SizedBox(height: 20), // platz zwischen logo und container

              // text container für die e-mail
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // grauer rahmen
                  borderRadius: BorderRadius.circular(10.0), // abgerundete ecken
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.mail, color: Colors.grey), // graues post icon
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

              const SizedBox(height: 20), // platz zwischen text containern

              // Text Container für das Passwort
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // grauer rahmen
                  borderRadius: BorderRadius.circular(10.0), // abgerundete ecken
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.lock, color: Colors.grey), // graues schlüssel icon
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true, // passwort wird versteckt
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

              const SizedBox(height: 20), // platz zwischen den text containern und dem button

              // text "Passwort vergessen?" in orange
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

              const SizedBox(height: 20), // platz zwischen dem text und dem button

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
