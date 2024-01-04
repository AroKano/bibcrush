import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Message {
  String text;
  bool sender; // true for sender, false for receiver
  DateTime dateTime;

  Message({required this.text, required this.sender, DateTime? dateTime})
      : this.dateTime = dateTime ?? DateTime.now();
}

class ChatScreen extends StatefulWidget {
  final String peerName;
  final String peerImageUrl;
  final String peerId;

  ChatScreen({required this.peerName, required this.peerImageUrl, required this.peerId,});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> messages = [];
  final TextEditingController _textController = TextEditingController();
  bool _isComposingMessage = false;

  String getChatId(String userId1, String userId2) {
    return userId1.hashCode <= userId2.hashCode
        ? '$userId1\_$userId2'
        : '$userId2\_$userId1';
  }

  String get chatId {
    final currentUser = FirebaseAuth.instance.currentUser!;
    return getChatId(currentUser.uid, widget.peerId);  // Assuming widget.peerId contains the peer's user ID
  }

  void _handleSubmitted(String text) {
    if (text.trim().isNotEmpty) {
      _textController.clear();
      setState(() {
        _isComposingMessage = false; // Reset the flag when the message is submitted
      });

      // Add the message to Firestore in the chat's 'messages' subcollection
      FirebaseFirestore.instance.collection('chats').doc(chatId) // You need to define chatId
        .collection('messages').add({
          'senderId': FirebaseAuth.instance.currentUser!.uid,
          'text': text,
          'timestamp': FieldValue.serverTimestamp(),
        });
    }
  }

  @override
  void initState() {
    super.initState();
    _textController.addListener(_handleTextChange);

    // Firestore listener setup
    FirebaseFirestore.instance.collection('chats').doc(chatId)
      .collection('messages').orderBy('timestamp', descending: true)
        .snapshots().listen((snapshot) {
          List<Message> newMessages = [];
          for (var doc in snapshot.docs) {
            var data = doc.data();
            newMessages.add(Message(
              text: data['text'],
              sender: data['senderId'] == FirebaseAuth.instance.currentUser!.uid,
              dateTime: (data['dateTime'] as Timestamp).toDate(),
            ));
          }
          setState(() {
            messages = newMessages;
          });
      });
  }

  void _handleTextChange() {
    setState(() {
      _isComposingMessage = _textController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _textController.removeListener(_handleTextChange);
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),
            CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
              radius: 23,
            ),
            SizedBox(width: 10),
            Text('Max Mustermann'),
          ],
        ),
        actions: [
          Transform.rotate(
            angle: -90 * 3.1415926535897932 / 180,
            child: IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                // Action for pressing the more_vert (three dots) icon
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Divider(
            color: Color(0xFFE7E7E7),
            thickness: 1,
          ),
          Expanded(
            child: ListView.builder(
              reverse: true, // Makes sure that the list starts from the bottom
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment: message.sender
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    decoration: BoxDecoration(
                      color: message.sender ? Color(0xFFFFE8D3) : Colors.black,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      message.text,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: message.sender ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      hintStyle:
                          TextStyle(fontSize: 18.0, color: Color(0xFFBEBEBE)),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            BorderSide(color: Color(0xFFBEBEBE), width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            BorderSide(color: Color(0xFFFF7A00), width: 2.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      suffixIcon: Container(
                        decoration: BoxDecoration(
                          color: _isComposingMessage
                              ? Color(0xFFFF7A00)
                              : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        margin: EdgeInsets.only(right: 8.0),
                        child: IconButton(
                          icon: Icon(Icons.send_rounded, color: Colors.white),
                          onPressed: _isComposingMessage
                              ? () => _handleSubmitted(_textController.text)
                              : null,
                        ),
                      ),
                    ),
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                    onSubmitted: _handleSubmitted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
