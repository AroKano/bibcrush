import 'package:bibcrush/pages/home_page.dart';
import 'package:bibcrush/pages/start_page.dart';
import 'package:bibcrush/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../components/custom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  //damit Passwort Übereinstimmung kontrolliert wird ohne auf hot Reload zu drücken
  final _formKey = GlobalKey<FormState>();
  bool _passwordsMatch = true;

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
  String _faculty = '3';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      endDrawer: Drawer(
        child: Container(
          color: Theme.of(context).colorScheme.primary,
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
                          Provider.of<ThemeProvider>(context, listen: false)
                              .toggleTheme();
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
                        _showChangePasswordDialog();
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.delete_rounded),
                        title: Text("Konto löschen"),
                        onTap: () {
                          _showDeleteAccountDialog();
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
                  )),
            ],
          ),
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
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
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
          SizedBox(
            height: 10,
          ),
          // TabBar and TabBarView
          Expanded(
            child: DefaultTabController(
              length: 2,
              initialIndex: 0,
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
                        _buildMyInfosTab(),
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
        selectedIndex: 4,
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

  Widget _buildMyInfosTab() {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        _buildInfoSection("Studying", _studying),
        _buildInfoSection("Semester", _semester),
        _buildInfoSection("Faculty", _faculty),
      ],
    );
  }

  Widget _buildInfoSection(String title, String caption) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            caption,
            style: TextStyle(fontSize: 16.0),
          ),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _showEditInfoDialog(context, title, caption);
            },
          ),
        ),
        Divider(
          color: Colors.grey,
          thickness: 0.5,
        ),
      ],
    );
  }

  void _showEditInfoDialog(
      BuildContext context, String title, String initialValue) {
    String newValue = initialValue;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit $title"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                onChanged: (value) {
                  newValue = value;
                },
                initialValue: initialValue,
                decoration: InputDecoration(labelText: title),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Color(0xFFFF7A00)),
              ),
            ),
            TextButton(
              onPressed: () {
                // Save the edited information
                setState(() {
                  switch (title) {
                    case "Studying":
                      _studying = newValue;
                      break;
                    case "Semester":
                      _semester = newValue;
                      break;
                    case "Faculty":
                      _faculty = newValue;
                      break;
                    // Add more cases for other info sections if needed
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text(
                "Save",
                style: TextStyle(color: Color(0xFFFF7A00)),
              ),
            ),
          ],
        );
      },
    );
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
              child: Text(
                "Cancel",
                style: TextStyle(color: Color(0xFFFF7A00)),
              ),
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
              child: Text(
                "Save",
                style: TextStyle(color: Color(0xFFFF7A00)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete your Account?'),
          content: const Text(
            '''If you select Delete we will delete your account on our server.

Your app data will also be deleted and you won't be able to retrieve it.''',
          ),
          actions: [
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(0xFFFF7A00)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Delete',
                style: TextStyle(color: Color(0xFFFF7A00)),
              ),
              onPressed: () {
                _deleteAccount();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StartPage(
                      showRegisterPage: () {},
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Password'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFFF7A00)),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'You need to type in a password';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      errorText:
                          _passwordsMatch ? null : 'Passwords do not match',
                      errorStyle: TextStyle(color: Colors.red),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFFF7A00)),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (_passwordController.text.isNotEmpty &&
                          value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _clearTextFields();
              },
              child: Text('Cancel', style: TextStyle(color: Color(0xFFFF7A00))),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _changePassword(_passwordController.text);
                  Navigator.of(context).pop();
                  _clearTextFields();
                }
              },
              child: Text('Save', style: TextStyle(color: Color(0xFFFF7A00))),
            ),
          ],
        );
      },
    );
  }

  void _clearTextFields() {
    _passwordController.clear();
    _confirmPasswordController.clear();
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

  Future<void> _deleteAccount() async {
    await currentUser.delete();
  }

  Future<void> _changePassword(String newPassword) async {
    await currentUser.updatePassword(newPassword);
  }
}
