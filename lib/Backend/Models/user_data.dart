class UserData {
  String userId;
  String email;
  int age;
  int knowledgeLevel; // Change to int
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
      email: data['Email'] ?? '',
      age: data['Age'] ?? 0,
      knowledgeLevel: data['Knowledge Level'] ?? 0, // Adjusted to int
      learningGoalPerDay: data['Learning Goal Per Day'] ?? 0,
      startingLevel:
          data['Starting level'] ?? 0, // Adjust key for Starting Level
      profile: ProfileData.fromFirestore(data['Profile'] ?? {}), // Correct key
    );
  }

  // Convert UserData object to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'Email': email,
      'Age': age,
      'Knowledge Level': knowledgeLevel,
      'Learning Goal Per Day': learningGoalPerDay,
      'Starting level': startingLevel, // Correct key
      'Profile': profile.toFirestore(), // Correct key
    };
  }
}

class ProfileData {
  String fullName;
  String username;
  int numberOfFollowers;
  int following;
  int topAchievements; // Change to int since it's stored as a number
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
      numberOfFollowers: data['Number of Followers'] ?? 0,
      following: data['Following'] ?? 0,
      topAchievements: data['Top Achievements'] ?? 0, // Adjusted to int
      streak: data['Streak'] ?? 0,
      totalProfit: (data['Total Profit'] ?? 0).toDouble(),
      portfolioScore: (data['Portfolio Score'] ?? 0).toDouble(),
      averageMonthlyGrowth: (data['Average Monthly Growth'] ?? 0).toDouble(),
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
