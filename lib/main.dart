import 'package:bibcrush/pages/home_page.dart';
import 'package:bibcrush/pages/profile_page.dart';
import 'package:bibcrush/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import 'auth/main_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
