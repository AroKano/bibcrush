import 'package:bibcrush/components/my_button.dart';
import 'package:bibcrush/components/my_textfield.dart';
import 'package:bibcrush/pages/home_page.dart';
import 'package:bibcrush/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegistrationPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _vornameController = TextEditingController();
  final _nachnameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  String usernameError = "";
  String emailError = "";
  String passwordError = "";
  String confirmPasswordError = "";
  String vornameError = "";
  String nachnameError = "";

  @override
  void dispose() {
    _vornameController.dispose();
    _nachnameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    // Clear previous error messages
    setState(() {
      usernameError = "";
      emailError = "";
      passwordError = "";
      confirmPasswordError = "";
      vornameError = "";
      nachnameError = "";
    });

    if (_vornameController.text.trim().isEmpty) {
      setState(() {
        vornameError = "Vorname ist erforderlich";
      });
      showSnackBar("Vorname ist erforderlich");
      return;
    }

    if (_nachnameController.text.trim().isEmpty) {
      setState(() {
        nachnameError = "Nachname ist erforderlich";
      });
      showSnackBar("Nachname is ist erforderlich");
      return;
    }

    if (_usernameController.text.trim().isEmpty) {
      setState(() {
        usernameError = "Benutzername ist erforderlich";
      });
      showSnackBar("Benutzername ist erforderlich");
      return;
    }

    if (_emailController.text.trim().isEmpty) {
      setState(() {
        emailError = "E-Mail Adresse ist erforderlich";
      });
      showSnackBar("E-Mail Adresse ist erforderlich");
      return;
    }

    if (_passwordController.text.trim().isEmpty) {
      setState(() {
        passwordError = "Passwort ist erforderlich";
      });
      showSnackBar("Passwort ist erforderlich");
      return;
    }

    if (!passwordConfirmed()) {
      // Handle password not confirmed error
      showSnackBar("Passwörter stimmen nicht überein");
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Registration successful, navigate to HomePage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage(showStartPage: widget.showLoginPage)),
      );
    } catch (e) {
      // Handle registration error
      showSnackBar("Registrierung fehlgeschlagen: $e");
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() != _confirmpasswordController.text.trim()) {
      setState(() {
        confirmPasswordError = "Passwörter stimmen nicht überein";
      });
      return false;
    }
    return true;
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
          title: const Text(
            'Registrieren',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Vorname',
                            ),
                            controller: _vornameController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Add this Text widget below the TextField
                Text(
                  vornameError,
                  style: TextStyle(color: Colors.red), // Customize the text color
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
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Nachname',
                            ),
                            controller: _nachnameController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Add this Text widget below the TextField
                Text(
                  nachnameError,
                  style: TextStyle(color: Colors.red), // Customize the text color
                ),

                // Your existing UI code...

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
                        const SizedBox(width: 10),
                        Expanded(
                          child: MyTextField(
                            hintText: "Benutzername",
                            obscureText: false,
                            controller: _usernameController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Add this Text widget below the TextField
                Text(
                  usernameError,
                  style: TextStyle(color: Colors.red), // Customize the text color
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
                        const SizedBox(width: 10),
                        Expanded(
                          child: MyTextField(
                            hintText: "E-Mail",
                            obscureText: false,
                            controller: _emailController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Add this Text widget below the TextField
                Text(
                  emailError,
                  style: TextStyle(color: Colors.red), // Customize the text color
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
                        const SizedBox(width: 10),
                        Expanded(
                          child: MyTextField(
                            hintText: "Passwort",
                            obscureText: true,
                            controller: _passwordController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Add this Text widget below the TextField
                Text(
                  passwordError,
                  style: TextStyle(color: Colors.red), // Customize the text color
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
                        const SizedBox(width: 10),
                        Expanded(
                          child: MyTextField(
                            hintText: "Passwort bestätigen",
                            obscureText: true,
                            controller: _confirmpasswordController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Add this Text widget below the TextField
                Text(
                  confirmPasswordError,
                  style: TextStyle(color: Colors.red), // Customize the text color
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Du hast bereits ein Konto? ",
                      style: TextStyle(color: Color(0xFFFF7A00)),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage(showStartPage: widget.showLoginPage)),
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

                MyButton(text: "Registrieren", onTap: signUp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
