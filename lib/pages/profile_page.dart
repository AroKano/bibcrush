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
        appBar: AppBar(),
        body: ListView(
          children: [
            const SizedBox(height: 50),

            //profile pic
            const Icon(
              Icons.person,
              size: 72,
            ),

            //name
            RichText(
              text: TextSpan(
                //AUSKOMMENTIEREN:
                //currentUser.name!,
                text: 'Max',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),

                //Benutzername

                children: [
                  TextSpan(
                    //AUSKOMMENTIEREN:
                    //currentUser.username!,
                    text: '@MaxMusty',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
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
