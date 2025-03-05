import 'package:money_monkey/Backend/Models/Settings.dart';

enum StudentStatus {
  Behind,
  Ahead,
  On_Track,
}

class Student {
  String studentId;
  String email;
  String phoneNumber;
  int age;
  int knowledgeLevel;
  int learningGoalPerDay;
  int startingLevel;
  List<String> classRooms;
  String progress;
  ProfileData profile;
  SettingsData settings;

  Student({
    required this.studentId,
    required this.email,
    required this.phoneNumber,
    required this.age,
    required this.knowledgeLevel,
    required this.learningGoalPerDay,
    required this.startingLevel,
    this.classRooms = const [],
    required this.progress,
    required this.profile,
    required this.settings,
  });

  /// Factory constructor to create a `Student` object from Firestore data.
  factory Student.fromFirestore(Map<String, dynamic> data, String id) {
    return Student(
      studentId: id,
      email: data['Email'] ?? '',
      phoneNumber: data['Phone Number'] ?? '',
      age: data['Age'] is int ? data['Age'] : 0,
      knowledgeLevel:
          data['Knowledge Level'] is int ? data['Knowledge Level'] : 0,
      learningGoalPerDay: data['Learning Goal Per Day'] is int
          ? data['Learning Goal Per Day']
          : 0,
      startingLevel: data['Starting Level'] is int ? data['Starting Level'] : 0,
      classRooms: data['ClassRooms'] != null
          ? List<String>.from(data['ClassRooms'])
          : [],
      progress: data['progress'] ?? '',
      profile: ProfileData.fromFirestore(data['Profile'] ?? {}),
      settings: SettingsData.fromFirestore(data['Settings'] ?? {}),
    );
  }

  /// Converts a `Student` object to a Firestore-compatible map.
  Map<String, dynamic> toFirestore() {
    return {
      'Email': email,
      'Phone Number': phoneNumber,
      'Age': age,
      'Knowledge Level': knowledgeLevel,
      'Learning Goal Per Day': learningGoalPerDay,
      'Starting Level': startingLevel,
      'ClassRooms': classRooms,
      'progress': progress,
      'Profile': profile.toFirestore(),
      'Settings': settings.toFirestore(),
    };
  }
  
  /// Factory constructor to create a Student from JSON (for cache purposes)
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentId: json['studentId'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      age: json['age'] ?? 0,
      knowledgeLevel: json['knowledgeLevel'] ?? 0,
      learningGoalPerDay: json['learningGoalPerDay'] ?? 0,
      startingLevel: json['startingLevel'] ?? 0,
      classRooms: json['classRooms'] != null 
          ? List<String>.from(json['classRooms']) 
          : [],
      progress: json['progress'] ?? '',
      profile: ProfileData.fromJson(json['profile'] ?? {}),
      settings: SettingsData.fromJson(json['settings'] ?? {}),
    );
  }
  
  /// Convert a Student to JSON (for cache purposes)
  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'email': email,
      'phoneNumber': phoneNumber,
      'age': age,
      'knowledgeLevel': knowledgeLevel,
      'learningGoalPerDay': learningGoalPerDay,
      'startingLevel': startingLevel,
      'classRooms': classRooms,
      'progress': progress,
      'profile': profile.toJson(),
      'settings': settings.toJson(),
    };
  }
}

class ProfileData {
  String fullName;
  String username;
  int numberOfFollowers;
  int following;
  int topAchievements; // Adjusted to int since it's stored as a number
  int streak;
  double totalProfit;
  double portfolioScore;
  double averageMonthlyGrowth;

  ProfileData({
    required this.fullName,
    required this.username,
    required this.numberOfFollowers,
    required this.following,
    required this.topAchievements, // Adjusted to int
    required this.streak,
    required this.totalProfit,
    required this.portfolioScore,
    required this.averageMonthlyGrowth,
  });

  // Convert Firestore document to ProfileData object
  factory ProfileData.fromFirestore(Map<String, dynamic> data) {
    return ProfileData(
      fullName: data['Full Name'] ?? '',
      username: data['Username'] ?? 'Your Name Here', // Default username
      numberOfFollowers:
          data['Number of Followers'] is int ? data['Number of Followers'] : 0,
      following: data['Following'] is int ? data['Following'] : 0,
      topAchievements: data['Top Achievements'] is int
          ? data['Top Achievements']
          : 0, // Adjusted to int
      streak: data['Streak'] is int ? data['Streak'] : 0,
      totalProfit:
          (data['Total Profit'] is num ? data['Total Profit'] : 0).toDouble(),
      portfolioScore:
          (data['Portfolio Score'] is num ? data['Portfolio Score'] : 0)
              .toDouble(),
      averageMonthlyGrowth: (data['Average Monthly Growth'] is num
              ? data['Average Monthly Growth']
              : 0)
          .toDouble(),
    );
  }

  // Convert ProfileData object to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'Full Name': fullName,
      'Username': username,
      'Number of Followers': numberOfFollowers,
      'Following': following,
      'Top Achievements': topAchievements, // Adjusted to int
      'Streak': streak,
      'Total Profit': totalProfit,
      'Portfolio Score': portfolioScore,
      'Average Monthly Growth': averageMonthlyGrowth,
    };
  }
  
  /// Factory constructor to create ProfileData from JSON (for cache purposes)
  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      fullName: json['fullName'] ?? '',
      username: json['username'] ?? 'Your Name Here',
      numberOfFollowers: json['numberOfFollowers'] ?? 0,
      following: json['following'] ?? 0,
      topAchievements: json['topAchievements'] ?? 0,
      streak: json['streak'] ?? 0,
      totalProfit: (json['totalProfit'] is num ? json['totalProfit'] : 0).toDouble(),
      portfolioScore: (json['portfolioScore'] is num ? json['portfolioScore'] : 0).toDouble(),
      averageMonthlyGrowth: (json['averageMonthlyGrowth'] is num ? json['averageMonthlyGrowth'] : 0).toDouble(),
    );
  }
  
  /// Convert ProfileData to JSON (for cache purposes)
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'username': username,
      'numberOfFollowers': numberOfFollowers,
      'following': following,
      'topAchievements': topAchievements,
      'streak': streak,
      'totalProfit': totalProfit,
      'portfolioScore': portfolioScore,
      'averageMonthlyGrowth': averageMonthlyGrowth,
    };
  }
}