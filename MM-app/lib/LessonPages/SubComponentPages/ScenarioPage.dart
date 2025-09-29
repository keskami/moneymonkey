import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GlobalWidgets/CustomSnackBars.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';
 
import 'package:money_monkey/LessonPages/Widgets/OptionsTile.dart';

class ScenarioPage extends StatefulWidget {
  String title = '';
  String subTitle = '';
  String wrong = '';
  String correct = '';
  String containerHeading = '';
  String containerSubHeading = '';
  List<String> options = [];
  String correctAnswer = '';
  String componentId;
  ScenarioPage(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.wrong,
      required this.correct,
      required this.containerHeading,
      required this.containerSubHeading,
      required this.options,
      required this.correctAnswer,
      required this.componentId});

  @override
  State<ScenarioPage> createState() => _ScenarioPageState();
}

class _ScenarioPageState extends State<ScenarioPage> {
  String currentQuestion = "";
  List<String> currentAnswers = [];
  bool _hasAnswered = false; // Add this flag to prevent multiple answers

  BaseLessonController baseLessonController =
        Get.find<BaseLessonController>();

  @override
  void initState() {
    super.initState();
    _hasAnswered = false; // Reset for each new question
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).clearSnackBars();
    });
  }

  @override
  void didUpdateWidget(ScenarioPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset when widget updates (new question)
    if (oldWidget.componentId != widget.componentId || 
        oldWidget.containerHeading != widget.containerHeading) {
      _hasAnswered = false;
      currentAnswers.clear();
    }
  }

  void answerQuestion(String ans) {
    // Prevent multiple answers only if they got it right
    if (_hasAnswered) return;
    
    currentAnswers.clear();
    
    if (widget.correctAnswer == ans) {
      _hasAnswered = true; // Only mark as answered if correct
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(CorrectAnswerSnackBar(message: widget.correct));
      setState(() {
        currentAnswers.add(ans);
      });
      Future.delayed(
        Duration(seconds: 2),
        () {
          baseLessonController.pageIndex.value += 1;
        },
      );
    } else {
      // Don't set _hasAnswered = true for wrong answers, allow retry
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(WrongAnswerSnackBar(message: widget.wrong));
      setState(() {
        currentAnswers.add(ans);
      });
    }
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
            widget.title,
            softWrap: true,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27,
            ),
          ).marginSymmetric(
              vertical: screenHeight * 0.025, horizontal: screenWidth * 0.015),
          //SubHeading
          Text(
            widget.subTitle,
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
            child: SingleChildScrollView(  // ✅ Removed Expanded
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Text(
                    widget.containerHeading,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ).marginSymmetric(horizontal: screenWidth * 0.015),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    widget.containerSubHeading,
                    softWrap: true,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ).marginSymmetric(horizontal: screenWidth * 0.015),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  ...widget.options.map((answer) {
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
        ],
      ).paddingSymmetric(horizontal: screenWidth * 0.25),
    );
  }

  mobileDisplay() {}
}