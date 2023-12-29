import 'package:bibcrush/components/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/custom_nav_bar.dart';
import 'start_page.dart'; // Importiere die Start-Seite

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool isLiked = false;
  bool isBookmarked = false;

  final user = FirebaseAuth.instance.currentUser!;

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();

    // Navigiere zur Start-Seite
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StartPage(
            showRegisterPage: () {},
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text('Vorname', style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(width: 4), // Fügen Sie einen Abstand zwischen Vorname und Benutzername hinzu
                            Text('@Benutzername'),
                          ],
                        ),
                        PopupMenuButton<String>(
                          itemBuilder: (BuildContext context) {
                            return {'Melden', 'Entfolgen'}.map((String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Text(choice),
                              );
                            }).toList();
                          },
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 0), // Änderung hier
                      child: Text('vor 2 Stunden'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1556379092-dca659792591?q=80&w=3132&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      width: 400,
                      height: 550,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Interaktive Schaltflächen für Kommentare, Likes, Speichern, Teilen
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(Icons.comment),
                        onPressed: () {
                          // Kommentar-Funktionalität hier einfügen
                          print('Kommentar');
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : null,
                        ),
                        onPressed: () {
                          // Toggle den Like-Status beim Klicken
                          setState(() {
                            isLiked = !isLiked;
                          });

                          // Like-Funktionalität hier einfügen
                          print('Like');
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          color: isBookmarked ? Colors.red : null,
                        ),
                        onPressed: () {
                          // Toggle den Like-Status beim Klicken
                          setState(() {
                            isBookmarked= !isBookmarked;
                          });

                          // Like-Funktionalität hier einfügen
                          print('Speichern');
                        },
                      ),                       IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () {
                          // Teilen-Funktionalität hier einfügen
                          print('Teilen');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),

      bottomNavigationBar: CustomNavBar(
        selectedIndex: 0,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        context: context,
      ),
    );
  }
}
