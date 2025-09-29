// models/student_profile.dart
import 'package:cloud_firestore/cloud_firestore.dart';

enum StudentStatus {
  Behind,
  Ahead,
  OnTrack,
}

class Student {
  String userId;
  String email;
  String name;
  String role;
  DateTime? createdAt;
  bool isActive;
  
  // Student-specific data
  int age;
  Map<String, bool> classrooms;
  int knowledgeLevel;
  int learningGoalPerDay;
  String phoneNumber;
  int startingLevel;
  String progress;
  
  // Nested objects
  ProfileData profile;
  SettingsData settings;

  Student({
    required this.userId,
    required this.email,
    required this.name,
    this.role = 'student',
    this.createdAt,
    this.isActive = true,
    required this.age,
    this.classrooms = const {},
    this.knowledgeLevel = 1,
    this.learningGoalPerDay = 3,
    this.phoneNumber = '',
    this.startingLevel = 1,
    this.progress = 'A.1.1.1',
    required this.profile,
    required this.settings,
  });

  // Business Logic Methods
  bool get canLevelUp => profile.portfolioScore >= 85 && profile.streak >= 7;
  
  double get dailyGoalProgress {
    if (learningGoalPerDay == 0) return 0.0;
    return (profile.streak / learningGoalPerDay).clamp(0.0, 1.0) * 100;
  }

  String get experienceLevel {
    if (knowledgeLevel >= 4) return 'Advanced';
    if (knowledgeLevel >= 3) return 'Intermediate';
    if (knowledgeLevel >= 2) return 'Beginner';
    return 'Novice';
  }

  bool get isHighPerformer => profile.portfolioScore > 80;

  StudentStatus get status {
    // Mock calculation - implement your actual logic
    if (profile.portfolioScore >= 90) return StudentStatus.Ahead;
    if (profile.portfolioScore >= 70) return StudentStatus.OnTrack;
    return StudentStatus.Behind;
  }

  // Validation
  bool get isValid => 
    email.isNotEmpty && 
    name.isNotEmpty && 
    userId.isNotEmpty &&
    age > 0;

  /// Factory constructor to create a Student from Firestore data
  factory Student.fromFirestore(Map<String, dynamic> data, String id) {
    return Student(
      userId: id,
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      role: data['role'] ?? 'student',
      createdAt: data['createdAt'] is Timestamp 
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
      isActive: data['isActive'] ?? true,
      age: data['age'] is int ? data['age'] : 0,
      classrooms: data['classrooms'] != null
          ? Map<String, bool>.from(data['classrooms'])
          : {},
      knowledgeLevel: data['knowledgeLevel'] is int ? data['knowledgeLevel'] : 1,
      learningGoalPerDay: data['learningGoalPerDay'] is int 
          ? data['learningGoalPerDay'] : 3,
      phoneNumber: data['phoneNumber'] ?? '',
      startingLevel: data['startingLevel'] is int ? data['startingLevel'] : 1,
      progress: data['progress'] ?? 'A.1.1.1',
      profile: ProfileData.fromFirestore(data['profile'] ?? {}),
      settings: SettingsData.fromFirestore(data['settings'] ?? {}),
    );
  }

