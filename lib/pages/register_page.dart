import 'package:bibcrush/components/my_button.dart';
import 'package:bibcrush/components/my_textfield.dart';
import 'package:bibcrush/pages/home_page.dart';
import 'package:bibcrush/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegistrationPage({Key? key, required this.showLoginPage})
      : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _firstNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _facultyController = TextEditingController();
  final _courseOfStudyController = TextEditingController();
  final _semesterController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  String firstNameError = "";
  String usernameError = "";
  String facultyError = "";
  String courseOfStudyError = "";
  String semesterError = "";
  String emailError = "";
  String passwordError = "";
  String confirmPasswordError = "";

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }


  bool passwordConfirmed() {
    if (_passwordController.text.trim() !=
        _confirmpasswordController.text.trim()) {
      setState(() {
        confirmPasswordError = "Passwords don't match!";
      });
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _usernameController.dispose();
    _facultyController.dispose();
    _courseOfStudyController.dispose();
    _semesterController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    // Clear previous error messages
    setState(() {
      firstNameError = "";
      usernameError = "";
      facultyError = "";
      courseOfStudyError = "";
      semesterError = "";
      emailError = "";
      passwordError = "";
      confirmPasswordError = "";
    });

    if (_firstNameController.text
        .trim()
        .isEmpty) {
      setState(() {
        firstNameError = "First Name is necessary";
      });
      showSnackBar("First Name is necessary");
      return;
    }

    if (_usernameController.text
        .trim()
        .isEmpty) {
      setState(() {
        usernameError = "Username is necessary";
      });
      showSnackBar("Username is necessary");
      return;
    }

    if (_facultyController.text
        .trim()
        .isEmpty) {
      setState(() {
        facultyError = "Faculty is necessary";
      });
      showSnackBar("Faculty is necessary");
      return;
    }

    if (_courseOfStudyController.text
        .trim()
        .isEmpty) {
      setState(() {
        courseOfStudyError = "Course of Study is necessary";
      });
      showSnackBar("Course of Study is necessary");
      return;
    }

    if (_semesterController.text
        .trim()
        .isEmpty) {
      setState(() {
        semesterError = "Semester is necessary";
      });
      showSnackBar("Semester is necessary");
      return;
    }

    if (_emailController.text
        .trim()
        .isEmpty) {
      setState(() {
        emailError = "E-Mail adress is necessary";
      });
      showSnackBar("E-Mail adress is necessary");
      return;
    }

    if (_passwordController.text
        .trim()
        .isEmpty) {
      setState(() {
        passwordError = "Passwort is necessary";
      });
      showSnackBar("Passwort is necessary");
      return;
    }

    if (!passwordConfirmed()) {
      // Handle password not confirmed error
      showSnackBar("Passwords don't match!");
      return;
    }

    // create user
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // add user details
      addUserDetails(
        _firstNameController.text.trim(),
        _usernameController.text.trim(),
        int.parse(_facultyController.text.trim()),
        _courseOfStudyController.text.trim(),
        int.parse(_semesterController.text.trim()),
        _emailController.text.trim(),
        FirebaseAuth.instance.currentUser!.uid,
        "Hey, edit your caption!", // Placeholder for caption
      );

      // Registration successful, navigate to HomePage
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
            (route) => false,
      );
    } catch (e) {
      // Handle registration error
      showSnackBar("Registration failed: $e");
    }
  }

  Future<void> addUserDetails(
      String first_name,
      String username,
      int faculty,
      String course_of_study,
      int semester,
      String email,
      String uid,
      String caption,
      ) async {
    await FirebaseFirestore.instance.collection("users").doc(uid).set({
      "First Name": first_name,
      "Username": username,
      "Faculty": faculty,
      "Course of Study": course_of_study,
      "Semester": semester,
      "E-Mail": email,
      "UID": uid,
      "Caption": "Hey, edit your caption!", // Placeholder for captions
      "Posts": 0,        // Default value for Posts
      "Follower": 0,     // Default value for Follower
      "Following": 0,    // Default value for Following
      "Crushes": 0,      // Default value for Crushes
    });
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Sign Up',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              hintText: 'First Name',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Add this Text widget below the TextField
                Text(
                  firstNameError,
                  style:
                  TextStyle(color: Colors.red), // Customize the text color
                ),

                const SizedBox(height: 20),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: MyTextField(
                            controller: _usernameController,
                            hintText: "Username",
                            obscureText: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Add this Text widget below the TextField
                Text(
                  usernameError,
                  style:
                  TextStyle(color: Colors.red), // Customize the text color
                ),

                const SizedBox(height: 20),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Faculty',
                            ),
                            controller: _facultyController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Text(
                  facultyError,
                  style:
                  TextStyle(color: Colors.red), // Customize the text color
                ),

                const SizedBox(height: 20),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Course of Study',
                            ),
                            controller: _courseOfStudyController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Add this Text widget below the TextField
                Text(
                  courseOfStudyError,
                  style:
                  TextStyle(color: Colors.red), // Customize the text color
                ),

                const SizedBox(height: 20),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Semester',
                            ),
                            controller: _semesterController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Add this Text widget below the TextField
                Text(
                  semesterError,
                  style:
                  TextStyle(color: Colors.red), // Customize the text color
                ),

                const SizedBox(height: 20),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: MyTextField(
                            hintText: "E-Mail",
                            obscureText: false,
                            controller: _emailController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Add this Text widget below the TextField
                Text(
                  emailError,
                  style:
                  TextStyle(color: Colors.red), // Customize the text color
                ),

                const SizedBox(height: 20),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: MyTextField(
                            hintText: "Password",
                            obscureText: true,
                            controller: _passwordController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Add this Text widget below the TextField
                Text(
                  passwordError,
                  style:
                  TextStyle(color: Colors.red), // Customize the text color
                ),

                const SizedBox(height: 20),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: MyTextField(
                            hintText: "Confirm Password",
                            obscureText: true,
                            controller: _confirmpasswordController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Add this Text widget below the TextField
                Text(
                  confirmPasswordError,
                  style:
                  TextStyle(color: Colors.red), // Customize the text color
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(color: Color(0xFFFF7A00)),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LoginPage(
                                    showStartPage: () {},
                                  )),
                        );
                      },
                      child: const Text(
                        "Sign in",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF7A00),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                MyButton(text: "Register", onTap: signUp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
