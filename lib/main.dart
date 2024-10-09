import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'LoginPages/main_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'com.example.moneyMonkey',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  
    return const MaterialApp(
      title: "Money Monkey",
      home: main_page(),
    );
  }
}
