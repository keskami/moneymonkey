// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:money_monkey/GettingStarted/controller/intro_pages_controller.dart';
import 'package:money_monkey/GettingStarted/controller/sign_up_controller.dart';
import 'package:money_monkey/GettingStarted/controller/start_fresh_controller.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SignUpController signUpController = Get.find();
  final StartFreshController startFreshController = Get.find();
  final GettingStartedController gettingStartedController = Get.find();
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

  Future<bool> checkEmailUsed(String email, BuildContext context) async {
    // Validate email format
    signUpController.isLoading.value = true;
    if (!email.isEmail) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Enter a valid email.")));

      signUpController.isLoading.value = false;
      return false;
    }

    try {
      final emailSnapshot = await _firestore
          .collection('Users')
          .where('Email', isEqualTo: email)
          .get();

      if (emailSnapshot.docs.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Email already associated with a user.")));
        signUpController.isLoading.value = false;
        return false;
      }

      signUpController.isLoading.value = false;
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error checking email: $e"),
        backgroundColor: Colors.red[100],
      ));
      signUpController.isLoading.value = false;
      return false;
    }
  }

  Future<void> signUpUser(BuildContext context) async {
    try {
      // Get the user input from the controller
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Container(
              color: Colors.red[100],
              child: Text(
                "Error Signing In: $e",
              ))));
      rethrow;
    }
  }

  Future<void> addUserDetails(String userId, String email) async {
    final userDocRef =
        FirebaseFirestore.instance.collection('Users').doc(userId);
    final userSnapshot = await userDocRef.get();

    if (userSnapshot.exists) {
      return;
    }
    List<String> following = [
      "QofNULUkjTRKL0cQccTNrwuri5I3",
      'J5OHmCH5dAgTtqgBtC9qHUSj34L2',
    ];

    List<String> followers = [
      "QofNULUkjTRKL0cQccTNrwuri5I3",
      'J5OHmCH5dAgTtqgBtC9qHUSj34L2',
      '6mMH88Ebp4aiYWIT3jGfBDyxxRB2'
    ];

    await userDocRef.set({
      'User ID': userId,
      'Email': email,
      'Phone Number': signUpController.phoneNumber.value,
      'Age': gettingStartedController.age.value,
      'Knowledge Level': gettingStartedController.knowledgeLevel.value,
      'Learning Goal Per Day': startFreshController.learningGoal.value,
      'Profile': {
        'Full Name': signUpController.name.value,
        'Username': signUpController.username.value,
        'Number of Followers': 3,
        'Following': 2,
        'Top Achievements': 0,
        'Streak': 0,
        'Total Profit': 0,
        'Average Monthly Growth': 0,
      },
      'Portfolio': {
        'Total Bananas': 8976,
        'Balance': 908,
        'Weekly net gain': -90,
      },
      'Invest Page (Discover)': {
        'Total Invested (Stocks)': 100,
        'Total Profit (Stocks)': 50,
        'Total Invested (ETFs)': 300,
        'Total Profit (ETFs)': -50,
        'Total Invested (Mutual Funds)': 500,
        'Total Profit (Mutual Funds)': 600,
        'Total Invested (Bonds)': 234,
        'Total Profit (Bonds)': -10,
        'Total invested Bananas': 7089,
        'Profit from Invested Bananas (Current Month)': 890,
        'Username': "Josh5"
      },
      'following': following,
      'followers': followers,
      'Settings': {
        'Preferences': {
          'Sound Effects': true,
          'Audio': false,
          'Dark Mode': false,
        },
        'Notifications': {
          'Reminders': {
            'Reminder Time': "08:00 AM",
            'Practice Email': true,
            'Practice Phone': false,
            'Weekly Progress': false,
          },
          'Friends': {
            'New Follower Email': true,
            'New Follower Phone': false,
            'Friend Activity Email': true,
            'Friend Activity Phone': false,
          },
          'Announcements': {
            'Marketing Notifications Email': true,
            'Marketing Notifications Phone': false,
            'Educational Tips Email': true,
            'Educational Tips Phone': false,
          },
        },
        'Privacy Settings': {
          'Public Profile': true,
        },
      }
    });

    final transactionsRef = userDocRef.collection('Transactions');

    await transactionsRef.add(
      {
        'Source/Destination': 'Test Source',
        'Amount': 200,
        'Date': FieldValue.serverTimestamp(),
        'Type': "Income"
      },
    );
    await transactionsRef.add({
      'Source/Destination': 'Test Source 2',
      'Amount': 150,
      'Date': FieldValue.serverTimestamp(),
      'Type': "Income"
    });

    await transactionsRef.add({
      'Source/Destination': 'Test Expense Source 1',
      'Amount': -100,
      'Date': FieldValue.serverTimestamp(),
      'Type': "Expense"
    });

    await transactionsRef.add({
      'Source/Destination': 'Test Expense Source 2',
      'Amount': -50,
      'Date': FieldValue.serverTimestamp(),
      'Type': "Expense"
    });

    await transactionsRef.add({
      'Source/Destination': 'Test Source 3',
      'Amount': 300,
      'Date': FieldValue.serverTimestamp(),
      'Type': "Income"
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
