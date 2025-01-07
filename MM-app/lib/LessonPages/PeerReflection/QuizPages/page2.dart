import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/GlobalWidgets/CustomSnackBars.dart';
import 'package:money_monkey/LessonPages/Controllers/PeerReflectionQuizController.dart';
import 'package:money_monkey/home.dart';

class PeerReflectionQuizPage2 extends StatefulWidget {
  @override
  _PeerReflectionQuizPage2State createState() =>
      _PeerReflectionQuizPage2State();
}

class _PeerReflectionQuizPage2State extends State<PeerReflectionQuizPage2> {
  PeerReflectionQuizcontroller peerReflectionQuizcontroller = Get.find();
  bool option1 = false;
  bool option2 = false;
  bool option3 = false;
  bool option4 = false;
  bool firstTime = true;
  bool correct = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double screenWidthUnit = screenWidth / 1920;
    double screenHeightUnit = screenHeight / 980;
    return Center(
        child: Padding(
      padding: EdgeInsets.fromLTRB(
          screenWidthUnit * 572, screenHeightUnit * 177, 0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What is the main purpose of money?",
            style: GoogleFonts.baloo2(
                fontSize: screenWidthUnit * 27,
                fontWeight: FontWeight.w700,
                color: Colors.black),
          ),
          SizedBox(
            height: screenHeightUnit * 61,
          ),
          Row(children: [
            quizOptionWithoutImage(
                text: 'To use it as a distraction',
                screenHeightUnit: screenHeightUnit,
                option: option1,
                screenWidthUnit: screenWidthUnit,
                onClick: () {
                  setState(() {
                    option1 = !option1;
                    option2 = false;
                    option3 = false;
                    option4 = false;
                  });
                },
                context: context),
            SizedBox(
              width: screenWidthUnit * 20,
            ),
            quizOptionWithoutImage(
                text: 'To exchange it for things\n we want or need',
                screenHeightUnit: screenHeightUnit,
                option: option2,
                screenWidthUnit: screenWidthUnit,
                onClick: () {
                  setState(() {
                    option2 = !option2;
                    option1 = false;
                    option3 = false;
                    option4 = false;
                  });
                },
                context: context),
          ]),
          SizedBox(
            height: screenHeightUnit * 17,
          ),
          Row(children: [
            quizOptionWithoutImage(
                text: 'To hide it away from others',
                option: option3,
                screenHeightUnit: screenHeightUnit,
                screenWidthUnit: screenWidthUnit,
                
                onClick: () {
                  setState(() {
                    option3 = !option3;
                    option2 = false;
                    option1 = false;
                    option4 = false;
                  });
                },
                context: context),
            SizedBox(
              width: screenWidthUnit * 20,
            ),
            quizOptionWithoutImage(
                text: 'To keep it only in banks',
                option: option4,
                screenHeightUnit: screenHeightUnit,
                screenWidthUnit: screenWidthUnit,
                onClick: () {
                  setState(() {
                    option4 = !option4;
                    option1 = false;
                    option3 = false;
                    option2 = false;
                  });
                },
                context: context),
          ]),
          SizedBox(
            height: screenHeightUnit * 64,
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
              if (correct) {
               Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
              }
              else if (option1 || option2 || option3 || option4) {
                if (option2) {
                  ScaffoldMessenger.of(context).showSnackBar(CorrectAnswerSnackBar(
                      message:
                          "Coins have been used since around 600\nB.C., making them the oldest form of\nmoney still in use."));
                  setState(() {
                    correct = true;
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(WrongAnswerSnackBar(
                      message:
                          "Coins have been used since around 600\nB.C., making them the oldest form of\nmoney still in use."));
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
                fontSize: screenWidthUnit * 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
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
