import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GlobalWidgets/CustomSnackBars.dart';
import 'package:money_monkey/LessonPages/Controllers/Component1_2Controller.dart';
import 'package:money_monkey/LessonPages/Widgets/OptionsTile.dart';
import 'package:money_monkey/LessonPages/Widgets/ShadowedBoxContainer.dart';
import 'package:money_monkey/themes/color_themes.dart';

class QuickCheckPage extends StatefulWidget {
  const QuickCheckPage({super.key});

  @override
  State<QuickCheckPage> createState() => _QuickCheckPageState();
}

class _QuickCheckPageState extends State<QuickCheckPage> {
  String title = "Lifelong Financial Responsibility";
  String question1 =
      "Which of the following best describes a strong financial habit at any age?";
  String question2 = "Which is a key benefit of having an emergency fund?";
  String correctAns1 = "Saving and investing a portion of earnings regularly";
  String correctAns2 =
      "It covers unexpected expenses, reducing stress and debt";
  String answer1 = "";
  String answer2 = "";
  List<String> options1 = <String>[
    "Spending money the moment you get it",
    "Saving and investing a portion of earnings regularly",
    "Waiting to save until you earn a high salary",
  ];
  List<String> options2 = [
    "It guarantees you’ll never worry about money again",
    "It covers unexpected expenses, reducing stress and debt",
    "It means you can freely spend on luxury items without a budget",
  ];
  bool isNextEnabled = false;
  ComponentOneTwoController componentOneTwoController = Get.find();
  void showMessage() {
    ScaffoldMessenger.of(context).clearSnackBars();
    if (answer1 == correctAns1 && answer2 == correctAns2) {
      ScaffoldMessenger.of(context).showSnackBar(
        CorrectAnswerSnackBar(
          message: "Yes, both these answers are correct!",
        ),
      );
      Future.delayed(
        Duration(seconds: 2),
        () {
          componentOneTwoController.pageIndex.value += 1;
        },
      );
    } else if (answer1 == correctAns1 || answer2 == correctAns2) {
      ScaffoldMessenger.of(context).showSnackBar(
        WrongAnswerSnackBar(
          message: "Only one of these answers are\ncorrect!",
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        WrongAnswerSnackBar(
          message: "Recheck your answer please.",
        ),
      );
    }
  }

  void answerQuestion(int questionNumber, String ans) {
    switch (questionNumber) {
      case 1:
        setState(() {
          answer1 = ans;
        });
        break;
      case 2:
        setState(() {
          answer2 = ans;
        });
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).clearSnackBars();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > screenHeight
        ? webDisplay(screenWidth, screenHeight)
        : mobileDisplay();
  }

  webDisplay(double screenWidth, double screenHeight) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Quick Check: $title",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 27,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FlextibleMCQ(screenWidth, screenHeight, question1, options1),
              SizedBox(width: screenWidth * 0.02),
              FlextibleMCQ(screenWidth, screenHeight, question2, options2),
            ],
          ).marginSymmetric(
            vertical: screenHeight * 0.025,
          ),
          GestureDetector(
            onTap: () {
              showMessage();
            },
            child: Container(
              width: screenWidth * 0.6,
              height: screenHeight * 0.08,
              decoration: BoxDecoration(
                color: LightTheme().pastelGreen,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Check",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ).paddingSymmetric(
        horizontal: screenWidth * 0.25,
        vertical: screenHeight * 0.02,
      ),
    );
  }

  Flexible FlextibleMCQ(double screenWidth, double screenHeight,
      String question, List<String> options) {
    return Flexible(
      flex: 1,
      child: ShadowedBoxContainer(
        child: Column(
          children: [
            Text(
              question,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
            ...options.map(
              (option) {
                return GestureDetector(
                  onTap: () {
                    answerQuestion(question == question1 ? 1 : 2, option);
                  },
                  child: OptionsTile(
                    isSelected: answer1 == option || answer2 == option,
                    childWidget: Container(
                      width: double.infinity,
                      height: screenHeight * 0.1,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.01,
                        vertical: screenHeight * 0.015,
                      ),
                      child: Text(
                        option,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ).paddingSymmetric(
          vertical: screenHeight * 0.03,
        ),
      ),
    );
  }

  mobileDisplay() {}
}
