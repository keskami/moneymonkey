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
    title: 'Financial and Decision Making',
    description: 'Learn the fundamentals of financial and decision making',
    lessonIds: ['A.1.1', 'A.1.2', 'A.1.3', 'A.1.4', 'A.1.5', 'A.1.6'],
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
      // 'A.1.3',
      // 'A.1.4',
      // 'A.1.5',
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
    title: 'Financial Reponsibility',
    description: 'Responsibility for personal finance decisions',
    lessonStatus: Status.Active,
    components: List.generate(6, (index) => 'A.1.1.${index + 1}'),
    progress: 0,
    totalComponents: 8,
  ),
  'A.1.2': Lesson(
    lessonId: 'A.1.2',
    title: 'Trading Principles',
    description: 'Core principles of successful trading strategies',
    lessonStatus: Status.Active,
    components:
        List.generate(6, (index) => 'A.1.2.${index + 1}'), // 6 components
    progress: 0,

    totalComponents: 8,
  ),
  // 'A.1.3': Lesson(
  //   lessonId: 'A.1.3',
  //   title: 'Risk Management',
  //   description: 'Understanding and mitigating trading risks',
  //   lessonStatus: Status.Active,
  //   components:
  //       List.generate(6, (index) => 'A.1.3.${index + 1}'), // 6 components
  //   progress: 0,

  //   totalComponents: 6,
  // ),
  // 'A.1.4': Lesson(
  //   lessonId: 'A.1.4',
  //   title: 'Technical Analysis Basics',
  //   description: 'Introduction to chart patterns and indicators',
  //   lessonStatus: Status.Active,
  //   components:
  //       List.generate(7, (index) => 'A.1.4.${index + 1}'), // 7 components
  //   progress: 0,

  //   totalComponents: 7,
  // ),
  // 'A.1.5': Lesson(
  //   lessonId: 'A.1.5',
  //   title: 'Fundamental Analysis',
  //   description: 'Evaluating assets based on financial metrics',
  //   lessonStatus: Status.Active,
  //   components:
  //       List.generate(6, (index) => 'A.1.5.${index + 1}'), // 6 components
  //   progress: 0,

  //   totalComponents: 6,
  // ),
  'A.2.1': Lesson(
    lessonId: 'A.2.1',
    title: 'Advanced Chart Patterns',
    description: 'Complex chart formations and their implications',
    lessonStatus: Status.Active,
    components:
        List.generate(8, (index) => 'A.2.1.${index + 1}'), // 8 components
    progress: 0,

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

    totalComponents: 5,
  ),
};

