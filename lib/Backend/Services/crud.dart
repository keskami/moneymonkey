import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> updateUser(String userId, Map<String, dynamic> userData) async {
    await _firestore.collection('Users').doc(userId).update(userData);
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

  Future<void> addFriend(
      String userId, String friendId, String friendUsername) async {
    await _firestore
        .collection('Social')
        .doc(userId)
        .collection('Friends')
        .doc(friendId)
        .set({'username': friendUsername});
  }

  Future<QuerySnapshot> getFriends(String userId) async {
    return await _firestore
        .collection('Social')
        .doc(userId)
        .collection('Friends')
        .get();
  }

  Future<void> deleteFriend(String userId, String friendId) async {
    await _firestore
        .collection('Social')
        .doc(userId)
        .collection('Friends')
        .doc(friendId)
        .delete();
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
