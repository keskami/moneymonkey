import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:money_monkey/GettingStarted/Frontend/Pages/IntroPages/gs_page1.dart';
import 'package:money_monkey/GettingStarted/Frontend/controller/sign_up_controller.dart';
import 'package:money_monkey/GettingStarted/Frontend/controller/start_fresh_controller.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SignUpController signUpController = Get.find();
  final StartFreshController startFreshController = Get.find();
  String user = "";
  //Google Sign In
  Future<void> googleAuth(BuildContext context) async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // User cancelled sign-in

      GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
      user = googleUser.displayName!;

      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      String userId = userCredential.user?.uid ?? '';
      String email = userCredential.user?.email ?? '';

      if (email.isNotEmpty) {
        addUserDetails(userId, email);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Container(
              color: Colors.red[100],
              child: Text(
                "Error during Google Sign In: $e",
              ))));
      // Handle error and inform the user (e.g., show a snackbar)
    }
  }

  // Function to create a new user
  Future<void> signUpUser(BuildContext context) async {
    try {
      // Get the user input from the controller
      String name = signUpController.name.value;
      String email = signUpController.email.value;
      String password = signUpController.password.value;

      // Create the user in Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String userId = userCredential.user!.uid;
      addUserDetails(userId, signUpController.email.value.trim());
      // Get the current user
      User? user = userCredential.user;

      if (user != null) {
        // Save additional user details (like name) in Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'userId': user.uid,
          'name': name,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
        });
        // You can set other fields, like 'age', 'knowledgeLevel', etc. if needed.
      }
    } catch (e) {
      // Handle errors such as invalid email, weak password, etc.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Container(
              color: Colors.red[100],
              child: Text(
                "Error during Google Sign In: $e",
              ))));
      rethrow;
    }
  }

  // Function to sign in an existing user
  Future<void> signInUser(
      String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Container(
              color: Colors.red[100],
              child: Text(
                "Error Signing In: $e",
              ))));
      rethrow;
    }
  }

  // Check if username exists within the Profile map
  Future<bool> checkUsernameExists(String username) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('Profile.Username', isEqualTo: username)
          .get();

      // Check if any document exists with the provided username
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      // Log the error for debugging purposes
      print("Error checking username existence: $e");
      // Handle error appropriately; you may choose to throw an exception or return false
      return false; // Assuming false if an error occurs
    }
  }

  //Add User Details
  Future<void> addUserDetails(String userId, String email) async {
    final userDocRef =
        FirebaseFirestore.instance.collection('Users').doc(userId);
    final userSnapshot = await userDocRef.get();

    if (userSnapshot.exists) {
      return;
    }

    await userDocRef.set({
      'User ID': userId,
      'Email': email,
      'Age': gettingStartedController.age.value, // Ensure value is not null
      'Knowledge Level': gettingStartedController.knowledgeLevel.value,
      'Learning Goal Per Day': startFreshController.learningGoal.value,
      'Starting level': gettingStartedController.knowledgeLevel.value,
      'Profile': {
        // Storing profile information as a map within the user document
        'Full Name': signUpController.name.value,
        'Username':
            signUpController.name.value, // Updated to use the correct field
        'Number of Followers': 0,
        'Following': 0,
        'Top Achievements': 0,
        'Streak': 0,
        'Total Profit': 0,
        'Average Monthly Growth': 0,
        'Portfolio Score': 0, // Add any other fields needed
      },
    });
  }

  // Function to sign out the user
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Container(
              color: Colors.red[100],
              child: Text(
                "Error during Signing Out: $e",
              ))));
      rethrow;
    }
  }
}
