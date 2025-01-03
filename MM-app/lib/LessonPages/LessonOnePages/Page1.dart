import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Widgets/continue_button.dart';
import 'package:money_monkey/GettingStarted/Widgets/option_tile.dart';
import 'package:money_monkey/GlobalWidgets/CustomSnackBars.dart';
import 'package:money_monkey/LessonPages/Controllers/LessonOneController.dart';
import 'package:money_monkey/LessonPages/Widgets/OptionsTile.dart';

class L1Page1 extends StatefulWidget {
  const L1Page1({
    super.key,
  });

  @override
  State<L1Page1> createState() {
    return _L1Page1State();
  }
}

class _L1Page1State extends State<L1Page1> {
  String currentQuestion = "";
  List<String> currentAnswers = [];
  List<String> correctAnswers = [
    "As soon as I start earning money (even if it’s part-time or allowance)"
  ];
  List<String> options = [
    "Once I have a full time job",
    "As soon as I start earning money (even if it’s part-time or allowance)",
    "After I graduate from college.",
    "Only when I’m ready to plan for retirement.",
  ];
  LessonOneController lessonOneController = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).clearSnackBars();
    });
  }

  SnackBar correctAnswer = CorrectAnswerSnackBar(
    message:
        "That's right! Financial responsibility can start early, from\nyour first paycheck or allowance. Let's explore why.",
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
  Widget build(context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > screenHeight
        ? webDisplay(screenWidth, screenHeight)
        : mobileDisplay();
  }

  Widget webDisplay(double screenWidth, double screenHeight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: screenWidth * 0.02),
        Text(
          "When Should Financial Responsibility Begin?",
          softWrap: true,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 27,
          ),
        ).marginSymmetric(
          vertical: screenHeight * 0.025,
          horizontal: screenWidth * 0.015,
        ),
        Text(
          "Before we dive in, let’s see what you think!",
          softWrap: true,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 19,
          ),
        ).marginSymmetric(
          vertical: screenHeight * 0.01,
          horizontal: screenWidth * 0.015,
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          height: screenHeight * 0.5,
          child: Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: options.map((answer) {
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
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        SizedBox(
          height: screenHeight * 0.1,
        ),
      ],
    ).paddingSymmetric(horizontal: screenWidth * 0.25);
  }

  Scaffold mobileDisplay() {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "",
                    softWrap: true,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: options.map((answer) {
                    return GestureDetector(
                      onTap: () {},
                      child: CustomOptionTile(
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
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            NextButton(
              nextPage: () {},
              isEnabled: currentAnswers.length > 0,
            ),
          ],
        )),
      ),
    );
  }
}
