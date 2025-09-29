import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/GlobalWidgets/CustomSnackBars.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';
import 'package:money_monkey/home.dart';

class Page4 extends StatefulWidget {
  final String title;       // e.g. "Reflection"
  final String subTitle;    // from data.questionData[3].data.question
  final String ava;         // data.data.options[0].description
  final String maria;       // data.data.options[1].description
  final String jason;       // data.data.options[2].description
  final String button;      // e.g. "Submit"
  final String feedback1;   // feedback for Ava
  final String feedback2;   // feedback for Maria
  final String feedback3;   // feedback for Jason

  const Page4({
    super.key,
    required this.title,
    required this.subTitle,
    required this.ava,
    required this.maria,
    required this.jason,
    required this.button,
    required this.feedback1,
    required this.feedback2,
    required this.feedback3,
  });

  @override
  _Page4State createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;
  final BaseLessonController baseLessonController = Get.find();

  bool mariaClicked = false;
  bool jasonClicked = false;
  bool avaClicked = false;
  bool delay = false;
  bool submitted = false;
  bool finishMode = false;

  @override
  void initState() {
    super.initState();
    _fourSecondDelay();
  }

  Future<void> _fourSecondDelay() async {
    await Future.delayed(Duration(seconds: 4));
    setState(() {
      delay = true;
    });
  }

