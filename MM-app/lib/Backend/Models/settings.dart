class SettingsData {
  Preferences preferences;
  Notifications notifications; // Contains all notification types
  PrivacySettings privacySettings;

  SettingsData({
    required this.preferences,
    required this.notifications, // Notifications initialized
    required this.privacySettings,
  });

  factory SettingsData.fromFirestore(Map<String, dynamic> data) {
    return SettingsData(
      preferences: Preferences.fromFirestore(data['Preferences'] ?? {}),
      notifications: Notifications.fromFirestore(data['Notifications'] ?? {}),
      privacySettings:
          PrivacySettings.fromFirestore(data['Privacy Settings'] ?? {}),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'Preferences': preferences.toFirestore(),
      'Notifications': notifications.toFirestore(),
      'Privacy Settings': privacySettings.toFirestore(),
    };
  }
  
  /// JSON serialization for cache purposes
  factory SettingsData.fromJson(Map<String, dynamic> json) {
    return SettingsData(
      preferences: Preferences.fromJson(json['preferences'] ?? {}),
      notifications: Notifications.fromJson(json['notifications'] ?? {}),
      privacySettings: PrivacySettings.fromJson(json['privacySettings'] ?? {}),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'preferences': preferences.toJson(),
      'notifications': notifications.toJson(),
      'privacySettings': privacySettings.toJson(),
    };
  }
}

class Notifications {
  RemindersNotifications reminders;
  FriendsNotifications friends;
  AnnouncementsNotifications announcements;

  Notifications({
    required this.reminders,
    required this.friends,
    required this.announcements,
  });

  factory Notifications.fromFirestore(Map<String, dynamic> data) {
    return Notifications(
      reminders: RemindersNotifications.fromFirestore(data['Reminders'] ?? {}),
      friends: FriendsNotifications.fromFirestore(data['Friends'] ?? {}),
      announcements:
          AnnouncementsNotifications.fromFirestore(data['Announcements'] ?? {}),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'Reminders': reminders.toFirestore(),
      'Friends': friends.toFirestore(),
      'Announcements': announcements.toFirestore(),
    };
  }
  
  /// JSON serialization for cache purposes
  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      reminders: RemindersNotifications.fromJson(json['reminders'] ?? {}),
      friends: FriendsNotifications.fromJson(json['friends'] ?? {}),
      announcements: AnnouncementsNotifications.fromJson(json['announcements'] ?? {}),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'reminders': reminders.toJson(),
      'friends': friends.toJson(),
      'announcements': announcements.toJson(),
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
  
