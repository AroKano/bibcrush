import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserAndFirstName extends StatelessWidget {
  final String documentId;

  GetUserAndFirstName({required this.documentId});

  @override
  Widget build(BuildContext context) {
    if (documentId.isEmpty) {
      return Text("Error: Document ID is empty");
    }

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }

          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;
          return Text("${data["First Name"]}" + " @${data["Username"]}");
        }
        return Text("Loading...");
      },
      future: users.doc(documentId).get(),
    );
  }
}
