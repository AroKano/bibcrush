import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentPage extends StatefulWidget {
  final String postId;

  CommentPage({required this.postId});

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Original Post
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('posts').doc(widget.postId).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                var post = snapshot.data!.data() as Map<String, dynamic>;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance.collection('users').doc(post['users']['UID']).get(),
                            builder: (context, userSnapshot) {
                              if (userSnapshot.connectionState == ConnectionState.waiting) {
                                return Text('Loading...');
                              }

                              if (userSnapshot.hasError || !userSnapshot.hasData || userSnapshot.data!.data() == null) {
                                return Text('No username');
                              }

                              var userData = userSnapshot.data!.data() as Map<String, dynamic>;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '${userData['First Name'] ?? 'No First Name'}',
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: 4),
                                          Text('@${userData['Username'] ?? 'No username'}'),
                                        ],
                                      ),
                                      PopupMenuButton<String>(
                                        itemBuilder: (BuildContext context) {
                                          return {'Report', 'Unfollow'}.map((String choice) {
                                            return PopupMenuItem<String>(
                                              value: choice,
                                              child: Text(choice),
                                            );
                                          }).toList();
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  _buildPostImage(post['imageUrl']),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(post['text'] ?? 'No text available'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            // Display Comments
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('comments').doc(widget.postId).collection('post_comments').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                var comments = snapshot.data!.docs;

                return ListView.builder(
                  shrinkWrap: true, // Important to prevent vertical scrolling conflict
                  physics: NeverScrollableScrollPhysics(), // Prevent vertical scrolling
                  itemCount: comments.length,
                  itemBuilder: (context, index) => _buildCommentWidget(comments[index].data() as Map<String, dynamic>),
                );
              },
            ),
            // Comment Text Field
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0), // Increased top padding
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: commentController,
                          decoration: InputDecoration(
                            hintText: 'Add a comment...',
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              icon: Icon(Icons.send),
                              onPressed: _postComment,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostImage(String? imageUrl) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return Image.network(
        imageUrl,
        width: 400,
        height: 550,
        fit: BoxFit.cover,
      );
    } else {
      return SizedBox.shrink(); // Empty placeholder if imageUrl is null or empty
    }
  }

  Widget _buildCommentWidget(Map<String, dynamic> comment) {
    return ListTile(
      title: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(comment['UID']).get(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }

          if (userSnapshot.hasError || !userSnapshot.hasData || userSnapshot.data!.data() == null) {
            return Text('No username');
          }

          var userData = userSnapshot.data!.data() as Map<String, dynamic>;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '@${userData['Username'] ?? 'No username'}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  PopupMenuButton<String>(
                    itemBuilder: (BuildContext context) {
                      return {'Report', 'Unfollow'}.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                ],
              ),
              SizedBox(height: 4), // Adjust the height as needed
              Text(comment['text'] ?? 'No text available'),
            ],
          );
        },
      ),
      // Add more comment details as needed
    );
  }

  void _postComment() async {
    String commentText = commentController.text.trim();

    if (commentText.isNotEmpty) {
      try {
        // Get the current user ID
        String currentUserId = FirebaseAuth.instance.currentUser!.uid;

        // Save the comment to the database
        var newComment = {
          'text': commentText,
          'UID': currentUserId,
          // Add more comment details as needed
        };

        await FirebaseFirestore.instance.collection('comments').doc(widget.postId).collection('post_comments').add(newComment);

        // Clear the comment text field
        commentController.clear();
      } catch (e) {
        print('Error posting comment: $e');
      }
    }
  }
}
