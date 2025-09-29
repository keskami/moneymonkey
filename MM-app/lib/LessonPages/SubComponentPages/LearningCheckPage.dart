import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GlobalWidgets/CustomSnackBars.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';
import 'package:money_monkey/LessonPages/Widgets/OptionsTile.dart';
import 'package:money_monkey/LessonPages/Widgets/ShadowedBoxContainer.dart';
import 'package:money_monkey/themes/color_themes.dart';

class LearningCheckPage extends StatefulWidget {
  // Instead of componentId alone, pass all relevant data
  final String title;
  final String question1;
  final String question2;
  final String correctAns1;
  final String correctAns2;
  final List<String> options1;
  final List<String> options2;
  final String button;
  final String bothCorrect;
  final String oneCorrect;
  final String wrong;

  const LearningCheckPage({
    super.key,
    required this.title,
    required this.question1,
    required this.question2,
    required this.correctAns1,
    required this.correctAns2,
    required this.options1,
    required this.options2,
    required this.button,
    required this.bothCorrect,
    required this.oneCorrect,
    required this.wrong,
  });

  @override
  State<LearningCheckPage> createState() => _LearningCheckPageState();
}

class _LearningCheckPageState extends State<LearningCheckPage> {
  final BaseLessonController baseLessonController =
      Get.find<BaseLessonController>();

  // Local state for chosen answers
  String answer1 = "";
  String answer2 = "";
  bool loading = false;
  bool _hasSubmitted = false; // Add flag to prevent multiple submissions

  @override
  void initState() {
    super.initState();
    _hasSubmitted = false; // Reset for each new question
  }

  @override
  void didUpdateWidget(LearningCheckPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset when widget updates (new question)
    if (oldWidget.title != widget.title || 
        oldWidget.question1 != widget.question1 ||
        oldWidget.question2 != widget.question2) {
      _hasSubmitted = false;
      answer1 = "";
      answer2 = "";
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

  /// Show a message based on correctness
  void showMessage() {
    // Prevent multiple submissions
    if (_hasSubmitted) return;
    
    // Check if both questions are answered
    if (answer1.isEmpty || answer2.isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please answer both questions before checking."),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).clearSnackBars();
    if (answer1 == widget.correctAns1 && answer2 == widget.correctAns2) {
      _hasSubmitted = true; // Only prevent further interaction if both are correct
      ScaffoldMessenger.of(context).showSnackBar(
        CorrectAnswerSnackBar(message: widget.bothCorrect),
      );
      Future.delayed(
        Duration(seconds: 2),
        () {
          baseLessonController.pageIndex.value += 1;
        },
      );
    } else if (answer1 == widget.correctAns1 || answer2 == widget.correctAns2) {
      // Don't set _hasSubmitted = true, allow retry for partial correct
      ScaffoldMessenger.of(context).showSnackBar(
        WrongAnswerSnackBar(message: widget.oneCorrect),
      );
    } else {
      // Don't set _hasSubmitted = true, allow retry for all wrong
      ScaffoldMessenger.of(context).showSnackBar(
        WrongAnswerSnackBar(message: widget.wrong),
      );
    }
  }

  /// Record which answer was selected for each question
  void answerQuestion(int questionNumber, String ans) {
    // Don't allow changing answers after submission
    if (_hasSubmitted) return;
    
    setState(() {
      if (questionNumber == 1) {
        answer1 = ans;
      } else if (questionNumber == 2) {
        answer2 = ans;
      }
    });
  }

  Widget webDisplay(double screenWidth, double screenHeight) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 27,
                  ),
                ),
                // Two MCQ sections side-by-side
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FlexibleMCQ(
                      screenWidth,
                      screenHeight,
                      widget.question1,
                      widget.options1,
                      questionNumber: 1,
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    FlexibleMCQ(
                      screenWidth,
                      screenHeight,
                      widget.question2,
                      widget.options2,
                      questionNumber: 2,
                    ),
                  ],
                ).marginSymmetric(
                  vertical: screenHeight * 0.025,
                ),
                // The "Check" button
                GestureDetector(
                  onTap: () {
                    showMessage();
                  },
                  child: Container(
                    width: screenWidth * 0.6,
                    height: screenHeight * 0.08,
                    decoration: BoxDecoration(
                      color: _hasSubmitted 
                          ? Colors.grey 
                          : LightTheme().pastelGreen,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        widget.button,
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
              vertical: screenHeight * 0.018,
            ),
          );
  }

  Widget mobileDisplay() {
    // Basic example for mobile layout; adapt as needed:
    return loading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // Title
                Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 20),
                // First question
                buildQuestionBox(
                  questionText: widget.question1,
                  options: widget.options1,
                  questionNumber: 1,
                ),
                SizedBox(height: 20),
                // Second question
                buildQuestionBox(
                  questionText: widget.question2,
                  options: widget.options2,
                  questionNumber: 2,
                ),
                SizedBox(height: 20),
                // "Check" button
                GestureDetector(
                  onTap: () => showMessage(),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _hasSubmitted 
                          ? Colors.grey 
                          : LightTheme().pastelGreen,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        widget.button,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Widget buildQuestionBox({
    required String questionText,
    required List<String> options,
    required int questionNumber,
  }) {
    return ShadowedBoxContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            questionText,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
          SizedBox(height: 10),
          ...options.map((option) {
            // Determine if the user selected this option for Q1 or Q2
            bool isSelected = false;
            if (questionNumber == 1) {
              isSelected = (answer1 == option);
            } else {
              isSelected = (answer2 == option);
            }

            return GestureDetector(
              onTap: () => answerQuestion(questionNumber, option),
              child: OptionsTile(
                isSelected: isSelected,
                childWidget: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  // The shared widget for a question+options in the web layout
  Flexible FlexibleMCQ(
    double screenWidth,
    double screenHeight,
    String questionText,
    List<String> options, {
    required int questionNumber,
  }) {
    return Flexible(
      flex: 1,
      child: ShadowedBoxContainer(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: screenWidth * .014),
              child: Text(
                questionText,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ),
            ),
            ...options.map((option) {
              // Determine if user selected it
              bool isSelected = false;
              if (questionNumber == 1) {
                isSelected = (answer1 == option);
              } else if (questionNumber == 2) {
                isSelected = (answer2 == option);
              }
              return GestureDetector(
                onTap: () => answerQuestion(questionNumber, option),
                child: OptionsTile(
                  isSelected: isSelected,
                  childWidget: Container(
                    width: double.infinity,
                    height: screenHeight * 0.1,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.01,
                      vertical: screenHeight * 0.01,
                    ),
                    child: Text(
                      option,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ).paddingSymmetric(
          vertical: screenHeight * 0.03,
        ),
      ),
    );
  }
}