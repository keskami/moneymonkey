import 'package:flutter/material.dart';
import 'package:money_monkey/Backend/Services/auth_service.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/sign_in_button.dart';

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
            toNextPage: () async {
              await authService.signOut(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Logged Out. Restart app.")));
            },
            child: Text("Signed In as ${authService.user} Tap to Logout."),
          ),
        ],
      ),
    );
  }
}
