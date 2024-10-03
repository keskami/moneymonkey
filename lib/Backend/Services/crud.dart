import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:money_monkey/Backend/Models/user_data.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create or update a User document with the given UserData object
  Future<void> createUser(UserData userData) async {
    await _firestore
        .collection('Users')
        .doc(userData.userId)
        .set(userData.toFirestore());
  }

  // Fetch a User document and convert it to UserData object
  Future<UserData?> getUser(String userId) async {
    try {
      // Reference to the user document
      final userDocRef = _firestore.collection('Users').doc(userId);

      // Fetch the user document
      final userSnapshot = await userDocRef.get();

      // Check if user exists
      if (!userSnapshot.exists) {
        return null; // Return null if user doesn't exist
      }

      // Extract user data from the document
      final userData =
          UserData.fromFirestore(userSnapshot.data()!, userSnapshot.id);

      return userData;
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }

  // Update a User document with the given UserData object
  Future<void> updateUser(UserData userData) async {
    await _firestore
        .collection('Users')
        .doc(userData.userId)
        .update(userData.toFirestore());
  }

  // Delete a User document
  Future<void> deleteUser(String userId) async {
    await _firestore.collection('Users').doc(userId).delete();
  }

  // Get the current logged-in user
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  // Sign out the current user
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
