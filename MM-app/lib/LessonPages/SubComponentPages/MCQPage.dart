import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/SubComponentModel.dart';
import 'package:money_monkey/GettingStarted/Widgets/continue_button.dart';
import 'package:money_monkey/GettingStarted/Widgets/option_tile.dart';
import 'package:money_monkey/GlobalWidgets/CustomSnackBars.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';

import 'package:money_monkey/LessonPages/Widgets/OptionsTile.dart';

class MCQPage extends StatefulWidget {
  final String wrong;
  final String correct;
  final String title;
  final String question;
  final String correctAnswer;
  final List<String> options;
  const MCQPage(
      {super.key,
      required this.wrong,
      required this.correct,
      required this.title,
      required this.question,
      required this.correctAnswer,
      required this.options});

  @override
  State<MCQPage> createState() {
    return _MCQPageState();
  }
}

class _MCQPageState extends State<MCQPage> {
  BaseLessonController baseLessonController = Get.find<BaseLessonController>();

  String currentQuestion = "";
  List<String> currentAnswers = [];
  bool _isCorrectAnswered = false; // Only lock when correct answer is given

  @override
  void initState() {
    super.initState();
    _isCorrectAnswered = false;
  }

  @override
  void didUpdateWidget(MCQPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset when widget updates (new question)
    if (oldWidget.question != widget.question || 
        oldWidget.title != widget.title) {
      _isCorrectAnswered = false;
      currentAnswers.clear();
    }
  }

  void answerQuestion(String ans) {
    // Only prevent answering if correct answer was already given
    if (_isCorrectAnswered) return;
    
    currentAnswers.clear();
    
    if (widget.correctAnswer == ans) {
      // Correct answer - lock and advance
      _isCorrectAnswered = true;
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
      // Wrong answer - show feedback but allow retry
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(WrongAnswerSnackBar(message: widget.wrong));
      setState(() {
        currentAnswers.add(ans);
      });
      // Clear the selection after a brief delay to allow retry
      Future.delayed(
        Duration(milliseconds: 1500),
        () {
          if (mounted && !_isCorrectAnswered) {
            setState(() {
              currentAnswers.clear();
            });
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    if (baseLessonController.pages.isEmpty) {
      return Center(child: Text("No data available"));
    }
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
          widget.question,
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
          widget.title,
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
            child: SingleChildScrollView(
              child: Column(
                children: widget.options.map((answer) {
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
                  children: widget.options.map((answer) {
                    return GestureDetector(
                      onTap: () {
                        answerQuestion(answer);
                      },
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