import 'package:flutter/material.dart';
import 'custom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

//user
final user = FirebaseAuth.instance.currentUser!;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;

  bool _selected = false;
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      endDrawer: Drawer(
          child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.sunny),
            title: Text("Light/Dark Mode"),
            trailing: Switch(
              onChanged: (bool? value) {
                // This is called when the user toggles the switch.
                setState(() {
                  _enabled = value!;
                });
              },
              value: _enabled,
            ),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Benachrichtigungen"),
            trailing: Switch(
              onChanged: (bool? value) {
                // This is called when the user toggles the switch.
                setState(() {
                  _enabled = value!;
                });
              },
              value: _enabled,
            ),
          ),
          ListTile(
            leading: Icon(Icons.key),
            title: Text("Passwort ändern"),
            onTap: () {},
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text("Log out"),
                onTap: () {},
              ),
            ),
          ),
        ],
      )),

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
            textAlign: TextAlign.center,
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
          Container(
            child: Text(
              //AUSKOMMENTIEREN:
              //currentUser.caption!,
              'Photographer | Music enthusiast | Coffee lover | Lifelong learner',
              textAlign: TextAlign.center,
            ),
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 80.0),
            padding: EdgeInsets.all(10.0),
          ),
        ],
      ),
      //untere Leiste
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
