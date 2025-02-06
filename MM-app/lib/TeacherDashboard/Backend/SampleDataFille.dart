import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Models/Teacher.dart';
import 'package:money_monkey/Backend/Models/settings.dart';

Teacher sampleTeacher = Teacher(
  name: "Mrs. Anderson",
  id: "temporaryTeacherId2025",
  classRooms: [],
);
Map<String, Classroom> sampleClassrooms = {
  'tempClassId1_2025': Classroom(
    classId: 'tempClassId1_2025',
    name: "Financial Basics 101",
    teacherId: 'temporaryTeacherId2025',
    studentIds: ["S123456", "S789012", "S345678"],
    lessonId: 'A.1.1.5',
  ),
  'tempClassId2_2025': Classroom(
    classId: 'tempClassId2_2025',
    name: "Investment Fundamentals",
    teacherId: 'temporaryTeacherId2025',
    studentIds: ["S901234", "S567890", "S123456"],
    lessonId: 'A.1.1.5',
  ),
  'tempClassId3_2025': Classroom(
    classId: 'tempClassId3_2025',
    name: "Advanced Trading",
    teacherId: 'temporaryTeacherId2025',
    studentIds: ["S901234", "S789012"],
    lessonId: 'A.1.2.5',
  ),
  'tempClassId4_2025': Classroom(
    classId: 'tempClassId4_2025',
    name: "Personal Finance",
    teacherId: 'temporaryTeacherId2025',
    studentIds: ["S567890", "S345678"],
    lessonId: 'A.1.3.5',
  ),
};
List<Student> sampleStudents = [
  Student(
    studentId: "S123456",
    email: "john.doe@example.com",
    phoneNumber: "+1234567890",
    age: 22,
    knowledgeLevel: 3,
    learningGoalPerDay: 5,
    startingLevel: 1,
    classRooms: ['tempClassId1_2025', 'tempClassId2_2025'],
    progress: "A.1.2.6",
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
  ),
  Student(
    studentId: "S789012",
    email: "emma.wilson@example.com",
    phoneNumber: "+1987654321",
    age: 20,
    knowledgeLevel: 2,
    learningGoalPerDay: 4,
    startingLevel: 2,
    classRooms: ['tempClassId1_2025', 'tempClassId3_2025'],
    progress: "A.1.3.6",
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
  ),
  Student(
    studentId: "S345678",
    email: "michael.smith@example.com",
    phoneNumber: "+1122334455",
    age: 21,
    knowledgeLevel: 4,
    learningGoalPerDay: 6,
    startingLevel: 1,
    classRooms: ['tempClassId1_2025', 'tempClassId4_2025'],
    progress: "A.1.2.1",
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
  ),
  Student(
    studentId: "S901234",
    email: "sophia.jones@example.com",
    phoneNumber: "+1654321987",
    age: 19,
    knowledgeLevel: 5,
    learningGoalPerDay: 7,
    startingLevel: 3,
    classRooms: ['tempClassId2_2025', 'tempClassId3_2025'],
    progress: "A.1.2.1",
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
  ),
  Student(
    studentId: "S567890",
    email: "daniel.miller@example.com",
    phoneNumber: "+1765432198",
    age: 23,
    knowledgeLevel: 3,
    learningGoalPerDay: 5,
    startingLevel: 2,
    classRooms: ['tempClassId2_2025', 'tempClassId4_2025'],
    progress: "A.1.2.7",
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
  ),
];
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
List<Unit> sampleAdvancedSyllabus = [
  Unit(
    unitId: 'A.1',
    title: 'Introduction to Trading',
    description: 'Learn the fundamentals of trading and market analysis',
    lessonIds: ['A.1.1', 'A.1.2', 'A.1.3'],
    unitStatus: Status.Active,
    totalLessons: 15,
    createdAt: DateTime.now(),
  ),
  Unit(
    unitId: 'A.2',
    title: 'Advanced Market Analysis',
    description: 'Master technical and fundamental analysis',
    lessonIds: ['A.2.1', 'A.2.2'],
    unitStatus: Status.Inactive,
    totalLessons: 10,
    createdAt: DateTime.now(),
  ),
];