  /// Convert Student to Firestore-compatible map
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'name': name,
      'role': role,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'isActive': isActive,
      'age': age,
      'classrooms': classrooms,
      'knowledgeLevel': knowledgeLevel,
      'learningGoalPerDay': learningGoalPerDay,
      'phoneNumber': phoneNumber,
      'startingLevel': startingLevel,
      'progress': progress,
      'profile': profile.toFirestore(),
      'settings': settings.toFirestore(),
    };
  }

  /// Factory constructor for JSON (caching purposes)
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      userId: json['userId'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? 'student',
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : null,
      isActive: json['isActive'] ?? true,
      age: json['age'] ?? 0,
      classrooms: json['classrooms'] != null 
          ? Map<String, bool>.from(json['classrooms']) 
          : {},
      knowledgeLevel: json['knowledgeLevel'] ?? 1,
      learningGoalPerDay: json['learningGoalPerDay'] ?? 3,
      phoneNumber: json['phoneNumber'] ?? '',
      startingLevel: json['startingLevel'] ?? 1,
      progress: json['progress'] ?? 'A.1.1.1',
      profile: ProfileData.fromJson(json['profile'] ?? {}),
      settings: SettingsData.fromJson(json['settings'] ?? {}),
    );
  }

  /// Convert Student to JSON (caching purposes)
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'role': role,
      'createdAt': createdAt?.toIso8601String(),
      'isActive': isActive,
      'age': age,
      'classrooms': classrooms,
      'knowledgeLevel': knowledgeLevel,
      'learningGoalPerDay': learningGoalPerDay,
      'phoneNumber': phoneNumber,
      'startingLevel': startingLevel,
      'progress': progress,
      'profile': profile.toJson(),
      'settings': settings.toJson(),
    };
  }

  /// Copy with method for immutable updates
  Student copyWith({
    String? userId,
    String? email,
    String? name,
    String? role,
    DateTime? createdAt,
    bool? isActive,
    int? age,
    Map<String, bool>? classrooms,
    int? knowledgeLevel,
    int? learningGoalPerDay,
    String? phoneNumber,
    int? startingLevel,
    String? progress,
    ProfileData? profile,
    SettingsData? settings,
  }) {
    return Student(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
      age: age ?? this.age,
      classrooms: classrooms ?? this.classrooms,
      knowledgeLevel: knowledgeLevel ?? this.knowledgeLevel,
      learningGoalPerDay: learningGoalPerDay ?? this.learningGoalPerDay,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      startingLevel: startingLevel ?? this.startingLevel,
      progress: progress ?? this.progress,
      profile: profile ?? this.profile,
      settings: settings ?? this.settings,
    );
  }
}

class ProfileData {
  double averageMonthlyGrowth;
  int following;
  String fullName;
  int numberOfFollowers;
  double portfolioScore;
  int streak;
  int topAchievements;
  double totalProfit;
  String username;

  ProfileData({
    this.averageMonthlyGrowth = 0.0,
    this.following = 0,
    this.fullName = '',
    this.numberOfFollowers = 0,
    this.portfolioScore = 0.0,
    this.streak = 0,
    this.topAchievements = 0,
    this.totalProfit = 0.0,
    this.username = '',
  });

  // Business logic
  String get performanceLevel {
    if (portfolioScore >= 90) return 'Excellent';
    if (portfolioScore >= 80) return 'Very Good';
    if (portfolioScore >= 70) return 'Good';
    if (portfolioScore >= 60) return 'Fair';
    return 'Needs Improvement';
  }

  bool get hasLongStreak => streak >= 30;
  bool get isInfluencer => numberOfFollowers > 1000;

  /// Factory constructor from Firestore data
  factory ProfileData.fromFirestore(Map<String, dynamic> data) {
    return ProfileData(
      averageMonthlyGrowth: (data['averageMonthlyGrowth'] is num 
          ? data['averageMonthlyGrowth'] : 0).toDouble(),
      following: data['following'] is int ? data['following'] : 0,
      fullName: data['fullName'] ?? '',
      numberOfFollowers: data['numberOfFollowers'] is int 
          ? data['numberOfFollowers'] : 0,
      portfolioScore: (data['portfolioScore'] is num 
          ? data['portfolioScore'] : 0).toDouble(),
      streak: data['streak'] is int ? data['streak'] : 0,
      topAchievements: data['topAchievements'] is int 
          ? data['topAchievements'] : 0,
      totalProfit: (data['totalProfit'] is num 
          ? data['totalProfit'] : 0).toDouble(),
      username: data['username'] ?? '',
    );
  }

  /// Convert to Firestore-compatible map
  Map<String, dynamic> toFirestore() {
    return {
      'averageMonthlyGrowth': averageMonthlyGrowth,
      'following': following,
      'fullName': fullName,
      'numberOfFollowers': numberOfFollowers,
      'portfolioScore': portfolioScore,
      'streak': streak,
      'topAchievements': topAchievements,
      'totalProfit': totalProfit,
      'username': username,
    };
  }

