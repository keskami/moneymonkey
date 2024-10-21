class UserData {
  String userId;
  String email;
  int age;
  String knowledgeLevel;
  int learningGoalPerDay;
  int startingLevel;
  ProfileData profile;

  UserData({
    required this.userId,
    required this.email,
    required this.age,
    required this.knowledgeLevel,
    required this.learningGoalPerDay,
    required this.startingLevel,
    required this.profile,
  });

  // Convert Firestore document to UserData object
  factory UserData.fromFirestore(Map<String, dynamic> data, String id) {
    return UserData(
      userId: id,
      email: data['email'] ?? '',
      age: data['age'] ?? 0,
      knowledgeLevel: data['knowledgeLevel'] ?? '',
      learningGoalPerDay: data['learningGoalPerDay'] ?? 0,
      startingLevel: data['startingLevel'] ?? 0,
      profile: ProfileData.fromFirestore(data['profile'] ?? {}),
    );
  }

  // Convert UserData object to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'age': age,
      'knowledgeLevel': knowledgeLevel,
      'learningGoalPerDay': learningGoalPerDay,
      'startingLevel': startingLevel,
      'profile': profile.toFirestore(),
    };
  }
}

class ProfileData {
  String fullName;
  String username;
  int numberOfFollowers;
  int following;
  List<String> topAchievements;
  int streak;
  double totalProfit;
  double portfolioScore;
  double averageMonthlyGrowth;

  ProfileData({
    required this.fullName,
    required this.username,
    required this.numberOfFollowers,
    required this.following,
    required this.topAchievements,
    required this.streak,
    required this.totalProfit,
    required this.portfolioScore,
    required this.averageMonthlyGrowth,
  });

  // Convert Firestore document to ProfileData object
  factory ProfileData.fromFirestore(Map<String, dynamic> data) {
    return ProfileData(
      fullName: data['fullName'] ?? '',
      username: data['username'] ?? '',
      numberOfFollowers: data['numberOfFollowers'] ?? 0,
      following: data['following'] ?? 0,
      topAchievements: List<String>.from(data['topAchievements'] ?? []),
      streak: data['streak'] ?? 0,
      totalProfit: (data['totalProfit'] ?? 0).toDouble(),
      portfolioScore: (data['portfolioScore'] ?? 0).toDouble(),
      averageMonthlyGrowth: (data['averageMonthlyGrowth'] ?? 0).toDouble(),
    );
  }

  // Convert ProfileData object to Firestore document
  Map<String, dynamic> toFirestore() {
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
