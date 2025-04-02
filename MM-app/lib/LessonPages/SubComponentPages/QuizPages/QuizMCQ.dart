import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/GlobalWidgets/CustomSnackBars.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';
import 'package:money_monkey/home.dart';

class QuizMCQPage extends StatefulWidget {
  final String question;
  final List<String> answers;
  final Map<String, String> feedback;

  // Changed from single correctAnswer to List of correctAnswers
  final List<String> correctAnswers;

  // Flag to determine if multiple selections are allowed
  final bool allowMultipleSelections;

  const QuizMCQPage({
    super.key,
    required this.question,
    required this.answers,
    required this.feedback,
    required this.correctAnswers,
    this.allowMultipleSelections = false, // Default to single answer mode
  });

  @override
  State<QuizMCQPage> createState() {
    return _QuizMCQPageState();
  }
}

class _QuizMCQPageState extends State<QuizMCQPage> {
  BaseLessonController baseLessonController = Get.find();

  // Track selected options
  Map<int, bool> selectedOptions = {
    0: false,
    1: false,
    2: false,
    3: false,
  };

  // Track selected answers
  List<String> selectedAnswers = [];

  bool firstTime = true;
  bool correct = false;

  @override
  void initState() {
    super.initState();
  }

  // Method to reset all state variables
  void resetState() {
    if (mounted) {
      setState(() {
        selectedOptions = {
          0: false,
          1: false,
          2: false,
          3: false,
        };
        selectedAnswers = [];
        firstTime = true;
        correct = false;
      });
    }
  }

  void toggleOption(int index) {
    setState(() {
      if (widget.allowMultipleSelections) {
        // For multiple selection mode, toggle the selected option
        selectedOptions[index] = !selectedOptions[index]!;

        // Update selectedAnswers list
        if (selectedOptions[index]!) {
          selectedAnswers.add(widget.answers[index]);
        } else {
          selectedAnswers.remove(widget.answers[index]);
        }
      } else {
        // For single selection mode, clear all other selections
        for (int i = 0; i < 4; i++) {
          selectedOptions[i] = i == index;
        }

        // Update selectedAnswers list
        selectedAnswers = [widget.answers[index]];
      }
    });
  }

  bool checkAnswers() {
    if (widget.allowMultipleSelections) {
      // For multiple answers, check if all selected answers are correct
      // and all correct answers are selected
      return selectedAnswers.length == widget.correctAnswers.length &&
          selectedAnswers
              .every((answer) => widget.correctAnswers.contains(answer)) &&
          widget.correctAnswers
              .every((answer) => selectedAnswers.contains(answer));
    } else {
      // For single answer, check if the selected answer is correct
      return selectedAnswers.length == 1 &&
          widget.correctAnswers.contains(selectedAnswers[0]);
    }
  }

  String getResponseFeedback() {
    // For multiple selection mode
    if (widget.allowMultipleSelections) {
      // Check if all selections match correct answers
      if (checkAnswers()) {
        return widget.feedback['correct'] ?? 'Correct!';
      }

      // If incorrect, try to provide specific feedback for the selection combination
      String combinedSelections = selectedAnswers.join(',');
      if (widget.feedback.containsKey(combinedSelections)) {
        return widget.feedback[combinedSelections]!;
      }

      // Fall back to generic feedback
      return widget.feedback['incorrect'] ?? 'Try again.';
    }
    // For single selection mode
    else if (selectedAnswers.isNotEmpty) {
      return widget.feedback[selectedAnswers[0]] ?? 'Try again.';
    }

    return '';
  }

