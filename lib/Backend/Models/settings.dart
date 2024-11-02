class SettingsData {
  Preferences preferences;
  Notifications notifications; // Updated with Notifications
  PrivacySettings privacySettings;

  SettingsData({
    required this.preferences,
    required this.notifications, // Notifications initialized
    required this.privacySettings,
  });

  factory SettingsData.fromFirestore(Map<String, dynamic> data) {
    return SettingsData(
      preferences: Preferences.fromFirestore(data['Preferences'] ?? {}),
      notifications: Notifications.fromFirestore(
          data['Notifications'] ?? {}), // Notifications retrieval
      privacySettings:
          PrivacySettings.fromFirestore(data['Privacy Settings'] ?? {}),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'Preferences': preferences.toFirestore(),
      'Notifications': notifications.toFirestore(), // Notifications saving
      'Privacy Settings': privacySettings.toFirestore(),
    };
  }
}

class Preferences {
  bool soundEffects;
  bool audio;
  bool darkMode;

  Preferences({
    required this.soundEffects,
    required this.audio,
    required this.darkMode,
  });

  factory Preferences.fromFirestore(Map<String, dynamic> data) {
    return Preferences(
      soundEffects: data['Sound Effects'] ?? true,
      audio: data['Audio'] ?? true,
      darkMode: data['Dark Mode'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'Sound Effects': soundEffects,
      'Audio': audio,
      'Dark Mode': darkMode,
    };
  }
}

class Notifications {
  bool emailNotifications;
  bool pushNotifications;
  bool smsNotifications;

  Notifications({
    required this.emailNotifications,
    required this.pushNotifications,
    required this.smsNotifications,
  });

  // Factory constructor to initialize from Firestore data
  factory Notifications.fromFirestore(Map<String, dynamic> data) {
    return Notifications(
      emailNotifications: data['Email Notifications'] ?? false,
      pushNotifications: data['Push Notifications'] ?? false,
      smsNotifications: data['SMS Notifications'] ?? false,
    );
  }

  // Convert Notifications object to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'Email Notifications': emailNotifications,
      'Push Notifications': pushNotifications,
      'SMS Notifications': smsNotifications,
    };
  }
}

class PrivacySettings {
  bool publicProfile;

  PrivacySettings({required this.publicProfile});

  factory PrivacySettings.fromFirestore(Map<String, dynamic> data) {
    return PrivacySettings(
      publicProfile: data['Public Profile'] ?? true,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'Public Profile': publicProfile,
    };
  }
}
