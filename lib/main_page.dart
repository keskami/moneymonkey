import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_monkey/login.dart';
import 'package:money_monkey/main.dart';
import 'package:money_monkey/nothing.dart';

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
              return LoginScreen();
            }else{
               return UserIdScreen();
            }
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