  @override
  void dispose() {
    // Clean up any resources or listeners here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Use relative sizing for better adaptability
    double screenWidthUnit = screenWidth / 1920;
    double screenHeightUnit = screenHeight / 980;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.15,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: (screenWidthUnit * 377 * 2) + (screenWidthUnit * 20),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.9,
              ),
              child: Text(
                widget.question,
                style: GoogleFonts.baloo2(
                  fontSize: screenWidthUnit * 34,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            if (widget.allowMultipleSelections)
              Container(
                margin: EdgeInsets.only(top: screenHeightUnit * 10),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidthUnit * 20,
                  vertical: screenHeightUnit * 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Select all correct answers",
                  style: GoogleFonts.baloo2(
                    fontSize: screenWidthUnit * 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue[800],
                  ),
                ),
              ),
            SizedBox(
              height: screenHeightUnit * 40,
            ),
            // First row - two buttons at the top
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                quizOptionWithoutImage(
                  text: widget.answers[0],
                  screenHeightUnit: screenHeightUnit,
                  option: selectedOptions[0]!,
                  screenWidthUnit: screenWidthUnit,
                  onClick: () => toggleOption(0),
                  context: context,
                ),
                SizedBox(width: screenWidthUnit * 20),
                quizOptionWithoutImage(
                  text: widget.answers[1],
                  screenHeightUnit: screenHeightUnit,
                  option: selectedOptions[1]!,
                  screenWidthUnit: screenWidthUnit,
                  onClick: () => toggleOption(1),
                  context: context,
                ),
              ],
            ),
            SizedBox(height: screenHeightUnit * 17),
            // Second row - two buttons at the bottom
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                quizOptionWithoutImage(
                  text: widget.answers[2],
                  option: selectedOptions[2]!,
                  screenHeightUnit: screenHeightUnit,
                  screenWidthUnit: screenWidthUnit,
                  onClick: () => toggleOption(2),
                  context: context,
                ),
                SizedBox(width: screenWidthUnit * 20),
                quizOptionWithoutImage(
                  text: widget.answers[3],
                  option: selectedOptions[3]!,
                  screenHeightUnit: screenHeightUnit,
                  screenWidthUnit: screenWidthUnit,
                  onClick: () => toggleOption(3),
                  context: context,
                ),
              ],
            ),
            SizedBox(
              height: screenHeightUnit * 60,
            ),
            bottomBar(
              screenHeightUnit: screenHeightUnit,
              screenWidthUnit: screenWidthUnit,
              firstTime: firstTime,
              hasSelection: selectedAnswers.isNotEmpty,
              correct: correct,
              onTap: () {
                if ((!firstTime && !correct)) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  setState(() {
                    firstTime = true;
                    selectedOptions.updateAll((key, value) => false);
                    selectedAnswers.clear();
                    correct = false;
                  });
                }

                if (correct) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();

                  resetState();

                  if (baseLessonController.pageIndex.value <
                      baseLessonController.pages.length - 1) {
                    // If not at the last page, simply increment and continue
                    baseLessonController.pageIndex.value += 1;
                  } else {
                    // If we're at the last page, reset index and navigate home
                    baseLessonController.pageIndex.value = 0;

                    // Navigate to HomePage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );

                    // Clean up the controller if it's registered
                    if (Get.isRegistered<BaseLessonController>()) {
                      Get.delete<BaseLessonController>();
                    }
                  }
                } else if (selectedAnswers.isNotEmpty) {
                  if (checkAnswers()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      CorrectAnswerSnackBar(
                        message: getResponseFeedback(),
                      ),
                    );
                    setState(() {
                      correct = true;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      WrongAnswerSnackBar(
                        message: getResponseFeedback(),
                      ),
                    );
                    setState(() {
                      firstTime = false;
                    });
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget quizOptionWithoutImage({
  required String text,
  required double screenHeightUnit,
  required double screenWidthUnit,
  required Function onClick,
  required BuildContext context,
  required bool option,
}) {
  // Adjust width to be more responsive
  double optionWidth = screenWidthUnit * 377;
  // Limit width for smaller screens
  if (optionWidth > MediaQuery.of(context).size.width * 0.8) {
    optionWidth = MediaQuery.of(context).size.width * 0.8;
  }

  return GestureDetector(
    onTap: () {
      onClick();
    },
    child: Container(
      height: screenHeightUnit * 153,
      width: optionWidth,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.8,
        minWidth: 150, // Set minimum width
      ),
      decoration: BoxDecoration(
        color: option ? Color.fromRGBO(137, 220, 142, 1) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            text,
            style: GoogleFonts.baloo2(
              fontSize: screenWidthUnit * 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}

Widget bottomBar({
  required double screenHeightUnit,
  required double screenWidthUnit,
  required bool firstTime,
  required bool hasSelection,
  required bool correct,
  required Function onTap,
}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      height: screenHeightUnit * 73,
      // Make width responsive
      width: screenWidthUnit * 744,
      constraints: BoxConstraints(
        maxWidth: 744,
        minWidth: 200,
      ),
      decoration: BoxDecoration(
        color: (!firstTime && !correct)
            ? Color.fromRGBO(255, 0, 0, .6)
            : (hasSelection)
                ? Color.fromRGBO(137, 220, 142, 1)
                : Color.fromRGBO(224, 227, 231, 1),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: (!firstTime)
              ? Color.fromRGBO(255, 0, 0, .6)
              : (hasSelection)
                  ? Color.fromRGBO(137, 220, 142, 1)
                  : Color.fromRGBO(224, 227, 231, 1),
          width: .1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          correct
              ? "Continue"
              : firstTime
                  ? "Check"
                  : "Try Again",
          style: GoogleFonts.baloo2(
            fontSize: screenWidthUnit * 21,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
