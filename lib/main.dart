import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      title: 'Flutter Firebase Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Firebase Integration',
          style: TextStyle(color: Colors.blue),),
        ),
        body: Center(
          child: Text('Firebase is now integrated!'),
        ),
      ),
    );
  }
}
