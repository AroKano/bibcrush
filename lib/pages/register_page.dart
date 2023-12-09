import 'package:bibcrush/components/my_button.dart';
import 'package:bibcrush/components/my_textfield.dart';
import 'package:bibcrush/pages/login_page.dart';
import 'package:bibcrush/pages/start_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bibcrush/helper/helper_functions.dart';

class RegistrationPage extends StatefulWidget {

  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPage();
}

  class _RegistrationPage extends State<RegistrationPage> {

    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPwController = TextEditingController();

    void registerUser()  async {
      // loading circle
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );// Center

      // make sure passwords match
      if (_passwordController.text != _confirmPwController.text) {
        // pop loading circle
        Navigator.pop(context);

        // show error message to user
        displayMessageToUser("Passwords don't match", context);
      }

      // try creating the user
      try {
        // create the user
        UserCredential? userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // pop loading circle
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // pop loading circle
        Navigator.pop(context);
        // display error message to user
        displayMessageToUser(e.code, context);
      }
    }

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
                    onTap: () {    // Navigiere zur Login-Seite
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const StartPage()),
                      );},
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

