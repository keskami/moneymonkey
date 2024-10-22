import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_monkey/Backend/Models/user_data.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch User Data from Firestore
  Future<UserData?> getUserData(String userId) async {
    try {
      // Reference the document in Firestore using the userId
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _db.collection('users').doc(userId).get();

      if (snapshot.exists) {
        // Convert the Firestore document into a UserData object
        Map<String, dynamic>? data = snapshot.data();
        if (data != null) {
          return UserData.fromFirestore(data, snapshot.id);
        }
      }
      return null;
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }
}
