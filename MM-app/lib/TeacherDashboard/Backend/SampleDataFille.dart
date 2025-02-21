import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Models/Teacher.dart';
import 'package:money_monkey/Backend/Models/settings.dart';
import 'package:money_monkey/LessonPages/Models/Models.dart';

Teacher sampleTeacher = Teacher(
  name: "Mrs. Anderson",
  id: "temporaryTeacherId2025",
  classRooms: [
    'tempClassId1_2025',
    'tempClassId3_2025',
    'tempClassId4_2025',
  ],
);

Map<String, Classroom> sampleClassrooms = {
  'tempClassId1_2025': Classroom(
    classId: 'tempClassId1_2025',
    name: "Financial Basics 101",
    teacherId: 'temporaryTeacherId2025',
    studentIds: ["S123456", "S789012", "S345678"],
    lessonId: 'A.1.1',
  ),
  'tempClassId2_2025': Classroom(
    classId: 'tempClassId2_2025',
    name: "Investment Fundamentals",
    teacherId: 'temporaryTeacherId2025',
    studentIds: ["S901234", "S567890", "S123456"],
    lessonId: 'A.1.2',
  ),
  'tempClassId3_2025': Classroom(
    classId: 'tempClassId3_2025',
    name: "Advanced Trading",
    teacherId: 'temporaryTeacherId2025',
    studentIds: ["S901234", "S789012"],
    lessonId: 'A.1.4',
  ),
  'tempClassId4_2025': Classroom(
    classId: 'tempClassId4_2025',
    name: "Personal Finance",
    teacherId: 'temporaryTeacherId2025',
    studentIds: ["S567890", "S345678"],
    lessonId: 'A.1.3',
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

Map<String, Unit> advancedUnits = {
  'A.1': Unit(
    unitId: 'A.1',
    title: 'Fundamentals of Trading',
    description: 'Introduction to market structures and trading basics',
    lessonIds: [
      'A.1.1',
      'A.1.2',
      'A.1.3',
      'A.1.4',
      'A.1.5',
    ],
    unitStatus: Status.Active,
    totalLessons: 8,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  'A.2': Unit(
    unitId: 'A.2',
    title: 'Advanced Market Analysis',
    description: 'Master technical and fundamental analysis',
    lessonIds: [
      'A.2.1',
      'A.2.2',
    ],
    unitStatus: Status.Active,
    totalLessons: 8,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
};

// Refactored lessons with no embedded component initializations
Map<String, Lesson> advancedLessons = {
  'A.1.1': Lesson(
    lessonId: 'A.1.1',
    title: 'Market Basics',
    description: 'Understanding financial markets and their structure',
    lessonStatus: Status.Active,
    components:
        List.generate(8, (index) => 'A.1.1.${index + 1}'), // 8 components
    progress: 0,
    performanceTrends: PerformanceTrends(
      label: 'Week 1',
      classAverage: 81.0,
      participationRate: 0.85,
      lessonCompletion: 0.7,
    ),
    totalComponents: 8,
  ),
  'A.1.2': Lesson(
    lessonId: 'A.1.2',
    title: 'Trading Principles',
    description: 'Core principles of successful trading strategies',
    lessonStatus: Status.Active,
    components:
        List.generate(8, (index) => 'A.1.2.${index + 1}'), // 8 components
    progress: 0,
    performanceTrends: PerformanceTrends(
      label: 'Week 2',
      classAverage: 82.0,
      participationRate: 0.87,
      lessonCompletion: 0.72,
    ),
    totalComponents: 8,
  ),
  'A.1.3': Lesson(
    lessonId: 'A.1.3',
    title: 'Risk Management',
    description: 'Understanding and mitigating trading risks',
    lessonStatus: Status.Active,
    components:
        List.generate(6, (index) => 'A.1.3.${index + 1}'), // 6 components
    progress: 0,
    performanceTrends: PerformanceTrends(
      label: 'Week 3',
      classAverage: 83.0,
      participationRate: 0.83,
      lessonCompletion: 0.75,
    ),
    totalComponents: 6,
  ),
  'A.1.4': Lesson(
    lessonId: 'A.1.4',
    title: 'Technical Analysis Basics',
    description: 'Introduction to chart patterns and indicators',
    lessonStatus: Status.Active,
    components:
        List.generate(7, (index) => 'A.1.4.${index + 1}'), // 7 components
    progress: 0,
    performanceTrends: PerformanceTrends(
      label: 'Week 4',
      classAverage: 84.0,
      participationRate: 0.81,
      lessonCompletion: 0.68,
    ),
    totalComponents: 7,
  ),
  'A.1.5': Lesson(
    lessonId: 'A.1.5',
    title: 'Fundamental Analysis',
    description: 'Evaluating assets based on financial metrics',
    lessonStatus: Status.Active,
    components:
        List.generate(6, (index) => 'A.1.5.${index + 1}'), // 6 components
    progress: 0,
    performanceTrends: PerformanceTrends(
      label: 'Week 5',
      classAverage: 85.0,
      participationRate: 0.79,
      lessonCompletion: 0.67,
    ),
    totalComponents: 6,
  ),
  'A.2.1': Lesson(
    lessonId: 'A.2.1',
    title: 'Advanced Chart Patterns',
    description: 'Complex chart formations and their implications',
    lessonStatus: Status.Active,
    components:
        List.generate(8, (index) => 'A.2.1.${index + 1}'), // 8 components
    progress: 0,
    performanceTrends: PerformanceTrends(
      label: 'Advanced Week 1',
      classAverage: 86.0,
      participationRate: 0.88,
      lessonCompletion: 0.76,
    ),
    totalComponents: 8,
  ),
  'A.2.2': Lesson(
    lessonId: 'A.2.2',
    title: 'Trading Psychology',
    description: 'Mental aspects of successful trading',
    lessonStatus: Status.Active,
    components:
        List.generate(5, (index) => 'A.2.2.${index + 1}'), // 5 components
    progress: 0,
    performanceTrends: PerformanceTrends(
      label: 'Advanced Week 2',
      classAverage: 87.0,
      participationRate: 0.86,
      lessonCompletion: 0.74,
    ),
    totalComponents: 5,
  ),
};

// Expanded component database with unique components for each lesson
Map<String, Component> advancedComponents = {
  // Components for Lesson A.1.1
  'A.1.1.1': Component(
    componentId: 'A.1.1.1',
    title: 'What are Financial Markets?',
    type: ComponentType.concept,
    componentStatus: Status.Completed,
    discussionQuestions: [
      "How do financial markets impact everyday life?",
      "What roles do different market participants play?",
      "Why is market efficiency important?",
    ],
    questionData: [
      // A sample multiple choice question
      Question(
        type: QuestionType.multipleChoice,
        data: MultipleChoice(
          question: "What is a financial market?",
          questionExplanation:
              "It is a platform where financial instruments such as stocks and bonds are traded.",
          options: [
            "Stock market",
            "Bond market",
            "Commodity market",
            "Real estate market"
          ],
          correctAnswers: ["Stock market"],
          prompts: Prompt(
            correct: "Correct!",
            incorrect: "Try again. Review the basics of market functions.",
          ),
        ),
      ),
    ],
  ),

  'A.1.1.2': Component(
    componentId: 'A.1.1.2',
    title: 'Market Types Exploration',
    type: ComponentType.interactiveActivity,
    componentStatus: Status.Active,
    discussionQuestions: [
      "How do stocks differ from bonds?",
      "What makes forex markets unique?",
    ],
    questionData: [],
  ),

  'A.1.1.3': Component(
    componentId: 'A.1.1.3',
    title: 'Market Participants',
    type: ComponentType.concept,
    componentStatus: Status.InProgress,
    discussionQuestions: [
      "What motivates institutional investors?",
      "How do retail traders affect market dynamics?",
      "What role do market makers serve?",
    ],
    questionData: [],
  ),

  'A.1.1.4': Component(
    componentId: 'A.1.1.4',
    title: 'The Great Crash of 1929',
    type: ComponentType.story,
    componentStatus: Status.Inactive,
    discussionQuestions: [
      "What lessons can modern investors learn from historical crashes?",
      "How did market regulation evolve after major crashes?",
    ],
    questionData: [],
  ),

  'A.1.1.5': Component(
    componentId: 'A.1.1.5',
    title: 'Market Opening Simulation',
    type: ComponentType.scenarioSimulation,
    componentStatus: Status.Inactive,
    discussionQuestions: [
      "What factors drive price movement at market open?",
      "How should traders approach market volatility periods?",
    ],
    questionData: [],
  ),

  'A.1.1.6': Component(
    componentId: 'A.1.1.6',
    title: 'Analyzing Market News',
    type: ComponentType.peerReflection,
    componentStatus: Status.Inactive,
    discussionQuestions: [
      "How do you identify market-moving news?",
      "What biases affect our interpretation of financial news?",
      "How can we verify the credibility of market information?",
    ],
    questionData: [],
  ),

  'A.1.1.7': Component(
    componentId: 'A.1.1.7',
    title: 'Market Research Resources',
    type: ComponentType.toolkit,
    componentStatus: Status.Active,
    discussionQuestions: [
      "What sources provide reliable market data?",
    ],
    questionData: [],
  ),

  'A.1.1.8': Component(
    componentId: 'A.1.1.8',
    title: 'Market Basics Assessment',
    type: ComponentType.quiz,
    componentStatus: Status.Inactive,
    discussionQuestions: [
      "How well do you understand market structures?",
      "Can you identify different market participants?",
      "Do you understand market terminology?",
    ],
    questionData: [],
  ),

  // Components for Lesson A.1.2
  'A.1.2.1': Component(
    componentId: 'A.1.2.1',
    title: 'Core Trading Concepts',
    type: ComponentType.concept,
    componentStatus: Status.Active,
    discussionQuestions: [
      "What defines a good trading strategy?",
      "How do risk and reward relate in trading?",
      "Why is consistency more important than occasional big wins?",
    ],
    questionData: [],
  ),

  'A.1.2.2': Component(
    componentId: 'A.1.2.2',
    title: 'Trading Journal Exercise',
    type: ComponentType.interactiveActivity,
    componentStatus: Status.Active,
    discussionQuestions: [
      "How does journaling improve trading performance?",
      "What metrics should traders track?",
    ],
    questionData: [],
  ),

  'A.1.2.3': Component(
    componentId: 'A.1.2.3',
    title: 'Position Sizing Strategies',
    type: ComponentType.concept,
    componentStatus: Status.InProgress,
    discussionQuestions: [
      "How does position sizing affect portfolio risk?",
      "What position sizing methods work best for different markets?",
      "When should position sizes be adjusted?",
    ],
    questionData: [],
  ),

  'A.1.2.4': Component(
    componentId: 'A.1.2.4',
    title: 'The Market Wizard',
    type: ComponentType.story,
    componentStatus: Status.Inactive,
    discussionQuestions: [
      "What traits do successful traders share?",
      "How do trading legends handle losing streaks?",
    ],
    questionData: [],
  ),

  'A.1.2.5': Component(
    componentId: 'A.1.2.5',
    title: 'Bull vs Bear Market Trading',
    type: ComponentType.scenarioSimulation,
    componentStatus: Status.Inactive,
    discussionQuestions: [
      "How should strategies adapt to market cycles?",
      "What indicators signal market direction changes?",
    ],
    questionData: [],
  ),

  'A.1.2.6': Component(
    componentId: 'A.1.2.6',
    title: 'Trade Review Session',
    type: ComponentType.peerReflection,
    componentStatus: Status.Inactive,
    discussionQuestions: [
      "What can we learn from examining trades objectively?",
      "How do emotions influence trading decisions?",
      "What patterns emerge from your trading history?",
    ],
    questionData: [],
  ),

  'A.1.2.7': Component(
    componentId: 'A.1.2.7',
    title: 'Trading Plan Template',
    type: ComponentType.toolkit,
    componentStatus: Status.Active,
    discussionQuestions: [
      "What elements make a trading plan effective?",
    ],
    questionData: [],
  ),

  'A.1.2.8': Component(
    componentId: 'A.1.2.8',
    title: 'Trading Principles Evaluation',
    type: ComponentType.quiz,
    componentStatus: Status.Inactive,
    discussionQuestions: [
      "Can you identify proper position sizing techniques?",
      "Do you understand trading plan requirements?",
      "How well can you evaluate risk/reward ratios?",
    ],
    questionData: [],
  ),

  // Components for Lesson A.1.3
  'A.1.3.1': Component(
    componentId: 'A.1.3.1',
    title: 'Risk Management Fundamentals',
    type: ComponentType.concept,
    componentStatus: Status.Active,
    discussionQuestions: [
      "Why do most traders fail due to poor risk management?",
      "How does portfolio diversification reduce risk?",
      "What role does volatility play in risk assessment?",
    ],
    questionData: [],
  ),

  'A.1.3.2': Component(
    componentId: 'A.1.3.2',
    title: 'Stop Loss Calculator',
    type: ComponentType.interactiveActivity,
    componentStatus: Status.Active,
    discussionQuestions: [
      "How tight should stop losses be?",
      "When should trailing stops be used?",
    ],
    questionData: [],
  ),

  'A.1.3.3': Component(
    componentId: 'A.1.3.3',
    title: 'Risk-Reward Ratios',
    type: ComponentType.concept,
    componentStatus: Status.Active,
    discussionQuestions: [
      "What is an acceptable risk-reward ratio?",
      "How do win rates relate to risk-reward ratios?",
      "When should risk parameters be adjusted?",
    ],
    questionData: [],
  ),

  'A.1.3.4': Component(
    componentId: 'A.1.3.4',
    title: 'The Recovered Trader',
    type: ComponentType.story,
    componentStatus: Status.Active,
    discussionQuestions: [
      "How does psychological recovery happen after big losses?",
      "What habits separate resilient traders from others?",
    ],
    questionData: [],
  ),

  'A.1.3.5': Component(
    componentId: 'A.1.3.5',
    title: 'Market Crash Simulation',
    type: ComponentType.scenarioSimulation,
    componentStatus: Status.Active,
    discussionQuestions: [
      "How do your risk management systems hold up under extreme stress?",
      "What contingency plans should traders develop?",
    ],
    questionData: [],
  ),

  'A.1.3.6': Component(
    componentId: 'A.1.3.6',
    title: 'Risk Management Assessment',
    type: ComponentType.quiz,
    componentStatus: Status.Active,
    discussionQuestions: [
      "Can you calculate position sizes based on risk percentages?",
      "Do you understand correlation in portfolio construction?",
      "How well can you design a comprehensive risk management plan?",
    ],
    questionData: [],
  ),

  // Components for A.2.1
  'A.2.1.1': Component(
    componentId: 'A.2.1.1',
    title: 'Complex Chart Pattern Recognition',
    type: ComponentType.concept,
    componentStatus: Status.Active,
    discussionQuestions: [
      "What makes harmonic patterns reliable?",
      "How do volume patterns confirm price patterns?",
      "When do pattern failures provide trading opportunities?",
    ],
    questionData: [],
  ),

  'A.2.1.2': Component(
    componentId: 'A.2.1.2',
    title: 'Pattern Scanner Workshop',
    type: ComponentType.interactiveActivity,
    componentStatus: Status.Active,
    discussionQuestions: [
      "How can pattern recognition be automated?",
      "What filters reduce false pattern signals?",
    ],
    questionData: [],
  ),

  'A.2.1.3': Component(
    componentId: 'A.2.1.3',
    title: 'Multi-timeframe Analysis',
    type: ComponentType.concept,
    componentStatus: Status.Active,
    discussionQuestions: [
      "How do patterns on higher timeframes influence lower ones?",
      "What is the optimal timeframe combination for day trading?",
      "How does fractal theory apply to market patterns?",
    ],
    questionData: [],
  ),

  'A.2.1.4': Component(
    componentId: 'A.2.1.4',
    title: 'The Pattern Master',
    type: ComponentType.story,
    componentStatus: Status.Active,
    discussionQuestions: [
      "What processes do professional pattern traders follow?",
      "How has pattern trading evolved with technology?",
    ],
    questionData: [],
  ),

  'A.2.1.5': Component(
    componentId: 'A.2.1.5',
    title: 'Pattern Trading Simulation',
    type: ComponentType.scenarioSimulation,
    componentStatus: Status.Active,
    discussionQuestions: [
      "How reliable are patterns during different market conditions?",
      "What confirmation indicators strengthen pattern signals?",
    ],
    questionData: [],
  ),

  'A.2.1.6': Component(
    componentId: 'A.2.1.6',
    title: 'Pattern Analysis Review',
    type: ComponentType.peerReflection,
    componentStatus: Status.Active,
    discussionQuestions: [
      "What biases affect our pattern recognition?",
      "How do we evaluate pattern quality objectively?",
      "What statistical methods help validate pattern effectiveness?",
    ],
    questionData: [],
  ),

  'A.2.1.7': Component(
    componentId: 'A.2.1.7',
    title: 'Advanced Pattern Toolkit',
    type: ComponentType.toolkit,
    componentStatus: Status.Active,
    discussionQuestions: [
      "What tools enhance pattern identification accuracy?",
    ],
    questionData: [],
  ),

  'A.2.1.8': Component(
    componentId: 'A.2.1.8',
    title: 'Advanced Pattern Mastery Test',
    type: ComponentType.quiz,
    componentStatus: Status.Active,
    discussionQuestions: [
      "Can you identify complex harmonic patterns?",
      "Do you understand pattern completion ratios?",
      "How well can you integrate patterns with other analysis methods?",
    ],
    questionData: [],
  ),

  // Components for A.2.2 - Trading Psychology
  'A.2.2.1': Component(
    componentId: 'A.2.2.1',
    title: 'The Trader\'s Mind',
    type: ComponentType.concept,
    componentStatus: Status.Active,
    discussionQuestions: [
      "How do cognitive biases affect trading decisions?",
      "What psychological traits define successful traders?",
      "How does stress impact trading performance?",
    ],
    questionData: [],
  ),

  'A.2.2.2': Component(
    componentId: 'A.2.2.2',
    title: 'Emotional Response Tracking',
    type: ComponentType.interactiveActivity,
    componentStatus: Status.Active,
    discussionQuestions: [
      "How do emotions correlate with trading mistakes?",
      "What techniques help manage trading emotions?",
    ],
    questionData: [],
  ),

  'A.2.2.3': Component(
    componentId: 'A.2.2.3',
    title: 'Trading Performance Optimization',
    type: ComponentType.concept,
    componentStatus: Status.Active,
    discussionQuestions: [
      "How do elite performers maintain mental clarity?",
      "What routines support consistent decision-making?",
      "How does mindfulness improve trading results?",
    ],
    questionData: [],
  ),

  'A.2.2.4': Component(
    componentId: 'A.2.2.4',
    title: 'The Mind Trader',
    type: ComponentType.story,
    componentStatus: Status.Active,
    discussionQuestions: [
      "How do professional traders handle prolonged drawdowns?",
      "What mental techniques preserve capital during slumps?",
    ],
    questionData: [],
  ),

  'A.2.2.5': Component(
    componentId: 'A.2.2.5',
    title: 'Trading Psychology Assessment',
    type: ComponentType.quiz,
    componentStatus: Status.Active,
    discussionQuestions: [
      "Can you identify your psychological trading weaknesses?",
      "Do you understand the impact of cognitive biases?",
      "How well can you implement mental performance techniques?",
    ],
    questionData: [],
  ),
};