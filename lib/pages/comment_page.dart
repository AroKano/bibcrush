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
                          title: Text('${post['text'] ?? 'No text available'}'),
                          subtitle: FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance.collection('users').doc(post['userId']).get(), // Change 'UID' to 'userId'
                            builder: (context, userSnapshot) {
                              if (userSnapshot.connectionState == ConnectionState.waiting) {
                                return Text('Loading...');
                              }

                              if (userSnapshot.hasError || !userSnapshot.hasData || userSnapshot.data!.data() == null) {
                                return Text('No username');
                              }

                              var userData = userSnapshot.data!.data() as Map<String, dynamic>;

                              return Text('@${userData['Username'] ?? 'No username'}');
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _buildPostImage(post['imageUrl']),
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

                return Column(
                  children: [
                    for (var comment in comments) _buildCommentWidget(comment.data() as Map<String, dynamic>),
                  ],
                );
              },
            ),

            // Comment Text Field
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: commentController,
                decoration: InputDecoration(
                  hintText: 'Add a comment...',
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
      title: Text(comment['text'] ?? 'No text available'),
      subtitle: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(comment['UID']).get(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }

          if (userSnapshot.hasError || !userSnapshot.hasData || userSnapshot.data!.data() == null) {
            return Text('No username');
          }

          var userData = userSnapshot.data!.data() as Map<String, dynamic>;

          return Text('@${userData['Username'] ?? 'No username'}');
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
