import 'package:bibcrush/components/my_button.dart';
import 'package:flutter/material.dart';
import 'register_page.dart';
import 'login_page.dart';

class StartPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const StartPage({Key? key, required this.showRegisterPage, required }) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/bibcrush_logo_orange.png',
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 20),
              MyButton(
                text: 'Login',
                onTap: () {
                  // Navigate to LoginPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage(showStartPage: widget.showRegisterPage,)),
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Kein Konto? ",
                    style: TextStyle(color: Color(0xFFFF7A00)),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to LoginPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegistrationPage(showLoginPage: widget.showRegisterPage,)),
                      );
                    },
                    child: const Text(
                      "Hier registrieren!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF7A00),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
