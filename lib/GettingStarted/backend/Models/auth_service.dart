import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Frontend/Pages/IntroPages/gs_page1.dart';
import 'package:money_monkey/GettingStarted/Frontend/controller/sign_up_controller.dart';
import 'package:money_monkey/GettingStarted/Frontend/controller/start_fresh_controller.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SignUpController signUpController = Get.find();
  final StartFreshController startFreshController = Get.find();

  // Function to create a new user
  Future<void> signUpUser() async {
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
      print('Error signing up user: $e');
      rethrow;
    }
  }

  // Function to sign in an existing user
  Future<void> signInUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Error signing in user: $e');
      rethrow;
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

    //
    await userDocRef.set({
      'User ID': userId,
      'Email': email,
      'Age': gettingStartedController.age.value,
      'Knowledge Level': gettingStartedController.knowledgeLevel.value,
      'Learning Goal Per Day': startFreshController.learningGoal.value,
    });

    await userDocRef.collection('profile').doc('userProfile').set({
      'Full Name': 'Your Name Here',
      'Username': 'Your Name Here',
      'Number of Followers': 0,
      'Following': 0,
      'Top Achievements': 0,
      'Streak': 0,
      'Total Profit': 0,
      'Average Monthly Growth': 0,
    });
  }

  // Function to sign out the user
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error signing out user: $e');
      rethrow;
    }
  }
}
