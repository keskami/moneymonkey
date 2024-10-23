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
      age: data['Age'] is int ? data['Age'] : 0,
      knowledgeLevel: data['Knowledge Level'] is int
          ? data['Knowledge Level']
          : 0, // Adjusted to int
      learningGoalPerDay: data['Learning Goal Per Day'] is int
          ? data['Learning Goal Per Day']
          : 0,
      startingLevel: data['Starting Level'] is int
          ? data['Starting Level']
          : 0, // Consistent key usage
      profile: data['Profile'] != null
          ? ProfileData.fromFirestore(data['Profile'])
          : ProfileData(
              // Handle null profile case
              fullName: '',
              username: 'Your Name Here',
              numberOfFollowers: 0,
              following: 0,
              topAchievements: 0,
              streak: 0,
              totalProfit: 0.0,
              portfolioScore: 0.0,
              averageMonthlyGrowth: 0.0),
    );
  }

  // Convert UserData object to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'Email': email,
      'Age': age,
      'Knowledge Level': knowledgeLevel,
      'Learning Goal Per Day': learningGoalPerDay,
      'Starting Level': startingLevel, // Consistent key usage
      'Profile': profile.toFirestore(), // Profile conversion
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
