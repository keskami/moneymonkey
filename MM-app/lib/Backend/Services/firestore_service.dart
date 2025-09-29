import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Student?> getUserData(String userId) async {
    try {
      // Reference the document in Firestore using the userId
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _db.collection('Users').doc(userId).get();

      if (snapshot.exists) {
        // Convert the Firestore document into a UserData object
        Map<String, dynamic>? data = snapshot.data();
        return Student.fromFirestore(data!, snapshot.id);
            }
      return null;
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  Future<bool> isFollowing(String userId, String otherID) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _db.collection('Users').doc(userId).get();

      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data();

        List<String>? userFollowing =
            List<String>.from(data?['following'] ?? []);

        return userFollowing.contains(otherID);
            }
      return false;
    } catch (e) {
      print("Error fetching user data: $e");
      return false;
    }
  }
}
