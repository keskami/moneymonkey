import 'package:money_monkey/Backend/Models/settings.dart';
import 'package:money_monkey/TeacherDashboard/Backend/SampleSyllabusFile.dart';

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
      progress: data['progress'],
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
      'ClassRooms': classRooms ?? [],
      'progress': progress,
      'Profile': profile.toFirestore(),
      'Settings': settings.toFirestore(),
    };
  }

  StudentStatus getCurrentLessonProgress(String componentId) {
    try {
      print("Comparing $componentId and $progress");
      List<String> teacherComps = componentId.split(".");
      List<String> studentComps = progress.split(".");
      print("Comparing $teacherComps and $studentComps");

      // Compare unit numbers
      int unitDiff = int.parse(teacherComps[1]) - int.parse(studentComps[1]);
      if (unitDiff != 0) {
        print(unitDiff > 0);
        return unitDiff > 0 ? StudentStatus.Behind : StudentStatus.Ahead;
      }

      // Compare lesson numbers
      int lessonDiff = int.parse(teacherComps[2]) - int.parse(studentComps[2]);
      if (lessonDiff != 0) {
        print(lessonDiff > 0);
        return lessonDiff > 0 ? StudentStatus.Behind : StudentStatus.Ahead;
      }

      // Compare component numbers
      int componentDiff =
          int.parse(teacherComps[3]) - int.parse(studentComps[3]);
      if (componentDiff > 0) {
        print(componentDiff > 0);
        return StudentStatus.Behind;
      } else if (componentDiff < 0) {
        return StudentStatus.Ahead;
      }

      return StudentStatus.On_Track;
    } catch (e) {
      print('Error calculating progress: $e');
      return StudentStatus.Behind; // Default to behind if there's an error
    }
  }

  double getCurrentUnitProgress(String lessonId) {
    double result = 0.0;
    //Runs from 1-2 because in sample lesson A.{unitN}.{lessonN}.{componentN}
    // We compare only ones at index 1,2
    result += (double.parse(lessonId[4])) - (double.parse(progress[4]));
    //
    result = result /
        (sampleAdvancedSyllabus[int.parse(lessonId[2])].lessonIds.length);
    print("-----------------------------------$result");
    if (result > 0) {
      print("Student is Behind.");
    } else if (result < 0) {
      print("Student is ahead.");
    } else {
      print("On Track.");
    }
    return result;
  }

  static Map<String, List<Student>> categorizeStudents(
      List<Student> students, String currentLessonId) {
    final Map<String, List<Student>> categories = {
      'topPerformers': [],
      'needsSupport': [],
    };

    for (var student in students) {
      // Get current progress metrics
      StudentStatus status = student.getCurrentLessonProgress(currentLessonId);
      double unitProgress = student.getCurrentUnitProgress(currentLessonId);

      // Calculate overall score based on multiple factors
      double overallScore = _calculateOverallScore(
          student.profile.portfolioScore,
          student.profile.streak,
          unitProgress,
          status);

      // Categorize based on overall score
      if (overallScore >= 85) {
        categories['topPerformers']!.add(student);
      } else if (overallScore <= 40 || status == StudentStatus.Behind) {
        categories['needsSupport']!.add(student);
      }
    }

    // Sort both lists by overall performance
    categories['topPerformers']!.sort(
        (a, b) => b.profile.portfolioScore.compareTo(a.profile.portfolioScore));
    categories['needsSupport']!.sort(
        (a, b) => a.profile.portfolioScore.compareTo(b.profile.portfolioScore));

    return categories;
  }

  static double _calculateOverallScore(
    double portfolioScore,
    int streak,
    double unitProgress,
    StudentStatus status,
  ) {
    double score = portfolioScore * 0.4; // 40% weight to portfolio score
    score += (streak / 60) * 25; // 25% weight to streak (normalized to 60 days)

    // 35% weight to progress status
    switch (status) {
      case StudentStatus.Ahead:
        score += 35;
        break;
      case StudentStatus.On_Track:
        score += 25;
        break;
      case StudentStatus.Behind:
        score += 10;
        break;
    }

    // Adjust for unit progress
    if (unitProgress < 0) {
      score *= 0.8; // Reduce score if behind in unit
    }

    return score;
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
