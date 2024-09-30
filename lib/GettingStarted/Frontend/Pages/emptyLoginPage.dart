import 'package:flutter/material.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/sign_in_button.dart';
import 'package:money_monkey/GettingStarted/backend/Models/auth_service.dart';

class EmptyLoggedInPage extends StatefulWidget {
  const EmptyLoggedInPage({super.key});

  @override
  State<EmptyLoggedInPage> createState() => _EmptyLoggedInPageState();
}

class _EmptyLoggedInPageState extends State<EmptyLoggedInPage> {
  // Create an instance of AuthService
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomSignInButton(
            color: Colors.white,
            isBordered: true,
            toNextPage: () async {},
            child: Text("Signed In as ${authService.user}."),
          ),
        ],
      ),
    );
  }
}
