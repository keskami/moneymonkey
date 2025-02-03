import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Services/lessonData.dart';
import 'package:money_monkey/LessonPages/Pages_ConceptOneTwo/1MCQPage.dart';
import 'package:money_monkey/LessonPages/Pages_ConceptOneTwo/2RevealPage.dart';
import 'package:money_monkey/LessonPages/Pages_ConceptOneTwo/3IconRevealPage.dart';
import 'package:money_monkey/LessonPages/Pages_ConceptOneTwo/4ScenarioPage.dart';
import 'package:money_monkey/LessonPages/Pages_ConceptOneTwo/Page5.dart';
import 'package:money_monkey/LessonPages/Pages_ConceptOneTwo/Page6.dart';
import 'package:money_monkey/LessonPages/Pages_ConceptOneTwo/5QuizkCheckPage.dart';
import 'package:money_monkey/LessonPages/Pages_ConceptOneTwo/6TakeawayPage.dart';
import 'package:money_monkey/LessonPages/Models/Concept1_2.dart';

import '../Pages_ConceptOneTwo/Page7.dart';

class ComponentOneTwoController extends GetxController {
  RxInt pageIndex = 0.obs;

  // To store fetched questions
  RxList<Question> questions = <Question>[].obs;

  var pages = [
    MCQPage(),
    RevealPage(),
    IconRevealPage(),
    ScenarioPage(),
    L1Page5(),
    L1Page6(),
    L1Page7(),
    QuickCheckPage(),
    TakeawayPage(),
  ];
  var pageData = <int, dynamic>{}.obs;
  final LessonData lessonData = LessonData();
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPageData();
  }

  Future<void> fetchPageData() async {
    try {
      for (int i = 1; i <= 9; i++) {
        var data = await lessonData.getPageInfoFromFirestore(
          levelName: "Advanced",
          UnitNumber: 1,
          LessonNumber: 1,
          TypeOfLesson: "Concept",
          PageNumber: i,
        );

        pageData[i] = data;
      }
    } catch (e) {
      print("Error fetching page data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}

//   DocumentReference<Map<String, dynamic>> getLessonDocRef(String lessonId) {
//     return FirebaseFirestore.instance.collection('Lessons').doc(lessonId);
//   }

//   Future<void> fetchQuestions(String lessonId) async {
//     try {
//       print("Starting to fetch questions for lesson: $lessonId");
//       final docRef = getLessonDocRef(lessonId);
//       final snapshot = await docRef.get();

//       if (!snapshot.exists) {
//         print("No document found for lesson: $lessonId");
//         return;
//       }
//       final data = snapshot.data()!;
//       questions.clear();
//       final sortedEntries = data.entries
//           .where((entry) => entry.key.startsWith('Question'))
//           .toList()
//         ..sort((a, b) => a.key.compareTo(b.key));

//       for (var entry in sortedEntries) {
//         try {
//           if (entry.value is! Map<String, dynamic>) {
//             print(
//                 "Invalid data format for ${entry.key}: ${entry.value.runtimeType}");
//             continue;
//           }

//           final questionData = entry.value as Map<String, dynamic>;
//           print("Question data: $questionData");

//           final question = Question.fromMap(questionData);
//           print("Successfully parsed question: ${question.type}");
//           questions.add(question);
//         } catch (e, stackTrace) {
//           print("Error parsing question ${entry.key}: $e");
//           print("Stack trace: $stackTrace");
//           continue;
//         }
//       }

//       print("Fetching complete. Total questions loaded: ${questions.length}");
//     } catch (e, stackTrace) {
//       print("Error in fetchQuestions: $e");
//       print("Stack trace: $stackTrace");
//       rethrow;
//     }
//   }

//   Future<void> addQuestion(
//       String lessonId, String fieldName, Question question) async {
//     try {
//       final docRef = getLessonDocRef(lessonId);
//       await docRef.update({fieldName: question.toMap()});
//       print("Question added successfully!");
//     } catch (e) {
//       print("Error adding question: $e");
//       rethrow;
//     }
//   }

//   /// Get the current question based on the page index
//   Question? get currentQuestion {
//     if (pageIndex.value < questions.length) {
//       return questions[pageIndex.value];
//     }
//     return null;
//   }

//   Future<void> initializeFirebaseWithSampleQuestions(String lessonId) async {
//     // Previous sample questions remain the same...
//     final multipleChoice = Question(
//       type: QuestionType.multipleChoice,
//       data: MultipleChoice(
//         question: "When Should Financial Responsibility Begin?",
//         questionExplanation: "Before we dive in, let’s see what you think!",
//         options: [
//           "Once I have a full-time job.",
//           "As soon as I start earning money (even if it’s part-time or allowance)",
//           "After I graduate from college.",
//           "Only when I’m ready to plan for retirement."
//         ],
//         correctAnswers: [
//           "As soon as I start earning money (even if it’s part-time or allowance)"
//         ],
//         prompts: Prompt(
//             correct:
//                 "That's right! Financial responsibility can start early, from your first paycheck or allowance. Let's explore why.",
//             incorrect:
//                 "Coins have been used since around 600 B.C., making them the oldest form of money still in use."),
//       ),
//     );

//     // Sample Reveal Card
//     final revealCard = Question(
//       type: QuestionType.revealCard,
//       data: RevealCard(
//           definition: "Financial Responsibility Over a Lifetime",
//           tapInstruction:
//               "Click for what it really means to be financially responsible over a lifetime...",
//           revealInformation: [
//             "Financial responsibility over a lifetime means consistently making informed decisions about earning, saving, spending, and investing, starting from your earliest income and continuing through retirement.",
//             "Why does it matter? Because small habits formed early—like setting aside a little money or comparing prices—can grow into long-term financial stability.",
//           ]),
//     );

//     // Sample Icon Reveal
//     final iconReveal = Question(
//       type: QuestionType.iconReveal,
//       data: IconReveal(
//         iconLinks: [
//           "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fcard.png?alt=media&token=d9ad44a7-c607-4a88-9c8b-64d49e47a245",
//           "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fgraduation-cap.png?alt=media&token=53e1203d-816d-4512-b570-db886d53d904",
//           "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fbriefcase-bag.png?alt=media&token=987a2538-9376-46ef-965e-502cf493d798",
//           "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fsunset.png?alt=media&token=2ebd97df-6903-4254-bd15-3a59c404825b",
//         ],
//         contents: [
//           "Even small allowances or part-time earnings can be budgeted. Learning to save a portion of every dollar sets a foundation for bigger goals later.",
//           "This might be your first real job or college experience. Start building credit responsibly and budget for regular bills—rent, utilities, groceries.",
//           "You might buy a home or consider long-term investments. Having an emergency fund, managing debt wisely, and planning for retirement become crucial.",
//           "You live off savings, pensions, or investments made earlier. Continued budgeting helps ensure your money lasts and you maintain your desired lifestyle.",
//         ],
//       ),
//     );

//     final scenario = Question(
//       type: QuestionType.scenario,
//       data: Scenario(
//         title: "Meet Jordan: A Life of Financial Decisions",
//         scenarioExplanation:
//             "Jordan is on a journey from high school to retirement. Let's help them make smart financial choices!",
//         questions: [
//           MultipleChoice(
//             question: "High School",
//             questionExplanation:
//                 "Jordan earns \$50/week from chores. Should Jordan save 10% (\$5) or spend it all?",
//             options: ["Save 10%", "Spend all of it"],
//             correctAnswers: ["Save 10%"],
//             prompts: Prompt(
//                 correct: "Great habit! Even \$5 a week adds up over time.",
//                 incorrect:
//                     "Coins have been used since around 600 B.C., making them the oldest form of money still in use."),
//           ),
//           MultipleChoice(
//             question: "High School",
//             questionExplanation:
//                 "Jordan just started a full-time job. Should he create a monthly budget first or just wing it?",
//             options: ["Create a monthly budget", "Wing it"],
//             correctAnswers: ["Create a monthly budget"],
//             prompts: Prompt(
//                 correct:
//                     "Smart move! This helps Jordan track spending and allocate money for bills, savings, and fun.",
//                 incorrect:
//                     "Consider which policy specifically addresses product damage."),
//           ),
//           MultipleChoice(
//             question: "Family Planning",
//             questionExplanation:
//                 "Jordan is thinking about starting a family soon. How important is it to have an emergency fund?",
//             options: ["High priority", "Not that important"],
//             correctAnswers: ["High priority"],
//             prompts: Prompt(
//                 correct:
//                     "Yes! Unexpected costs like medical bills or childcare can pop up. Having a cushion is crucial.",
//                 incorrect:
//                     "Consider which policy specifically addresses product damage."),
//           ),
//           MultipleChoice(
//             question: "Retirement",
//             questionExplanation:
//                 "Jordan is now approaching retirement. Should they continue some form of budgeting?",
//             options: ["Yes", "No"],
//             correctAnswers: ["Yes"],
//             prompts: Prompt(
//                 correct:
//                     "Yes! Consistent budgeting helps ensure savings last throughout retirement.",
//                 incorrect:
//                     "Consider which policy specifically addresses product damage."),
//           ),
//         ],
//       ),
//     );
// // Sample Learning Check
//     final learningCheck = Question(
//       type: QuestionType.lerningCheck,
//       data: LearningCheck(
//         question1:
//             "Which of the following best describes a strong financial habit at any age?",
//         question2: "Which is a key benefit of having an emergency fund?",
//         options1: [
//           "Spending money the moment you get it",
//           "Saving and investing a portion of earnings regularly",
//           "Waiting to save until you earn a high salary",
//         ],
//         options2: [
//           "It guarantees you’ll never worry about money again",
//           "It covers unexpected expenses, reducing stress and debt",
//           "It means you can freely spend on luxury items without a budget",
//         ],
//         correctAns1: "Saving and investing a portion of earnings regularly",
//         correctAns2: "It covers unexpected expenses, reducing stress and debt",
//       ),
//     );
//     // Sample Key Takeaways
//     final keyTakeaways = Question(
//       type: QuestionType.keyTakeaways,
//       data: KeyTakeaways(
//         takeaway: {
//           "Early habits matter":
//               "Starting even with small amounts when young helps build bigger savings over time.",
//           "Budgeting at Every Stage":
//               "From first job to retirement, a budget reduces overspending and increases savings.",
//           "Preparedness for Changes":
//               "Plan for life transitions—like family or job changes—by maintaining an emergency fund.",
//           "Never Too Late to Improve":
//               "Even close to retirement, you can still refine your budget and investment approach for a more secure future.",
//         },
//       ),
//     );

//     try {
//       await addQuestion(lessonId, "Question1", multipleChoice);
//       await addQuestion(lessonId, "Question2", revealCard);
//       await addQuestion(lessonId, "Question3", iconReveal);
//       await addQuestion(lessonId, "Question4", learningCheck);
//       await addQuestion(lessonId, "Question5", keyTakeaways);
//       await addQuestion(lessonId, "Question6", scenario);

//       print(
//           "Successfully initialized Firebase with sample questions including scenario!");

//       await fetchQuestions(lessonId);
//     } catch (e) {
//       print("Error initializing Firebase with sample questions: $e");
//       rethrow;
//     }
//   }
// }
