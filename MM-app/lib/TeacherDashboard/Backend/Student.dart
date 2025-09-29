import 'package:money_monkey/Backend/Models/Settings.dart';

class UserData {
  String userId;
  String email;
  String phoneNumber;
  int age;
  int knowledgeLevel;
  int learningGoalPerDay;
  int startingLevel;
  ProfileData profile;
  SettingsData settings;

  UserData({
    required this.userId,
    required this.email,
    required this.phoneNumber,
    required this.age,
    required this.knowledgeLevel,
    required this.learningGoalPerDay,
    required this.startingLevel,
    required this.profile,
    required this.settings,
  });

  factory UserData.fromFirestore(Map<String, dynamic> data, String id) {
    return UserData(
      userId: id,
      email: data['Email'] ?? '',
      phoneNumber: data['Phone Number'] ?? '', // Retrieve phone number
      age: data['Age'] is int ? data['Age'] : 0,
      knowledgeLevel:
          data['Knowledge Level'] is int ? data['Knowledge Level'] : 0,
      learningGoalPerDay: data['Learning Goal Per Day'] is int
          ? data['Learning Goal Per Day']
          : 0,
      startingLevel: data['Starting Level'] is int ? data['Starting Level'] : 0,
      profile: ProfileData.fromFirestore(data['Profile'] ?? {}),
      settings: SettingsData.fromFirestore(
          data['Settings'] ?? {}), // Retrieve settings
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'Email': email,
      'Phone Number': phoneNumber, // Save phone number
      'Age': age,
      'Knowledge Level': knowledgeLevel,
      'Learning Goal Per Day': learningGoalPerDay,
      'Starting Level': startingLevel,
      'Profile': profile.toFirestore(),
      'Settings': settings.toFirestore(), // Save settings
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
}
