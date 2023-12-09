import 'package:bibcrush/components/my_button.dart';
import 'package:bibcrush/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  Future<void> passwordReset() async {
    try {
      await FirebaseAuth.instance.signOut(); // Log out the current user

      var methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(_emailController.text.trim());

      if (methods.isEmpty) {
        // No user found with this email address
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("No user found with this email address."),
            );
          },
        );
      } else {
        // Email found, send the password reset email
        await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());

        // Show success dialog
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("Password reset email sent successfully!"),
            );
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      print("Password reset failed: ${e.code} - ${e.message}");
      String errorMessage = "You did not enter an email.";

      if (e.code == 'user-not-found') {
        errorMessage = "No user found with this email address.";
      }

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Password reset failed: $errorMessage"),
          );
        },
      );
    } catch (e) {
      print("Unexpected error: $e");
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("An unexpected error occurred."),
          );
        },
      );
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Geben Sie Ihre E-Mail-Adresse ein und wir senden Ihnen einen Link zum Zurücksetzen des Passworts',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
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
                  const Icon(Icons.mail, color: Colors.grey),
                  const SizedBox(width: 10),
                  Expanded(
                    child: MyTextField(hintText: "E-Mail eingeben", obscureText: false, controller: _emailController)
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          MyButton(text: "Bestätigung", onTap: passwordReset)
        ],
      ),
    );
  }
}
