//import 'package:firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //user (folgende Zeile muss AUSKOMMENTIEREN werden)
  //final currentuser = FirebaseAuth.instance.currentuser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Profile"),
          backgroundColor: const Color(0xFFFF7A00),
        ),
        body: ListView(
          children: [
            const SizedBox(height: 50),

            //profile pic
            const Icon(
              Icons.person,
              size: 72,
            ),
            //user caption
            Text(
              //AUSKOMMENTIEREN:
              //currentUser.caption!,
              'Photographer | Music enthusiast | Coffee lover | Lifelong learner',
              textAlign: TextAlign.center,
            ),
          ],
        ));
  }
}
