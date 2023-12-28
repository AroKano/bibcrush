import 'package:bibcrush/components/my_button.dart';
import 'package:bibcrush/components/my_textfield.dart';
import 'package:bibcrush/pages/home_page.dart';
import 'package:bibcrush/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final _usernameController = TextEditingController();
  final _fakultaetController = TextEditingController();
  final _studiengangController = TextEditingController();
  final _semesterController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  String vornameError = "";
  String usernameError = "";
  String fakultaetError = "";
  String studiengangError = "";
  String semesterError = "";
  String emailError = "";
  String passwordError = "";
  String confirmPasswordError = "";


  @override
  void dispose() {
    _vornameController.dispose();
    _usernameController.dispose();
    _fakultaetController.dispose();
    _studiengangController.dispose();
    _semesterController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    // Clear previous error messages
    setState(() {
      vornameError = "";
      usernameError = "";
      fakultaetError = "";
      studiengangError = "";
      semesterError = "";
      emailError = "";
      passwordError = "";
      confirmPasswordError = "";
    });

    if (_vornameController.text.trim().isEmpty) {
      setState(() {
        vornameError = "Vorname ist erforderlich";
      });
      showSnackBar("Vorname ist erforderlich");
      return;
    }

    if (_usernameController.text.trim().isEmpty) {
      setState(() {
        usernameError = "Benutzername ist erforderlich";
      });
      showSnackBar("Benutzername ist erforderlich");
      return;
    }

    if (_fakultaetController.text.trim().isEmpty) {
      setState(() {
        fakultaetError = "Fakultät ist erforderlich";
      });
      showSnackBar("Fakultät is ist erforderlich");
      return;
    }

    if (_studiengangController.text.trim().isEmpty) {
      setState(() {
        studiengangError = "Studiengang ist erforderlich";
      });
      showSnackBar("Studiengang is ist erforderlich");
      return;
    }

    if (_semesterController.text.trim().isEmpty) {
      setState(() {
        semesterError = "Semester ist erforderlich";
      });
      showSnackBar("Semester is ist erforderlich");
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


    // create user
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // add user details
      addUserDetails(
        _vornameController.text.trim(),
        _usernameController.text.trim(),
        _fakultaetController.text.trim(),
        _studiengangController.text.trim(),
        int.parse(_semesterController.text.trim()),
        _emailController.text.trim(),
      );

      // Registration successful, navigate to HomePage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      // Handle registration error
      showSnackBar("Registrierung fehlgeschlagen: $e");
    }
  }

  Future addUserDetails(
      String vorname, String username, String fakultaet, String studiengang, int semester, String email) async {
    await FirebaseFirestore.instance.collection("users").add({
      "Vorname": vorname,
      "Benutzername": username,
      "Fakultät": fakultaet,
      "Studiengang": studiengang,
      "Semester": semester,
      "E-Mail": email,
    });
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
                            controller: _vornameController,
                            decoration: InputDecoration(
                              hintText: 'Vorname',
                            ),
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
                          child: MyTextField(
                            controller: _usernameController,
                            hintText: "Benutzername",
                            obscureText: false,
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
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Fakultät',
                            ),
                            controller: _fakultaetController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Text(
                  fakultaetError,
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
                              hintText: 'Studiengang',
                            ),
                            controller: _studiengangController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Add this Text widget below the TextField
                Text(
                  studiengangError,
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
                              hintText: 'Semester',
                            ),
                            controller: _semesterController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Add this Text widget below the TextField
                Text(
                  semesterError,
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
                          MaterialPageRoute(builder: (context) => LoginPage(showStartPage: () {  },)),
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
