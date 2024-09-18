import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserIdScreen extends StatefulWidget {
  const UserIdScreen({Key? key}) : super(key: key);

  @override
  State<UserIdScreen> createState() => _UserIdScreenState();
}

class _UserIdScreenState extends State<UserIdScreen> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User ID: ${user?.uid}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Signed in as: ${user?.email}'),
            MaterialButton(
              onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            color: Colors.white,
            child: Text("Sign out"),)
          ],
        ),
      ),
    );
  }
}
