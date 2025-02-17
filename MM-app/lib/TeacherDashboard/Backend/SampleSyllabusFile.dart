import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Models/QuestionsModel.dart';

List<SubComponent> sampleComponent1 = [
  SubComponent(
    type: SubComponentType.multipleChoice,
    data: MultipleChoice(
      question: "When Should Financial Responsibility Begin?",
      questionExplanation: "Before we dive in, let’s see what you think!",
      options: [
        "Once I have a full-time job.",
        "As soon as I start earning money (even if it’s part-time or allowance)",
        "After I graduate from college.",
        "Only when I’m ready to plan for retirement."
      ],
      correctAnswers: [
        "As soon as I start earning money (even if it’s part-time or allowance)"
      ],
      prompts: Prompt(
          correct:
              "That's right! Financial responsibility can start early, from your first paycheck or allowance. Let's explore why.",
          incorrect:
              "Coins have been used since around 600 B.C., making them the oldest form of money still in use."),
    ),
  ),
  SubComponent(
    type: SubComponentType.revealCard,
    data: RevealCard(
      definition:
          "Financial responsibility over a lifetime means consistently making informed decisions about earning, saving, spending, and investing, starting from your earliest income and continuing through retirement.",
      tapInstruction:
          "Click for what it really means to be financially responsible over a lifetime...",
      revealInformation: [
        "Financial responsibility over a lifetime means consistently making informed decisions about earning, saving, spending, and investing, starting from your earliest income and continuing through retirement.",
        "Why does it matter? Because small habits formed early—like setting aside a little money or comparing prices—can grow into long-term financial stability."
      ],
    ),
  ),
  SubComponent(
    type: SubComponentType.iconReveal,
    data: IconReveal(
      iconLinks: [
        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fcard.png?alt=media&token=d9ad44a7-c607-4a88-9c8b-64d49e47a245",
        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fgraduation-cap.png?alt=media&token=53e1203d-816d-4512-b570-db886d53d904"
      ],
      contents: [
        "Even small allowances or part-time earnings can be budgeted. Learning to save a portion of every dollar sets a foundation for bigger goals later.",
        "This might be your first real job or college experience. Start building credit responsibly and budget for regular bills—rent, utilities, groceries."
      ],
    ),
  ),
  SubComponent(
    type: SubComponentType.lerningCheck,
    data: LearningCheck(
        question1:
            "Which of the following best describes a strong financial habit at any age?",
        question2: "Which is a key benefit of having an emergency fund?",
        options1: [
          "Spending money the moment you get it",
          "Saving and investing a portion of earnings regularly",
          "Waiting to save until you earn a high salary"
        ],
        options2: [
          "It guarantees you’ll never worry about money again",
          "It covers unexpected expenses, reducing stress and debt",
          "It means you can freely spend on luxury items without a budget"
        ],
        correctAns1: "Saving and investing a portion of earnings regularly",
        correctAns2: "It covers unexpected expenses, reducing stress and debt"),
  ),
  SubComponent(
    type: SubComponentType.keyTakeaways,
    data: KeyTakeaways(
      takeaway: {
        "Budgeting at Every Stage":
            "From first job to retirement, a budget reduces overspending and increases savings.",
        "Early habits matter":
            "Starting even with small amounts when young helps build bigger savings over time.",
        "Never Too Late to Improve":
            "Even close to retirement, you can still refine your budget and investment approach for a more secure future.",
        "Preparedness for Changes":
            "Plan for life transitions—like family or job changes—by maintaining an emergency fund."
      },
    ),
  ),
];

List<Unit> sampleAdvancedSyllabus = [
  Unit(
    unitId: "A.1",
    title: "What is Money?",
    description: "Unit 1 Description",
    lessonIds: [
      "A.1.1",
      "A.1.2",
      "A.1.3",
      "A.1.4",
      "A.1.5",
      "A.1.6",
    ],
    totalLessons: 20,
    unitStatus: Status.Inactive,
  ),
];
