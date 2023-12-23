import 'package:bibcrush/pages/home_page.dart';
import 'package:bibcrush/pages/start_page.dart';
import 'package:flutter/material.dart';
import '../components/custom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bibcrush/pages/home_page.dart';

//user
final currentUser = FirebaseAuth.instance.currentUser!;

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;

  bool _lightDarkModeEnabled = true;
  bool _notificationsEnabled = true;

  // <Future<void> _signOut() async {
  //   await FirebaseAuth.instance.signOut();

  //   // Navigiere zur Start-Seite FUNKTIONIERT NOCH NICHT
  //   // Navigator.pushReplacement(
  //   //   context,
  //   //   MaterialPageRoute(
  //   //       builder: (context) => const StartPage(
  //   //             showStartPage: widget.showRegisterPage,
  //   //           )),
  //   // );
  // }>

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> _changePassword(String password) async {
    //Pass in the password to updatePassword.
    currentUser.updatePassword(password).then((_) {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Column(
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text("Ausloggen"),
                onTap: () {
                  _signOut();
                },
              ),
            ),
          ],
        ),
      ),
//User profile UI
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),

          // profile pic
          const Icon(
            Icons.person,
            size: 72,
          ),

          // name
          RichText(
            text: TextSpan(
              text: 'Max',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              children: [
                TextSpan(
                  text: '@MaxMusty',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),

          // user caption
          Container(
            child: Text(
              'Photographer | Music enthusiast | Coffee lover | Lifelong learner',
              textAlign: TextAlign.center,
            ),
            margin: EdgeInsets.symmetric(horizontal: 80.0),
            padding: EdgeInsets.all(10.0),
          ),
          //edit button
          TextButton(
            onPressed: () {
              // Navigate to the edit profile screen or show a dialog
              _showEditProfileDialog(context);
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(8), // Set to 0 for a squared button
              )),
              side: MaterialStateProperty.all(BorderSide(
                color: Colors.grey, // Set the color of the outline
                width: 0.5, // Set the width of the outline
              )),
            ),
            child: Text(
              "Edit Profile",
              style: TextStyle(
                color: Colors.blue, // Set text color to blue
              ),
            ),
          ),
          SizedBox(height: 10),

          //user statistics
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey, width: 0.5),
                bottom: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatisticColumn("Posts", "0"),
                  _buildStatisticColumn("Followers", "0"),
                  _buildStatisticColumn("Following", "0"),
                  _buildStatisticColumn("Crushes", "0"),
                ],
              ),
            ),
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

Widget _buildStatisticColumn(String title, String value) {
  return Column(
    children: [
      Text(
        value,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 4),
      Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
    ],
  );
}

void _showEditProfileDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Edit Profile"),
        content: Column(
          children: [
            // Create form fields for editing name, username, and caption
            TextFormField(
              // Implement logic to update the name
              // initialValue: currentUser.name,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextFormField(
              // Implement logic to update the username
              // initialValue: currentUser.username,
              decoration: InputDecoration(labelText: "Benutzername"),
            ),
            TextFormField(
              // Implement logic to update the caption
              // initialValue: currentUser.caption,
              decoration: InputDecoration(labelText: "Beschreibung"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // Implement logic to save the edited profile information

              Navigator.of(context).pop();
            },
            child: Text("Save"),
          ),
        ],
      );
    },
  );
}
