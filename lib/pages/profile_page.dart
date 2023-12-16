import 'package:bibcrush/pages/home_page.dart';
import 'package:bibcrush/pages/start_page.dart';
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
  int _selectedIndex = 0;

  bool _lightDarkModeEnabled = true;
  bool _notificationsEnabled = true;

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();

    // Navigiere zur Start-Seite
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const StartPage()),
    );
  }

  Future<void> _changePassword(String password) async {
    //Pass in the password to updatePassword.
    user.updatePassword(password).then((_) {
      print("Successfully changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }

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
                  setState(() {
                    _lightDarkModeEnabled = value!;
                  });
                },
                value: _lightDarkModeEnabled,
                activeTrackColor: Colors.orange,
                activeColor: Colors.white,
              ),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text(
                "Benachrichtigungen",
                style: TextStyle(fontSize: 15.0),
              ),
              trailing: Switch(
                onChanged: (bool? value) {
                  setState(() {
                    _notificationsEnabled = value!;
                  });
                },
                value: _notificationsEnabled,
                activeTrackColor: Colors.orange,
                activeColor: Colors.white,
              ),
            ),
            ListTile(
              leading: Icon(Icons.key),
              title: Text("Passwort ändern"),
              onTap: () {
                //PASSWORT LOGIK EINSETZEN ALSO STRING IN FOLGENDE METHODE REIN
                // _changePassword();
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Ausloggen"),
              onTap: () {
                _signOut();
              },
            ),
          ],
        ),
      ),

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

          // RichText(
          //     text: TextSpan(
          //   text: 'hello',
          //   style: TextStyle(
          //     color: Colors.black,
          //     fontWeight: FontWeight.bold,
          //     fontSize: 24,
          //   ),
          // )),
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
