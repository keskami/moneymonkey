import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/Settings.dart';

class SettingsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DocumentReference<Map<String, dynamic>> getUserDocRef(String userId) {
    return _firestore.collection('Users').doc(userId);
  }

  Future<void> updatePreferences({
    required String userId,
    bool? soundEffects,
    bool? audio,
    bool? darkMode,
  }) async {
    Map<String, dynamic> updates = {};
    if (soundEffects != null) updates['Sound Effects'] = soundEffects;
    if (audio != null) updates['Audio'] = audio;
    if (darkMode != null) updates['Dark Mode'] = darkMode;

    await getUserDocRef(userId).update({
      'Settings.Preferences': updates,
    });
  }

  Future<Map<String, dynamic>> getPreferences(String userId) async {
    return await _getSubCollectionData(userId, ['Settings', 'Preferences']);
  }

  Future<void> updateProfileSettings({
    required String userId,
    required String name,
    required String username,
    required String email,
    required String phoneNumber,
  }) async {
    Map<String, dynamic> profileUpdates = {
      'Full Name': name,
      'Username': username,
    };
    Map<String, dynamic> userUpdates = {
      'Email': email,
      'Phone Number': phoneNumber,
    };
    await getUserDocRef(userId).set({
      'Profile': profileUpdates,
      ...userUpdates,
    }, SetOptions(merge: true));
  }

  Future<Map<String, dynamic>> getPrivacySettings(String userId) async {
    return await _getSubCollectionData(
        userId, ['Settings', 'Privacy Settings']);
  }

  Future<void> updatePrivacySettings({
    required String userId,
    required bool public,
  }) async {
    await getUserDocRef(userId).update(
      {
        'Settings.Privacy Settings.Public Profile': public,
      },
    );
  }

  Future<void> updateNotificationSettings<T>({
    required String userId,
    required String category,
    required T settings,
  }) async {
    await getUserDocRef(userId).update({
      'Settings.Notifications.$category': (settings as dynamic).toFirestore(),
    });
  }

  Future<T> getNotificationSettings<T>(
      {required String userId,
      required String category,
      required T Function(Map<String, dynamic>) fromFirestore}) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await getUserDocRef(userId).get();
      Map<String, dynamic> data =
          snapshot.data()?['Settings']['Notifications'][category] ?? {};
      return fromFirestore(data);
    } catch (e) {
      print('Error fetching $category notifications: $e');
      return fromFirestore({});
    }
  }

  Future<void> updateRemindersNotifications({
    required String userId,
    required RemindersNotifications settings,
  }) async {
    Map<String, dynamic> reminderUpdates = {
      'Practice Email': settings.practiceEmail,
      'Practice Phone': settings.practicePhone,
      'Weekly Progress': settings.weeklyProgress,
      'Reminder Time': settings.reminderTime,
    };
    await getUserDocRef(userId).update({
      'Settings.Notifications.Reminders': reminderUpdates,
    });
  }

  Future<RemindersNotifications> getRemindersNotifications(
      String userId) async {
    return await getNotificationSettings(
      userId: userId,
      category: 'Reminders',
      fromFirestore: (data) => RemindersNotifications.fromFirestore(data),
    );
  }

  Future<void> updateFriendsNotifications(
      String userId, FriendsNotifications settings) async {
    await updateNotificationSettings(
      userId: userId,
      category: 'Friends',
      settings: settings,
    );
  }

  Future<FriendsNotifications> getFriendsNotifications(String userId) async {
    return await getNotificationSettings(
      userId: userId,
      category: 'Friends',
      fromFirestore: (data) => FriendsNotifications.fromFirestore(data),
    );
  }

  Future<void> updateAnnouncementsNotifications(
      String userId, AnnouncementsNotifications settings) async {
    await updateNotificationSettings(
      userId: userId,
      category: 'Announcements',
      settings: settings,
    );
  }

  Future<AnnouncementsNotifications> getAnnouncementsNotifications(
      String userId) async {
    return await getNotificationSettings(
      userId: userId,
      category: 'Announcements',
      fromFirestore: (data) => AnnouncementsNotifications.fromFirestore(data),
    );
  }

  Future<Map<String, dynamic>> _getSubCollectionData(
      String userId, List<String> path) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await getUserDocRef(userId).get();
      Map<String, dynamic>? data = snapshot.data();
      for (String segment in path) {
        if (data == null) return {};
        data = data[segment];
      }
      return data ?? {};
    } catch (e) {
      print('Error fetching data for path $path: $e');
      return {};
    }
  }
}
