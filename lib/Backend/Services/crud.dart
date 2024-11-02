import 'dart:math';

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

  Future<List<Map<String, String>>> findFriendsFromSearch(
      String search, int howManyWanted, String userId) async {
    List<Map<String, String>> users = [];

    try {
      final String searchTermLower = search;
      final String endSearchTerm = searchTermLower + '\uf8ff';

      print("Searching for usernames containing: $searchTermLower");

      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('Profile.Username', isGreaterThanOrEqualTo: searchTermLower)
          .where('Profile.Username', isLessThanOrEqualTo: endSearchTerm)
          .get();

      print("Snapshot retrieved: ${snapshot.docs.length} documents found");

      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await _firestore.collection('Users').doc(userId).get();
      Map<String, dynamic>? userData = userSnapshot.data();

      List<String>? userFollowing =
          List<String>.from(userData?['following'] ?? []);

      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey('Profile')) {
          final profile = data['Profile'] as Map<String, dynamic>?;
          if (profile != null && !userFollowing.contains(doc.id)) {
            Map<String, String> user = {
              'name': profile['Full Name'] ?? 'Unknown',
              'username': profile['Username'] ?? 'Unknown',
              'whySuggested': 'Username: ' + profile['Username'],
              'otherID': doc.id
            };

            users.add(user);
            if (users.length >= howManyWanted) {
              break;
            }
          }
        }
      }
    } catch (error) {
      print("Error finding friends: $error");
    }
    print(users);

    return users;
  }

  Future<List<Map<String, String>>> findFriends(
      String userId, int howManyWanted) async {
    Map<String, int> mutualCounts = {};
    Map<String, List<String>> mutualConnections = {};
    List<Map<String, String>> mutualFriends = [];
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await _firestore.collection('Users').doc(userId).get();

    if (userSnapshot.exists) {
      Map<String, dynamic>? userData = userSnapshot.data();

      if (userData != null) {
        List<String>? userFollowing =
            List<String>.from(userData['following'] ?? []);

        for (String followedUserId in userFollowing) {
          DocumentSnapshot<Map<String, dynamic>> followedUserSnapshot =
              await _firestore.collection('Users').doc(followedUserId).get();

          if (followedUserSnapshot.exists) {
            Map<String, dynamic>? followedUserData =
                followedUserSnapshot.data();
            if (followedUserData != null) {
              List<String>? followedUserFollowing =
                  List<String>.from(followedUserData['following'] ?? []);

              for (String potentialMutualId in followedUserFollowing) {
                if (potentialMutualId != userId &&
                    potentialMutualId != followedUserId) {
                  mutualCounts[potentialMutualId] =
                      (mutualCounts[potentialMutualId] ?? 0) + 1;

                  mutualConnections.putIfAbsent(potentialMutualId, () => []);
                  mutualConnections[potentialMutualId]!.add(followedUserId);
                }
              }
            }
          }
        }

        Random random = Random();
        for (String mutualId in mutualCounts.keys) {
          DocumentSnapshot<Map<String, dynamic>> mutualUserSnapshot =
              await _firestore.collection('Users').doc(mutualId).get();

          if (mutualUserSnapshot.exists && !userFollowing.contains(mutualId)) {
            Map<String, dynamic>? mutualUserData = mutualUserSnapshot.data();
            if (mutualUserData != null) {
              List<String> connections = mutualConnections[mutualId] ?? [];
              String randomConnectionId = connections.isNotEmpty
                  ? connections[random.nextInt(connections.length)]
                  : 'Unknown';

              String randomConnectionName = 'Unknown';
              if (randomConnectionId != 'Unknown') {
                DocumentSnapshot<Map<String, dynamic>>
                    randomConnectionSnapshot = await _firestore
                        .collection('Users')
                        .doc(randomConnectionId)
                        .get();
                if (randomConnectionSnapshot.exists) {
                  Map<String, dynamic>? randomConnectionData =
                      randomConnectionSnapshot.data();
                  randomConnectionName = randomConnectionData?['Profile']
                          ['Full Name'] ??
                      'Unknown';
                }
              }

              mutualFriends.add({
                'otherID': mutualId,
                'name': mutualUserData['Profile']['Full Name'] ?? 'Unknown',
                'count': mutualCounts[mutualId].toString(),
                'randomConnection': randomConnectionName,
                'whySuggested': 'Followed by $randomConnectionName'
              });
            }
          }
        }

        mutualFriends.sort((a, b) {
          int countComparison =
              int.parse(b['count']!).compareTo(int.parse(a['count']!));
          if (countComparison != 0) {
            return countComparison;
          } else {
            return a['name']!.compareTo(b['name']!);
          }
        });

        if (mutualFriends.length > howManyWanted) {
          mutualFriends = mutualFriends.sublist(0, howManyWanted);
        }
      }
    }

    return mutualFriends;
  }

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
