import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../pages/home_page.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() {
  runApp(CreatePost());
}

class CreatePost extends StatelessWidget {
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

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  XFile? _image;
  TextEditingController textController = TextEditingController();

  // Override the dispose method here
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void _captureImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  void _uploadMedia() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() {
        _image = file;
      });
    }
  }

  Future<void> _createPost(String text, File? imageFile) async {
    try {
      String? imageUrl;
      if (imageFile != null) {
        String fileName = 'posts/${DateTime.now().millisecondsSinceEpoch}_${imageFile.path.split('/').last}';
        firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child(fileName);
        firebase_storage.UploadTask uploadTask = ref.putFile(imageFile);
        firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
        imageUrl = await taskSnapshot.ref.getDownloadURL();
      }

      Map<String, dynamic> postData = {
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'text': text,
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance.collection('posts').add(postData);
    } catch (e) {
      print(e);
    }
  }


  // Call _createPost when the Post button is pressed
  void _handlePostButtonPressed() {
    // Get the text from the text field controller
    String postText = textController.text;

    // Call the _createPost method with the text and image file
    _createPost(postText, _image != null ? File(_image!.path) : null);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: OverflowBox(
            maxWidth: double.infinity,
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                        (Route<dynamic> route) => false,
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  foregroundColor: Color(0xFFE85555),
                ),
                child: Text('Cancel', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          title: Text(''),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: TextButton(
                onPressed: _handlePostButtonPressed,
                child: Text('Post', style: TextStyle(fontSize: 18.0, color: Color(0xFFFF7A00), fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              if (_image != null) Image.file(File(_image!.path)),
              Divider(
                height: 1,
                color: Color(0xFFE7E7E7),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: 'Type something...',
                    hintStyle: TextStyle(fontSize: 18.0, color: Color(0xFF939393), fontWeight: FontWeight.normal),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              ),
              // ... Rest of the widgets ...
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          color: Theme.of(context).colorScheme.background,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: _buildActionItem(context, 'Capture', Icons.camera_alt, Color(0xFFC6D2DD), Color(0xFF41698D), _captureImage),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildActionItem(context, 'Upload', Icons.file_upload, Color(0xFFD6ECCF), Color(0xFF78C05F), _uploadMedia),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionItem(BuildContext context, String text, IconData icon, Color color, Color iconColor, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          fixedSize: Size.fromHeight(60),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, color: iconColor),
            SizedBox(width: 8),
            Text(text, style: TextStyle(color: Color(0xFF323232), fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
