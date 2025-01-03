import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GlobalWidgets/CustomSnackBars.dart';
import 'package:money_monkey/LessonPages/Controllers/LessonOneController.dart';
import 'package:money_monkey/LessonPages/Widgets/OptionsTile.dart';

class L1Page6 extends StatefulWidget {
  const L1Page6({super.key});

  @override
  State<L1Page6> createState() => _L1Page6State();
}

class _L1Page6State extends State<L1Page6> {
  String currentQuestion = "";
  List<String> currentAnswers = [];
  List<String> correctAnswers = ["High priority"];
  List<String> options = [
    "High priority",
    "Not that important",
  ];
  String _containerHeading = "Family Planning";
  String _containerSubHeading =
      "Jordan is thinking about starting a family soon. How important is it to have an emergency fund?";
  LessonOneController lessonOneController = Get.find();
  SnackBar correctAnswer = CorrectAnswerSnackBar(
    message:
        "Yes! Unexpected costs like medical\nbills or childcare can pop up. Having a\ncushion is crucial.",
  );

  SnackBar wrongAnswer = WrongAnswerSnackBar(
    message:
        "Coins have been used since\naround 600 B.C., making them the\noldest form of money still in use.",
  );

  void answerQuestion(String ans) {
    currentAnswers.clear();
    if (correctAnswers.contains(ans)) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(correctAnswer);
      setState(() {
        currentAnswers.add(ans);
      });
      Future.delayed(
        Duration(seconds: 2),
        () {
          lessonOneController.pageIndex.value += 1;
        },
      );
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(wrongAnswer);
      setState(() {
        currentAnswers.add(ans);
      });
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: screenWidth * 0.02),
          //Heading
          Text(
            "Meet Jordan: A Life of Financial Decisions",
            softWrap: true,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27,
            ),
          ).marginSymmetric(
              vertical: screenHeight * 0.025, horizontal: screenWidth * 0.015),
          //SubHeading
          Text(
            "Jordan is on a journey from high school to retirement. Let's help them make smart financial choices!",
            softWrap: true,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 19,
            ),
          ).marginSymmetric(
            vertical: screenHeight * 0.01,
            horizontal: screenWidth * 0.015,
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Container(
            height: screenHeight * 0.4,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.015,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 2,
                  spreadRadius: 1,
                  offset: Offset(0, 3),
                ),
              ],
              color: Colors.white,
            ),
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Text(
                      _containerHeading,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ).marginSymmetric(horizontal: screenWidth * 0.015),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Text(
                      _containerSubHeading,
                      softWrap: true,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ).marginSymmetric(horizontal: screenWidth * 0.015),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    ...options.map((answer) {
                      return GestureDetector(
                        onTap: () {
                          answerQuestion(answer);
                        },
                        child: OptionsTile(
                          isSelected: currentAnswers.contains(answer),
                          childWidget: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 15,
                            ),
                            child: Text(
                              answer,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: screenWidth * 0.25),
    );
  }

  mobileDisplay() {}
}
