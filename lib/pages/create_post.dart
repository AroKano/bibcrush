import 'package:flutter/material.dart';
import 'custom_nav_bar.dart';

class CreatePost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context); // Close the current screen
          },
        ),
        title: Text('Create Post'),
        actions: [
          TextButton(
            onPressed: () {
              // Handle post action

              // Assuming the post is successful, navigate back to the previous screen
              Navigator.pop(context);
            },
            child: Text('Post'),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Type something...',
              ),
            ),
            // Add additional widgets as necessary
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        onTabChange: (index) {
          // Handle tab change if needed
        },
      ),
    );
  }
}
