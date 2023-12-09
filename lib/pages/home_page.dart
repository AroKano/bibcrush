import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'custom_nav_bar.dart';
import 'start_page.dart'; // Importiere die Start-Seite

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final user = FirebaseAuth.instance.currentUser!;

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();

    // Navigiere zur Start-Seite
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const StartPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Eingeloggt als ${user.email!}'),
            ElevatedButton(
              onPressed: _signOut,
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
                  'Ausloggen',
                  style: TextStyle(color: Colors.white),
                ),
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
