import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//user
final currentUser = FirebaseAuth.instance.currentUser!;

class OthersProfilePage extends StatefulWidget {
  final String documentId;

  OthersProfilePage({required this.documentId, Key? key}) : super(key: key);

  @override
  State<OthersProfilePage> createState() => _OthersProfilePageState();
}

class _OthersProfilePageState extends State<OthersProfilePage> {
  int _selectedIndex = 0;

  late String _name;
  late String _username;
  late String _caption;
  late String _studying;
  late int _semester;
  late int _faculty;

  @override
  void initState() {
    super.initState();
    // Fetch user data when the page is created
    // No need to call _fetchUserData manually
  }

  Future<Map<String, dynamic>?> _fetchUserData() async {
    try {
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.documentId)
          .get();

      if (document.exists) {
        return document.data() as Map<String, dynamic>?;
      } else {
        return null; // or handle the case where the document doesn't exist
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null; // or handle the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text('Profile'),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading user data'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('User not found'));
          } else {
            Map<String, dynamic>? data = snapshot.data;

            _name = data?['First Name'] ?? '';
            _username = data?['Username'] ?? '';
            _caption = data?['Caption'] ?? '';
            _studying = data?['Course of Study'] ?? '';
            _semester = data?['Semester'] ?? 0;
            _faculty = data?['Faculty'] ?? 0;

            // Continue building your UI here using the fetched data
            return Column(
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
                        text: ' @$_username',
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
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        fixedSize: Size(90, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Follow",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFFFF7A00)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            side: MaterialStateProperty.all(
                              BorderSide(
                                color: Color(0xFFFF7A00),
                                width: 0.7,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.favorite,
                                color: Colors.white,
                              ),
                              Text(
                                "Crush",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(
                  color: Colors.grey,
                  thickness: 0.5,
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
                            Tab(text: "Posts"),
                            Tab(text: "Info"),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              // Tab 1:  Posts
                              Center(
                                child: Text("No posts yet."),
                              ),

                              // Tab 2: Infos
                              _buildMyInfosTab(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildMyInfosTab() {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        _buildInfoSection("Studying", _studying),
        _buildInfoSection("Semester", _semester.toString()),
        _buildInfoSection("Faculty", _faculty.toString()),
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
        ),
        Divider(
          color: Colors.grey,
          thickness: 0.5,
        ),
      ],
    );
  }
}
