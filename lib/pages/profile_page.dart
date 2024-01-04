import 'package:bibcrush/pages/start_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:bibcrush/theme/theme_provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../components/custom_nav_bar.dart';
import 'comment_page.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  int _postLikes = 0; // Add this line

  int _selectedIndex = 0;
  bool _lightDarkModeEnabled = true;
  bool _notificationsEnabled = true;

  final _currentPasswordController = TextEditingController();
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
          print("User Document: ${document.data()}");

          if (document.reference != null &&
              document.reference.path.isNotEmpty) {
            print(document.reference);
            docIDs.add(document.reference.id);

            // Update local state with user details
            setState(() {
              _first_name = document['First Name'] ?? '';
              _username = document['Username'] ?? '';
              _caption = document['Caption'] ?? '';
              _courseOfStudy = document['Course of Study'] ?? '';

              // Treat faculty and semester as int
              _semester = document['Semester'] as int?;
              _faculty = document['Faculty'] as int?;

              // Fetch and update additional user statistics
              _fetchUserStatistics();
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

  Future<void> _fetchUserStatistics() async {
    // Fetch user statistics (Posts, Follower, Following, Crushes)
    final userStatsDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get();

    if (userStatsDoc.exists) {
      setState(() {
        // Assuming 'Posts' is a list, handle it accordingly
        var posts = userStatsDoc['Posts'];
        _posts = posts is List ? posts.length : 0;

        // Assuming 'Follower' is a list, handle it accordingly
        var followers = userStatsDoc['Follower'];
        _follower = followers is List ? followers.length : 0;

        // Assuming 'Following' is a list, handle it accordingly
        var following = userStatsDoc['Following'];
        _following = following is List ? following.length : 0;

        // Assuming 'Crushes' is a list, handle it accordingly
        var crushes = userStatsDoc['Crushes'];
        _crushes = crushes is List ? crushes.length : 0;
      });
    }
  }

  String _formatTimestamp(Timestamp timestamp) {
    var postTime = timestamp.toDate();
    return timeago.format(postTime, locale: 'en_short');
  }

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
                        "Notifications",
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
                      title: Text("Change password"),
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
                        title: Text("Delete account"),
                        onTap: () {
                          _showDeleteAccountDialog();
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.logout),
                        title: Text("Log out"),
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
              text: _first_name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
              children: [
                TextSpan(
                  text: ' @' + _username,
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
                      Tab(text: "My Info"),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Tab 1: My Posts
                        _buildMyPostsTab(),

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

  Widget _buildStatisticColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildMyPostWidget(DocumentSnapshot postDoc) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(postDoc['users']['UID']).get(),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (userSnapshot.hasError) {
          print('Error fetching user data: ${userSnapshot.error}');
          return Text('Error: ${userSnapshot.error}');
        }

        var post = postDoc.data() as Map<String, dynamic>;
        var userData = userSnapshot.data?.data() as Map<String, dynamic>? ?? {};

        if (userData == null) {
          print('Error: userData is null');
          return Container();  // or any other suitable widget
        }

        bool isCurrentUserOwner = post['users']['UID'] == FirebaseAuth.instance.currentUser?.uid;

        print("User Document: ${userSnapshot.data}");

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(userData?['First Name'] ?? 'Unknown', style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(width: 4),
                          Text('@${userData?['Username'] ?? 'Unknown'}'),
                        ],
                      ),
                      PopupMenuButton<String>(
                        itemBuilder: (BuildContext context) {
                          List<PopupMenuEntry<String>> menuItems = [];

                          if (isCurrentUserOwner) {
                            // Add "Delete" option only if the current user is not the owner of the post
                            menuItems.add(
                              PopupMenuItem<String>(
                                value: 'Delete',
                                child: Text('Delete'),
                              ),
                            );
                          } else if (!isCurrentUserOwner) {
                            // Add "Report" option only if the current user is not the owner
                            menuItems.add(
                              PopupMenuItem<String>(
                                value: 'Report',
                                child: Text('Report'),
                              ),
                            );
                          }
                          return menuItems;
                        },
                        onSelected: (String value) async {
                          if (value == 'Delete') {
                            // Handle the delete action here
                            await _deletePost(postDoc.id);
                          } else if (value == 'Report') {
                            // Handle the report action here
                          }
                        },
                      ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Text(_formatTimestamp(post['timestamp'])),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: post['imageUrl'] != null
                      ? Image.network(
                    post['imageUrl'],
                    width: 400,
                    height: 550,
                    fit: BoxFit.cover,
                  )
                      : Container(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    post['text'] ?? '',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommentPage(postId: postDoc.id),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        post['likes'] != null && post['likes']! > 0 ? Icons.favorite : Icons.favorite_border,
                        color: post['likes'] != null && post['likes']! > 0 ? Colors.red : null,
                      ),
                      onPressed: () async {
                        int newLikes = post['likes'] != null && post['likes']! > 0 ? post['likes']! - 1 : post['likes']! + 1;
                        await FirebaseFirestore.instance.collection('posts').doc(postDoc.id).update({'likes': newLikes});
                        setState(() {
                          post['likes'] = newLikes;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
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

  Widget _buildMyPostsTab() {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('posts')
          .where('users.UID', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        var posts = snapshot.data!.docs;

        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return _buildMyPostWidget(posts[index]);
          },
        );
      },
    );
  }

  Future<void> _deletePost(String postId) async {
    try {
      // Delete comments related to the post
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .get()
          .then((commentSnapshot) async {
        for (var commentDoc in commentSnapshot.docs) {
          await commentDoc.reference.delete();
        }
      });

      // Delete the post itself
      await FirebaseFirestore.instance.collection('posts').doc(postId).delete();

      print('Post deleted successfully');
    } catch (e) {
      print('Error deleting post: $e');
      // Handle the error as needed, such as showing a message to the user
    }
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
                decoration: InputDecoration(
                  labelText: "First Name",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFF7A00)),
                  ),
                ),
              ),
              TextFormField(
                readOnly: true,
                initialValue: _username,
                decoration: InputDecoration(labelText: "Username"),
              ),
              TextFormField(
                onChanged: (value) {
                  newCaption = value;
                },
                initialValue: _caption,
                decoration: InputDecoration(
                  labelText: "Caption",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFF7A00)),
                  ),
                ),
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
                // Update the caption in Firestore
                await _updateEditProfileInFirestore(newFirstName, newCaption);

                // Update the local state
                setState(() {
                  _first_name = newFirstName;
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
                    controller: _currentPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Current password',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFFF7A00)),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'You need to type in your current password';
                      }
                      return null;
                    },
                  ),
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
                  _changePassword(_currentPasswordController.text,
                      _passwordController.text);
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
    _currentPasswordController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  void _showErrorPopup(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK', style: TextStyle(color: Color(0xFFFF7A00))),
            ),
          ],
        );
      },
    );
  }

  Future<String?> _changePassword(String oldPassword, String newPassword) async {
    User user = FirebaseAuth.instance.currentUser!;
    AuthCredential credential =
    EmailAuthProvider.credential(email: user.email!, password: oldPassword);

    Map<String, String?> codeResponses = {
      // Re-auth responses
      "user-mismatch": null,
      "user-not-found": null,
      "invalid-credential": null,
      "invalid-email": null,
      "wrong-password": null,
      "invalid-verification-code": null,
      "invalid-verification-id": null,
      "weak-password": null,
      "requires-recent-login": null
    };

    try {
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
      await _signOut();
    } on FirebaseAuthException catch (error) {
      String errorMessage =
          codeResponses[error.code] ?? "Wrong current password";
      _showErrorPopup(errorMessage);
    }
  }

  Future<void> _signOut() async {await FirebaseAuth.instance.signOut();
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StartPage(
          showRegisterPage: () {},
        ),
      ));
  }

  Future<void> _deleteAccount() async {
    try {
      // Delete user posts
      final postQuerySnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .where('users.UID', isEqualTo: uid)
          .get();

      for (var postDoc in postQuerySnapshot.docs) {
        // Delete comments related to the post
        final commentQuerySnapshot = await FirebaseFirestore.instance
            .collection('posts')
            .doc(postDoc.id)
            .collection('comments')
            .get();

        for (var commentDoc in commentQuerySnapshot.docs) {
          await commentDoc.reference.delete();
        }

        // Delete the post itself
        await postDoc.reference.delete();
      }

      // Delete the user document in Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).delete();

      // Delete the user account in Firebase Authentication
      await currentUser.delete();
    } catch (e) {
      print('Error deleting account: $e');
      // Handle the error as needed, such as showing a message to the user
    }
  }

  Future<void> _updateEditInfoInFirestore(String title, String newValue) async {
    try {
      // Get the current user's document ID
      String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
      print("Current User UID: $userId");

      // Fetch the current user document
      DocumentSnapshot<Map<String, dynamic>> userDocument =
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .get();

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
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .set(currentData);

      print("$title updated in Firestore");
    } catch (e) {
      print("Error updating $title in Firestore: $e");
      // Handle the error accordingly
    }
  }

  Future<void> _updateEditProfileInFirestore(String newFirstName, String newCaption) async {
    try {
      // Get the current user's document ID
      String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

      // Update the user information in Firestore
      await FirebaseFirestore.instance.collection("users").doc(userId).update({
        "First Name": newFirstName,
        "Caption": newCaption,
      });

      print("User information updated in Firestore");
    } catch (e) {
      print("Error updating user information in Firestore: $e");
      // Handle the error accordingly
    }
  }
}