  /// Factory constructor from JSON (for cache)
  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      averageMonthlyGrowth: (json['averageMonthlyGrowth'] is num 
          ? json['averageMonthlyGrowth'] : 0).toDouble(),
      following: json['following'] ?? 0,
      fullName: json['fullName'] ?? '',
      numberOfFollowers: json['numberOfFollowers'] ?? 0,
      portfolioScore: (json['portfolioScore'] is num 
          ? json['portfolioScore'] : 0).toDouble(),
      streak: json['streak'] ?? 0,
      topAchievements: json['topAchievements'] ?? 0,
      totalProfit: (json['totalProfit'] is num 
          ? json['totalProfit'] : 0).toDouble(),
      username: json['username'] ?? '',
    );
  }

  /// Convert to JSON (for cache)
  Map<String, dynamic> toJson() {
    return {
      'averageMonthlyGrowth': averageMonthlyGrowth,
      'following': following,
      'fullName': fullName,
      'numberOfFollowers': numberOfFollowers,
      'portfolioScore': portfolioScore,
      'streak': streak,
      'topAchievements': topAchievements,
      'totalProfit': totalProfit,
      'username': username,
    };
  }

  ProfileData copyWith({
    double? averageMonthlyGrowth,
    int? following,
    String? fullName,
    int? numberOfFollowers,
    double? portfolioScore,
    int? streak,
    int? topAchievements,
    double? totalProfit,
    String? username,
  }) {
    return ProfileData(
      averageMonthlyGrowth: averageMonthlyGrowth ?? this.averageMonthlyGrowth,
      following: following ?? this.following,
      fullName: fullName ?? this.fullName,
      numberOfFollowers: numberOfFollowers ?? this.numberOfFollowers,
      portfolioScore: portfolioScore ?? this.portfolioScore,
      streak: streak ?? this.streak,
      topAchievements: topAchievements ?? this.topAchievements,
      totalProfit: totalProfit ?? this.totalProfit,
      username: username ?? this.username,
    );
  }
}

class SettingsData {
  NotificationSettings notifications;
  UserPreferences preferences;
  PrivacySettings privacySettings;

  SettingsData({
    required this.notifications,
    required this.preferences,
    required this.privacySettings,
  });

  /// Factory constructor from Firestore data
  factory SettingsData.fromFirestore(Map<String, dynamic> data) {
    return SettingsData(
      notifications: NotificationSettings.fromFirestore(
          data['notifications'] ?? {}),
      preferences: UserPreferences.fromFirestore(
          data['preferences'] ?? {}),
      privacySettings: PrivacySettings.fromFirestore(
          data['privacySettings'] ?? {}),
    );
  }

  /// Convert to Firestore-compatible map
  Map<String, dynamic> toFirestore() {
    return {
      'notifications': notifications.toFirestore(),
      'preferences': preferences.toFirestore(),
      'privacySettings': privacySettings.toFirestore(),
    };
  }

  /// Factory constructor from JSON (for cache)
  factory SettingsData.fromJson(Map<String, dynamic> json) {
    return SettingsData(
      notifications: NotificationSettings.fromJson(
          json['notifications'] ?? {}),
      preferences: UserPreferences.fromJson(
          json['preferences'] ?? {}),
      privacySettings: PrivacySettings.fromJson(
          json['privacySettings'] ?? {}),
    );
  }

  /// Convert to JSON (for cache)
  Map<String, dynamic> toJson() {
    return {
      'notifications': notifications.toJson(),
      'preferences': preferences.toJson(),
      'privacySettings': privacySettings.toJson(),
    };
  }

  SettingsData copyWith({
    NotificationSettings? notifications,
    UserPreferences? preferences,
    PrivacySettings? privacySettings,
  }) {
    return SettingsData(
      notifications: notifications ?? this.notifications,
      preferences: preferences ?? this.preferences,
      privacySettings: privacySettings ?? this.privacySettings,
    );
  }
}

class NotificationSettings {
  AnnouncementNotifications announcements;
  FriendNotifications friends;
  ReminderNotifications reminders;

  NotificationSettings({
    required this.announcements,
    required this.friends,
    required this.reminders,
  });

  factory NotificationSettings.fromFirestore(Map<String, dynamic> data) {
    return NotificationSettings(
      announcements: AnnouncementNotifications.fromFirestore(
          data['announcements'] ?? {}),
      friends: FriendNotifications.fromFirestore(
          data['friends'] ?? {}),
      reminders: ReminderNotifications.fromFirestore(
          data['reminders'] ?? {}),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'announcements': announcements.toFirestore(),
      'friends': friends.toFirestore(),
      'reminders': reminders.toFirestore(),
    };
  }

