import 'package:bibcrush/components/my_button.dart';
import 'package:bibcrush/components/my_textfield.dart';
import 'package:bibcrush/pages/login_page.dart';
import 'package:bibcrush/pages/start_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bibcrush/helper/helper_functions.dart';

class RegistrationPage extends StatefulWidget {

  final VoidCallback showLoginPage;
  const RegistrationPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPage();
}

  class _RegistrationPage extends State<RegistrationPage> {

    final  _usernameController = TextEditingController();
    final  _emailController = TextEditingController();
    final  _passwordController = TextEditingController();
    final  _confirmPwController = TextEditingController();


    Future confirm() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim()
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white, // weißer hintergrund
        appBar: AppBar( //WIDGET: app leiste oben
          backgroundColor: Colors.white,
          elevation: 0, // kein schatten
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
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Expanded(
                        child: MyTextField(
                            hintText: "Benutzername",
                            obscureText: false,
                            controller: _usernameController
                        )
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
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Expanded(
                        child: MyTextField(
                            hintText: "E-Mail",
                            obscureText: false,
                            controller: _emailController,
                        )
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
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Expanded(
                        child: MyTextField(
                            hintText: "Passwort",
                            obscureText: true,
                            controller: _passwordController,
                        )
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // text container für das passwort bestätigen
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Expanded(
                        child: MyTextField(
                            hintText: "Passwort bestätigen",
                            obscureText: true,
                            controller: _confirmPwController,
                        )
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // text "Du hast bereits ein Konto? Anmelden." in orange
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Du hast bereits ein Konto? ",
                    style: TextStyle(color: Color(0xFFFF7A00)),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to LoginPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage(showStartPage: widget.showLoginPage,)),
                      );
                    },
                    child: const Text(
                      "Anmelden",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF7A00),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // button "Bestätigen" mit abgerundeten ecken
              MyButton(text: "Bestätigung", onTap: confirm)
            ],
          ),
        ),
      ),
    );
  }
}

