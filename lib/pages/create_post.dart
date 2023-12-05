import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Post',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CreatePostPage(),
    );
  }
}

class CreatePostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 12.0), // Add left padding to "Cancel" button
          child: TextButton(
            onPressed: () {
              // Handle cancel action
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero, // Remove additional padding inside the TextButton
              primary: Color(0xFFE85555), // This is the text color
              minimumSize: Size(20, 20), // Adjust the size to better fit the "Cancel" text if necessary
            ),
            child: Text('Cancel', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          ),
        ),
        title: Text(''),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10.0), // Add right padding to "Post" button
            child: TextButton(
              onPressed: () {
                // Handle post action
              },
              child: Text('Post', style: TextStyle(fontSize: 18.0, color: Color(0xFFFF7A00), fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          // Add a Divider widget with color and padding
          Padding(
            padding: EdgeInsets.only(top: 5), // Adjust the top padding as needed
            child: Divider(
              height: 1,
              color: Color(0xFFE7E7E7), // Replace with your hex code color
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5), // Adjust the bottom padding as needed
            child: Container(
              color: Colors.white, // Background color of the container
              height: 10, // Height of the padding
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0), // Add horizontal padding to the text field
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type something...',
                hintStyle: TextStyle(fontSize: 18.0, color: Color(0xFF939393), fontWeight: FontWeight.normal),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            _buildActionItem(context, 'Capture', Icons.camera_alt, Colors.blue),
            _buildActionItem(context, 'Upload', Icons.file_upload, Colors.purple),
            _buildActionItem(context, 'Tag Location', Icons.location_on, Colors.orange),
            _buildActionItem(context, 'GIF', Icons.gif, Colors.blue),
            // Add more items as needed
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem(BuildContext context, String text, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: InkWell(
        onTap: () {
          // Define your button tap behavior here
          print('$text tapped!');
        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, color: Colors.white), // Replace with Image.asset for custom icons
              SizedBox(width: 8),
              Text(text, style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}

