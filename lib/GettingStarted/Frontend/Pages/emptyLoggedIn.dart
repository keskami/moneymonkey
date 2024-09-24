import 'package:flutter/material.dart';
import 'package:money_monkey/GettingStarted/Frontend/Pages/SignUpPages/sud_email.dart';

class Emptyloggedin extends StatelessWidget {
  const Emptyloggedin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Logged In as : ${signUpController.name.value}"),
      ),
    );
  }
}
