import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'custom_nav_bar.dart';
import 'create_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('signed in as ${user.email!}'),
            MaterialButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
              color: Colors.deepPurple[200],
              child: const Text('sign out'),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });

          // Handle additional logic based on tab changes, if needed
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreatePost(
                  onPostCreated: () {
                    // Refresh the Home Screen or perform any other actions
                    print('Post created! Refreshing...');
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
