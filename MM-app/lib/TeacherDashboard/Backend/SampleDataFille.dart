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
    components: List.generate(6, (index) => 'A.1.1.${index + 1}'),
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
        List.generate(6, (index) => 'A.1.1.${index + 1}'), // 6 components
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
          questionHeading: "",
          question:
              "When is the best time to start practicing financial responsibility?",
          questionExplanation: "Before we dive in, let’s see what you think!",
          options: [
            "When I get my first job after college.",
            "When I start earning money, even if it's from chores or an allowance.",
            "Only after I start earning a high salary.",
            "Once I’m ready to start saving for retirement."
          ],
          correctAnswers: [
            "When I start earning money, even if it's from chores or an allowance."
          ],
          prompts: Prompt(
            correct:
                "That’s right! You can start practicing financial responsibility early by saving or budgeting your allowance or earnings from part-time work.",
            incorrect:
                "Not quite! Financial responsibility begins as soon as you start earning money. Learning to manage it early builds healthy habits for life.",
          ),
        ),
      ),
      Question(
        type: QuestionType.revealCard,
        data: RevealCard(
          title: "Definition: Financial Responsibility Over a Lifetime",
          definition:
              "Financial responsibility involves managing your money and other assets in a way that is productive and in your best interest. This includes living within your means, budgeting, saving, investing wisely, and planning for both foreseeable and unforeseen expenses throughout your life.",
          tapInstruction:
              "Click to reveal what it really means to be financially responsible over a lifetime.",
          revealInformation: [
            "Financial responsibility over a lifetime means consistently making informed decisions about earning, saving, spending, and investing, starting from your earliest income and continuing through retirement.",
            "Why does it matter? Because small habits formed early—like setting aside a little money or comparing prices—can grow into long-term financial stability.",
          ],
        ),
      ),
      Question(
        type: QuestionType.iconReveal,
        data: IconReveal(
          title: "Definition: Financial Responsibility Over a Lifetime",
          iconLinks: [
            "assets/icons/teenage_years.png",
            "assets/icons/young_adulthood.png",
            "assets/icons/midlife.png",
            "assets/icons/retirement.png"
          ],
          contents: [
            "Teenage Years: Even small allowances or part-time job earnings can be budgeted. Learning to save a portion of every dollar lays a foundation for bigger financial goals later.",
            "Young Adulthood: This might be your first real job or college experience. Budgeting for regular expenses like rent, utilities, and groceries becomes essential.",
            "Midlife: You might buy a home, manage debt, and start long-term investments. Building an emergency fund and saving for retirement are key priorities.",
            "Retirement: You live off savings, pensions, or investments made earlier. Continued budgeting ensures your money lasts through retirement."
          ],
        ),
      ),
      Question(
        type: QuestionType.scenario,
        data: Scenario(
          title: "Meet Jordan: A Life of Financial Decisions",
          scenarioExplanation:
              "Jordan is on a journey from high school to retirement. Let’s help them make smart financial choices!",
          questions: [
            MultipleChoice(
              questionHeading: "High School",
              question:
                  "Jordan earns \$50/week from chores. Should Jordan save 10% (\$5) or spend it all?",
              questionExplanation:
                  "Starting financial habits early can lead to long-term success.",
              options: [
                "Save 10%",
                "Spend all of it",
              ],
              correctAnswers: ["Save 10%"],
              prompts: Prompt(
                correct:
                    "Great choice! Saving a portion of your earnings builds a habit that can lead to financial security over time.",
                incorrect:
                    "Spending everything means missing out on the chance to build financial habits that pay off in the future.",
              ),
            ),
            MultipleChoice(
              questionHeading: "High School",
              question:
                  "Jordan just started their first job. Should they create a budget or spend as they go?",
              questionExplanation:
                  "Budgeting is key to financial stability and achieving long-term goals.",
              options: [
                "Create a budget",
                "Spend as they go",
              ],
              correctAnswers: ["Create a budget"],
              prompts: Prompt(
                correct:
                    "Smart decision! A budget helps manage spending, ensuring that important goals like savings and bills are covered.",
                incorrect:
                    "Without a budget, it’s easy to overspend and miss out on reaching financial goals.",
              ),
            ),
            MultipleChoice(
              questionHeading: "Family Planning",
              question:
                  "Jordan is planning to start a family. How important is having an emergency fund?",
              questionExplanation:
                  "An emergency fund can provide financial security for unexpected life events.",
              options: [
                "High priority",
                "Not that important",
              ],
              correctAnswers: ["High priority"],
              prompts: Prompt(
                correct:
                    "Yes! An emergency fund protects against unexpected expenses like medical bills or home repairs.",
                incorrect:
                    "Without an emergency fund, unexpected costs can cause serious financial stress.",
              ),
            ),
            MultipleChoice(
              questionHeading: "Retirement",
              question:
                  "Jordan is approaching retirement. Should they continue budgeting?",
              questionExplanation:
                  "Budgeting in retirement ensures financial stability for the years ahead.",
              options: [
                "Yes",
                "No",
              ],
              correctAnswers: ["Yes"],
              prompts: Prompt(
                correct:
                    "Correct! Even in retirement, budgeting helps ensure that savings last for the long haul.",
                incorrect:
                    "Without budgeting, it’s easy to run out of savings before retirement is over.",
              ),
            ),
          ],
        ),
      ),
      Question(
        type: QuestionType.learningCheck,
        data: LearningCheck(
          title: "Quick Check: Lifelong Financial Responsibility",
          question1:
              "Which of the following best describes a responsible way to handle your income?",
          question2: "What is a key benefit of creating a budget?",
          options1: [
            "Spend most of it on things you enjoy, since you earned it.",
            "Save some for emergencies and future goals.",
            "Only worry about saving when you start making a lot of money."
          ],
          options2: [
            "It helps you plan your expenses and save for future goals.",
            "It lets you avoid worrying about how much you spend.",
            "It guarantees you’ll never run out of money."
          ],
          correctAns1: "Save some for emergencies and future goals.",
          correctAns2:
              "It helps you plan your expenses and save for future goals.",
        ),
      ),
      Question(
        type: QuestionType.keyTakeaways,
        data: KeyTakeaways(
          title: "Key Takeaways: Lifelong Financial Responsibility",
          hint: "What’s one new financial habit you’ll adopt this month?",
          takeaways: [
            Takeaway(
              title: "Start Small, Think Big",
              description:
                  "Even saving small amounts early helps build a strong financial foundation over time.",
            ),
            Takeaway(
              title: "Budget for Every Stage",
              description:
                  "Whether it’s your first paycheck or retirement income, budgeting ensures you stay in control of your finances.",
            ),
            Takeaway(
              title: "Be Prepared for the Unexpected",
              description:
                  "Life changes like job transitions or starting a family can bring unexpected expenses—an emergency fund is key.",
            ),
            Takeaway(
              title: "It’s Never Too Late to Improve",
              description:
                  "No matter your age, you can always adjust your financial habits to improve your future stability.",
            ),
          ],
        ),
      ),
    ],
  ),

  // 'A.1.1.2': Component(
  //   componentId: 'A.1.1.2',
  //   title: 'Market Types Exploration',
  //   type: ComponentType.interactiveActivity,
  //   componentStatus: Status.Active,
  //   discussionQuestions: [
  //     "How do stocks differ from bonds?",
  //     "What makes forex markets unique?",
  //   ],
  //   questionData: [
  //   ],
  // ),

  'A.1.1.2': Component(
    componentId: 'A.1.1.2',
    title: 'Market Participants',
    type: ComponentType.concept,
    componentStatus: Status.InProgress,
    discussionQuestions: [
      "What motivates institutional investors?",
      "How do retail traders affect market dynamics?",
      "What role do market makers serve?",
    ],
    questionData: [
      Question(
        type: QuestionType.multipleChoice,
        data: MultipleChoice(
          questionHeading: "",
          question:
              "When is the best time to start practicing financial responsibility?",
          questionExplanation: "Before we dive in, let’s see what you think!",
          options: [
            "When I get my first job after college.",
            "When I start earning money, even if it's from chores or an allowance.",
            "Only after I start earning a high salary.",
            "Once I’m ready to start saving for retirement."
          ],
          correctAnswers: [
            "When I start earning money, even if it's from chores or an allowance."
          ],
          prompts: Prompt(
            correct:
                "That’s right! You can start practicing financial responsibility early by saving or budgeting your allowance or earnings from part-time work.",
            incorrect:
                "Not quite! Financial responsibility begins as soon as you start earning money. Learning to manage it early builds healthy habits for life.",
          ),
        ),
      ),
      Question(
        type: QuestionType.revealCard,
        data: RevealCard(
          title: "Definition: Financial Responsibility Over a Lifetime",
          definition:
              "Financial responsibility involves managing your money and other assets in a way that is productive and in your best interest. This includes living within your means, budgeting, saving, investing wisely, and planning for both foreseeable and unforeseen expenses throughout your life.",
          tapInstruction:
              "Click to reveal what it really means to be financially responsible over a lifetime.",
          revealInformation: [
            "Financial responsibility over a lifetime means consistently making informed decisions about earning, saving, spending, and investing, starting from your earliest income and continuing through retirement.",
            "Why does it matter? Because small habits formed early—like setting aside a little money or comparing prices—can grow into long-term financial stability.",
          ],
        ),
      ),
      Question(
        type: QuestionType.iconReveal,
        data: IconReveal(
          title: "Definition: Financial Responsibility Over a Lifetime",
          iconLinks: [
            "assets/icons/teenage_years.png",
            "assets/icons/young_adulthood.png",
            "assets/icons/midlife.png",
            "assets/icons/retirement.png"
          ],
          contents: [
            "Teenage Years: Even small allowances or part-time job earnings can be budgeted. Learning to save a portion of every dollar lays a foundation for bigger financial goals later.",
            "Young Adulthood: This might be your first real job or college experience. Budgeting for regular expenses like rent, utilities, and groceries becomes essential.",
            "Midlife: You might buy a home, manage debt, and start long-term investments. Building an emergency fund and saving for retirement are key priorities.",
            "Retirement: You live off savings, pensions, or investments made earlier. Continued budgeting ensures your money lasts through retirement."
          ],
        ),
      ),
      Question(
        type: QuestionType.scenario,
        data: Scenario(
          title: "Meet Jordan: A Life of Financial Decisions",
          scenarioExplanation:
              "Jordan is on a journey from high school to retirement. Let’s help them make smart financial choices!",
          questions: [
            MultipleChoice(
              questionHeading: "High School",
              question:
                  "Jordan earns \$50/week from chores. Should Jordan save 10% (\$5) or spend it all?",
              questionExplanation:
                  "Starting financial habits early can lead to long-term success.",
              options: [
                "Save 10%",
                "Spend all of it",
              ],
              correctAnswers: ["Save 10%"],
              prompts: Prompt(
                correct:
                    "Great choice! Saving a portion of your earnings builds a habit that can lead to financial security over time.",
                incorrect:
                    "Spending everything means missing out on the chance to build financial habits that pay off in the future.",
              ),
            ),
            MultipleChoice(
              questionHeading: "High School",
              question:
                  "Jordan just started their first job. Should they create a budget or spend as they go?",
              questionExplanation:
                  "Budgeting is key to financial stability and achieving long-term goals.",
              options: [
                "Create a budget",
                "Spend as they go",
              ],
              correctAnswers: ["Create a budget"],
              prompts: Prompt(
                correct:
                    "Smart decision! A budget helps manage spending, ensuring that important goals like savings and bills are covered.",
                incorrect:
                    "Without a budget, it’s easy to overspend and miss out on reaching financial goals.",
              ),
            ),
            MultipleChoice(
              questionHeading: "Family Planning",
              question:
                  "Jordan is planning to start a family. How important is having an emergency fund?",
              questionExplanation:
                  "An emergency fund can provide financial security for unexpected life events.",
              options: [
                "High priority",
                "Not that important",
              ],
              correctAnswers: ["High priority"],
              prompts: Prompt(
                correct:
                    "Yes! An emergency fund protects against unexpected expenses like medical bills or home repairs.",
                incorrect:
                    "Without an emergency fund, unexpected costs can cause serious financial stress.",
              ),
            ),
            MultipleChoice(
              questionHeading: "Retirement",
              question:
                  "Jordan is approaching retirement. Should they continue budgeting?",
              questionExplanation:
                  "Budgeting in retirement ensures financial stability for the years ahead.",
              options: [
                "Yes",
                "No",
              ],
              correctAnswers: ["Yes"],
              prompts: Prompt(
                correct:
                    "Correct! Even in retirement, budgeting helps ensure that savings last for the long haul.",
                incorrect:
                    "Without budgeting, it’s easy to run out of savings before retirement is over.",
              ),
            ),
          ],
        ),
      ),
      Question(
        type: QuestionType.learningCheck,
        data: LearningCheck(
          title: "Quick Check: Lifelong Financial Responsibility",
          question1:
              "Which of the following best describes a responsible way to handle your income?",
          question2: "What is a key benefit of creating a budget?",
          options1: [
            "Spend most of it on things you enjoy, since you earned it.",
            "Save some for emergencies and future goals.",
            "Only worry about saving when you start making a lot of money."
          ],
          options2: [
            "It helps you plan your expenses and save for future goals.",
            "It lets you avoid worrying about how much you spend.",
            "It guarantees you’ll never run out of money."
          ],
          correctAns1: "Save some for emergencies and future goals.",
          correctAns2:
              "It helps you plan your expenses and save for future goals.",
        ),
      ),
      Question(
        type: QuestionType.keyTakeaways,
        data: KeyTakeaways(
          title: "Key Takeaways: Lifelong Financial Responsibility",
          hint: "What’s one new financial habit you’ll adopt this month?",
          takeaways: [
            Takeaway(
              title: "Start Small, Think Big",
              description:
                  "Even saving small amounts early helps build a strong financial foundation over time.",
            ),
            Takeaway(
              title: "Budget for Every Stage",
              description:
                  "Whether it’s your first paycheck or retirement income, budgeting ensures you stay in control of your finances.",
            ),
            Takeaway(
              title: "Be Prepared for the Unexpected",
              description:
                  "Life changes like job transitions or starting a family can bring unexpected expenses—an emergency fund is key.",
            ),
            Takeaway(
              title: "It’s Never Too Late to Improve",
              description:
                  "No matter your age, you can always adjust your financial habits to improve your future stability.",
            ),
          ],
        ),
      ),
    ],
  ),

  'A.1.1.3': Component(
    componentId: 'A.1.1.3',
    title: 'The Great Crash of 1929',
    type: ComponentType.story,
    componentStatus: Status.Inactive,
    discussionQuestions: [
      "What lessons can modern investors learn from historical crashes?",
      "How did market regulation evolve after major crashes?",
    ],
    questionData: [
      Question(
        type: QuestionType.intro,
        data: IntroPage(
          title: "Financial Responsibility Story",
          mintyText:
              "Meet Minty the Money Monkey! Minty is here to help you make smart financial choices and show you how decisions can impact your future.",
          imageUrl:
              "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMinty.png?alt=media&token=50e15d9a-3fc7-4fdb-9beb-ef2857b68793",
        ),
      ),
      Question(
        type: QuestionType.problem,
        data: ProblemPage(
          title: "Financial Responsibility Story",
          subtitle: "Taking control of your money to build a secure future",
          scenarioText:
              "Alex, a young adult, earns \$4,000 per month but often runs out of money by the end of each month. Let’s help Alex figure out what’s going wrong and how to improve!",
          instructions: "Think and then reveal the problem…",
          problem: "Problem: No control over spending and no savings plan.",
        ),
      ),
      Question(
        type: QuestionType.solution,
        data: SolutionPage(
          title: "Financial Responsibility Story",
          subtitle: "Taking control of your money to build a secure future",
          Card1: [
            "Track Spending",
            "Record every expense to see where the money is going."
          ],
          Card2: [
            "Plan Ahead",
            "Create a monthly budget to manage essential and non-essential expenses."
          ],
          Card3: [
            "Save First",
            "Set aside 20% of income for savings before spending on anything else."
          ],
        ),
      ),
      Question(
        type: QuestionType.impact,
        data: Impact(
          title: "Financial Responsibility Story",
          subtitle: "Taking control of your money to build a secure future",
          beforeContent: [
            "No savings.",
            "Constant stress about money.",
            "No emergency fund."
          ],
          afterContent: [
            "\$800 saved per month.",
            "Peace of mind with a growing emergency fund.",
            "Ready for unexpected expenses."
          ],
        ),
      ),
    ],
  ),

  'A.1.1.4': Component(
    componentId: 'A.1.1.4',
    title: 'Market Opening Simulation',
    type: ComponentType.scenarioSimulation,
    componentStatus: Status.Inactive,
    discussionQuestions: [
      "What factors drive price movement at market open?",
      "How should traders approach market volatility periods?",
    ],
    questionData: [
      Question(
        type: QuestionType.scenariointro,
        data: IntroductionPage(
          scenario:
              "Congratulations! You’ve just started your first part-time job and earned your first paycheck of \$500. You have several things you want to do with the money: buy new sneakers, save for college, and plan for weekend activities. Let’s see how financially responsible you can be!",
          mintyImage: "assets/images/minty.png",
          options: [
            ScenarioOption(
                title: "Sneakers",
                iconUrl:
                    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FStory1%2Fsneakers%201.png?alt=media&token=625bdbab-4e8d-42cd-82b4-8f79a1bedf3f",
                score: 0),
            ScenarioOption(
                title: "College",
                iconUrl:
                    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FStory1%2Fcollege%201.png?alt=media&token=cd5510da-9563-41a8-a2eb-bd13594312a3",
                score: 0),
            ScenarioOption(
                title: "Activities",
                iconUrl:
                    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FStory1%2Factivities%201.png?alt=media&token=8a2aa7b5-e154-4aa9-ae20-44cfc38e01a7",
                score: 0),
          ],
        ),
      ),
      Question(
        type: QuestionType.scenarioquestion,
        data: [
          ScenarioQuestion(
              questionText: "How much will you save?",
              options: [
                ScenarioOption(
                    title: "Save \$250 (50%)",
                    iconUrl: "Maximum savings for future goals",
                    score: 20),
                ScenarioOption(
                    title: "Save \$100 (20%)",
                    iconUrl: "Moderate savings approach",
                    score: 30),
                ScenarioOption(
                    title: "Save \$0 (0%)", 
                    iconUrl: "No savings", 
                    score: 20)
              ],
              feedback: {
                "Save \$250 (50%)":
                    "Great choice! Saving a significant portion ensures you’re planning for the future.",
                "Save \$100 (20%)": "Bad choice!",
                "Save \$0 (0%)": "Bad Choice!",
              }),
          ScenarioQuestion(
              questionText: "What about those \$150 sneakers?",
              options: [
                ScenarioOption(
                    title: "Buy Now (\$150)",
                    iconUrl: "Get them immediately",
                    score: 15),
                ScenarioOption(
                    title: "Wait for Next Paycheck",
                    iconUrl: "Practice patience",
                    score: 10),
                ScenarioOption(
                    title: "Buy Cheaper Option (\$75)",
                    iconUrl: "Find a balance",
                    score: 20),
              ],
              feedback: {
                "Buy Now (\$150)":
                    "Great choice! Saving a significant portion ensures you’re planning for the future.",
                "Wait for Next Paycheck": "Bad choice!",
                "Buy Cheaper Option (\$75)": "Bad Choice!",
              }),
          ScenarioQuestion(
              questionText: "Planning for emergencies",
              options: [
                ScenarioOption(
                    title: "Set aside \$150",
                    iconUrl: "Strong emergency fund",
                    score: 15),
                ScenarioOption(
                    title: "Set aside \$50",
                    iconUrl: "Small emergency fund",
                    score: 25),
                ScenarioOption(
                    title: "Keep Nothing for Emergencies",
                    iconUrl: "Spend it all",
                    score: 30),
              ],
              feedback: {
                "Set aside \$150":
                    "Great choice! Saving a significant portion ensures you’re planning for the future.",
                "Set aside \$50": "Bad choice!",
                "Keep Nothing for Emergencies": "Bad Choice!",
              }),
        ],
      ),
      Question(
        type: QuestionType.scenarioresults,
        data: ScenarioResult.fromMap({
          "selectedChoices": [
            {
              "category": "Savings",
              "value": 250,
              "scoreImpact": 40,
            },
            {
              "category": "Sneakers",
              "value": 0,
              "scoreImpact": 0,
            },
            {
              "category": "Emergency Fund",
              "value": 150,
              "scoreImpact": 40,
            },
            {
              "category": "Remaining",
              "value": 100,
              "scoreImpact": 20,
            }
          ]
        }),
      ),
    ],
  ),

  'A.1.1.5': Component(
    componentId: 'A.1.1.5',
    title: 'Analyzing Market News',
    type: ComponentType.peerReflection,
    componentStatus: Status.Inactive,
    discussionQuestions: [
      "How do you identify market-moving news?",
      "What biases affect our interpretation of financial news?",
      "How can we verify the credibility of market information?",
    ],
    questionData: [
      Question(
        type: QuestionType.peerintro,
        data: PeerReflectionIntro(
          title: "Taking Responsibility for Personal Financial Decisions",
          subTitle:
              "Taking responsibility for your finances means adapting your approach as your life circumstances change. Whether you’re managing your own finances or supporting others, smart decision-making is key to building long-term financial stability.",
          characters: [
            PeerCharacter(
              name: "Liam",
              role: "The Goal Setter",
              story:
                  "Liam started saving money from a part-time job in high school. Now in his mid-20s, he’s working toward buying his first home while continuing to invest in his retirement fund.",
              imageUrl: "assets/images/liam.png",
            ),
            PeerCharacter(
              name: "Sophia",
              role: "The Family Caregiver",
              story:
                  "Sophia, a mother of three, manages her family’s expenses, ensuring her kids have what they need for school and extracurricular activities. She also focuses on building an emergency fund to protect her family from unexpected events.",
              imageUrl: "assets/images/sophia.png",
            ),
            PeerCharacter(
              name: "Ethan",
              role: "The Independent Investor",
              story:
                  "Ethan is in his early 30s and has chosen to focus on personal development and financial growth. He regularly invests in stocks and mutual funds, aiming to grow his wealth over time while planning for big future goals like starting his own business.",
              imageUrl: "assets/images/ethan.png",
            ),
          ],
        ),
      ),
      Question(
        type: QuestionType.peerstories,
        data: PeerStories(
          title: "Peer Stories",
          characters: [
            PeerCharacter(
              name: "Liam",
              role: "The Goal Setter",
              story:
                  "Liam started saving money from a part-time job in high school. Now in his mid-20s, he’s working toward buying his first home while continuing to invest in his retirement fund.",
              imageUrl: "assets/images/liam.png",
            ),
            PeerCharacter(
              name: "Sophia",
              role: "The Family Caregiver",
              story:
                  "Sophia, a mother of three, manages her family’s expenses, ensuring her kids have what they need for school and extracurricular activities. She also focuses on building an emergency fund to protect her family from unexpected events.",
              imageUrl: "assets/images/sophia.png",
            ),
            PeerCharacter(
              name: "Ethan",
              role: "The Independent Investor",
              story:
                  "Ethan is in his early 30s and has chosen to focus on personal development and financial growth. He regularly invests in stocks and mutual funds, aiming to grow his wealth over time while planning for big future goals like starting his own business.",
              imageUrl: "assets/images/ethan.png",
            ),
          ],
        ),
      ),
      Question(
        type: QuestionType.peermatch,
        data: PeerMatch(
          title: "Match Actions to Categories",
          categories: [
            MatchCategory(
              title: "Lifelong Financial Well-Being",
              correctActions: [
                "Investing in retirement funds",
                "Saving for a first home",
                "Planning for long-term goals",
              ],
            ),
            MatchCategory(
              title: "Responsibility with Dependents",
              correctActions: [
                "Building an emergency fund",
                "Saving for children’s education",
                "Flexible budgeting for family needs",
              ],
            ),
            MatchCategory(
              title: "Responsibility without Dependents",
              correctActions: [
                "Starting a business fund",
                "Personal investment portfolio",
              ],
            ),
          ],
          actions: [
            "Investing in retirement funds",
            "Building an emergency fund",
            "Saving for children’s education",
            "Starting a business fund",
            "Saving for a first home",
            "Flexible budgeting for family needs",
            "Personal investment portfolio",
            "Planning for long-term goals",
          ],
          feedbackMessages: {
            "correct":
                "That's right! Financial responsibility can start early, from your first paycheck or allowance.",
            "incorrect":
                "Oops! Coins have been used since ancient Rome, but currency in the oldest form of money is still in use.",
          },
        ),
      ),
      Question(
        type: QuestionType.peerreflectionend,
        data: PeerReflectionEnd(
          question:
              "Which peer’s financial situation do you relate to most? Why?",
          options: [
            ReflectionOption(
              name: "Liam",
              description:
                  "Liam, because I’m focused on achieving long-term goals like buying a home.",
              imageUrl: "assets/images/liam.png",
            ),
            ReflectionOption(
              name: "Sophia",
              description:
                  "Sophia, because I have to balance family needs with future savings.",
              imageUrl: "assets/images/sophia.png",
            ),
            ReflectionOption(
              name: "Ethan",
              description:
                  "Ethan, because I’m working on growing my personal wealth and investments.",
              imageUrl: "assets/images/ethan.png",
            ),
          ],
          feedbackMessages: {
            "Liam":
                "That’s right! Working toward long-term goals like buying a home requires a disciplined approach to saving and investing.",
            "Sophia":
                "Good thinking! Managing family expenses while building a safety net is crucial when supporting others.",
            "Ethan":
                "Great choice! Without dependents, you can focus more on personal financial growth and taking calculated investment risks.",
          },
          buttonText: "Finish Peer Reflection",
        ),
      ),
    ],
  ),

  'A.1.1.6': Component(
    componentId: 'A.1.1.6',
    title: 'Market Basics Assessment',
    type: ComponentType.quiz,
    componentStatus: Status.Inactive,
    discussionQuestions: [
      "How well do you understand market structures?",
      "Can you identify different market participants?",
      "Do you understand market terminology?",
    ],
    questionData: [
      Question(
        type: QuestionType.quiztextmcquestion,
        data: TextBasedQuestion(
          question: "What is a key reason to start saving early in life?",
          options: [
            "To build good financial habits over time",
            "To buy expensive luxury items immediately",
            "To avoid making a budget",
            "To spend without worrying about the future",
          ],
          correctAnswers: ["To build good financial habits over time"],
          feedbackMessages: {
            "To build good financial habits over time":
                "Correct! Starting early helps you develop smart money habits that last a lifetime.",
            "To buy expensive luxury items immediately":
                "Not quite! Financial responsibility focuses on long-term stability rather than instant gratification.",
            "To avoid making a budget":
                "Incorrect! Budgeting is a key part of financial planning.",
            "To spend without worrying about the future":
                "Not quite! Planning and saving early helps ensure financial security.",
          },
          isMultiSelect: false,
          buttonText: "Check Answer",
        ),
      ),
      Question(
        type: QuestionType.quizimagemcquestion,
        data: QuizMultipleChoice(
          question:
              "Which of the following is an example of a long-term financial goal?",
          options: [
            QuizOption(
                text: "Saving for a concert ticket",
                imageUrl: "assets/images/concert_ticket.png"),
            QuizOption(
                text: "Planning for college tuition",
                imageUrl: "assets/images/college.png"),
            QuizOption(
                text: "Saving for retirement",
                imageUrl: "assets/images/retirement.png"),
            QuizOption(
                text: "Buying a new phone",
                imageUrl: "assets/images/phone.png"),
          ],
          correctAnswers: ["Saving for retirement"],
          feedbackMessages: {
            "Saving for retirement":
                "Correct! Retirement savings require long-term financial planning.",
            "Saving for a concert ticket":
                "Not quite! This is a short-term goal.",
            "Planning for college tuition": "This is a medium-term goal.",
            "Buying a new phone":
                "Incorrect! Buying a phone is usually a short-term purchase.",
          },
          isMultiSelect: false,
          buttonText: "Check Answer",
        ),
      ),
      Question(
        type: QuestionType.quiztextmcquestion,
        data: QuizMultipleChoice(
          question:
              "Which of the following are good strategies for financial responsibility? (Select all that apply)",
          options: [
            QuizOption(text: "Set aside money for emergencies"),
            QuizOption(text: "Spend all your income on entertainment"),
            QuizOption(text: "Create a budget and stick to it"),
            QuizOption(text: "Ignore long-term financial goals"),
          ],
          correctAnswers: [
            "Set aside money for emergencies",
            "Create a budget and stick to it"
          ],
          feedbackMessages: {
            "Set aside money for emergencies":
                "Correct! An emergency fund helps cover unexpected expenses.",
            "Spend all your income on entertainment":
                "Incorrect! Financial responsibility means balancing spending and saving.",
            "Create a budget and stick to it":
                "Correct! Budgeting helps you manage expenses effectively.",
            "Ignore long-term financial goals":
                "Not quite! Planning for the future is a key part of financial stability.",
          },
          isMultiSelect: true,
          buttonText: "Submit",
        ),
      ),
      Question(
        type: QuestionType.quiztextmcquestion,
        data: TextBasedQuestion(
          question: "Why is it important to have an emergency fund?",
          options: [
            "To cover unexpected expenses",
            "To buy luxury items",
            "To invest in risky stocks",
            "To avoid working a job",
          ],
          correctAnswers: ["To cover unexpected expenses"],
          feedbackMessages: {
            "To cover unexpected expenses":
                "Correct! Emergency funds provide financial security for unexpected costs.",
            "To buy luxury items":
                "Incorrect! Emergency funds should be used for necessary expenses, not luxuries.",
            "To invest in risky stocks":
                "Not quite! Investments should be separate from emergency savings.",
            "To avoid working a job":
                "Wrong choice! An emergency fund is meant to support you in emergencies, not avoid work.",
          },
          isMultiSelect: false,
          buttonText: "Check Answer",
        ),
      ),
      Question(
        type: QuestionType.quiztextmcquestion,
        data: QuizMultipleChoice(
          question:
              "Which actions demonstrate financial responsibility? (Select all that apply)",
          options: [
            QuizOption(text: "Planning for future expenses"),
            QuizOption(text: "Setting financial goals"),
            QuizOption(text: "Spending without tracking expenses"),
            QuizOption(text: "Regularly contributing to savings"),
          ],
          correctAnswers: [
            "Planning for future expenses",
            "Setting financial goals",
            "Regularly contributing to savings"
          ],
          feedbackMessages: {
            "Planning for future expenses":
                "Correct! Preparing for future expenses is a sign of financial responsibility.",
            "Setting financial goals":
                "Correct! Goals provide direction for saving and spending wisely.",
            "Spending without tracking expenses":
                "Incorrect! Tracking spending is important for managing finances effectively.",
            "Regularly contributing to savings":
                "Correct! Saving consistently builds financial security over time.",
          },
          isMultiSelect: true,
          buttonText: "Submit",
        ),
      ),
    ],
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
