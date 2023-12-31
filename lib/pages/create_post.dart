import 'package:flutter/material.dart';

class CreatePostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color customOrangeColor = Color(0xFFFF7A00);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.0), // Vergrößert den Abstand oben

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.clear, color: customOrangeColor),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => HomePage(),
                    //   ),
                    // );
                    print('Quit');
                  },
                ),
                SizedBox(width: 16.0), // Erhöht den Abstand zwischen den Icons und dem Text
                Text(
                  'New Post',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 20.0, // Vergrößert die Schriftgröße von 'New Post'
                  ),
                ),
                SizedBox(width: 16.0), // Erhöht den Abstand zwischen den Icons und dem Text
                IconButton(
                  icon: Icon(Icons.check, color: customOrangeColor),
                  onPressed: () {
                    // Hier kannst du die Logik für das Bestätigen implementieren
                    print('Post');
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Container(
              height: 200.0,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(8.0),
              child: Theme(
                data: Theme.of(context).copyWith(
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: customOrangeColor,
                    selectionColor: customOrangeColor,
                    selectionHandleColor: customOrangeColor,
                  ),
                ),
                child: TextField(
                  cursorColor: customOrangeColor,
                  style: TextStyle(color: Colors.black),
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Do you have a crush?',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ElevatedButton(
                    onPressed: () {
                      // Hier kannst du die Logik für die Kamera implementieren
                      print('Capture');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(customOrangeColor),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Icon(Icons.camera_alt),
                          Text('Capture'),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ElevatedButton(
                    onPressed: () {
                      // Hier kannst du die Logik für das Foto hochladen implementieren
                      print('Upload');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(customOrangeColor),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Icon(Icons.file_upload),
                          Text('Upload'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}