import 'package:bibcrush/components/my_button.dart';
import 'package:bibcrush/components/my_textfield.dart';
import 'package:bibcrush/pages/start_page.dart';
import 'package:bibcrush/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'forgot_pw_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showStartPage;
  const LoginPage({Key? key, required this.showStartPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();



  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Anmeldung erfolgreich, navigiere zur Home-Seite und ersetze die aktuelle Seite
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(showStartPage: widget.showStartPage)),
      );

    } catch (e) {
      // Fehler bei der Anmeldung
      print("Anmeldungsfehler: $e");
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Anmeldung fehlgeschlagen: $e"),
          );
        },
      );
    }
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                // Navigate to LoginPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StartPage(showRegisterPage: widget.showStartPage),
                  ),
                );
              },

            ),
          ),
          title: const Text(
            'Anmeldung',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.mail, color: Colors.grey),
                      const SizedBox(width: 10),
                      Expanded(
                        child: MyTextField(
                            hintText: "E-Mail eingeben",
                            obscureText: false,
                            controller: _emailController
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.lock, color: Colors.grey),
                      const SizedBox(width: 10),
                      Expanded(
                        child: MyTextField(
                            hintText: 'Passwort eingeben',
                            obscureText: true,
                            controller: _passwordController
                        )
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
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

              const SizedBox(height: 20),

              MyButton(text: "Anmelden", onTap: signIn)
            ],
          ),
        ),
      ),
    );
  }
}
