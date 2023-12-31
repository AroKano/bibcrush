import 'package:flutter/material.dart';

class CreatePostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.clear,
                      color: Color(0xFFFF7A00)), // Akzentfarbe
                  onPressed: () {
                    // Hier kannst du die Logik für das Schließen implementieren
                    print('Cancel');
                  },
                ),
                Text(
                  'New Post',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.check,
                      color: Color(0xFFFF7A00)), // Akzentfarbe
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
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(8.0),
              child: Theme(
                data: Theme.of(context).copyWith(
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: Color(0xFFFF7A00), // Akzentfarbe
                    selectionColor: Color(0xFFFF7A00), // Akzentfarbe
                    selectionHandleColor: Color(0xFFFF7A00), // Akzentfarbe
                  ),
                ),
                child: TextField(
                  cursorColor: Color(0xFFFF7A00), // Akzentfarbe
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
                      backgroundColor: MaterialStateProperty.all(
                          Color(0xFFFF7A00)), // Akzentfarbe
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
                      backgroundColor: MaterialStateProperty.all(
                          Color(0xFFFF7A00)), // Akzentfarbe
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
