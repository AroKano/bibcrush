import 'package:bibcrush/pages/start_page.dart';
import 'package:bibcrush/pages/home_page.dart'; // Importiere die Home-Seite
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'forgot_pw_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> confirm() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Anmeldung erfolgreich, navigiere zur Home-Seite
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()), // Hier wird die Home-Seite aufgerufen
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StartPage()),
              );
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
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
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
              ElevatedButton(
                onPressed: confirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7A00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: const Text(
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
