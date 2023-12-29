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

  String _name = 'Max';
  String _username = '@MaxMusty';
  String _caption =
      'Photographer | Music enthusiast | Coffee lover | Lifelong learner';
  String _posts = '0';
  String _followers = '0';
  String _following = '0';
  String _crushes = '0';
  String _studying = 'Computer Science';
  String _semester = '3rd Semester';
  String _faculty = 'Engineering';

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          const Icon(
            Icons.person,
            size: 72,
          ),
          RichText(
            text: TextSpan(
              text: _name,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              children: [
                TextSpan(
                  text: _username,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Text(
              _caption,
              textAlign: TextAlign.center,
            ),
            margin: EdgeInsets.symmetric(horizontal: 80.0),
            padding: EdgeInsets.all(10.0),
          ),
          TextButton(
            onPressed: () {
              // Navigate to the edit profile screen or show a dialog
              _showEditProfileDialog(context);
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )),
              side: MaterialStateProperty.all(BorderSide(
                color: Colors.grey,
                width: 0.5,
              )),
            ),
            child: Text(
              "Edit Profile",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(height: 10),
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
                  _buildStatisticColumn("Posts", _posts),
                  _buildStatisticColumn("Followers", _followers),
                  _buildStatisticColumn("Following", _following),
                  _buildStatisticColumn("Crushes", _crushes),
                ],
              ),
            ),
          ),
          // TabBar and TabBarView
          Expanded(
            child: DefaultTabController(
              length: 2, // Number of tabs
              initialIndex: 0, // Index of the initially selected tab
              child: Column(
                children: [
                  TabBar(
                    labelColor: Colors.orange,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.orange,
                    tabs: [
                      Tab(text: "My Posts"),
                      Tab(text: "My Infos"),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Tab 1: My Posts
                        Center(
                          child: Text("No posts yet."),
                        ),

                        // Tab 2: My Infos
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Studying: $_studying"),
                              Text("Semester: $_semester"),
                              Text("Faculty: $_faculty"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        context: context,
      ),
    );
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

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StartPage(
            showRegisterPage: () {},
          ),
        ));
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

  void _showEditProfileDialog(BuildContext context) {
    String newName = _name;
    String newUsername = _username;
    String newCaption = _caption;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                onChanged: (value) {
                  newName = value;
                },
                initialValue: _name,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextFormField(
                onChanged: (value) {
                  newUsername = value;
                },
                initialValue: _username,
                decoration: InputDecoration(labelText: "Username"),
              ),
              TextFormField(
                onChanged: (value) {
                  newCaption = value;
                },
                initialValue: _caption,
                decoration: InputDecoration(labelText: "Caption"),
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
                // Save the edited profile information
                setState(() {
                  _name = newName;
                  _username = newUsername;
                  _caption = newCaption;
                });
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
