import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Reference to user document
  DocumentReference<Map<String, dynamic>> getUserDocRef(String userId) {
    return _firestore.collection('Users').doc(userId);
  }

  // Update Preferences (Sound Effects, Audio, Dark Mode)
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

  // Get Preferences
  Future<Map<String, dynamic>> getPreferences(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await getUserDocRef(userId).get();
      if (snapshot.exists) {
        // Access preferences if they exist in the document
        return snapshot.data()?['Settings']['Preferences'] ?? {};
      } else {
        return {}; // Return an empty map if no document found
      }
    } catch (e) {
      print('Error fetching preferences: $e');
      return {}; // Return empty map on error
    }
  }

  // Update Profile Settings (Name, Username, Password, Email, Phone Number)
  Future<void> updateProfileSettings({
    required String userId,
    required String name,
    required String username,
    required String email,
    required String phoneNumber,
  }) async {
    // Set FullName and Username under Profile
    Map<String, dynamic> profileUpdates = {
      'Full Name': name,
      'Username': username,
    };

    // Set Email and Phone Number directly under UserId
    Map<String, dynamic> userUpdates = {
      'Email': email,
      'Phone Number': phoneNumber,
    };

    // Update Profile map and root-level fields separately
    await getUserDocRef(userId).set({
      'Profile': profileUpdates,
      ...userUpdates,
    }, SetOptions(merge: true));
  }

  Future<Map<String, dynamic>> getPrivacySettings(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await getUserDocRef(userId).get();
      if (snapshot.exists) {
        // Access preferences if they exist in the document
        return snapshot.data()?['Settings']['Privacy Settings'] ?? {};
      } else {
        return {}; // Return an empty map if no document found
      }
    } catch (e) {
      print('Error fetching preferences: $e');
      return {}; // Return empty map on error
    }
  }

  Future<void> updatePrivacySettings({
    required String userId,
    required bool public,
  }) async {
    await getUserDocRef(userId).set(
      {
        'Settings': {
          'Privacy Settings': {
            'Public Profile': public,
          },
        }
      },
      SetOptions(
        merge: true,
      ),
    );
  }
}
