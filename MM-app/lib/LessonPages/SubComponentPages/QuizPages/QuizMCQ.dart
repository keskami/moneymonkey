import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/GlobalWidgets/CustomSnackBars.dart';
import 'package:money_monkey/LessonPages/Controllers/PeerReflectionQuizController.dart';
import 'package:money_monkey/LessonPages/Models/Models.dart';
import 'package:money_monkey/LessonPages/Repositories/addLesson.dart';

class QuizMCQPage extends StatefulWidget {
  final String question;
  final List<String> answers;
  final Map<String, String> feedback;
  final String correctAnswer;

  const QuizMCQPage({
    super.key,
    required this.question,
    required this.answers,
    required this.feedback,
    required this.correctAnswer,
  });

  @override
  State<QuizMCQPage> createState() {
    return _QuizMCQPageState();
  }
}

class _QuizMCQPageState extends State<QuizMCQPage> {
  PeerReflectionQuizcontroller peerReflectionQuizcontroller = Get.find();
  bool option1 = false;
  bool option2 = false;
  bool option3 = false;
  bool option4 = false;
  String selectedOption = "";

  bool firstTime = true;
  bool correct = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double screenWidthUnit = screenWidth / 1920;
    double screenHeightUnit = screenHeight / 980;
    return Center(
        child: Padding(
      padding: EdgeInsets.fromLTRB(
          screenWidthUnit * 572, screenHeightUnit * 122, 0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.question,
            style: GoogleFonts.baloo2(
                fontSize: screenWidthUnit * 27,
                fontWeight: FontWeight.w700,
                color: Colors.black),
          ),
          SizedBox(
            height: screenHeightUnit * 51,
          ),
          Row(children: [
            quizOptionWithoutImage(
                text: widget.answers[0],
                screenHeightUnit: screenHeightUnit,
                option: option1,
                screenWidthUnit: screenWidthUnit,
                //image: 'assets/images/banknote.png',
                onClick: () {
                  setState(() {
                    option1 = !option1;
                    option2 = false;
                    option3 = false;
                    option4 = false;

                    selectedOption = widget.answers[0];
                  });
                },
                context: context),
            SizedBox(
              width: screenWidthUnit * 20,
            ),
            quizOptionWithoutImage(
                text: widget.answers[2],
                screenHeightUnit: screenHeightUnit,
                option: option2,
                screenWidthUnit: screenWidthUnit,
                //image: 'assets/images/coin.png',
                onClick: () {
                  setState(() {
                    option2 = !option2;
                    option1 = false;
                    option3 = false;
                    option4 = false;
                    selectedOption = widget.answers[1];
                  });
                },
                context: context),
          ]),
          SizedBox(
            height: screenHeightUnit * 17,
          ),
          Row(children: [
            quizOptionWithoutImage(
                text: widget.answers[2],
                option: option3,
                screenHeightUnit: screenHeightUnit,
                screenWidthUnit: screenWidthUnit,
                //image: 'assets/images/creditcard.png',
                onClick: () {
                  setState(() {
                    option3 = !option3;
                    option2 = false;
                    option1 = false;
                    option4 = false;
                    selectedOption = widget.answers[2];
                  });
                },
                context: context),
            SizedBox(
              width: screenWidthUnit * 20,
            ),
            quizOptionWithoutImage(
                text: widget.answers[3],
                option: option4,
                screenHeightUnit: screenHeightUnit,
                screenWidthUnit: screenWidthUnit,
                //image: 'assets/images/mobile.png',
                onClick: () {
                  setState(() {
                    option4 = !option4;
                    option1 = false;
                    option3 = false;
                    option2 = false;
                    selectedOption = widget.answers[3];
                  });
                },
                context: context),
          ]),
          SizedBox(
            height: screenHeightUnit * 44,
          ),
          bottomBar(
            screenHeightUnit: screenHeightUnit,
            screenWidthUnit: screenWidthUnit,
            firstTime: firstTime,
            option1: option1,
            option2: option2,
            option3: option3,
            option4: option4,
            correct: correct,
            onTap: () {
              if ((!firstTime && !correct)) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                setState(() {
                  firstTime = true;
                  option1 = false;
                  option2 = false;
                  option3 = false;
                  option4 = false;
                  correct = false;
                  selectedOption = "";
                });
              }

              if (correct) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                peerReflectionQuizcontroller.pageIndex.value += 1;
              } else if (option1 || option2 || option3 || option4) {
                if (widget.correctAnswer == selectedOption) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      CorrectAnswerSnackBar(
                          message: widget.feedback[widget.correctAnswer] ?? ''));
                  setState(() {
                    correct = true;
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      WrongAnswerSnackBar(
                          message: widget.feedback[selectedOption] ?? ''));
                  setState(() {
                    firstTime = false;
                  });
                }
              } else {}
            },
          )
        ],
      ),
    ));
  }
}

Widget quizOptionWithoutImage(
    {required String text,
    required double screenHeightUnit,
    required double screenWidthUnit,
    required Function onClick,
    required BuildContext context,
    required bool option}) {
  return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        height: screenHeightUnit * 153,
        width: screenWidthUnit * 377,
        decoration: BoxDecoration(
          color: option ? Color.fromRGBO(137, 220, 142, 1) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: GoogleFonts.baloo2(
                  fontSize: screenWidthUnit * 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ));
}

Widget quizOptionWithImage(
    {required String text,
    required double screenHeightUnit,
    required double screenWidthUnit,
    required String image,
    required Function onClick,
    required BuildContext context,
    required bool option}) {
  return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        height: screenHeightUnit * 153,
        width: screenWidthUnit * 377,
        decoration: BoxDecoration(
          color: option ? Color.fromRGBO(137, 220, 142, 1) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              image,
              height: screenHeightUnit * 120,
              width: screenWidthUnit * 120,
              fit: BoxFit.cover,
            ),
            SizedBox(width: screenWidthUnit * 10),
            Text(
              text,
              style: GoogleFonts.baloo2(
                fontSize: screenWidthUnit * 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ));
}

Widget bottomBar({
  required double screenHeightUnit,
  required double screenWidthUnit,
  required bool firstTime,
  required bool option1,
  required bool option2,
  required bool option3,
  required bool option4,
  required bool correct,
  required Function onTap,
}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      height: screenHeightUnit * 73,
      width: screenWidthUnit * 744,
      decoration: BoxDecoration(
        color: (!firstTime && !correct)
            ? Color.fromRGBO(255, 0, 0, .6)
            : (option1 || option2 || option3 || option4)
                ? Color.fromRGBO(137, 220, 142, 1)
                : Color.fromRGBO(224, 227, 231, 1),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: (!firstTime)
              ? Color.fromRGBO(255, 0, 0, .6)
              : (option1 || option2 || option3 || option4)
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
              color: Colors.white),
        ),
      ),
    ),
  );
}