  /// JSON serialization for cache purposes
  factory Preferences.fromJson(Map<String, dynamic> json) {
    return Preferences(
      soundEffects: json['soundEffects'] ?? true,
      audio: json['audio'] ?? true,
      darkMode: json['darkMode'] ?? false,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'soundEffects': soundEffects,
      'audio': audio,
      'darkMode': darkMode,
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
  
  /// JSON serialization for cache purposes
  factory PrivacySettings.fromJson(Map<String, dynamic> json) {
    return PrivacySettings(
      publicProfile: json['publicProfile'] ?? true,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'publicProfile': publicProfile,
    };
  }
}

class RemindersNotifications {
  bool practiceEmail;
  bool practicePhone;
  bool weeklyProgress;
  String reminderTime; // Stores user-defined reminder time

  RemindersNotifications({
    this.practiceEmail = false,
    this.practicePhone = false,
    this.weeklyProgress = false,
    this.reminderTime = '08:00 AM', // Default time
  });

  factory RemindersNotifications.fromFirestore(Map<String, dynamic> data) {
    return RemindersNotifications(
      practiceEmail: data['Practice Email'] ?? false,
      practicePhone: data['Practice Phone'] ?? false,
      weeklyProgress: data['Weekly Progress'] ?? false,
      reminderTime: data['Reminder Time'] ?? '08:00 AM',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'Practice Email': practiceEmail,
      'Practice Phone': practicePhone,
      'Weekly Progress': weeklyProgress,
      'Reminder Time': reminderTime,
    };
  }
  
  /// JSON serialization for cache purposes
  factory RemindersNotifications.fromJson(Map<String, dynamic> json) {
    return RemindersNotifications(
      practiceEmail: json['practiceEmail'] ?? false,
      practicePhone: json['practicePhone'] ?? false,
      weeklyProgress: json['weeklyProgress'] ?? false,
      reminderTime: json['reminderTime'] ?? '08:00 AM',
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'practiceEmail': practiceEmail,
      'practicePhone': practicePhone,
      'weeklyProgress': weeklyProgress,
      'reminderTime': reminderTime,
    };
  }
}

class FriendsNotifications {
  bool newFollowerEmail;
  bool newFollowerPhone;
  bool friendActivityEmail;
  bool friendActivityPhone;

  FriendsNotifications({
    this.newFollowerEmail = false,
    this.newFollowerPhone = false,
    this.friendActivityEmail = false,
    this.friendActivityPhone = false,
  });

  factory FriendsNotifications.fromFirestore(Map<String, dynamic> data) {
    return FriendsNotifications(
      newFollowerEmail: data['New Follower Email'] ?? false,
      newFollowerPhone: data['New Follower Phone'] ?? false,
      friendActivityEmail: data['Friend Activity Email'] ?? false,
      friendActivityPhone: data['Friend Activity Phone'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'New Follower Email': newFollowerEmail,
      'New Follower Phone': newFollowerPhone,
      'Friend Activity Email': friendActivityEmail,
      'Friend Activity Phone': friendActivityPhone,
    };
  }
  
  /// JSON serialization for cache purposes
  factory FriendsNotifications.fromJson(Map<String, dynamic> json) {
    return FriendsNotifications(
      newFollowerEmail: json['newFollowerEmail'] ?? false,
      newFollowerPhone: json['newFollowerPhone'] ?? false,
      friendActivityEmail: json['friendActivityEmail'] ?? false,
      friendActivityPhone: json['friendActivityPhone'] ?? false,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'newFollowerEmail': newFollowerEmail,
      'newFollowerPhone': newFollowerPhone,
      'friendActivityEmail': friendActivityEmail,
      'friendActivityPhone': friendActivityPhone,
    };
  }
}

class AnnouncementsNotifications {
  bool marketingNotificationsEmail;
  bool marketingNotificationsPhone;
  bool educationalTipsEmail;
  bool educationalTipsPhone;

  AnnouncementsNotifications({
    this.marketingNotificationsEmail = false,
    this.marketingNotificationsPhone = false,
    this.educationalTipsEmail = false,
    this.educationalTipsPhone = false,
  });

  factory AnnouncementsNotifications.fromFirestore(Map<String, dynamic> data) {
    return AnnouncementsNotifications(
      marketingNotificationsEmail:
          data['Marketing Notifications Email'] ?? false,
      marketingNotificationsPhone:
          data['Marketing Notifications Phone'] ?? false,
      educationalTipsEmail: data['Educational Tips Email'] ?? false,
      educationalTipsPhone: data['Educational Tips Phone'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'Marketing Notifications Email': marketingNotificationsEmail,
      'Marketing Notifications Phone': marketingNotificationsPhone,
      'Educational Tips Email': educationalTipsEmail,
      'Educational Tips Phone': educationalTipsPhone,
    };
  }
  
  /// JSON serialization for cache purposes
  factory AnnouncementsNotifications.fromJson(Map<String, dynamic> json) {
    return AnnouncementsNotifications(
      marketingNotificationsEmail: json['marketingNotificationsEmail'] ?? false,
      marketingNotificationsPhone: json['marketingNotificationsPhone'] ?? false,
      educationalTipsEmail: json['educationalTipsEmail'] ?? false,
      educationalTipsPhone: json['educationalTipsPhone'] ?? false,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'marketingNotificationsEmail': marketingNotificationsEmail,
      'marketingNotificationsPhone': marketingNotificationsPhone,
      'educationalTipsEmail': educationalTipsEmail,
      'educationalTipsPhone': educationalTipsPhone,
    };
  }
}