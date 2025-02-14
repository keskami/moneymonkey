import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Backend/Services/auth_service.dart';
import 'package:money_monkey/GlobalWidgets/CustomSnackBars.dart';
import 'package:money_monkey/LessonPages/Controllers/PeerReflectionQuizController.dart';
import 'package:money_monkey/LessonPages/Repositories/addLesson.dart';

class PeerReflectionQuizPage1 extends StatefulWidget {
  @override
  _PeerReflectionQuizPage1State createState() =>
      _PeerReflectionQuizPage1State();
}

class _PeerReflectionQuizPage1State extends State<PeerReflectionQuizPage1> {
  PeerReflectionQuizcontroller peerReflectionQuizcontroller = Get.find();
  bool option1 = false;
  bool option2 = false;
  bool option3 = false;
  bool option4 = false;
  int selectedOption = 0;
  int correctAnswer = 0;

  bool firstTime = true;
  bool correct = false;

  String question = '';
  bool hasDataAdded = false;
  String answer1 = '';
  String answer2 = '';
  String answer3 = '';
  String answer4 = '';
  bool loading = true;

  Future<void> setData(data) async {
    setState(() {
      question = data['question'];
      answer1 = data['answer1'];
      answer2 = data['answer2'];
      answer3 = data['answer3'];
      answer4 = data['answer4'];
      correctAnswer = int.parse(data['correct']);
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    // If the controller has already finished loading before this widget is built:
    if (!peerReflectionQuizcontroller.isLoading.value) {
      setData(peerReflectionQuizcontroller.pageData[1]);
    }
    ever(peerReflectionQuizcontroller.isLoading, (loadingValue) {
      if (loadingValue == false) {
        setData(peerReflectionQuizcontroller.pageData[1]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double screenWidthUnit = screenWidth / 1920;
    double screenHeightUnit = screenHeight / 980;
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Center(
            child: Padding(
            padding: EdgeInsets.fromLTRB(
                screenWidthUnit * 572, screenHeightUnit * 122, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question,
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
                      text: answer1,
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

                          selectedOption = 1;
                        });
                      },
                      context: context),
                  SizedBox(
                    width: screenWidthUnit * 20,
                  ),
                  quizOptionWithoutImage(
                      text: answer2,
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
                          selectedOption = 2;
                        });
                      },
                      context: context),
                ]),
                SizedBox(
                  height: screenHeightUnit * 17,
                ),
                Row(children: [
                  quizOptionWithoutImage(
                      text: answer3,
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
                          selectedOption = 3;
                        });
                      },
                      context: context),
                  SizedBox(
                    width: screenWidthUnit * 20,
                  ),
                  quizOptionWithoutImage(
                      text: answer4,
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
                          selectedOption = 4;
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
                        selectedOption = 0;
                      });
                    }

                    if (correct) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      peerReflectionQuizcontroller.pageIndex.value += 1;
                    } else if (option1 || option2 || option3 || option4) {
                      if (correctAnswer == selectedOption) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            CorrectAnswerSnackBar(
                                message:
                                    "Coins have been used since around 600\nB.C., making them the oldest form of\nmoney still in use."));
                        setState(() {
                          correct = true;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            WrongAnswerSnackBar(
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
