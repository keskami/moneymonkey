import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/ScenarioPages/IntroductionPage.dart';
import 'package:money_monkey/LessonPages/ScenarioPages/QuestionPage.dart';
import 'package:money_monkey/LessonPages/ScenarioPages/ResultPage.dart';

class ScenarioController extends GetxController {
  final Map<String, String> questions = {
    "How much will you save?": "Save \$250 (50%)",
    "What about those \$150 sneakers?": "Wait for Next Paycheck",
    "Planning for Emergencies": "Set aside \$150",
  };

  final List<List<List<String>>> options = [
    [
      ["Save \$250 (50%)", "Maximum savings for future goals"],
      ["Save \$100 (20%)", "Moderate savings approach"],
      ["Save \$0 (0%)", "No savings"],
    ],
    [
      ["Buy Now (\$150)", "Get them immediately"],
      ["Wait for Next Paycheck", "Practice patience"],
      ["Buy Cheaper Option (\$75)", "Find a balance"],
    ],
    [
      ["Set aside \$150", "Strong emergency fund"],
      ["Set aside \$50", "Small emergency fund"],
      ["Keep Nothing for Emergencies", "Spend it all"],
    ],
  ];

  RxInt pageIndex = 0.obs;
  RxDouble responsibilityScore = 0.0.obs;

  var pages = [
    IntroductionPage(),
    QuestionPage(
      question: "How much will you save?",
      correctAns: "Save \$250 (50%)",
      options: [
        ["Save \$250 (50%)", "Maximum savings for future goals"],
        ["Save \$100 (20%)", "Moderate savings approach"],
        ["Save \$0 (0%)", "No savings"],
      ],
      correctMessage:
          "Great choice! Saving a significant portion ensures you're planning for the future.",
    ),
    QuestionPage(
      question: "What about those \$150 sneakers?",
      correctAns: "Wait for Next Paycheck",
      options: [
        ["Buy Now (\$150)", "Get them immediately"],
        ["Wait for Next Paycheck", "Practice patience"],
        ["Buy Cheaper Option (\$75)", "Find a balance"],
      ],
      correctMessage:
          "Great decision! Delaying gratification helps you stay within your budget.",
    ),
    QuestionPage(
      question: "Planning for Emergencies",
      correctAns: "Set aside \$150",
      options: [
        ["Set aside \$150", "Strong emergency fund"],
        ["Set aside \$50", "Small emergency fund"],
        ["Keep Nothing for Emergencies", "Spend it all"],
      ],
      correctMessage:
          "Excellent! Planning for emergencies helps you avoid debt in tough times.",
    ),
    ResultPage(),
  ];
}
