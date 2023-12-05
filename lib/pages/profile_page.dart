import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  //current logged in user

  //future to fetch user details

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text("Profile"),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      elevation: 0,
    ));
  }
}
