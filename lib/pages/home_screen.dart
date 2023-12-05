import 'package:flutter/material.dart';
import 'custom_nav_bar.dart';
import 'create_post.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Text(
          'Welcome to the Home Screen!',
          style: TextStyle(fontSize: 18),
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
