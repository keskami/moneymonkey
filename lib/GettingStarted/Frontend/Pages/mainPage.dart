import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_monkey/GettingStarted/Frontend/Pages/emptyLoginPage.dart';
import 'package:money_monkey/GettingStarted/Frontend/Pages/gs_home.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Check if we have a connection and user data
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;

            // If the user is not null and is logged in
            if (user != null && user.uid.isNotEmpty) {
              print("Logged in as: ${user.uid}");
              return const EmptyLoggedInPage();
            } else {
              // User is not logged in
              print("User not logged in");
              return GettingStartedHome();
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while checking auth state
            return const Center(child: CircularProgressIndicator());
          } else {
            // Default case, user is not logged in
            return GettingStartedHome();
          }
        },
      ),
    );
  }
}
