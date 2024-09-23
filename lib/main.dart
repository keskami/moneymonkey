import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:money_monkey/pages/LoginPages/main_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'com.example.moneyMonkey',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  
    return const MaterialApp(
      title: "Money Monkey",
      home: main_page(),
    );
  }
}
