import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CreatePostPage(),
    );
  }
}

class CreatePostPage extends StatelessWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Closes the keyboard when the user taps outside of the TextField
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: TextButton(
              onPressed: () {
                // Handle cancel action
              },
              style: TextButton.styleFrom(
                foregroundColor: Color(0xFFE85555),
                padding: EdgeInsets.zero,
                minimumSize: Size(20, 20),
              ),
              child: Text('Cancel',
                  style:
                  TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            ),
          ),
          title: Text(''),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: TextButton(
                onPressed: () {
                  // Handle post action
                },
                child: Text('Post',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Color(0xFFFF7A00),
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Divider(
                height: 1,
                color: Color(0xFFE7E7E7),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Container(
                color: Colors.white,
                height: 10,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Type something...',
                  hintStyle: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFF939393),
                      fontWeight: FontWeight.normal),
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
          height: 70,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _buildActionItem(context, 'Capture', Icons.camera_alt,
                  Color(0xFFC6D2DD), Color(0xFF41698D)),
              _buildActionItem(context, 'Upload', Icons.file_upload,
                  Color(0xFFD6ECCF), Color(0xFF78C05F)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionItem(BuildContext context, String text, IconData icon,
      Color color, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: InkWell(
        onTap: () {
          print('$text tapped!');
        },
        child: Container(
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 15.0, right: 15.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, color: iconColor),
              SizedBox(width: 8),
              Text(text,
                  style: TextStyle(
                      color: Color(0xFF323232), fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
