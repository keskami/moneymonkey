import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_monkey/pages/LoginPages/login.dart';
import 'package:money_monkey/Pages/ProfilePages/profileScreen.dart';

// ignore: camel_case_types
class main_page extends StatelessWidget {
  const main_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User? user = FirebaseAuth.instance.currentUser;
            String userId = user?.uid ?? '';
            if(userId.isEmpty){
              return const LoginScreen();
            }else{
               return const LoginScreen();
            }
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
