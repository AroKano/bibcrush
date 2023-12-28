import 'package:bibcrush/components/my_button.dart';
import 'package:bibcrush/pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/custom_nav_bar.dart';
import 'start_page.dart'; // Importiere die Start-Seite

class HomePage extends StatefulWidget {
  final VoidCallback showStartPage;
  HomePage({Key? key, required this.showStartPage}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final user = FirebaseAuth.instance.currentUser!;

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();

    // Navigiere zur Start-Seite
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StartPage(showRegisterPage: widget.showStartPage),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        leading: IconButton(
          icon: const Icon(Icons.person, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Eingeloggt als ${user.email!}'),

            const SizedBox(height: 20), // Platz zwischen den Textcontainern

            Container(
              padding: EdgeInsets.all(16), // Hier das Padding auf 16 setzen
              child: MyButton(
                text: "Ausloggen",
                onTap: _signOut,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}