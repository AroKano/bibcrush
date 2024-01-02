import 'package:bibcrush/pages/start_page.dart';
import 'package:bibcrush/read%20data/get_user_and_first_name.dart';
import 'package:flutter/material.dart';
import '../components/custom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:bibcrush/theme/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  int _selectedIndex = 0;
  bool _lightDarkModeEnabled = true;
  bool _notificationsEnabled = true;

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  //damit Passwort Übereinstimmung kontrolliert wird ohne auf hot Reload zu drücken
  final _formKey = GlobalKey<FormState>();
  bool _passwordsMatch = true;

  int _posts = 0;
  int _follower = 0;
  int _following = 0;
  int _crushes = 0;
  String _first_name = '';
  String _username = '';
  String _caption = '';
  String _courseOfStudy = '';
  int? _semester;
  int? _faculty;

  List<String> docIDs = [];
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    getDocs();
  }

  Future<void> getDocs() async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .where('UID', isEqualTo: user?.uid ?? '')
          .get()
          .then((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          final document = snapshot.docs[0];

          if (document.reference != null &&
              document.reference.path.isNotEmpty) {
            print(document.reference);
            docIDs.add(document.reference.id);

            // Update local state with user details
            setState(() {
              _first_name = document['First Name'] ?? '';
              _username = document['Username'] ?? '';

              _caption = document['Caption'] ?? '';
              _posts = document['Posts'] ?? 0;
              _follower = document['Follower'] ?? 0;
              _following = document['Following'] ?? 0;
              _crushes = document['Crushes'] ?? 0;
              _courseOfStudy = document['Course of Study'] ?? '';

              // Treat faculty and semester as int
              _semester = document['Semester'] as int?;
              _faculty = document['Faculty'] as int?;
            });
          } else {
            print("Error: Document reference is null or empty");
            // Handle the error accordingly
          }
        }
      });
    } catch (e) {
      print("Error fetching user details: $e");
      // Handle the error accordingly
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
          GetUserAndFirstName(documentId: docIDs.isNotEmpty ? docIDs[0] : ""),
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
                  _buildStatisticColumn("Posts", _posts.toString()),
                  _buildStatisticColumn("Follower", _follower.toString()),
                  _buildStatisticColumn("Following", _following.toString()),
                  _buildStatisticColumn("Crushes", _crushes.toString()),
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
        _buildInfoSection("Studying", _courseOfStudy),
        _buildInfoSection("Semester", _semester?.toString() ?? ""),
        _buildInfoSection("Faculty", _faculty?.toString() ?? ""),
      ],
    );
  }

  Widget _buildInfoSection(String title, String? caption) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            caption ?? "N/A",
            style: TextStyle(fontSize: 16.0),
          ),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _showEditInfoDialog(context, title, caption ?? "");
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

  void _showEditInfoDialog(BuildContext context, String title, String initialValue) {
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
              onPressed: () async {
                // Save the edited information
                try {
                  await _updateEditInfoInFirestore(title, newValue);

                  setState(() {
                    switch (title) {
                      case "Course of Study":
                        _courseOfStudy = newValue;
                        break;
                      case "Semester":
                      // Check if newValue is a valid integer string before parsing
                        if (int.tryParse(newValue) != null) {
                          _semester = int.parse(newValue);
                        } else {
                          print("Invalid integer for Semester: $newValue");
                          // Handle the error accordingly
                        }
                        break;
                      case "Faculty":
                      // Check if newValue is a valid integer string before parsing
                        if (int.tryParse(newValue) != null) {
                          _faculty = int.parse(newValue);
                        } else {
                          print("Invalid integer for Faculty: $newValue");
                          // Handle the error accordingly
                        }
                        break;
                    // Add more cases for other info sections if needed
                    }
                  });

                  Navigator.of(context).pop();
                } catch (e) {
                  print("Error saving edited information: $e");
                  // Handle the error accordingly
                }
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
    String newFirstName = _first_name;
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
                  newFirstName = value;
                },
                initialValue: _first_name,
                decoration: InputDecoration(labelText: "First Name"),
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
              onPressed: () async {
                // Update the caption in Firestore
                await _updateEditProfileInFirestore(
                    newFirstName, newUsername, newCaption);

                // Update the local state
                setState(() {
                  _first_name = newFirstName;
                  _username = newUsername;
                  _caption = newCaption;
                });

                Navigator.of(context).pop();
              },
              child: Text("Save",
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
                    builder: (context) =>
                        StartPage(
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

  Future<void> _updateEditInfoInFirestore(String title, String newValue) async {
    try {
      // Get the current user's document ID
      String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
      print("Current User UID: $userId");

      // Fetch the current user document
      DocumentSnapshot<Map<String, dynamic>> userDocument =
      await FirebaseFirestore.instance.collection("users").doc(userId).get();

      // Get the current data from the document
      Map<String, dynamic> currentData = userDocument.data() ?? {};

      // Update the specific field based on the title
      switch (title) {
        case "Course of Study":
          currentData["Course of Study"] = newValue;
          break;
        case "Semester":
        // Check if newValue is a valid integer string before parsing
          if (int.tryParse(newValue) != null) {
            currentData["Semester"] = int.parse(newValue);
          } else {
            print("Invalid integer for Semester: $newValue");
            // Handle the error accordingly
          }
          break;
        case "Faculty":
        // Check if newValue is a valid integer string before parsing
          if (int.tryParse(newValue) != null) {
            currentData["Faculty"] = int.parse(newValue);
          } else {
            print("Invalid integer for Faculty: $newValue");
            // Handle the error accordingly
          }
          break;
      // Add more cases for other info sections if needed
      }

      // Update the entire user information in Firestore
      await FirebaseFirestore.instance.collection("users").doc(userId).set(currentData);

      print("$title updated in Firestore");
    } catch (e) {
      print("Error updating $title in Firestore: $e");
      // Handle the error accordingly
    }
  }

  Future<void> _updateEditProfileInFirestore(String newFirstName, String newUsername, String newCaption) async {
    try {
      // Get the current user's document ID
      String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

      // Update the user information in Firestore
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .update({
        "First Name": newFirstName,
        "Username": newUsername,
        "Caption": newCaption,
      });

      print("User information updated in Firestore");
    } catch (e) {
      print("Error updating user information in Firestore: $e");
      // Handle the error accordingly
    }
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              StartPage(
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