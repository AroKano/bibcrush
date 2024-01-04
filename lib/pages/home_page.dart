import 'package:bibcrush/components/custom_nav_bar.dart';
import 'package:bibcrush/pages/start_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'comment_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final user = FirebaseAuth.instance.currentUser!;

  String _formatTimestamp(Timestamp timestamp) {
    var postTime = timestamp.toDate();
    return timeago.format(postTime, locale: 'en_short');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('posts').get(),
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
              return _buildPostWidget(posts[index]);
            },
          );
        },
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: 0,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        context: context,
      ),
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

  Widget _buildPostWidget(DocumentSnapshot postDoc) {
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
}
