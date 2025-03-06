import 'dart:convert';
import 'dart:io';

import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Models/SubComponentModel.dart';
import 'package:money_monkey/Backend/Models/Teacher.dart';
import 'package:money_monkey/Backend/Models/Settings.dart';
import 'package:money_monkey/TeacherDashboard/Backend/SampleDataFille.dart';

/// A utility class to convert sample data to JSON and back
class SampleDataConverter {
  /// Convert all sample data to a JSON string
  static String convertToJsonString(
    Teacher teacher,
    Map<String, Classroom> classrooms,
    List<Student> students,
    Map<String, Unit> units,
    Map<String, Lesson> lessons,
    Map<String, Component> components,
  ) {
    final Map<String, dynamic> data = {
      'teacher': _convertTeacher(teacher),
      'classrooms': _convertClassrooms(classrooms),
      'students': _convertStudents(students),
      'units': _convertUnits(units),
      'lessons': _convertLessons(lessons),
      'components': _convertComponents(components),
    };

    return jsonEncode(data);
  }

  /// Convert sample data to JSON and save to a file
  static Future<void> saveToFile(
    String filePath,
    Teacher teacher,
    Map<String, Classroom> classrooms,
    List<Student> students,
    Map<String, Unit> units,
    Map<String, Lesson> lessons,
    Map<String, Component> components,
  ) async {
    final jsonString = convertToJsonString(
      teacher,
      classrooms,
      students,
      units,
      lessons,
      components,
    );

    final file = File(filePath);
    await file.writeAsString(jsonString);
    print('Sample data saved to: $filePath');
  }

  /// Load sample data from a JSON file
  static Future<Map<String, dynamic>> loadFromFile(String filePath) async {
    final file = File(filePath);
    final jsonString = await file.readAsString();
    return loadFromJsonString(jsonString);
  }

  /// Load sample data from a JSON string
  static Map<String, dynamic> loadFromJsonString(String jsonString) {
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);

