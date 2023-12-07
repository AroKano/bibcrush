import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Robert Müller'),
        actions: [
          // Add more actions if needed
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Action for pressing the more_vert (three dots) icon
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              // This will be your chat list
              children: [
                // Add your chat messages here
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(hintText: 'Type a message'),
                    // Handling the user input
                    onSubmitted: (String text) {
                      // Code to handle the message input
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Code to send the message
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

