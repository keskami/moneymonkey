// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/controller/intro_pages_controller.dart';
import 'package:money_monkey/GettingStarted/controller/sign_up_controller.dart';
import 'package:money_monkey/GettingStarted/controller/start_fresh_controller.dart';
import 'package:money_monkey/home.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SignUpController signUpController = Get.find();
  final StartFreshController startFreshController = Get.find();
  final GettingStartedController gettingStartedController = Get.find();

  /// Checks if an email is already in use
  Future<bool> checkEmailUsed(String email, BuildContext context) async {
    signUpController.isLoading.value = true;
    
    if (!email.isEmail) {
      _showSnackBar(context, "Enter a valid email.", Colors.red);
      signUpController.isLoading.value = false;
      return false;
    }

    try {
      final emailSnapshot = await _firestore
          .collection('Users')
          .where('Email', isEqualTo: email)
          .get();

      if (emailSnapshot.docs.isNotEmpty) {
        _showSnackBar(context, "Email already associated with a user.", Colors.red);
        signUpController.isLoading.value = false;
        return false;
      }

      signUpController.isLoading.value = false;
      return true;
    } catch (e) {
      _showSnackBar(context, "Error checking email: $e", Colors.red);
      signUpController.isLoading.value = false;
      return false;
    }
  }

  /// Signs up a new user with email and password
  Future<bool> signUpUser(BuildContext context) async {
    try {
      signUpController.isLoading.value = true;
      
      String email = signUpController.email.value.trim();
      String password = signUpController.password.value;

      // Create user in Firebase Auth
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String userId = userCredential.user!.uid;

      // Create user profile in Firestore
      await _createUserProfile(
        userId: userId,
        email: email,
        fullName: signUpController.name.value,
        username: signUpController.username.value,
        phoneNumber: signUpController.phoneNumber.value,
        age: gettingStartedController.age.value,
        knowledgeLevel: gettingStartedController.knowledgeLevel.value,
        learningGoal: startFreshController.learningGoal.value,
      );

      signUpController.isLoading.value = false;
      _navigateToHome(context);
      return true;
    } catch (e) {
      signUpController.isLoading.value = false;
      _handleAuthError(e, context, "Error during sign up");
      return false;
    }
  }

  /// Signs in an existing user with email and password
  Future<bool> signInUser(String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _navigateToHome(context);
      return true;
    } catch (e) {
      _handleAuthError(e, context, "Error signing in");
      return false;
    }
  }

  /// Handles Google authentication for both sign up and sign in (WEB VERSION)
  Future<bool> googleAuth(BuildContext context) async {
    try {
      // For web, use GoogleAuthProvider directly with Firebase Auth
      final GoogleAuthProvider googleProvider = GoogleAuthProvider();
      
      // Add scopes if needed
      googleProvider.addScope('email');
      googleProvider.addScope('profile');
      
      // Sign in with popup for web
      final UserCredential userCredential = await _auth.signInWithPopup(googleProvider);
      
      String userId = userCredential.user?.uid ?? '';
      String email = userCredential.user?.email ?? '';
      String? displayName = userCredential.user?.displayName;

      if (email.isEmpty) {
        _showSnackBar(context, "Unable to get email from Google account.", Colors.red);
        return false;
      }

      // Check if user profile exists, create if not
      final userDoc = await _firestore.collection('Users').doc(userId).get();
      if (!userDoc.exists) {
        await _createUserProfile(
          userId: userId,
          email: email,
          fullName: displayName ?? 'User',
          username: displayName ?? 'User',
        );
      }

      _navigateToHome(context);
      return true;
    } catch (e) {
      _handleAuthError(e, context, "Error during Google Sign In");
      return false;
    }
  }

  /// Signs out the current user (WEB VERSION)
  Future<bool> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      // For web, Firebase Auth handles Google sign-out automatically
      return true;
    } catch (e) {
      _showSnackBar(context, "Error during sign out: $e", Colors.red);
      return false;
    }
  }

  /// Creates a comprehensive user profile in Firestore
  Future<void> _createUserProfile({
    required String userId,
    required String email,
    String fullName = 'Your Name Here',
    String username = 'Your Name Here',
    String phoneNumber = '',
    int age = 0,
    int knowledgeLevel = 0,
    int learningGoal = 0,
  }) async {
    final userDocRef = _firestore.collection('Users').doc(userId);
    
    // Check if user already exists
    final userSnapshot = await userDocRef.get();
    if (userSnapshot.exists) return;

    // Default followers and following (consider removing in production)
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
      'Phone Number': phoneNumber,
      'Age': age,
      'Knowledge Level': knowledgeLevel,
      'Learning Goal Per Day': learningGoal,
      'Profile': {
        'Full Name': fullName,
        'Username': username,
        'Number of Followers': followers.length,
        'Following': following.length,
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
        'Username': username
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

    // Create sample transactions
    await _createSampleTransactions(userDocRef);
    
    // Create progression collection
    await _createProgressionCollection(userDocRef);
  }

  /// Creates sample transactions for new users
  Future<void> _createSampleTransactions(DocumentReference userDocRef) async {
    final transactionsRef = userDocRef.collection('Transactions');

    final sampleTransactions = [
      {
        'Source/Destination': 'Test Source',
        'Amount': 200,
        'Date': FieldValue.serverTimestamp(),
        'Type': "Income"
      },
      {
        'Source/Destination': 'Test Source 2',
        'Amount': 150,
        'Date': FieldValue.serverTimestamp(),
        'Type': "Income"
      },
      {
        'Source/Destination': 'Test Expense Source 1',
        'Amount': -100,
        'Date': FieldValue.serverTimestamp(),
        'Type': "Expense"
      },
      {
        'Source/Destination': 'Test Expense Source 2',
        'Amount': -50,
        'Date': FieldValue.serverTimestamp(),
        'Type': "Expense"
      },
      {
        'Source/Destination': 'Test Source 3',
        'Amount': 300,
        'Date': FieldValue.serverTimestamp(),
        'Type': "Income"
      },
    ];

    for (var transaction in sampleTransactions) {
      await transactionsRef.add(transaction);
    }
  }

  /// Creates initial progression data for new users
  Future<void> _createProgressionCollection(DocumentReference userDocRef) async {
    final progressionCollectionRef = userDocRef.collection('Progression');
    
    await progressionCollectionRef.doc('progression1').set({
      'Level': 1,
      'Unit': 1,
      'Lesson': 'Earning and Saving',
      'Progress': 0,
      'Quiz Scores': [],
      'Earnings from Lesson': {
        'Monkeys': 0,
        'Diamonds': 0,
        'Bananas': 0,
      },
    });
  }

  /// Navigates to the home page
  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  /// Shows a snackbar message
  void _showSnackBar(BuildContext context, String message, Color? backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Handles authentication errors
  void _handleAuthError(dynamic error, BuildContext context, String defaultMessage) {
    String message = defaultMessage;
    
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'weak-password':
          message = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          message = 'The account already exists for that email.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        case 'user-not-found':
          message = 'No user found for that email.';
          break;
        case 'wrong-password':
          message = 'Wrong password provided for that user.';
          break;
        case 'invalid-credential':
          message = 'Invalid email or password.';
          break;
        case 'network-request-failed':
          message = 'Network error. Please check your connection.';
          break;
        default:
          message = error.message ?? defaultMessage;
      }
    }

    _showSnackBar(context, message, Colors.red);
  }
}