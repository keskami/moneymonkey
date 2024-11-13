import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_monkey/GettingStarted/Pages/gs_home.dart';
import 'package:money_monkey/Invest/Pages/Real%20Estate%20Pages/real_estate_home.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
  });

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
              return RealEstateHome();
            }
          } else {
            return GettingStartedHome();
          }
        },
      ),
    );
  }
}
