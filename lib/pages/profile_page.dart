import 'package:flutter/material.dart';
import '../components/custom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

//user
final user = FirebaseAuth.instance.currentUser!;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                    // currentUser.username!,
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

// @override
// Widget build(BuildContext context) {
//   int _selectedIndex = 0;

//   return Scaffold(
//     bottomNavigationBar: CustomNavBar(
//       selectedIndex: _selectedIndex,
//       onTabChange: (index) {
//         setState(() {
//           _selectedIndex = index;
//         });
//       },
//     ),
//   );
// }