    return {
      'teacher': _parseTeacher(jsonData['teacher']),
      'classrooms': _parseClassrooms(jsonData['classrooms']),
      'students': _parseStudents(jsonData['students']),
      'units': _parseUnits(jsonData['units']),
      'lessons': _parseLessons(jsonData['lessons']),
      'components': _parseComponents(jsonData['components']),
    };
  }

  // Conversion methods for each data type
  static Map<String, dynamic> _convertTeacher(Teacher teacher) {
    return {
      'name': teacher.name,
      'id': teacher.id,
      'classRooms': teacher.classRooms,
      'profilePictureLink': teacher.profilePictureLink,
    };
  }

  static Map<String, dynamic> _convertClassrooms(Map<String, Classroom> classrooms) {
    final result = <String, dynamic>{};
    classrooms.forEach((key, classroom) {
      result[key] = {
        'classId': classroom.classId,
        'name': classroom.name,
        'teacherId': classroom.teacherId,
        'studentIds': classroom.studentIds,
        'lessonId': classroom.lessonId,
      };
    });
    return result;
  }

  static List<Map<String, dynamic>> _convertStudents(List<Student> students) {
    return students.map((student) {
      return {
        'studentId': student.studentId,
        'email': student.email,
        'phoneNumber': student.phoneNumber,
        'age': student.age,
        'knowledgeLevel': student.knowledgeLevel,
        'learningGoalPerDay': student.learningGoalPerDay,
        'startingLevel': student.startingLevel,
        'classRooms': student.classRooms,
        'progress': student.progress,
        'profile': {
          'fullName': student.profile.fullName,
          'username': student.profile.username,
          'numberOfFollowers': student.profile.numberOfFollowers,
          'following': student.profile.following,
          'topAchievements': student.profile.topAchievements,
          'streak': student.profile.streak,
          'totalProfit': student.profile.totalProfit,
          'portfolioScore': student.profile.portfolioScore,
          'averageMonthlyGrowth': student.profile.averageMonthlyGrowth,
        },
        'settings': _convertSettings(student.settings),
      };
    }).toList();
  }

  static Map<String, dynamic> _convertSettings(SettingsData settings) {
    return {
      'preferences': {
        'soundEffects': settings.preferences.soundEffects,
        'audio': settings.preferences.audio,
        'darkMode': settings.preferences.darkMode,
      },
      'notifications': {
        'reminders': {
          'practiceEmail': settings.notifications.reminders.practiceEmail,
          'practicePhone': settings.notifications.reminders.practicePhone,
          'weeklyProgress': settings.notifications.reminders.weeklyProgress,
          'reminderTime': settings.notifications.reminders.reminderTime,
        },
        'friends': {
          'newFollowerEmail': settings.notifications.friends.newFollowerEmail,
          'newFollowerPhone': settings.notifications.friends.newFollowerPhone,
          'friendActivityEmail': settings.notifications.friends.friendActivityEmail,
          'friendActivityPhone': settings.notifications.friends.friendActivityPhone,
        },
        'announcements': {
          'marketingNotificationsEmail': settings.notifications.announcements.marketingNotificationsEmail,
          'marketingNotificationsPhone': settings.notifications.announcements.marketingNotificationsPhone,
          'educationalTipsEmail': settings.notifications.announcements.educationalTipsEmail,
          'educationalTipsPhone': settings.notifications.announcements.educationalTipsPhone,
        },
      },
      'privacySettings': {
        'publicProfile': settings.privacySettings.publicProfile,
      },
    };
  }

  static Map<String, dynamic> _convertUnits(Map<String, Unit> units) {
    final result = <String, dynamic>{};
    units.forEach((key, unit) {
      result[key] = {
        'unitId': unit.unitId,
        'title': unit.title,
        'description': unit.description,
        'lessonIds': unit.lessonIds,
        'unitStatus': statusToFirestore(unit.unitStatus),
        'totalLessons': unit.totalLessons,
        'createdAt': unit.createdAt?.toIso8601String(),
        'updatedAt': unit.updatedAt?.toIso8601String(),
      };
    });
    return result;
  }

  static Map<String, dynamic> _convertLessons(Map<String, Lesson> lessons) {
    final result = <String, dynamic>{};
    lessons.forEach((key, lesson) {
      result[key] = {
        'lessonId': lesson.lessonId,
        'title': lesson.title,
        'description': lesson.description,
        'lessonStatus': statusToFirestore(lesson.lessonStatus),
        'components': lesson.components,
        'progress': lesson.progress,
        'totalComponents': lesson.totalComponents,
        'startedAt': lesson.startedAt?.toIso8601String(),
        'completedAt': lesson.completedAt?.toIso8601String(),
        'interactiveActivityLinks': lesson.interactiveActivityLinks,
        'teachersGuideLink': lesson.teachersGuideLink,
        'studentWorkshopTemplateLinks': lesson.studentWorkshopTemplateLinks,
      };
    });
    return result;
  }

  static Map<String, dynamic> _convertComponents(Map<String, Component> components) {
    final result = <String, dynamic>{};
    components.forEach((key, component) {
      result[key] = {
        'componentId': component.componentId,
        'title': component.title,
        'type': component.type.name,
        'componentStatus': statusToFirestore(component.componentStatus),
        'progress': component.progress,
        'discussionQuestions': component.discussionQuestions,
        'questionData': component.questionData.map((q) => q.toMap()).toList(),
        'performanceTrends': {
          'classAverage': component.performanceTrends.classAverage,
          'participationRate': component.performanceTrends.participationRate,
          'lessonCompletion': component.performanceTrends.lessonCompletion,
          'lastUpdated': component.performanceTrends.lastUpdated?.toIso8601String(),
        },
      };
    });
    return result;
  }

  // Parsing methods for each data type
  static Teacher _parseTeacher(Map<String, dynamic> data) {
    return Teacher(
      name: data['name'],
      id: data['id'],
      classRooms: List<String>.from(data['classRooms']),
      profilePictureLink: data['profilePictureLink'],
    );
  }

  static Map<String, Classroom> _parseClassrooms(Map<String, dynamic> data) {
    final result = <String, Classroom>{};
    data.forEach((key, value) {
      result[key] = Classroom(
        classId: value['classId'],
        name: value['name'],
        teacherId: value['teacherId'],
        studentIds: List<String>.from(value['studentIds']),
        lessonId: value['lessonId'],
      );
    });
    return result;
  }

  static List<Student> _parseStudents(List<dynamic> data) {
    return data.map<Student>((item) {
      return Student(
        studentId: item['studentId'],
        email: item['email'],
        phoneNumber: item['phoneNumber'],
        age: item['age'],
        knowledgeLevel: item['knowledgeLevel'],
        learningGoalPerDay: item['learningGoalPerDay'],
        startingLevel: item['startingLevel'],
        classRooms: List<String>.from(item['classRooms']),
        progress: item['progress'],
        profile: ProfileData(
          fullName: item['profile']['fullName'],
          username: item['profile']['username'],
          numberOfFollowers: item['profile']['numberOfFollowers'],
          following: item['profile']['following'],
          topAchievements: item['profile']['topAchievements'],
          streak: item['profile']['streak'],
          totalProfit: item['profile']['totalProfit'],
          portfolioScore: item['profile']['portfolioScore'],
          averageMonthlyGrowth: item['profile']['averageMonthlyGrowth'],
        ),
        settings: _parseSettings(item['settings']),
      );
    }).toList();
  }

  static SettingsData _parseSettings(Map<String, dynamic> data) {
    return SettingsData(
      preferences: Preferences(
        soundEffects: data['preferences']['soundEffects'],
        audio: data['preferences']['audio'],
        darkMode: data['preferences']['darkMode'],
      ),
      notifications: Notifications(
        reminders: RemindersNotifications(
          practiceEmail: data['notifications']['reminders']['practiceEmail'],
          practicePhone: data['notifications']['reminders']['practicePhone'],
          weeklyProgress: data['notifications']['reminders']['weeklyProgress'],
          reminderTime: data['notifications']['reminders']['reminderTime'],
        ),
        friends: FriendsNotifications(
          newFollowerEmail: data['notifications']['friends']['newFollowerEmail'],
          newFollowerPhone: data['notifications']['friends']['newFollowerPhone'],
          friendActivityEmail: data['notifications']['friends']['friendActivityEmail'],
          friendActivityPhone: data['notifications']['friends']['friendActivityPhone'],
        ),
        announcements: AnnouncementsNotifications(
          marketingNotificationsEmail: data['notifications']['announcements']['marketingNotificationsEmail'],
          marketingNotificationsPhone: data['notifications']['announcements']['marketingNotificationsPhone'],
          educationalTipsEmail: data['notifications']['announcements']['educationalTipsEmail'],
          educationalTipsPhone: data['notifications']['announcements']['educationalTipsPhone'],
        ),
      ),
      privacySettings: PrivacySettings(
        publicProfile: data['privacySettings']['publicProfile'],
      ),
    );
  }

  static Map<String, Unit> _parseUnits(Map<String, dynamic> data) {
    final result = <String, Unit>{};
    data.forEach((key, value) {
      result[key] = Unit(
        unitId: value['unitId'],
        title: value['title'],
        description: value['description'],
        lessonIds: List<String>.from(value['lessonIds']),
        unitStatus: statusFromFirestore(value['unitStatus']),
        totalLessons: value['totalLessons'],
        createdAt: value['createdAt'] != null ? DateTime.parse(value['createdAt']) : null,
        updatedAt: value['updatedAt'] != null ? DateTime.parse(value['updatedAt']) : null,
      );
    });
    return result;
  }

  static Map<String, Lesson> _parseLessons(Map<String, dynamic> data) {
    final result = <String, Lesson>{};
    data.forEach((key, value) {
      result[key] = Lesson(
        lessonId: value['lessonId'],
        title: value['title'],
        description: value['description'],
        lessonStatus: statusFromFirestore(value['lessonStatus']),
        components: List<String>.from(value['components']),
        progress: value['progress'],
        totalComponents: value['totalComponents'],
        startedAt: value['startedAt'] != null ? DateTime.parse(value['startedAt']) : null,
        completedAt: value['completedAt'] != null ? DateTime.parse(value['completedAt']) : null,
        interactiveActivityLinks: List<String>.from(value['interactiveActivityLinks']),
        teachersGuideLink: value['teachersGuideLink'],
        studentWorkshopTemplateLinks: value['studentWorkshopTemplateLinks'],
      );
    });
    return result;
  }

  static Map<String, Component> _parseComponents(Map<String, dynamic> data) {
    final result = <String, Component>{};
    data.forEach((key, value) {
      result[key] = Component(
        componentId: value['componentId'],
        title: value['title'],
        type: ComponentTypeExtension.fromString(value['type']),
        componentStatus: statusFromFirestore(value['componentStatus']),
        progress: value['progress'].toDouble(),
        discussionQuestions: value['discussionQuestions'] != null
            ? List<String>.from(value['discussionQuestions'])
            : null,
        questionData: (value['questionData'] as List)
            .map((q) => SubComponent.fromMap(q))
            .toList(),
        performanceTrends: PerformanceTrends(
          classAverage: value['performanceTrends']['classAverage'],
          participationRate: value['performanceTrends']['participationRate'],
          lessonCompletion: value['performanceTrends']['lessonCompletion'],
          lastUpdated: value['performanceTrends']['lastUpdated'] != null
              ? DateTime.parse(value['performanceTrends']['lastUpdated'])
              : null,
        ),
      );
    });
    return result;
  }
}

// Example usage
void main() async {
  // Convert sample data to JSON and save to file
  await SampleDataConverter.saveToFile(
    'lib/resources/sample_data.json',
    sampleTeacher,
    sampleClassrooms,
    sampleStudents,
    advancedUnits,
    advancedLessons,
    advancedComponents,
  );

  // Load sample data from file
  final loadedData = await SampleDataConverter.loadFromFile('assets/sample_data.json');
  
  // Access loaded data
  final Teacher loadedTeacher = loadedData['teacher'];
  final Map<String, Classroom> loadedClassrooms = loadedData['classrooms'];
  final List<Student> loadedStudents = loadedData['students'];
  final Map<String, Unit> loadedUnits = loadedData['units'];
  final Map<String, Lesson> loadedLessons = loadedData['lessons'];
  final Map<String, Component> loadedComponents = loadedData['components'];

  print('Loaded ${loadedComponents.length} components');
}