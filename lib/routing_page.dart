import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_monkey/GettingStarted/Frontend/Pages/gs_home.dart';
import 'package:money_monkey/Invest/ETFPages/etf_page.dart';

// ignore: camel_case_types
class MainPage extends StatelessWidget {
  const MainPage({super.key});

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
              return GettingStartedHome();
            } else {
              // return ProfilePage(
              //   userID: userId,
              //   user: user!,
              // );
              return ETFHomePage();
            }
          } else {
            return GettingStartedHome();
          }
        },
      ),
    );
  }
}
