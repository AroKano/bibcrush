import 'package:flutter/material.dart';
import 'custom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: const Text('Homepage'),
//     ),
//     body: Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text('signed in as ${user.email!}'),
//           MaterialButton(
//             onPressed: () {
//               FirebaseAuth.instance.signOut();
//             },
//             color: Colors.deepPurple[200],
//             child: const Text('sign out'),
//           )
//         ],
//       ),
//     ),
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
