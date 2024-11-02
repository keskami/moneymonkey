import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:money_monkey/Backend/Models/user_data.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 1. User Management and Authentication

  Future<void> createUser(String userId, Map<String, dynamic> userData) async {
    await _firestore.collection('Users').doc(userId).set(userData);
  }

  Future<DocumentSnapshot> getUser(String userId) async {
    return await _firestore.collection('Users').doc(userId).get();
  }

  Future<void> updateUser(String userId, Map<String, dynamic> userData) async {
    await _firestore.collection('Users').doc(userId).update(userData);
  }

  Future<void> deleteUser(String userId) async {
    await _firestore.collection('Users').doc(userId).delete();
  }

  // 2. Financial Education and Progression

  Future<void> createLessonProgress(String userId, String lessonId,
      Map<String, dynamic> lessonProgress) async {
    await _firestore
        .collection('Progression')
        .doc(userId)
        .collection('LessonDetails')
        .doc(lessonId)
        .set(lessonProgress);
  }

  Future<DocumentSnapshot> getLessonProgress(
      String userId, String lessonId) async {
    return await _firestore
        .collection('Progression')
        .doc(userId)
        .collection('LessonDetails')
        .doc(lessonId)
        .get();
  }

  Future<void> updateLessonProgress(String userId, String lessonId,
      Map<String, dynamic> lessonProgress) async {
    await _firestore
        .collection('Progression')
        .doc(userId)
        .collection('LessonDetails')
        .doc(lessonId)
        .update(lessonProgress);
  }

  Future<void> deleteLessonProgress(String userId, String lessonId) async {
    await _firestore
        .collection('Progression')
        .doc(userId)
        .collection('LessonDetails')
        .doc(lessonId)
        .delete();
  }

  // 3. Curriculum Flow

  Future<QuerySnapshot> getCourses() async {
    return await _firestore.collection('Curriculum').get();
  }

  Future<DocumentSnapshot> getCourse(String courseId) async {
    return await _firestore.collection('Curriculum').doc(courseId).get();
  }

  Future<QuerySnapshot> getUnits(String courseId) async {
    return await _firestore
        .collection('Curriculum')
        .doc(courseId)
        .collection('Units')
        .get();
  }

  Future<QuerySnapshot> getLessons(String courseId, String unitId) async {
    return await _firestore
        .collection('Curriculum')
        .doc(courseId)
        .collection('Units')
        .doc(unitId)
        .collection('Lessons')
        .get();
  }

  // 4. Financial Transactions and Portfolio

  Future<void> addTransaction(
      String userId, Map<String, dynamic> transaction) async {
    await _firestore
        .collection('Portfolios')
        .doc(userId)
        .collection('Transactions')
        .add(transaction);
  }

  Future<QuerySnapshot> getTransactions(String userId) async {
    return await _firestore
        .collection('Portfolios')
        .doc(userId)
        .collection('Transactions')
        .get();
  }

  Future<void> updateTransaction(String userId, String transactionId,
      Map<String, dynamic> transactionData) async {
    await _firestore
        .collection('Portfolios')
        .doc(userId)
        .collection('Transactions')
        .doc(transactionId)
        .update(transactionData);
  }

  Future<void> deleteTransaction(String userId, String transactionId) async {
    await _firestore
        .collection('Portfolios')
        .doc(userId)
        .collection('Transactions')
        .doc(transactionId)
        .delete();
  }

  // 5. Investment Management

  Future<void> addStockInvestment(String userId, String stockName,
      Map<String, dynamic> investmentData) async {
    await _firestore
        .collection('Investments')
        .doc(userId)
        .collection('Stocks')
        .doc(stockName)
        .set(investmentData);
  }

  Future<QuerySnapshot> getStockInvestments(String userId) async {
    return await _firestore
        .collection('Investments')
        .doc(userId)
        .collection('Stocks')
        .get();
  }

  Future<void> updateStockInvestment(String userId, String stockName,
      Map<String, dynamic> investmentData) async {
    await _firestore
        .collection('Investments')
        .doc(userId)
        .collection('Stocks')
        .doc(stockName)
        .update(investmentData);
  }

  Future<void> deleteStockInvestment(String userId, String stockName) async {
    await _firestore
        .collection('Investments')
        .doc(userId)
        .collection('Stocks')
        .doc(stockName)
        .delete();
  }

  // 6. Social and Community Features

  Future<void> unfollow(String userId, String otherID) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await _firestore.collection('Users').doc(userId).get();

      DocumentSnapshot<Map<String, dynamic>> otherSnapshot =
          await _firestore.collection('Users').doc(otherID).get();

      if (userSnapshot.exists && otherSnapshot.exists) {
        Map<String, dynamic>? userData = userSnapshot.data();
        Map<String, dynamic>? otherData = otherSnapshot.data();

        if (userData != null && otherData != null) {
          List<String>? otherFollowers =
              List<String>.from(otherData['followers'] ?? []);
          int otherCurrentFollowers =
              otherData['Profile']['Number of Followers'] ?? 0;
          otherFollowers.remove(userId);
          await _firestore.collection('Users').doc(otherID).update({
            'followers': otherFollowers,
            'Profile.Number of Followers': otherCurrentFollowers - 1,
          });

          List<String>? userFollowing =
              List<String>.from(userData['following'] ?? []);
          int userCurrentFollowing = userData['Profile']['Following'] ?? 0;
          if (userFollowing.contains(otherID)) {
            userFollowing.remove(otherID);
            await _firestore.collection('Users').doc(userId).update({
              'following': userFollowing,
              'Profile.Following': userCurrentFollowing - 1,
            });
          }
        }
      }
      return null;
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  Future<UserData?> follow(String userId, String otherId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await _firestore.collection('Users').doc(userId).get();

      DocumentSnapshot<Map<String, dynamic>> otherSnapshot =
          await _firestore.collection('Users').doc(otherId).get();

      if (userSnapshot.exists && otherSnapshot.exists) {
        Map<String, dynamic>? userData = userSnapshot.data();
        Map<String, dynamic>? otherData = otherSnapshot.data();

        if (userData != null && otherData != null) {
          List<String>? otherFollowers =
              List<String>.from(otherData['followers'] ?? []);
          int otherCurrentFollowers =
              otherData['Profile']['Number of Followers'] ?? 0;
          otherFollowers.add(userId);
          await _firestore.collection('Users').doc(otherId).update({
            'followers': otherFollowers,
            'Profile.Number of Followers': otherCurrentFollowers + 1,
          });

          List<String>? userFollowing =
              List<String>.from(userData['following'] ?? []);
          int userCurrentFollowing = userData['Profile']['Following'] ?? 0;
          if (!userFollowing.contains(otherId)) {
            userFollowing.add(otherId);
            await _firestore.collection('Users').doc(userId).update({
              'following': userFollowing,
              'Profile.Following': userCurrentFollowing + 1,
            });
          }
        }
      }
      return null;
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  // 7. Settings and Notifications

  Future<void> updateSettings(
      String userId, Map<String, dynamic> settings) async {
    await _firestore
        .collection('Settings')
        .doc(userId)
        .set(settings, SetOptions(merge: true));
  }

  Future<DocumentSnapshot> getSettings(String userId) async {
    return await _firestore.collection('Settings').doc(userId).get();
  }

  Future<void> deleteSettings(String userId) async {
    await _firestore.collection('Settings').doc(userId).delete();
  }

  // Additional methods for handling user authentication
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