  factory NotificationSettings.fromJson(Map<String, dynamic> json) {
    return NotificationSettings(
      announcements: AnnouncementNotifications.fromJson(
          json['announcements'] ?? {}),
      friends: FriendNotifications.fromJson(
          json['friends'] ?? {}),
      reminders: ReminderNotifications.fromJson(
          json['reminders'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'announcements': announcements.toJson(),
      'friends': friends.toJson(),
      'reminders': reminders.toJson(),
    };
  }

  NotificationSettings copyWith({
    AnnouncementNotifications? announcements,
    FriendNotifications? friends,
    ReminderNotifications? reminders,
  }) {
    return NotificationSettings(
      announcements: announcements ?? this.announcements,
      friends: friends ?? this.friends,
      reminders: reminders ?? this.reminders,
    );
  }
}

class AnnouncementNotifications {
  bool educationalTipsEmail;
  bool educationalTipsPhone;
  bool marketingNotificationsEmail;
  bool marketingNotificationsPhone;

  AnnouncementNotifications({
    this.educationalTipsEmail = false,
    this.educationalTipsPhone = true,
    this.marketingNotificationsEmail = true,
    this.marketingNotificationsPhone = true,
  });

  factory AnnouncementNotifications.fromFirestore(Map<String, dynamic> data) {
    return AnnouncementNotifications(
      educationalTipsEmail: data['educationalTipsEmail'] ?? false,
      educationalTipsPhone: data['educationalTipsPhone'] ?? true,
      marketingNotificationsEmail: data['marketingNotificationsEmail'] ?? true,
      marketingNotificationsPhone: data['marketingNotificationsPhone'] ?? true,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'educationalTipsEmail': educationalTipsEmail,
      'educationalTipsPhone': educationalTipsPhone,
      'marketingNotificationsEmail': marketingNotificationsEmail,
      'marketingNotificationsPhone': marketingNotificationsPhone,
    };
  }

  factory AnnouncementNotifications.fromJson(Map<String, dynamic> json) {
    return AnnouncementNotifications(
      educationalTipsEmail: json['educationalTipsEmail'] ?? false,
      educationalTipsPhone: json['educationalTipsPhone'] ?? true,
      marketingNotificationsEmail: json['marketingNotificationsEmail'] ?? true,
      marketingNotificationsPhone: json['marketingNotificationsPhone'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'educationalTipsEmail': educationalTipsEmail,
      'educationalTipsPhone': educationalTipsPhone,
      'marketingNotificationsEmail': marketingNotificationsEmail,
      'marketingNotificationsPhone': marketingNotificationsPhone,
    };
  }

  AnnouncementNotifications copyWith({
    bool? educationalTipsEmail,
    bool? educationalTipsPhone,
    bool? marketingNotificationsEmail,
    bool? marketingNotificationsPhone,
  }) {
    return AnnouncementNotifications(
      educationalTipsEmail: educationalTipsEmail ?? this.educationalTipsEmail,
      educationalTipsPhone: educationalTipsPhone ?? this.educationalTipsPhone,
      marketingNotificationsEmail: marketingNotificationsEmail ?? this.marketingNotificationsEmail,
      marketingNotificationsPhone: marketingNotificationsPhone ?? this.marketingNotificationsPhone,
    );
  }
}

class FriendNotifications {
  bool friendActivityEmail;
  bool friendActivityPhone;
  bool newFollowerEmail;
  bool newFollowerPhone;

  FriendNotifications({
    this.friendActivityEmail = true,
    this.friendActivityPhone = false,
    this.newFollowerEmail = true,
    this.newFollowerPhone = false,
  });

  factory FriendNotifications.fromFirestore(Map<String, dynamic> data) {
    return FriendNotifications(
      friendActivityEmail: data['friendActivityEmail'] ?? true,
      friendActivityPhone: data['friendActivityPhone'] ?? false,
      newFollowerEmail: data['newFollowerEmail'] ?? true,
      newFollowerPhone: data['newFollowerPhone'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'friendActivityEmail': friendActivityEmail,
      'friendActivityPhone': friendActivityPhone,
      'newFollowerEmail': newFollowerEmail,
      'newFollowerPhone': newFollowerPhone,
    };
  }

  factory FriendNotifications.fromJson(Map<String, dynamic> json) {
    return FriendNotifications(
      friendActivityEmail: json['friendActivityEmail'] ?? true,
      friendActivityPhone: json['friendActivityPhone'] ?? false,
      newFollowerEmail: json['newFollowerEmail'] ?? true,
      newFollowerPhone: json['newFollowerPhone'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'friendActivityEmail': friendActivityEmail,
      'friendActivityPhone': friendActivityPhone,
      'newFollowerEmail': newFollowerEmail,
      'newFollowerPhone': newFollowerPhone,
    };
  }

  FriendNotifications copyWith({
    bool? friendActivityEmail,
    bool? friendActivityPhone,
    bool? newFollowerEmail,
    bool? newFollowerPhone,
  }) {
    return FriendNotifications(
      friendActivityEmail: friendActivityEmail ?? this.friendActivityEmail,
      friendActivityPhone: friendActivityPhone ?? this.friendActivityPhone,
      newFollowerEmail: newFollowerEmail ?? this.newFollowerEmail,
      newFollowerPhone: newFollowerPhone ?? this.newFollowerPhone,
    );
  }
}

class ReminderNotifications {
  bool practiceEmail;
  bool practicePhone;
  String reminderTime;
  bool weeklyProgress;

  ReminderNotifications({
    this.practiceEmail = true,
    this.practicePhone = false,
    this.reminderTime = '07:30 AM',
    this.weeklyProgress = true,
  });

  factory ReminderNotifications.fromFirestore(Map<String, dynamic> data) {
    return ReminderNotifications(
      practiceEmail: data['practiceEmail'] ?? true,
      practicePhone: data['practicePhone'] ?? false,
      reminderTime: data['reminderTime'] ?? '07:30 AM',
      weeklyProgress: data['weeklyProgress'] ?? true,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'practiceEmail': practiceEmail,
      'practicePhone': practicePhone,
      'reminderTime': reminderTime,
      'weeklyProgress': weeklyProgress,
    };
  }

  factory ReminderNotifications.fromJson(Map<String, dynamic> json) {
    return ReminderNotifications(
      practiceEmail: json['practiceEmail'] ?? true,
      practicePhone: json['practicePhone'] ?? false,
      reminderTime: json['reminderTime'] ?? '07:30 AM',
      weeklyProgress: json['weeklyProgress'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'practiceEmail': practiceEmail,
      'practicePhone': practicePhone,
      'reminderTime': reminderTime,
      'weeklyProgress': weeklyProgress,
    };
  }

  ReminderNotifications copyWith({
    bool? practiceEmail,
    bool? practicePhone,
    String? reminderTime,
    bool? weeklyProgress,
  }) {
    return ReminderNotifications(
      practiceEmail: practiceEmail ?? this.practiceEmail,
      practicePhone: practicePhone ?? this.practicePhone,
      reminderTime: reminderTime ?? this.reminderTime,
      weeklyProgress: weeklyProgress ?? this.weeklyProgress,
    );
  }
}

class UserPreferences {
  bool audio;
  bool darkMode;
  bool soundEffects;

  UserPreferences({
    this.audio = true,
    this.darkMode = false,
    this.soundEffects = true,
  });

  factory UserPreferences.fromFirestore(Map<String, dynamic> data) {
    return UserPreferences(
      audio: data['audio'] ?? true,
      darkMode: data['darkMode'] ?? false,
      soundEffects: data['soundEffects'] ?? true,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'audio': audio,
      'darkMode': darkMode,
      'soundEffects': soundEffects,
    };
  }

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      audio: json['audio'] ?? true,
      darkMode: json['darkMode'] ?? false,
      soundEffects: json['soundEffects'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'audio': audio,
      'darkMode': darkMode,
      'soundEffects': soundEffects,
    };
  }

  UserPreferences copyWith({
    bool? audio,
    bool? darkMode,
    bool? soundEffects,
  }) {
    return UserPreferences(
      audio: audio ?? this.audio,
      darkMode: darkMode ?? this.darkMode,
      soundEffects: soundEffects ?? this.soundEffects,
    );
  }
}

class PrivacySettings {
  bool publicProfile;

  PrivacySettings({
    this.publicProfile = true,
  });

  factory PrivacySettings.fromFirestore(Map<String, dynamic> data) {
    return PrivacySettings(
      publicProfile: data['publicProfile'] ?? true,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'publicProfile': publicProfile,
    };
  }

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

  PrivacySettings copyWith({
    bool? publicProfile,
  }) {
    return PrivacySettings(
      publicProfile: publicProfile ?? this.publicProfile,
    );
  }
}