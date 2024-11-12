import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_monkey/Lesson%20Flow/Screens/home.dart';
import 'package:money_monkey/LoginPages/login.dart';

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User? user = FirebaseAuth.instance.currentUser;
          String userId = user?.uid ?? '';
          if (userId.isEmpty) {
            return const LoginScreen();
          } else {
            return HomePage();
          }
        } else {
          return const LoginScreen();
        }
      },
    ),
  );
}
