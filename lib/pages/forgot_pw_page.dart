import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({ super.key });

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
           return AlertDialog(
             content: Text(e.message.toString()),
        );
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Weißer Hintergrund
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Kein Schatten
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Zurück-Pfeil
          onPressed: () {
            Navigator.pop(context); // Close the current screen
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
              'Enter Your Email and we will send you a password reset link',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),

          const SizedBox(height: 20), // Platz zwischen dem Text und dem Button

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

          const SizedBox(height: 20), // Platz zwischen dem Text und dem Button

          MaterialButton(
            onPressed: passwordReset,
            color: const Color(0xFFFF7A00),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Text(
              'Reset Password',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
