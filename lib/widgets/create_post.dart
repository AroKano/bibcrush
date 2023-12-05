import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Post Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PostScreen(),
    );
  }
}

class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            // Handle cancel/post action
          },
        ),
        title: Text('9:41'),
        actions: [
          TextButton(
            onPressed: () {
              // Handle cancel/post action
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
    );
  }
}