Map<String, Lesson> sampleLessons = {
  'A.1.1': Lesson(
    lessonId: 'A.1.1',
    title: 'Trading Basics',
    description: 'Understanding market fundamentals',
    lessonStatus: Status.Active,
    components: {
      'A.1.1.1': Component(
        componentId: 'A.1.1.1',
        title: 'What is Trading?',
        type: ComponentType.concept,
        componentStatus: Status.Completed,
      ),
      'A.1.1.2': Component(
        componentId: 'A.1.1.2',
        title: 'Market Types',
        type: ComponentType.interactiveActivity,
        componentStatus: Status.Completed,
      ),
    },
    progress: 100,
    discussionQuestions: ['How do markets function?', 'What moves prices?'],
    performanceTrends: PerformanceTrends(
      label: 'Week 1',
      classAverage: 85,
      participationRate: 0.9,
      lessonCompletion: 1.0,
    ),
    totalComponents: 2,
  ),
  'A.1.2': Lesson(
    lessonId: 'A.1.2',
    title: 'Technical Analysis',
    description: 'Learn to read charts and patterns',
    lessonStatus: Status.Active,
    components: {
      'A.1.2.1': Component(
        componentId: 'A.1.2.1',
        title: 'Chart Basics',
        type: ComponentType.concept,
        componentStatus: Status.Active,
      ),
    },
    progress: 50,
    discussionQuestions: ['What are key chart patterns?'],
    performanceTrends: PerformanceTrends(
      label: 'Week 2',
      classAverage: 78,
      participationRate: 0.85,
      lessonCompletion: 0.7,
    ),
    totalComponents: 1,
  ),
};

final Map<String, List<String>> classLessonProgress = {
  'tempClassId1_2025': ['A.1.1', 'A.1.2', 'A.1.3'],
  'tempClassId2_2025': ['A.1.1', 'A.1.2'],
  'tempClassId3_2025': ['A.2.1', 'A.2.2'],
  'tempClassId4_2025': ['A.1.1'],
};

final Map<String, Map<String, double>> studentPerformance = {
  'S123456': {'A.1.1': 95, 'A.1.2': 88, 'A.1.3': 92},
  'S789012': {'A.1.1': 87, 'A.1.2': 85},
  'S345678': {'A.1.1': 90, 'A.2.1': 85},
  'S901234': {'A.1.1': 93, 'A.1.2': 91},
  'S567890': {'A.1.1': 89, 'A.2.1': 86},
};

Map<String, Component> sampleComponents = {
  'A.1.1.1': Component(
    componentId: 'A.1.1.1',
    title: 'Introduction to Markets',
    type: ComponentType.concept,
    componentStatus: Status.Active,
    progress: 100,
    discussionQuestions: ['What is a financial market?'],
  ),
  'A.1.1.2': Component(
    componentId: 'A.1.1.2',
    title: 'Market Types Quiz',
    type: ComponentType.quiz,
    componentStatus: Status.Active,
    progress: 80,
    questionData: {
      'questions': [
        {'question': 'What is a stock market?', 'correctAnswer': 'A'},
        {'question': 'Define market liquidity', 'correctAnswer': 'B'},
      ]
    },
  ),
  'A.1.2.1': Component(
    componentId: 'A.1.2.1',
    title: 'Reading Charts',
    type: ComponentType.interactiveActivity,
    componentStatus: Status.Inactive,
    progress: 60,
  ),
  'A.1.3.1': Component(
    componentId: 'A.1.3.1',
    title: 'Trading Strategies',
    type: ComponentType.concept,
    componentStatus: Status.Inactive,
    progress: 0,
  ),
};

Map<String, Unit> sampleUnits = {
  'A.1': Unit(
    unitId: 'A.1',
    title: 'Financial Markets Fundamentals',
    description: 'Understanding market basics and trading foundations',
    lessonIds: ['A.1.1', 'A.1.2', 'A.1.3'],
    unitStatus: Status.Active,
    totalLessons: 12,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  'A.2': Unit(
    unitId: 'A.2',
    title: 'Technical Analysis',
    description: 'Learn chart patterns and technical indicators',
    lessonIds: ['A.2.1', 'A.2.2'],
    unitStatus: Status.Inactive,
    totalLessons: 8,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  'I.1': Unit(
    unitId: 'I.1',
    title: 'Risk Management',
    description: 'Master risk assessment and portfolio management',
    lessonIds: ['I.1.1', 'I.1.2'],
    unitStatus: Status.Inactive,
    totalLessons: 10,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
};