// Expanded component database with unique components for each lesson
Map<String, Component> advancedComponents = {
  // Components for Lesson A.1.1
  'A.1.1.1': Component(
    componentId: 'A.1.1.1',
    title: 'Concept: Financial Responsibility over a Lifetime',
    type: ComponentType.concept,
    componentStatus: Status.Completed,
    discussionQuestions: [
      "How do financial priorities shift from teenage years to retirement?",
      "What challenges do people face when managing money at different life stages?",
      "Why is it important to budget and save consistently over time?",
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
          whyMatter:
            "Why does it matter? Because small habits formed early—like setting aside a little money or comparing prices—can grow into long-term financial stability.",
        ),
      ),
      Question(
        type: QuestionType.iconReveal,
        data: IconReveal(
          title: "Definition: Financial Responsibility Over a Lifetime",
          iconLinks: [
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fcard.png?alt=media&token=d9ad44a7-c607-4a88-9c8b-64d49e47a245",
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fgraduation-cap.png?alt=media&token=53e1203d-816d-4512-b570-db886d53d904",
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fbriefcase-bag.png?alt=media&token=987a2538-9376-46ef-965e-502cf493d798",
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fsunset.png?alt=media&token=2ebd97df-6903-4254-bd15-3a59c404825b"
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
          correctAns2: "It helps you plan your expenses and save for future goals.",
          feedbackCorrect: "Great job! Responsible financial habits help you build stability and plan for the future. Keep it up!",
          feedbackOneIncorrect: "Almost there! Remember, good financial habits involve planning ahead and making informed decisions. Try again!",
          feedbackBothIncorrect: "Be careful! Managing money wisely means saving, budgeting, and making informed choices. Review the lesson and try again!"
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
              imageUrl: 
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fcheck.png?alt=media&token=8bca0178-2264-4919-828d-4492cd6680e7",
            ),
            Takeaway(
              title: "Budget for Every Stage",
              description:
                  "Whether it’s your first paycheck or retirement income, budgeting ensures you stay in control of your finances.",
              imageUrl: 
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fcheck.png?alt=media&token=8bca0178-2264-4919-828d-4492cd6680e7",
            ),
            Takeaway(
              title: "Be Prepared for the Unexpected",
              description:
                  "Life changes like job transitions or starting a family can bring unexpected expenses—an emergency fund is key.",
              imageUrl: 
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fcheck.png?alt=media&token=8bca0178-2264-4919-828d-4492cd6680e7",
            ),    
            Takeaway(
              title: "It’s Never Too Late to Improve",
              description:
                  "No matter your age, you can always adjust your financial habits to improve your future stability.",
              imageUrl: 
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fcheck.png?alt=media&token=8bca0178-2264-4919-828d-4492cd6680e7",    
            ),
          ],
        ),
      ),
    ],
    performanceTrends: PerformanceTrends(
      classAverage: 45,
      participationRate: 78,
      lessonCompletion: 54,
    ),
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
    title: 'Concept: Flying Solo vs Supporting Others',
    type: ComponentType.concept,
    componentStatus: Status.InProgress,
    discussionQuestions: [
      "How do financial responsibilities change when someone has dependents?",
      "What are some financial advantages and challenges of managing money independently?",
      "Why is it important to plan for unexpected expenses, especially when supporting others?",
    ],
    questionData: [
      // Multiple Choice Question
      Question(
        type: QuestionType.multipleChoice,
        data: MultipleChoice(
          questionHeading: "",
          question: "How does financial responsibility typically change when someone has dependents?",
          questionExplanation: "Before we dive in, let’s see what you think!",
          options: [
            "They can focus entirely on personal goals, like travel and entertainment.",
            "They need to prioritize the needs of their dependents, like food, healthcare, and education.",
            "They no longer need to save money.",
            "They should take on debt to maintain their previous lifestyle."
          ],
          correctAnswers: [
            "They need to prioritize the needs of their dependents, like food, healthcare, and education."
          ],
          prompts: Prompt(
            correct: "That’s right! When someone has dependents, their financial priorities shift toward providing for others, which may include housing, healthcare, and education.",
            incorrect: "Not quite! Individuals with dependents must balance personal goals with the responsibility of supporting others, which often involves saving, budgeting, and planning for family needs.",
          ),
        ),
      ),

      // Reveal Card: Definition of Financial Responsibility
      Question(
        type: QuestionType.revealCard,
        data: RevealCard(
          title: "Definition: Flying Solo vs. Supporting Others",
          definition: "Financial responsibility differs significantly based on whether a person is supporting just themselves or others (e.g., children or family members).",
          tapInstruction: "Click to reveal how financial priorities change based on dependents.",
          whyMatter: "Financial priorities change when supporting others, requiring careful budgeting for essentials like housing, healthcare, and education.",
        ),
      ),

      // Icon Reveal: Financial Priorities Based on Life Situation
      Question(
        type: QuestionType.iconReveal,
        data: IconReveal(
          title: "Definition: How Responsibilities Change Based on Dependents",
          iconLinks: [
            "assets/icons/flying_solo.png",
            "assets/icons/supporting_family.png"
          ],
          contents: [
            "Flying Solo: More financial flexibility, focusing on personal growth, investing, and building long-term wealth.",
            "Supporting Others: Requires budgeting for dependents’ needs like food, healthcare, education, and maintaining a strong emergency fund."
          ],
        ),
      ),

      // Scenario-Based Learning: Meet Alex
      Question(
        type: QuestionType.scenario,
        data: Scenario(
          title: "Meet Alex: Navigating Financial Responsibility",
          scenarioExplanation: "Alex is a 28-year-old living in the city, navigating financial decisions in two different life situations. Let’s help them make wise choices!",
          questions: [
            MultipleChoice(
              questionHeading: "Flying Solo",
              question: "Alex just got a raise. Should he:",
              questionExplanation: "Alex is currently responsible for only himself. What’s the best financial move?",
              options: [
                "Increase his spending on leisure activities.",
                "Increase his savings rate.",
                "Spend most of the raise on a new desk setup."
              ],
              correctAnswers: ["Increase his savings rate."],
              prompts: Prompt(
                correct: "Good choice! Increasing savings helps Alex prepare for future goals like buying a home or investing.",
                incorrect: "Not quite! While spending on leisure is fine in moderation, prioritizing savings builds long-term financial security.",
              ),
            ),
            MultipleChoice(
              questionHeading: "Supporting a Family",
              question: "Alex now supports a family and has an unexpected car repair. Should he:",
              questionExplanation: "With dependents relying on him, how should Alex handle an unexpected expense?",
              options: [
                "Use their emergency fund.",
                "Put it on a high-interest credit card.",
                "Delay the repair until they can afford it."
              ],
              correctAnswers: ["Use their emergency fund."],
              prompts: Prompt(
                correct: "Great job! An emergency fund is designed to handle unexpected expenses without disrupting the family’s financial stability.",
                incorrect: "Not quite! Putting it on a high-interest credit card or delaying the repair could lead to bigger financial problems later.",
              ),
            ),
          ],
        ),
      ),

      // Learning Check: Quick Check on Financial Responsibility for Different Situations
      Question(
        type: QuestionType.learningCheck,
        data: LearningCheck(
          title: "Quick Check: Flying Solo vs. Supporting Others",
          question1: "Which of the following is the best financial strategy for someone with dependents?",
          question2: "Why might someone without dependents have a greater ability to take financial risks?",
          options1: [
            "Focusing solely on paying off debt, even if it means cutting necessary expenses.",
            "Investing all available income in high-risk opportunities to grow wealth quickly.",
            "Building a family emergency fund and prioritizing essential expenses."
          ],
          options2: [
            "They don’t have to budget or plan their expenses.",
            "They can allocate more income toward personal financial growth, such as investments."
            "They don’t need to save money for future emergencies."
          ],
          correctAns1: "Building a family emergency fund and prioritizing essential expenses.",
          correctAns2: "They can allocate more income toward personal financial growth, such as investments.",
          feedbackCorrect: "Great job! Financial responsibilities shift when supporting others, and those without dependents often have more flexibility in taking financial risks.",
          feedbackOneIncorrect: "Almost there! Remember, having dependents requires balancing essential expenses, while financial flexibility depends on individual circumstances.",
          feedbackBothIncorrect: "Be careful! Managing finances wisely depends on life circumstances—supporting dependents requires budgeting, while financial freedom comes with careful planning.",
        ),
      ),

      // Key Takeaways: Summary of Lesson
      Question(
        type: QuestionType.keyTakeaways,
        data: KeyTakeaways(
          title: "Key Takeaways: Flying Solo vs. Supporting Others",
          hint: "How do financial responsibilities change when supporting dependents?",
          takeaways: [
            Takeaway(
              title: "Financial Priorities Change",
              description: "Supporting dependents shifts financial goals toward providing for others and ensuring family stability.",
              imageUrl: 
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fcheck.png?alt=media&token=8bca0178-2264-4919-828d-4492cd6680e7",
            ),
            Takeaway(
              title: "Emergency Funds Are Crucial",
              description: "Families face more unexpected expenses, making an emergency fund even more critical.",
              imageUrl: 
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fcheck.png?alt=media&token=8bca0178-2264-4919-828d-4492cd6680e7",
            ),
            Takeaway(
              title: "Flexibility for Individuals Without Dependents",
              description: "Without dependents, there’s more room for personal financial growth, such as investing or pursuing personal interests.",
              imageUrl: 
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fcheck.png?alt=media&token=8bca0178-2264-4919-828d-4492cd6680e7",
            ),
            Takeaway(
              title: "Planning is Key",
              description: "Whether supporting others or flying solo, long-term planning ensures financial security.",
              imageUrl: 
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fcheck.png?alt=media&token=8bca0178-2264-4919-828d-4492cd6680e7",
            ),
          ],
        ),
      ),
    ],
    performanceTrends: PerformanceTrends(
      classAverage: 86,
      participationRate: 54,
      lessonCompletion: 59,
    ),
  ),

  'A.1.1.3': Component(
    componentId: 'A.1.1.3',
    title: 'Story: Financial Responsibility',
    type: ComponentType.story,
    componentStatus: Status.Inactive,
    discussionQuestions: [
      "How do financial habits developed early in life impact long-term stability?",
      "What challenges might someone face when trying to manage money responsibly?",
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
    performanceTrends: PerformanceTrends(
      classAverage: 74,
      participationRate: 81,
      lessonCompletion: 73,
    ),
  ),

  'A.1.1.4': Component(
    componentId: 'A.1.1.4',
    title: 'Scenario Simulation: Managing Your First Paycheck',
    type: ComponentType.scenarioSimulation,
    componentStatus: Status.InProgress,
    discussionQuestions: [
      "Why is it important to save a portion of your paycheck?",
      "How can delaying a purchase benefit your long-term financial goals?",
      "What are the risks of not having an emergency fund?",
    ],
    questionData: [
      Question(
        type: QuestionType.scenariointro,
        data: IntroductionPage(
          scenario:
              "Congratulations! You’ve just started your first part-time job and earned your first paycheck of \$500. You have several things you want to do with the money: buy new sneakers, save for college, and plan for weekend activities. Let’s see how financially responsible you can be!",
          mintyImage: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2FMinty.png?alt=media&token=f08ea8f6-fe3c-4a9d-8be2-a40a28f0c51c",
           options: [
            ScenarioOption(
                title: "Sneakers",
                iconUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fsneakers%201.png?alt=media&token=2202c42d-edba-4200-b501-b04a13af03d4",
                score: 0,
                type: ""),
            ScenarioOption(
                title: "College",
                iconUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fcollegehat.png?alt=media&token=28948378-e9e6-455a-927c-cd1d0b118e69",
                score: 0,
                type: ""),
            ScenarioOption(
                title: "Activities",
                iconUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Factivities%201.png?alt=media&token=272d0e9f-12f2-4508-89f4-3e682e1b307b",
                score: 0,
                type: ""),
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
                    iconUrl: "assets/images/save_250.png",
                    score: 40,
                    type: ""),
                ScenarioOption(
                    title: "Save \$100 (20%)",
                    iconUrl: "assets/images/save_100.png",
                    score: 20,
                    type: ""),
                ScenarioOption(
                    title: "Save \$0 (0%)",
                    iconUrl: "assets/images/save_0.png",
                    score: 0,
                    type: "")
              ],
              feedback: {
                "Save \$250 (50%)": "Great choice! Saving a significant portion ensures you’re planning for the future.",
                "Save \$100 (20%)": "Good decision! Saving part of your income builds a safety net while leaving room for spending.",
                "Save \$0 (0%)": "Not the best decision. Without savings, you may face difficulties when unexpected expenses arise.",
              }),
          ScenarioQuestion(
              questionText: "What about those \$150 sneakers?",
              options: [
                ScenarioOption(
                    title: "Buy Now (\$150)",
                    iconUrl: "Get them immediately",
                    score: 15,
                    type: ""),
                ScenarioOption(
                    title: "Wait for Next Paycheck",
                    iconUrl: "Practice patience",
                    score: 10,
                    type: ""),
                ScenarioOption(
                    title: "Buy Cheaper Option (\$75)",
                    iconUrl: "Find a balance",
                    score: 20,
                    type: ""),
              ],
              feedback: {
                "Buy Now (\$150)": "Spending on wants is okay occasionally, but it’s important to prioritize savings and needs first.",
                "Wait for Next Paycheck": "Great decision! Delaying gratification helps you stay within your budget.",
                "Buy Cheaper Option (\$75)": "Good compromise! You get what you want while keeping more money for other priorities.",
              }),
          ScenarioQuestion(questionText: "Planning for emergencies", options: [
            ScenarioOption(
                title: "Set aside \$150",
                iconUrl: "Strong emergency fund",
                score: 15,
                type: ""),
            ScenarioOption(
                title: "Set aside \$50",
                iconUrl: "Small emergency fund",
                score: 25,
                type: ""),
            ScenarioOption(
                title: "Keep Nothing for Emergencies",
                iconUrl: "Spend it all",
                score: 30,
                type: ""),
          ], feedback: {
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
              "category": "Savings Habits",
              "value": 40,
              "scoreImpact": 40,
            },
            {
              "category": "Spending Discipline",
              "value": 20,
              "scoreImpact": 20,
            },
            {
              "category": "Emergency Preparedness",
              "value": 40,
              "scoreImpact": 40,
            }
          ]
        }),
      ),
    ],
    performanceTrends: PerformanceTrends(
      classAverage: 57,
      participationRate: 50,
      lessonCompletion: 65,
    ),
  ),


  'A.1.1.5': Component(
    componentId: 'A.1.1.5',
    title: 'Peer Reflection: Financial Responsibility',
    type: ComponentType.peerReflection,
    componentStatus: Status.Inactive,
    discussionQuestions: [
      "How do different life situations impact financial priorities and decision-making?",
      "Why is it important to balance financial independence with long-term financial planning?",
      "What financial lessons can we learn from peers with different responsibilities and goals?",
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
              imageUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fboymonkey1.png?alt=media&token=46fcb8e0-3644-473c-b09d-8997c28a4686",
            ),
            PeerCharacter(
              name: "Sophia",
              role: "The Family Caregiver",
              story:
                  "Sophia, a mother of three, manages her family’s expenses, ensuring her kids have what they need for school and extracurricular activities. She also focuses on building an emergency fund to protect her family from unexpected events.",
              imageUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fgirlmonkey1.png?alt=media&token=2ba73e9c-30db-4426-a2f6-6e87e77858de",
            ),
            PeerCharacter(
              name: "Ethan",
              role: "The Independent Investor",
              story:
                  "Ethan is in his early 30s and has chosen to focus on personal development and financial growth. He regularly invests in stocks and mutual funds, aiming to grow his wealth over time while planning for big future goals like starting his own business.",
              imageUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Funisexmonkey1.png?alt=media&token=208794d7-ab62-46f0-b49c-cc7fc5bb436f",
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
              imageUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fboymonkey1.png?alt=media&token=46fcb8e0-3644-473c-b09d-8997c28a4686",
            ),
            PeerCharacter(
              name: "Sophia",
              role: "The Family Caregiver",
              story:
                  "Sophia, a mother of three, manages her family’s expenses, ensuring her kids have what they need for school and extracurricular activities. She also focuses on building an emergency fund to protect her family from unexpected events.",
              imageUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fgirlmonkey1.png?alt=media&token=2ba73e9c-30db-4426-a2f6-6e87e77858de",
            ),
            PeerCharacter(
              name: "Ethan",
              role: "The Independent Investor",
              story:
                  "Ethan is in his early 30s and has chosen to focus on personal development and financial growth. He regularly invests in stocks and mutual funds, aiming to grow his wealth over time while planning for big future goals like starting his own business.",
              imageUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Funisexmonkey1.png?alt=media&token=208794d7-ab62-46f0-b49c-cc7fc5bb436f",
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
              imageUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fboymonkey1.png?alt=media&token=46fcb8e0-3644-473c-b09d-8997c28a4686",
            ),
            ReflectionOption(
              name: "Sophia",
              description:
                  "Sophia, because I have to balance family needs with future savings.",
              imageUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fgirlmonkey1.png?alt=media&token=2ba73e9c-30db-4426-a2f6-6e87e77858de",
            ),
            ReflectionOption(
              name: "Ethan",
              description:
                  "Ethan, because I’m working on growing my personal wealth and investments.",
              imageUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Funisexmonkey1.png?alt=media&token=208794d7-ab62-46f0-b49c-cc7fc5bb436f",
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
    performanceTrends: PerformanceTrends(
      classAverage: 62,
      participationRate: 63,
      lessonCompletion: 45,
    ),
  ),

  'A.1.1.6': Component(
    componentId: 'A.1.1.6',
    title: 'Quiz: Financial Responsibility',
    type: ComponentType.quiz,
    componentStatus: Status.Inactive,
    discussionQuestions: [
      "What did you think about the quiz, were you well prepared?"
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
                imageUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fconcert-ticket.svg?alt=media&token=ee234595-08d5-4b83-a3be-d648e3473c3a"),
            QuizOption(
                text: "Planning for college tuition",
                imageUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fcollegehat.png?alt=media&token=28948378-e9e6-455a-927c-cd1d0b118e69"),
            QuizOption(
                text: "Saving for retirement",
                imageUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fretirement.png?alt=media&token=42647cf7-324e-4f5c-928f-56ece52b08d1"),
            QuizOption(
                text: "Buying a new phone",
                imageUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fphone.png?alt=media&token=f57a75e8-4f0c-474c-80d9-c6b23521a47c"),
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
        data: TextBasedQuestion(
          question:
              "Which of the following are good strategies for financial responsibility? (Select all that apply)",
          options: [
            "Set aside money for emergencies",
            "Spend all your income on entertainment",
            "Create a budget and stick to it",
            "Ignore long-term financial goals",
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
        data: TextBasedQuestion(
          question:
              "Which actions demonstrate financial responsibility? (Select all that apply)",
          options: [
            "Planning for future expenses",
            "Setting financial goals",
            "Spending without tracking expenses",
            "Regularly contributing to savings",
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
    performanceTrends: PerformanceTrends(
      classAverage: 45,
      participationRate: 78,
      lessonCompletion: 54,
    ),
  ),

  'A.1.2.1': Component(
    componentId: 'A.1.2.1',
    title: 'Concept: Reliable vs. Questionable Financial Information',
    type: ComponentType.concept,
    componentStatus: Status.Active,
    discussionQuestions: [
      "What are key signs that financial information may be unreliable or misleading?",
      "How can emotional language and urgency be used to manipulate financial decisions?",
      "Why is it important to verify financial claims with multiple credible sources?",
    ],
    questionData: [
      Question(
        type: QuestionType.multipleChoice,
        data: MultipleChoice(
          questionHeading: "",
          question: "What is the most important factor in determining if a financial source is reliable?",
          questionExplanation: "Before we dive in, let’s see what you think!",
          options: [
            "If it was shared by a friend on social media.",
            "If it presents multiple perspectives and cites sources.",
            "If the advice promises quick financial success.",
            "If the information contains strong emotional language."
          ],
          correctAnswers: [
            "If it presents multiple perspectives and cites sources."
          ],
          prompts: Prompt(
            correct: "That’s right! Reliable financial sources provide multiple perspectives, cite evidence, and avoid sensationalist claims.",
            incorrect: "Not quite! Just because something is shared online or seems urgent doesn’t mean it’s reliable. Always verify financial sources using trusted references.",
          ),
        ),
      ),

      Question(
        type: QuestionType.revealCard,
        data: RevealCard(
          title: "Definition: Reliable Financial Information",
          definition: "Reliable financial information is accurate, objective, relevant, and up-to-date. It is based on facts and data, not opinions or emotions. Trustworthy sources present balanced perspectives and cite credible references to support their claims.",
          tapInstruction: "Click to reveal what it really means for financial information to be reliable.",
          whyMatter: "Why does it matter? Because financial decisions affect long-term stability. Basing choices on misleading or outdated information can lead to financial losses, scams, or poor investments.",
        ),
      ),

      // Icon Reveal: Four Factors of Reliable Financial Information
      Question(
        type: QuestionType.iconReveal,
        data: IconReveal(
          title: "Four Factors of Reliable Financial Information",
          iconLinks: [
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%202%2Fobjectivity.png?alt=media&token=f9be8daa-808b-4b1e-a82a-0fcc08d73a2d",
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%202%2Faccuracy.png?alt=media&token=dba35b18-751d-42de-a5d1-c585438bc278",
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%202%2Frelevance.png?alt=media&token=031e3ff2-6934-41cf-bfb8-e34f355b7fee",
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%202%2Fcurrency.png?alt=media&token=d973bc3e-891d-483c-9f8f-74c607f6f475",
          ],
          contents: [
            "Objectivity: The source avoids bias and presents facts, not opinions. One-sided information can mislead financial decisions.",
            "Accuracy: Statements are verified and supported by reputable experts. Inaccurate data can lead to costly mistakes.",
            "Relevancy: The information applies to your situation—generic advice can lead to missed opportunities.",
            "Currency: Financial data must be up-to-date. Outdated information can be irrelevant or even harmful."
          ],
        ),
      ),

      // Scenario-Based Learning: Meet Taylor
      Question(
        type: QuestionType.scenario,
        data: Scenario(
          title: "Meet Taylor: Evaluating Financial Information",
          scenarioExplanation: "Taylor encounters various financial information sources throughout her life. Let’s help her make informed decisions by evaluating the credibility of the information she receives!",
          questions: [
            MultipleChoice(
              questionHeading: "Text Message",
              question: "Taylor receives a text claiming, 'You've been selected for a 5,000 dollar grant! No application needed—just provide your bank details.' What should Taylor do?",
              questionExplanation: "Financial scams often use urgency and promises of free money to trick people.",
              options: [
                "Ignore the message and check official financial aid sources.",
                "Provide their bank details quickly to secure the grant.",
                "Reply to the message asking for more details."
              ],
              correctAnswers: ["Ignore the message and check official financial aid sources."],
              prompts: Prompt(
                correct: "Smart move! Official grants never ask for banking details via text. Always verify opportunities through legitimate organizations.",
                incorrect: "Be careful! Scammers use urgency and fake offers to trick people. Always verify financial opportunities before acting.",
              ),
            ),
            MultipleChoice(
              questionHeading: "Breaking Financial News on Social Media",
              question: "Taylor sees a post claiming, 'Major bank collapse happening NOW! Withdraw your money before it’s too late!' There are thousands of repostsWhat should Taylor do?",
              questionExplanation: "Social media spreads misinformation quickly—verify before acting.",
              options: [
                "Immediately withdraw all their money in case the tweet is true.",
                "Check official news sources and the bank’s website before making any financial decisions.",
                "Share the tweet with friends and family to warn them."
              ],
              correctAnswers: ["Check official news sources and the bank’s website before making any financial decisions."],
              prompts: Prompt(
                correct: "Smart decision! Verify financial news with trusted sources before reacting. Banks provide official statements if issues arise.",
                incorrect: "Be careful! Reacting without verification can cause unnecessary panic. Always check reliable sources first.",
              ),
            ),
          ],
        ),
      ),

      Question(
        type: QuestionType.learningCheck,
        data: LearningCheck(
          title: "Quick Check: Evaluating Financial Information",
          question1: "Which of the following is a key characteristic of reliable financial information?",
          question2: "Which of these is a red flag that a financial source may be unreliable?",
          options1: [
            "It presents multiple perspectives and cites sources.",
            "It uses urgency and emotional language to persuade readers.",
            "It promises guaranteed financial success."
          ],
          options2: [
            "It includes up-to-date data and references reputable organizations.",
            "It pressures you to act immediately or miss out.",
            "It provides a balanced discussion of financial options."
          ],
          correctAns1: "It presents multiple perspectives and cites sources.",
          correctAns2: "It pressures you to act immediately or miss out.",
          feedbackCorrect: "Great job! Reliable sources use facts and citations, while misleading ones rely on pressure, hype, and manipulation.",
          feedbackOneIncorrect: "Almost there! Trusted sources use evidence, not urgency or big promises. Always verify information with reputable sources.",
          feedbackBothIncorrect: "Be careful! Reliable sources avoid emotional tactics and urgency. Always check if a source is well-researched and properly cited.",
        ),
      ),

      // Key Takeaways: Summary of Lesson
      Question(
        type: QuestionType.keyTakeaways,
        data: KeyTakeaways(
          title: "Key Takeaways: Evaluating Financial Information",
          hint: "What steps will you take to verify financial information before acting on it?",
          takeaways: [
            Takeaway(
              title: "Reliable Sources Use Facts, Not Hype",
              description: "Trustworthy financial information is objective, well-cited, and free from emotional manipulation or urgency.",
              imageUrl: 
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fcheck.png?alt=media&token=8bca0178-2264-4919-828d-4492cd6680e7",
            ),
            Takeaway(
              title: "Misinformation Spreads Quickly",
              description: "Social media and unreliable sources can spread false financial claims—always verify with reputable institutions.",
              imageUrl: 
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fcheck.png?alt=media&token=8bca0178-2264-4919-828d-4492cd6680e7",
            ),
            Takeaway(
              title: "Look for Multiple Perspectives",
              description: "Reliable sources present balanced viewpoints and cite evidence rather than making bold, unsupported claims.",
              imageUrl: 
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fcheck.png?alt=media&token=8bca0178-2264-4919-828d-4492cd6680e7",
            ),
            Takeaway(
              title: "Outdated or Biased Information Can Be Harmful",
              description: "Financial advice should be current, accurate, and relevant to your situation—outdated or biased sources can lead to poor decisions.",
              imageUrl: 
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fcheck.png?alt=media&token=8bca0178-2264-4919-828d-4492cd6680e7",
            ),
          ],
        ),
      ),
    ],
    performanceTrends: PerformanceTrends(
      classAverage: 85,
      participationRate: 42,
      lessonCompletion: 42,
    ),
  ),

  'A.1.2.2': Component(
    componentId: 'A.1.2.2',
    title: 'Recognizing and Avoiding Consumer Fraud',
    type: ComponentType.concept,
    componentStatus: Status.Active,
    discussionQuestions: [
      "Why do scammers use urgency and emotions to trick people?",
      "If you get a suspicious financial message, what steps should you take before acting?",
    ],
    questionData: [
      // Multiple Choice Question: Introduction to Consumer Fraud
      Question(
        type: QuestionType.multipleChoice,
        data: MultipleChoice(
          questionHeading: "",
          question: "What is a common tactic used by online scammers to deceive consumers?",
          questionExplanation: "Before we dive in, let’s see what you think!",
          options: [
            "They use urgency and pressure to force quick decisions.",
            "They always provide official documents for verification.",
            "They operate openly and disclose their real identities.",
            "They avoid using personal or financial information in scams."
          ],
          correctAnswers: [
            "They use urgency and pressure to force quick decisions."
          ],
          prompts: Prompt(
            correct: "That’s right! Scammers often create a false sense of urgency to pressure victims into acting without thinking critically.",
            incorrect: "Not quite! Scammers frequently use emotional pressure and time-sensitive offers to manipulate victims. Be cautious of urgency tactics.",
          ),
        ),
      ),

      // Reveal Card: Definition of Consumer Fraud
      Question(
        type: QuestionType.revealCard,
        data: RevealCard(
          title: "Definition: Consumer Fraud & Online Scams",
          definition: "Consumer fraud occurs when individuals or businesses use deceptive, unfair, or false practices to gain financially at the expense of others.",
          tapInstruction: "Click to reveal why understanding consumer fraud is important.",
          whyMatter: "Being aware of common scams can help you avoid financial loss, identity theft, and legal trouble.",
        ),
      ),

      // Icon Reveal: Types of Consumer Fraud
      Question(
        type: QuestionType.iconReveal,
        data: IconReveal(
          title: "Common Types of Consumer Fraud",
          iconLinks: [
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%202%2Fphishing.png?alt=media&token=90c7d62c-263e-47f3-9f25-161332e15596",
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%202%2Fpyramid-scheme.png?alt=media&token=f0e91a3e-e0d4-40f3-b34b-051ea192c711",
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%202%2Ffake.png?alt=media&token=ab397c50-70e7-419a-8832-18e28d95de69",
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%202%2Ffake(1).png?alt=media&token=472fbb78-35f4-4a7c-84aa-6e4fa0fdbc89",
          ],
          contents: [
            "Phishing Scams: Fraudulent emails or texts pretending to be from trusted sources to steal personal information.",
            "Ponzi & Pyramid Schemes: Fraudulent investment schemes that promise high returns but rely on new investors to pay earlier participants.",
            "Fake Investment Opportunities: Scammers pose as legitimate investors or brokers, promising guaranteed profits with no risk.",
            "Identity Theft: Criminals steal personal information to access bank accounts, open credit cards, or take out loans in someone else’s name."
          ],
        ),
      ),

      // Scenario-Based Learning: Meet Jordan
      Question(
        type: QuestionType.scenario,
        data: Scenario(
          title: "Meet Jordan: Avoiding Consumer Fraud",
          scenarioExplanation: "Jordan is navigating the online financial world and encounters different potential scams. Let’s help them make safe financial decisions!",
          questions: [
            MultipleChoice(
              questionHeading: "Suspicious Email",
              question: "Jordan receives an email saying he won a lottery he never entered and must pay a small fee to claim his prize. What should Jordan do?",
              questionExplanation: "Scammers use fake lottery winnings to steal money and personal details.",
              options: [
                "Ignore the email and delete it immediately.",
                "Reply with personal details to confirm the prize.",
                "Send a small payment to claim the winnings."
              ],
              correctAnswers: ["Ignore the email and delete it immediately."],
              prompts: Prompt(
                correct: "Great job! Legitimate lotteries never ask for upfront payments. Always ignore and delete suspicious emails.",
                incorrect: "Be careful! Scammers use fake winnings to lure victims into revealing personal information or paying fraudulent fees.",
              ),
            ),
            MultipleChoice(
              questionHeading: "Social Media Investment Offer",
              question: "Jordan sees a social media ad promising ‘100% risk-free returns’ for a new investment. The company has flashy testimonials but no official business registration. What should Jordan do?",
              questionExplanation: "Legitimate investments always disclose risks. High-return, no-risk opportunities are a red flag.",
              options: [
                "Research the company on government financial websites before investing.",
                "Invest quickly before the opportunity disappears.",
                "Trust the testimonials and invest a small amount."
              ],
              correctAnswers: ["Research the company on government financial websites before investing."],
              prompts: Prompt(
                correct: "Smart move! Always verify investment opportunities through official sources before committing money.",
                incorrect: "Be cautious! Scammers use urgency and fake testimonials to trick investors. Always check government databases for legitimacy.",
              ),
            ),
          ],
        ),
      ),

      // Learning Check: Quick Check on Consumer Fraud & Scams
      Question(
        type: QuestionType.learningCheck,
        data: LearningCheck(
          title: "Quick Check: Consumer Fraud & Online Scams",
          question1: "What is a major warning sign of a financial scam?",
          question2: "Why should you be cautious about unsolicited financial offers?",
          options1: [
            "Guaranteed high returns with no risk.",
            "A financial expert explains the risks before investing.",
            "Only available to people with financial experience."
          ],
          options2: [
            "Scammers use them to target people with limited financial knowledge.",
            "They are always trustworthy since they reach out first.",
            "Companies must contact you first to offer a good deal."
          ],
          correctAns1: "Guaranteed high returns with no risk.",
          correctAns2: "Scammers use them to target people with limited financial knowledge.",
          feedbackCorrect: "Great job! Scams often promise unrealistic guarantees and target uninformed consumers.",
          feedbackOneIncorrect: "Almost there! Scammers use high-pressure tactics and too-good-to-be-true offers. Stay cautious!",
          feedbackBothIncorrect: "Be careful! Fraudsters manipulate emotions and urgency to trick victims. Always verify financial claims before acting.",
        ),
      ),

      // Key Takeaways: Summary of Lesson
      Question(
        type: QuestionType.keyTakeaways,
        data: KeyTakeaways(
          title: "Key Takeaways: Consumer Fraud & Online Scams",
          hint: "What’s one action you can take to protect yourself from financial fraud?",
          takeaways: [
            Takeaway(
              title: "Scammers Use Urgency & Emotion",
              description: "Fraudsters pressure victims into acting quickly before they can think critically.",
              imageUrl: 
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fcheck.png?alt=media&token=8bca0178-2264-4919-828d-4492cd6680e7",
            ),
            Takeaway(
              title: "Verify Before You Act",
              description: "Always research financial opportunities through official sources before making decisions.",
              imageUrl: 
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fcheck.png?alt=media&token=8bca0178-2264-4919-828d-4492cd6680e7",
            ),
            Takeaway(
              title: "If It Sounds Too Good to Be True, It Probably Is",
              description: "Guaranteed profits and no-risk opportunities are common scam tactics.",
              imageUrl: 
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fcheck.png?alt=media&token=8bca0178-2264-4919-828d-4492cd6680e7",
            ),
            Takeaway(
              title: "Protect Personal Information",
              description: "Never share sensitive details with unverified sources, especially online or over the phone.",
              imageUrl: 
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fcheck.png?alt=media&token=8bca0178-2264-4919-828d-4492cd6680e7",
            ),
          ],
        ),
      ),
    ],
    performanceTrends: PerformanceTrends(
      classAverage: 76,
      participationRate: 40,
      lessonCompletion: 71,
    ),
  ),

  'A.1.2.3': Component(
    componentId: 'A.1.2.3',
    title: 'Story: Spotting Financial Scams',
    type: ComponentType.story,
    componentStatus: Status.InProgress,
    discussionQuestions: [
      "How can you verify if a financial offer is legitimate?",
      "What are some common red flags that indicate a scam?",
      "Why do scammers use urgency and emotional pressure in their tactics?",
    ],
    questionData: [
      Question(
        type: QuestionType.intro,
        data: IntroPage(
          title: "Spotting Financial Scams",
          mintyText:
              "Meet Minty the Money Monkey! Minty is here to help you sharpen your ability to detect scams and make safe financial decisions.",
          imageUrl:
              "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMinty.png?alt=media&token=50e15d9a-3fc7-4fdb-9beb-ef2857b68793",
        ),
      ),
      // Question( 
      //   type: QuestionType.newlanding,
      //   data: newlanding(
      //     title: "Spotting Financial Scams", 
      //     subtitle: "Learning how to separate real financial opportunities from scams", 
      //     meetMinty: "Meet Minty the Money Monkey", 
      //     mintyUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMinty.png?alt=media&token=50e15d9a-3fc7-4fdb-9beb-ef2857b68793"
      //   ),
      // ),
      Question(
        type: QuestionType.problem,
        data: ProblemPage(
          title: "Spotting Financial Scams",
          subtitle: "Learning how to separate real financial opportunities from scams",
          scenarioText:
              "Jordan just got their first job and is excited about managing their own finances. One day, they receive an email stating they’ve won a 1,000 dollar prize in a contest they don’t remember entering. Another day, they see a social media ad promoting an investment that promises to triple their money overnight. Let’s help Jordan decide what’s real and what’s a scam!",
          instructions: "Think and then reveal the problem…",
          problem: "Problem: Struggling to differentiate between real financial opportunities and scams.",
        ),
      ),
      Question(
        type: QuestionType.solution,
        data: SolutionPage(
          title: "Spotting Financial Scams",
          subtitle: "How to protect yourself from financial fraud",
          Card1: [
            "Verify the Source",
            "Always check official websites, reviews, and the organization contact."
          ],
          Card2: [
            "Watch for Red Flags",
            "Scams often use urgency, guaranteed returns, and emotional manipulation to pressure victims."
          ],
          Card3: [
            "Never Share Personal Information",
            "Banks and government agencies will never ask for sensitive details over email, phone, or text."
          ],
        ),
      ),
      Question(
        type: QuestionType.impact,
        data: Impact(
          title: "Spotting Financial Scams",
          subtitle: "How smart financial choices protect your future",
          beforeContent: [
            "Nearly fell for a fake contest scam.",
            "Considered investing in a too-good-to-be-true scheme.",
            "Shared personal information without verifying the source."
          ],
          afterContent: [
            "Knows how to verify financial claims before acting.",
            "Recognizes common scam tactics and avoids fraud.",
            "Protects personal and financial information from scammers."
          ],
        ),
      ),
    ],
    performanceTrends: PerformanceTrends(
      classAverage: 50,
      participationRate: 83,
      lessonCompletion: 64,
    ),
  ),

  'A.1.2.4': Component(
    componentId: 'A.1.2.4',
    title: 'Scenario Simulation: Evaluating Financial Information',
    type: ComponentType.scenarioSimulation,
    componentStatus: Status.InProgress,
    discussionQuestions: [
      "How do financial scams use urgency and pressure tactics to manipulate people?",
      "What steps should you take to verify financial news or investment opportunities?",
      "Why might even well-designed websites and professional-looking emails be deceptive?",
    ],
    questionData: [
      Question(
        type: QuestionType.scenariointro,
        data: IntroductionPage(
          scenario:
              "You come across a forum post claiming that traders have made thousands overnight in a ‘low-risk, high-reward’ crypto scheme. At the same time, you receive an email from your bank stating that there has been ‘suspicious activity’ on your account, asking you to confirm your details. What do you do?",
          mintyImage: "assets/images/minty.png",
          options: [
            ScenarioOption(
                title: "Ignore", 
                iconUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%202%2Fignore.png?alt=media&token=a93138a9-bc32-46bb-b261-06d56770dd0a", 
                score: 40,
                type: ""),
            ScenarioOption(
                title: "Verify", 
                iconUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%202%2Fverify.png?alt=media&token=bc73f84f-5e85-4c8e-9b0c-6836f6734224", 
                score: 30,
                type: ""),
            ScenarioOption(
                title: "Click", 
                iconUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%202%2Fclick.png?alt=media&token=a307268c-5b03-4495-9034-2d3e9784cdaf", 
                score: -50,
                type: ""),
          ],
        ),
      ),
      Question(
        type: QuestionType.scenarioquestion,
        data: [
          ScenarioQuestion(
            questionText: "A financial influencer on TikTok claims they turned \$500 into \$25,000 in two months and offers a ‘limited-time’ course for \$50. What do you do?",
            options: [
              ScenarioOption(
                  title: "Research", 
                  iconUrl: "", 
                  score: 40,
                  type: ""),
              ScenarioOption(
                  title: "Buy", 
                  iconUrl: "", 
                  score: -50,
                  type: ""),
              ScenarioOption(
                  title: "Ask", 
                  iconUrl: "", 
                  score: 20,
                  type: ""),
            ],
            feedback: {
              "Research": "Great move! Always verify influencers’ claims before acting.",
              "Buy": "Be careful! Scammers often create urgency to pressure buyers.",
              "Ask": "Good step, but scammers can fake results. Always check independent sources.",
            }
          ),
          ScenarioQuestion(
            questionText: "You receive a call from someone claiming to be from the IRS, stating you owe money and must pay immediately via gift card or cryptocurrency. What should you do?",
            options: [
              ScenarioOption(
                  title: "Report", 
                  iconUrl: "", 
                  score: 40,
                  type: ""),
              ScenarioOption(
                  title: "Pay", 
                  iconUrl: "", 
                  score: -50,
                  type: ""),
              ScenarioOption(
                  title: "Ask", 
                  iconUrl: "", 
                  score: 30,
                  type: ""),
            ],
            feedback: {
              "Report": "Correct! The IRS never demands immediate payments via gift cards or crypto.",
              "Pay": "Scammers rely on fear tactics. The IRS never makes threats over the phone.",
              "Ask": "Good thinking, but scammers can fake ID numbers. Always verify with official sources.",
            }
          ),
          ScenarioQuestion(
            questionText: "A well-designed website claims you can ‘triple your money’ by joining their investment platform. What should you do?",
            options: [
              ScenarioOption(
                  title: "Verify", 
                  iconUrl: "", 
                  score: 40,
                  type: ""),
              ScenarioOption(
                  title: "Join", 
                  iconUrl: "", 
                  score: -50,
                  type: ""),
              ScenarioOption(
                  title: "Check", 
                  iconUrl: "", 
                  score: 10,
                  type: ""),
            ],
            feedback: {
              "Verify": "Great choice! Legitimate investments follow regulations and provide transparency.",
              "Join": "Be cautious! Scammers often use fake testimonials and promises of high returns.",
              "Check": "A good first step, but always confirm regulatory oversight before investing.",
            }
          ),
        ],
      ),
      Question(
        type: QuestionType.scenarioresults,
        data: ScenarioResult.fromMap({
          "selectedChoices": [
            {
              "category": "Avoiding Phishing Scams",
              "value": 40,
              "scoreImpact": 50,
            },
            {
              "category": "Recognizing Financial Fraud",
              "value": -50,
              "scoreImpact": -50,
            },
            {
              "category": "Critical Thinking in Finance",
              "value": 40,
              "scoreImpact": 40,
            },
            {
              "category": "Verifying Investment Opportunities",
              "value": 30,
              "scoreImpact": 30,
            }
          ]
        }),
      ),
    ],
    performanceTrends: PerformanceTrends(
      classAverage: 63,
      participationRate: 65,
      lessonCompletion: 47,
    ),
  ),

  'A.1.2.5': Component(
    componentId: 'A.1.2.5',
    title: 'Peer Reflection: Evaluating Financial Information',
    type: ComponentType.peerReflection,
    componentStatus: Status.InProgress,
    discussionQuestions: [
      "How can personal biases affect our ability to evaluate financial information critically?",
      "What are some common tactics scammers use to make fraudulent schemes appear legitimate?",
      "Why do some misleading financial claims continue to spread, even when proven false?",
    ],
    questionData: [
      Question(
        type: QuestionType.peerintro,
        data: PeerReflectionIntro(
          title: "Recognizing Reliable vs. Misleading Financial Information",
          subTitle:
              "Not all financial information is created equal. Learning how to separate facts from misleading claims is crucial for making informed decisions and avoiding financial pitfalls.",
          characters: [
            PeerCharacter(
              name: "Jordan",
              role: "The Skeptical Researcher",
              story:
                  "Jordan double-checks every financial claim before believing it. They’ve avoided multiple scams by researching sources and questioning credibility before making decisions.",
              imageUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fboymonkey1.png?alt=media&token=46fcb8e0-3644-473c-b09d-8997c28a4686",
            ),
            PeerCharacter(
              name: "Taylor",
              role: "The Cautious Investor",
              story:
                  "Taylor invests carefully but almost fell for an online trading scheme. After checking the company’s credentials, they discovered it was unregulated and avoided a financial disaster.",
              imageUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fgirlmonkey1.png?alt=media&token=2ba73e9c-30db-4426-a2f6-6e87e77858de",
            ),
            PeerCharacter(
              name: "Chris",
              role: "The Trend Follower",
              story:
                  "Chris gets financial advice from social media influencers and has made both great and terrible financial choices. They’re learning to fact-check before acting on financial trends.",
              imageUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Funisexmonkey1.png?alt=media&token=208794d7-ab62-46f0-b49c-cc7fc5bb436f",
            ),
          ],
        ),
      ),
      Question(
        type: QuestionType.peerstories,
        data: PeerStories(
          title: "Peer Stories: Evaluating Financial Claims",
          characters: [
            PeerCharacter(
              name: "Jordan",
              role: "The Skeptical Researcher",
              story:
                  "Jordan double-checks every financial claim before believing it. They’ve avoided multiple scams by researching sources and questioning credibility before making decisions.",
              imageUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fboymonkey1.png?alt=media&token=46fcb8e0-3644-473c-b09d-8997c28a4686",
            ),
            PeerCharacter(
              name: "Taylor",
              role: "The Cautious Investor",
              story:
                  "Taylor invests carefully but almost fell for an online trading scheme. After checking the company’s credentials, they discovered it was unregulated and avoided a financial disaster.",
              imageUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fgirlmonkey1.png?alt=media&token=2ba73e9c-30db-4426-a2f6-6e87e77858de",
            ),
            PeerCharacter(
              name: "Chris",
              role: "The Trend Follower",
              story:
                  "Chris gets financial advice from social media influencers and has made both great and terrible financial choices. They’re learning to fact-check before acting on financial trends.",
              imageUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Funisexmonkey1.png?alt=media&token=208794d7-ab62-46f0-b49c-cc7fc5bb436f",
            ),
          ],
        ),
      ),
      Question(
        type: QuestionType.peermatch,
        data: PeerMatch(
          title: "Match Actions to Categories: Financial Information Evaluation",
          categories: [
            MatchCategory(
              title: "Verifying Financial Information",
              correctActions: [
                "Checking multiple sources before making financial decisions",
                "Looking for government regulation or accreditation",
                "Researching the credentials of financial influencers",
              ],
            ),
            MatchCategory(
              title: "Red Flags of Financial Misinformation",
              correctActions: [
                "Using emotional language or urgency to create pressure",
                "Guaranteeing high returns with no risk",
                "Lack of official documentation or transparency",
              ],
            ),
            MatchCategory(
              title: "Smart Financial Decision-Making",
              correctActions: [
                "Learning how to differentiate biased vs. factual sources",
                "Asking for verification before acting on financial claims",
              ],
            ),
          ],
          actions: [
            "Checking multiple sources before making financial decisions",
            "Looking for government regulation or accreditation",
            "Researching the credentials of financial influencers",
            "Using emotional language or urgency to create pressure",
            "Guaranteeing high returns with no risk",
            "Lack of official documentation or transparency",
            "Learning how to differentiate biased vs. factual sources",
            "Asking for verification before acting on financial claims",
          ],
          feedbackMessages: {
            "correct":
                "Well done! Reliable financial information is backed by credible sources and not influenced by pressure tactics.",
            "incorrect":
                "Be careful! Misleading financial claims often rely on urgency, fake testimonials, or emotional appeal.",
          },
        ),
      ),
      Question(
        type: QuestionType.peerreflectionend,
        data: PeerReflectionEnd(
          question:
              "Which peer’s approach to financial decision-making do you relate to most? Why?",
          options: [
            ReflectionOption(
              name: "Jordan",
              description:
                  "Jordan, because I prefer to research before making financial decisions.",
              imageUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fboymonkey1.png?alt=media&token=46fcb8e0-3644-473c-b09d-8997c28a4686",
            ),
            ReflectionOption(
              name: "Taylor",
              description:
                  "Taylor, because I’m careful with investments but learning to identify financial traps.",
              imageUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fgirlmonkey1.png?alt=media&token=2ba73e9c-30db-4426-a2f6-6e87e77858de",
            ),
            ReflectionOption(
              name: "Chris",
              description:
                  "Chris, because I’ve acted on financial trends before but am working on fact-checking.",
              imageUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Funisexmonkey1.png?alt=media&token=208794d7-ab62-46f0-b49c-cc7fc5bb436f",
            ),
          ],
          feedbackMessages: {
            "Jordan":
                "Great mindset! Researching financial claims before acting can prevent major financial mistakes.",
            "Taylor":
                "Good choice! Learning to evaluate investment credibility is key to protecting your financial future.",
            "Chris":
                "It’s great that you’re learning! Social media trends can be misleading, so fact-checking is essential.",
          },
          buttonText: "Finish Peer Reflection",
        ),
      ),
    ],
    performanceTrends: PerformanceTrends(
      classAverage: 88,
      participationRate: 69,
      lessonCompletion: 53,
    ),
  ),

  'A.1.2.6': Component(
    componentId: 'A.1.2.6',
    title: 'Quiz: Evaluating Financial Information',
    type: ComponentType.quiz,
    componentStatus: Status.InProgress,
    discussionQuestions: [
      "What did you think about the difficulty of the quiz?",
    ],
    questionData: [
      // Question 1: Identifying Reliable Financial Information
      Question(
        type: QuestionType.quiztextmcquestion,
        data: TextBasedQuestion(
          question: "Which of the following is a key trait of reliable financial information?",
          options: [
            "It is based on verifiable sources and presents multiple perspectives.",
            "It uses emotional language to convince readers.",
            "It guarantees a high return on investments.",
            "It pressures you to act quickly before missing an opportunity.",
          ],
          correctAnswers: ["It is based on verifiable sources and presents multiple perspectives."],
          feedbackMessages: {
            "It is based on verifiable sources and presents multiple perspectives.":
                "Correct! Reliable financial information is backed by credible sources and presents balanced perspectives.",
            "It uses emotional language to convince readers.":
                "Incorrect! Emotional appeals are often used to manipulate decisions rather than provide facts.",
            "It guarantees a high return on investments.":
                "Not quite! No investment can guarantee returns without risk—this is a red flag for scams.",
            "It pressures you to act quickly before missing an opportunity.":
                "Wrong choice! Scammers create urgency to trick people into making impulsive decisions.",
          },
          isMultiSelect: false,
          buttonText: "Check Answer",
        ),
      ),

      // Question 2: Recognizing Financial Fraud
      Question(
        type: QuestionType.quiztextmcquestion,
        data: TextBasedQuestion(
          question: "Which of the following is a common sign of a financial scam?",
          options: [
            "It promises high returns with no risk.",
            "It provides transparent documentation and regulatory approval.",
            "It encourages you to research and verify information independently.",
            "It includes realistic expectations about potential risks and rewards.",
          ],
          correctAnswers: ["It promises high returns with no risk."],
          feedbackMessages: {
            "It promises high returns with no risk.":
                "Correct! Scams often lure people in with unrealistic promises of risk-free profits.",
            "It provides transparent documentation and regulatory approval.":
                "Incorrect! Legitimate financial opportunities are transparent about risks and regulated by authorities.",
            "It encourages you to research and verify information independently.":
                "Not quite! Scams discourage verification to keep victims from discovering the truth.",
            "It includes realistic expectations about potential risks and rewards.":
                "Wrong choice! Ethical financial advice acknowledges both risks and rewards openly.",
          },
          isMultiSelect: false,
          buttonText: "Check Answer",
        ),
      ),

      // Question 3: Multi-Select – Avoiding Financial Misinformation
      Question(
        type: QuestionType.quiztextmcquestion,
        data: TextBasedQuestion(
          question: "Which of the following are good strategies to avoid financial misinformation? (Select all that apply)",
          options: [
            "Verify information through official sources like government websites or financial institutions.",
            "Fact-check viral social media financial advice before acting on it.",
            "Trust any advice that has a lot of positive comments and likes online.",
            "Avoid financial offers that require immediate action without time to research.",
          ],
          correctAnswers: [
            "Verify information through official sources like government websites or financial institutions.",
            "Fact-check viral social media financial advice before acting on it.",
            "Avoid financial offers that require immediate action without time to research.",
          ],
          feedbackMessages: {
            "Verify information through official sources like government websites or financial institutions.":
                "Correct! Trusted sources provide reliable, fact-based financial guidance.",
            "Fact-check viral social media financial advice before acting on it.":
                "Correct! Popularity online does not always mean accuracy—always verify financial claims.",
            "Trust any advice that has a lot of positive comments and likes online.":
                "Incorrect! Social proof can be manipulated—likes and comments don't guarantee reliability.",
            "Avoid financial offers that require immediate action without time to research.":
                "Correct! Scammers use urgency to pressure people into bad financial decisions.",
          },
          isMultiSelect: true,
          buttonText: "Submit",
        ),
      ),

      // Question 4: Image-Based Question on Financial Scams
      Question(
        type: QuestionType.quizimagemcquestion,
        data: QuizMultipleChoice(
          question: "Which image represents a clear sign of a financial scam?",
          options: [
            QuizOption(
                text: "A government website detailing federal student loan repayment options.",
                imageUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%202%2Fgovernment.png?alt=media&token=f4ccbd68-a8f8-4618-9499-4c6c38b1d459"),
            QuizOption(
                text: "A news article analyzing the stock market with expert citations.",
                imageUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%202%2Fnews.png?alt=media&token=5e81562e-7454-4ab5-9866-14450e61da9a"),
            QuizOption(
                text: "An investment ad promising 'guaranteed 200% returns in a week!'",
                imageUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%202%2Fadvertisement.png?alt=media&token=bf8f11e9-b016-4ec3-8db6-2c7e08553479"),
            QuizOption(
                text: "A financial planner’s report explaining different risk levels of investments.",
                imageUrl: "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%202%2Ffinancial.png?alt=media&token=389288e9-1300-4a25-8b11-3ab54f215968"),
          ],
          correctAnswers: ["An investment ad promising 'guaranteed 200% returns in a week!'"],
          feedbackMessages: {
            "An investment ad promising 'guaranteed 200% returns in a week!'":
                "Correct! Any promise of guaranteed profits in a short period is a major red flag for fraud.",
            "A government website detailing federal student loan repayment options.":
                "Incorrect! Government sites provide legitimate financial guidance and regulations.",
            "A news article analyzing the stock market with expert citations.":
                "Not quite! Reliable sources provide balanced perspectives and cite experts.",
            "A financial planner’s report explaining different risk levels of investments.":
                "Wrong choice! Professional financial planners offer well-researched, risk-assessed advice.",
          },
          isMultiSelect: false,
          buttonText: "Check Answer",
        ),
      ),

      // Question 5: Ethical Financial Decisions
      Question(
        type: QuestionType.quiztextmcquestion,
        data: TextBasedQuestion(
          question: "A friend tells you about a 'once-in-a-lifetime' investment opportunity. What should you do?",
          options: [
            "Invest immediately before the opportunity disappears.",
            "Ignore any financial advice that comes from people you know.",
            "Research the company and verify its legitimacy before making any decision.",
            "Trust the friend’s recommendation without doing independent research.",
          ],
          correctAnswers: ["Research the company and verify its legitimacy before making any decision."],
          feedbackMessages: {
            "Invest immediately before the opportunity disappears.":
                "Incorrect! Urgency is often a tactic used in scams to pressure victims.",
            "Ignore any financial advice that comes from people you know.":
                "Not quite! Some personal recommendations can be valuable, but they should still be fact-checked.",
            "Research the company and verify its legitimacy before making any decision.":
                "Correct! Always verify financial opportunities before making decisions.",
            "Trust the friend’s recommendation without doing independent research.":
                "Wrong choice! Even well-meaning friends can unknowingly share misleading financial advice.",
          },
          isMultiSelect: false,
          buttonText: "Check Answer",
        ),
      ),
    ],
    performanceTrends: PerformanceTrends(
      classAverage: 88,
      participationRate: 69,
      lessonCompletion: 53,
    ),
  ),

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
    performanceTrends: PerformanceTrends(
      classAverage: 51,
      participationRate: 61,
      lessonCompletion: 63,
    ),
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
    performanceTrends: PerformanceTrends(
      classAverage: 58,
      participationRate: 89,
      lessonCompletion: 78,
    ),
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
    performanceTrends: PerformanceTrends(
      classAverage: 94,
      participationRate: 68,
      lessonCompletion: 73,
    ),
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
    performanceTrends: PerformanceTrends(
      classAverage: 59,
      participationRate: 88,
      lessonCompletion: 31,
    ),
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
    performanceTrends: PerformanceTrends(
      classAverage: 35,
      participationRate: 48,
      lessonCompletion: 79,
    ),
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
    performanceTrends: PerformanceTrends(
      classAverage: 58,
      participationRate: 61,
      lessonCompletion: 58,
    ),
  ),

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
    performanceTrends: PerformanceTrends(
      classAverage: 52,
      participationRate: 63,
      lessonCompletion: 51,
    ),
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
    performanceTrends: PerformanceTrends(
      classAverage: 55,
      participationRate: 66,
      lessonCompletion: 34,
    ),
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
    performanceTrends: PerformanceTrends(
      classAverage: 66,
      participationRate: 51,
      lessonCompletion: 63,
    ),
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
    performanceTrends: PerformanceTrends(
      classAverage: 64,
      participationRate: 64,
      lessonCompletion: 32,
    ),
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
    performanceTrends: PerformanceTrends(
      classAverage: 42,
      participationRate: 65,
      lessonCompletion: 83,
    ),
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
    performanceTrends: PerformanceTrends(
      classAverage: 73,
      participationRate: 63,
      lessonCompletion: 89,
    ),
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
    performanceTrends: PerformanceTrends(
      classAverage: 90,
      participationRate: 95,
      lessonCompletion: 58,
    ),
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
    performanceTrends: PerformanceTrends(
      classAverage: 94,
      participationRate: 65,
      lessonCompletion: 53,
    ),
  ),

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
    performanceTrends: PerformanceTrends(
      classAverage: 51,
      participationRate: 59,
      lessonCompletion: 52,
    ),
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
    performanceTrends: PerformanceTrends(
      classAverage: 88,
      participationRate: 54,
      lessonCompletion: 50,
    ),
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
    performanceTrends: PerformanceTrends(
      classAverage: 51,
      participationRate: 86,
      lessonCompletion: 78,
    ),
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
    performanceTrends: PerformanceTrends(
      classAverage: 72,
      participationRate: 59,
      lessonCompletion: 82,
    ),
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
    performanceTrends: PerformanceTrends(
      classAverage: 85,
      participationRate: 78,
      lessonCompletion: 85,
    ),
  ),
};