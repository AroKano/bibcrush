import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final currentUser = FirebaseAuth.instance.currentUser!;

class User {
  String name = 'Max';
  String username = '@MaxMusty';
  String caption =
      'Photographer | Music enthusiast | Coffee lover | Lifelong learner';
  String posts = '0';
  String followers = '0';
  String following = '0';
  String crushes = '0';
  String studying = 'Computer Science';
  String semester = '3rd Semester';
  String faculty = 'Engineering';

  User({
    required this.name,
    required this.username,
  });
}