  void _showFeedback() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    if (mariaClicked) {
      ScaffoldMessenger.of(context).showSnackBar(
        CorrectAnswerSnackBar(message: widget.feedback2),
      );
    } else if (jasonClicked) {
      ScaffoldMessenger.of(context).showSnackBar(
        CorrectAnswerSnackBar(message: widget.feedback3),
      );
    } else if (avaClicked) {
      ScaffoldMessenger.of(context).showSnackBar(
        CorrectAnswerSnackBar(message: widget.feedback1),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return screenWidth > screenHeight
        ? webDisplay(screenWidth, screenHeight)
        : mobileDisplay(screenWidth, screenHeight);
  }
  
  Widget webDisplay(double screenWidth, double screenHeight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: screenHeight * 0.04),
        
        // Title
        Text(
          widget.title,
          style: GoogleFonts.baloo2(
            fontSize: 28,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        
        SizedBox(height: screenHeight * 0.02),
        
        // Subtitle/question
        Text(
          widget.subTitle,
          style: GoogleFonts.baloo2(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        
        SizedBox(height: screenHeight * 0.04),
        
        // Options container
        Container(
          width: double.infinity,
          child: Column(
            children: [
              // Maria option
              lessonTab(
                image: "assets/images/newMonkeys/Maria.png",
                name: widget.maria,
                isClicked: mariaClicked,
                isDisabled: submitted,
                onClick: () {
                  if (!submitted) {
                    setState(() {
                      mariaClicked = true;
                      jasonClicked = false;
                      avaClicked = false;
                    });
                  }
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              
              SizedBox(height: 16),
              
              // Jason option
              lessonTab(
                image: "assets/images/newMonkeys/Jason.png",
                name: widget.jason,
                isClicked: jasonClicked,
                isDisabled: submitted,
                onClick: () {
                  if (!submitted) {
                    setState(() {
                      jasonClicked = true;
                      avaClicked = false;
                      mariaClicked = false;
                    });
                  }
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              
              SizedBox(height: 16),
              
              // Ava option
              lessonTab(
                image: "assets/images/newMonkeys/Ava.png",
                name: widget.ava,
                isClicked: avaClicked,
                isDisabled: submitted,
                onClick: () {
                  if (!submitted) {
                    setState(() {
                      avaClicked = true;
                      jasonClicked = false;
                      mariaClicked = false;
                    });
                  }
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
            ],
          ),
        ),
        
        SizedBox(height: screenHeight * 0.05),
        
        // Submit/Finish button
        GestureDetector(
          onTap: () {
            if (finishMode) {
              baseLessonController.pageIndex.value += 1;
            } else if ((avaClicked || jasonClicked || mariaClicked) &&
                delay &&
                !submitted) {
              // First submission
              setState(() {
                submitted = true;
                finishMode = true;
              });
              _showFeedback();
            } else if (!delay) {
              // still in the initial lock
            } else {
              // No selection made
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please select a peer to continue'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: Container(
            height: 56,
            width: 160,
            decoration: BoxDecoration(
              color: ((avaClicked || jasonClicked || mariaClicked) && delay)
                  ? Color.fromRGBO(137, 220, 142, 1)
                  : Color.fromRGBO(224, 227, 231, 1),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                finishMode ? "Next" : widget.button,
                style: GoogleFonts.baloo2(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: screenWidth * 0.25); // Key for proper alignment
  }
  
  Widget mobileDisplay(double screenWidth, double screenHeight) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          
          // Title
          Text(
            widget.title,
            style: GoogleFonts.baloo2(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          
          SizedBox(height: 12),
          
          // Subtitle/question
          Text(
            widget.subTitle,
            style: GoogleFonts.baloo2(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: 20),
          
          // Options container
          Column(
            children: [
              // Maria option
              lessonTabMobile(
                image: "assets/images/newMonkeys/Maria.png",
                name: widget.maria,
                isClicked: mariaClicked,
                isDisabled: submitted,
                onClick: () {
                  if (!submitted) {
                    setState(() {
                      mariaClicked = true;
                      jasonClicked = false;
                      avaClicked = false;
                    });
                  }
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              
              SizedBox(height: 12),
              
              // Jason option
              lessonTabMobile(
                image: "assets/images/newMonkeys/Jason.png",
                name: widget.jason,
                isClicked: jasonClicked,
                isDisabled: submitted,
                onClick: () {
                  if (!submitted) {
                    setState(() {
                      jasonClicked = true;
                      avaClicked = false;
                      mariaClicked = false;
                    });
                  }
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              
              SizedBox(height: 12),
              
              // Ava option
              lessonTabMobile(
                image: "assets/images/newMonkeys/Ava.png",
                name: widget.ava,
                isClicked: avaClicked,
                isDisabled: submitted,
                onClick: () {
                  if (!submitted) {
                    setState(() {
                      avaClicked = true;
                      jasonClicked = false;
                      mariaClicked = false;
                    });
                  }
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
            ],
          ),
          
          SizedBox(height: 24),
          
          // Submit/Finish button
          GestureDetector(
            onTap: () {
              if (finishMode) {
                baseLessonController.pageIndex.value += 1;
              } else if ((avaClicked || jasonClicked || mariaClicked) &&
                  delay &&
                  !submitted) {
                // First submission
                setState(() {
                  submitted = true;
                  finishMode = true;
                });
                _showFeedback();
              } else if (!delay) {
                // still in the initial lock
              } else {
                // No selection made
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please select a peer to continue'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            child: Container(
              height: 50,
              width: 140,
              decoration: BoxDecoration(
                color: ((avaClicked || jasonClicked || mariaClicked) && delay)
                    ? Color.fromRGBO(137, 220, 142, 1)
                    : Color.fromRGBO(224, 227, 231, 1),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  finishMode ? "Finish" : widget.button,
                  style: GoogleFonts.baloo2(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          
          SizedBox(height: 20),
        ],
      ).paddingSymmetric(horizontal: 16), // Mobile padding
    );
  }
}

/// Redesigned lessonTab for web layout
Widget lessonTab({
  required String image,
  required String name,
  required bool isClicked,
  required bool isDisabled,
  required Function onClick,
  required double screenWidth,
  required double screenHeight,
}) {
  return GestureDetector(
    onTap: () {
      if (!isDisabled) {
        onClick();
      }
    },
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isClicked ? Color.fromRGBO(137, 220, 142, 1) : Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 60,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              name,
              style: GoogleFonts.baloo2(
                fontSize: 16,
                color: isDisabled && !isClicked ? Colors.grey : Colors.black,
                fontWeight: FontWeight.w500,
              ),
              softWrap: true,
            ),
          ),
        ],
      ),
    ),
  );
}

/// Mobile-specific lessonTab
Widget lessonTabMobile({
  required String image,
  required String name,
  required bool isClicked,
  required bool isDisabled,
  required Function onClick,
  required double screenWidth,
  required double screenHeight,
}) {
  return GestureDetector(
    onTap: () {
      if (!isDisabled) {
        onClick();
      }
    },
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isClicked ? Color.fromRGBO(137, 220, 142, 1) : Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 50,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: GoogleFonts.baloo2(
                fontSize: 14,
                color: isDisabled && !isClicked ? Colors.grey : Colors.black,
                fontWeight: FontWeight.w500,
              ),
              softWrap: true,
            ),
          ),
        ],
      ),
    ),
  );
}