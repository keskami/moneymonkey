import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Models/Teacher.dart';
import 'package:money_monkey/Backend/Models/settings.dart';

Teacher sampleTeacher = Teacher(
  name: "Mrs. Anderson",
  id: "temporaryTeacherId2025",
  classRooms: [
    Classroom(
      classId: 'tempClassId1_2025',
      name: "Financial Basics 101",
      teacherId: 'temporaryTeacherId2025',
      studentIds: [
        "S123456", // John Doe
        "S789012", // Emma Wilson
        "S345678", // Michael Smith
      ],
      lessonId: 'tempLessonId1_2025',
      upcomingLessonId: 'tempUpcomingLessonId1_2025',
    ),
    Classroom(
      classId: 'tempClassId2_2025',
      name: "Investment Fundamentals",
      teacherId: 'temporaryTeacherId2025',
      studentIds: [
        "S901234", // Sophia Jones
        "S567890", // Daniel Miller
        "S123456", // John Doe (in multiple classes)
      ],
      lessonId: 'tempLessonId2_2025',
      upcomingLessonId: 'tempUpcomingLessonId2_2025',
    ),
    Classroom(
      classId: 'tempClassId3_2025',
      name: "Advanced Trading",
      teacherId: 'temporaryTeacherId2025',
      studentIds: [
        "S901234", // Sophia Jones (in multiple classes)
        "S789012", // Emma Wilson (in multiple classes)
      ],
      lessonId: 'tempLessonId3_2025',
      upcomingLessonId: 'tempUpcomingLessonId3_2025',
    ),
    Classroom(
      classId: 'tempClassId4_2025',
      name: "Personal Finance",
      teacherId: 'temporaryTeacherId2025',
      studentIds: [
        "S567890", // Daniel Miller (in multiple classes)
        "S345678", // Michael Smith (in multiple classes)
      ],
      lessonId: 'tempLessonId4_2025',
      upcomingLessonId: 'tempUpcomingLessonId4_2025',
    ),
  ],
);
Student sampleStudent1 = Student(
  studentId: "S123456",
  email: "john.doe@example.com",
  phoneNumber: "+1234567890",
  age: 22,
  knowledgeLevel: 3,
  learningGoalPerDay: 5,
  startingLevel: 1,
  classRooms: ['tempClassId1_2025', 'tempClassId2_2025'],
  profile: ProfileData(
    fullName: "John Doe",
    username: "john_doe_25",
    numberOfFollowers: 1500,
    following: 180,
    topAchievements: 5,
    streak: 30,
    totalProfit: 2500.75,
    portfolioScore: 88.4,
    averageMonthlyGrowth: 7.5,
  ),
  settings: settingsData,
);

Student sampleStudent2 = Student(
  studentId: "S789012",
  email: "emma.wilson@example.com",
  phoneNumber: "+1987654321",
  age: 20,
  knowledgeLevel: 2,
  learningGoalPerDay: 4,
  startingLevel: 2,
  classRooms: ['tempClassId1_2025', 'tempClassId3_2025'],
  profile: ProfileData(
    fullName: "Emma Wilson",
    username: "emma_w_20",
    numberOfFollowers: 1200,
    following: 210,
    topAchievements: 7,
    streak: 45,
    totalProfit: 3100.50,
    portfolioScore: 91.2,
    averageMonthlyGrowth: 6.8,
  ),
  settings: settingsData,
);

Student sampleStudent3 = Student(
  studentId: "S345678",
  email: "michael.smith@example.com",
  phoneNumber: "+1122334455",
  age: 21,
  knowledgeLevel: 4,
  learningGoalPerDay: 6,
  startingLevel: 1,
  classRooms: ['tempClassId1_2025', 'tempClassId4_2025'],
  profile: ProfileData(
    fullName: "Michael Smith",
    username: "mike_smith21",
    numberOfFollowers: 900,
    following: 150,
    topAchievements: 3,
    streak: 20,
    totalProfit: 1800.25,
    portfolioScore: 85.7,
    averageMonthlyGrowth: 5.9,
  ),
  settings: settingsData,
);

Student sampleStudent4 = Student(
  studentId: "S901234",
  email: "sophia.jones@example.com",
  phoneNumber: "+1654321987",
  age: 19,
  knowledgeLevel: 5,
  learningGoalPerDay: 7,
  startingLevel: 3,
  classRooms: ['tempClassId2_2025', 'tempClassId3_2025'],
  profile: ProfileData(
    fullName: "Sophia Jones",
    username: "sophia_j19",
    numberOfFollowers: 2300,
    following: 310,
    topAchievements: 9,
    streak: 60,
    totalProfit: 4500.80,
    portfolioScore: 95.3,
    averageMonthlyGrowth: 8.2,
  ),
  settings: settingsData,
);

Student sampleStudent5 = Student(
  studentId: "S567890",
  email: "daniel.miller@example.com",
  phoneNumber: "+1765432198",
  age: 23,
  knowledgeLevel: 3,
  learningGoalPerDay: 5,
  startingLevel: 2,
  classRooms: ['tempClassId2_2025', 'tempClassId4_2025'],
  profile: ProfileData(
    fullName: "Daniel Miller",
    username: "danielm_23",
    numberOfFollowers: 1100,
    following: 200,
    topAchievements: 4,
    streak: 35,
    totalProfit: 2700.45,
    portfolioScore: 89.0,
    averageMonthlyGrowth: 7.1,
  ),
  settings: settingsData,
);

SettingsData settingsData = SettingsData(
  preferences: Preferences(
    soundEffects: true,
    audio: true,
    darkMode: true,
  ),
  notifications: Notifications(
    reminders: RemindersNotifications(
      practiceEmail: true,
      practicePhone: false,
      weeklyProgress: true,
      reminderTime: '07:30 AM',
    ),
    friends: FriendsNotifications(
      newFollowerEmail: true,
      newFollowerPhone: false,
      friendActivityEmail: true,
      friendActivityPhone: false,
    ),
    announcements: AnnouncementsNotifications(
      marketingNotificationsEmail: true,
      marketingNotificationsPhone: true,
      educationalTipsEmail: false,
      educationalTipsPhone: true,
    ),
  ),
  privacySettings: PrivacySettings(publicProfile: true),
);
