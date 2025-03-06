import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Backend/Models/SubComponentModel.dart';
import 'package:money_monkey/GlobalWidgets/CustomSnackBars.dart';
import 'package:money_monkey/LessonPages/Controllers/PeerReflectionController.dart';
 
import 'package:money_monkey/LessonPages/Pages/PeerReflection.dart';
import 'package:money_monkey/home.dart';

class Page4 extends StatefulWidget {
  @override
  _Page4State createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;
  bool isLoading = true;
  int? balance;
  int totalBanans = 0;
  bool mariaClicked = false;
  bool jasonClicked = false;
  bool avaClicked = false;
  PeerReflectioncontroller peerReflectionController = Get.find();
  bool delay = false;

  // New variables for updated functionality
  bool submitted = false;
  bool finishMode = false;

  bool loading = true;
  String title = '';
  String subTitle = '';
  String ava = '';
  String maria = '';
  String jason = '';
  String button = '';
  String feedback1 = '';
  String feedback2 = '';
  String feedback3 = '';

  Future<void> setData(SubComponent data) async {
    setState(() {
      title = "Reflection";
      subTitle = data.data.question;
      ava = data.data.options[0].description;
      maria = data.data.options[1].description;
      jason = data.data.options[2].description;
      button = "Submit";
      feedback1 = data.data.feedbackMessages[data.data.options[0].name];
      feedback2 = data.data.feedbackMessages[data.data.options[1].name];
      feedback3 = data.data.feedbackMessages[data.data.options[2].name];

      loading = false;
    });
    _6secdelay();
  }

  @override
  void initState() {
    super.initState();
    if (peerReflectionController.pageData.isNotEmpty) {
      setData(peerReflectionController.pageData[3]);
    }
    if (title == '') {
      setData(peerReflectionController.pageData[3]);
    }
  }

  Future<void> _6secdelay() async {
    await Future.delayed(Duration(seconds: 4));
    setState(() {
      delay = true;
    });
  }

  // Show the appropriate feedback based on the selected option
  void _showFeedback() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if (mariaClicked) {
      ScaffoldMessenger.of(context)
          .showSnackBar(CorrectAnswerSnackBar(message: feedback1));
    } else if (jasonClicked) {
      ScaffoldMessenger.of(context)
          .showSnackBar(CorrectAnswerSnackBar(message: feedback2));
    } else if (avaClicked) {
      ScaffoldMessenger.of(context)
          .showSnackBar(CorrectAnswerSnackBar(message: feedback3));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidthUnit = screenWidth / 390;
    double screenHeightUnit = screenHeight / 880;
    double webScreenWidthUnit = screenWidth / 1920;
    double webScreenHeightUnit = screenHeight / 1080;

    // Calculate constrained width to prevent overflow
    double cardWidth = screenWidth * 0.5; // 50% of screen width

    return Column(
      children: [
        SizedBox(height: screenHeight * .05),
        // Center the title and subtitle
        Text(
          title,
          style: GoogleFonts.baloo2(
            fontSize: screenWidthUnit * 6,
            color: Color.fromRGBO(0, 0, 0, 1),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: webScreenHeightUnit * 10),
        Container(
          width: cardWidth,
          child: Text(
            subTitle,
            style: GoogleFonts.baloo2(
              fontSize: screenWidthUnit * 4.5,
              color: Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: webScreenHeightUnit * 50),

        // Centered option cards
        Container(
          width: cardWidth,
          child: Column(
            children: [
              lessonTab(
                image: "assets/images/newMonkeys/Maria.png",
                name: maria,
                isClicked: mariaClicked,
                isDisabled: submitted, // Disable after submission
                onClick: () {
                  if (!submitted) {
                    setState(() {
                      mariaClicked = true;
                      jasonClicked = false;
                      avaClicked = false;
                    });
                  }
                },
                context: context,
                cardWidth: cardWidth,
                screenWidthUnit: screenWidthUnit,
                webScreenHeightUnit: webScreenHeightUnit,
              ),
              SizedBox(height: webScreenHeightUnit * 29),
              lessonTab(
                image: "assets/images/newMonkeys/Jason.png",
                name: jason,
                isClicked: jasonClicked,
                isDisabled: submitted, // Disable after submission
                onClick: () {
                  if (!submitted) {
                    setState(() {
                      jasonClicked = true;
                      avaClicked = false;
                      mariaClicked = false;
                    });
                  }
                },
                context: context,
                cardWidth: cardWidth,
                screenWidthUnit: screenWidthUnit,
                webScreenHeightUnit: webScreenHeightUnit,
              ),
              SizedBox(height: webScreenHeightUnit * 29),
              lessonTab(
                image: "assets/images/newMonkeys/Ava.png",
                name: ava,
                isClicked: avaClicked,
                isDisabled: submitted, // Disable after submission
                onClick: () {
                  if (!submitted) {
                    setState(() {
                      avaClicked = true;
                      jasonClicked = false;
                      mariaClicked = false;
                    });
                  }
                },
                context: context,
                cardWidth: cardWidth,
                screenWidthUnit: screenWidthUnit,
                webScreenHeightUnit: webScreenHeightUnit,
              ),
            ],
          ),
        ),

        // Bottom button with consistent spacing
        Padding(
          padding: EdgeInsets.only(top: webScreenHeightUnit * 60),
          child: GestureDetector(
            onTap: () {
              if (finishMode) {
                // User already submitted, clicking "Finish" navigates to home
                if (Get.isRegistered<PeerReflectioncontroller>()) {
                  Get.delete<PeerReflectioncontroller>();
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              } else if ((avaClicked || jasonClicked || mariaClicked) &&
                  delay &&
                  !submitted) {
                // First submission - show feedback, lock the selection, change button text
                setState(() {
                  submitted = true;
                  finishMode = true;
                  button = "Finish";
                });

                // Show appropriate feedback
                _showFeedback();
              } else if (!delay) {
                // Do nothing during initial delay
              } else {
                // No selection made - show warning
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Please select a peer to continue'),
                  duration: Duration(seconds: 2),
                ));
              }
            },
            child: Container(
              height: screenHeightUnit * 58,
              width: screenWidthUnit * 130, // Wider button for text
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
                  button,
                  style: GoogleFonts.baloo2(
                    fontSize: screenWidthUnit * 4.2,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

Widget lessonTab({
  required String image,
  required String name,
  required bool isClicked,
  required bool isDisabled, // New parameter to know if cards are disabled
  required Function onClick,
  required BuildContext context,
  required double cardWidth,
  required double webScreenHeightUnit,
  required double screenWidthUnit,
}) {
  return GestureDetector(
    onTap: () {
      if (!isDisabled) {
        onClick();
      }
    },
    child: Container(
      width: cardWidth, // Fixed width to prevent overflow
      decoration: BoxDecoration(
        color: isClicked ? Color.fromRGBO(137, 220, 142, 1) : Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: const Color.fromRGBO(175, 175, 175, 1),
          width: .1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: webScreenHeightUnit * 73,
          ),
          SizedBox(width: 15),
          // Make the text wrap properly
          Expanded(
            child: Text(
              name,
              style: GoogleFonts.baloo2(
                fontSize: screenWidthUnit * 3.6,
                color: isDisabled && !isClicked
                    ? Colors.grey
                    : Colors
                        .black, // Grey out unselected options after submission
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.visible,
              softWrap: true,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget topOfLesson({
  required double screenWidthUnit,
  required double screenHeightUnit,
  required double pageNumber,
  required double totalPages,
  required BuildContext context,
  required int bananas,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          icon: Icon(Icons.close, color: Colors.black)),
      TweenAnimationBuilder<double>(
        tween: Tween<double>(
            begin: (pageNumber - 1) / totalPages, end: pageNumber / totalPages),
        duration: Duration(seconds: 2),
        builder: (context, value, child) {
          return Container(
            height: screenHeightUnit * 25,
            width: screenWidthUnit * 202,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(135, 206, 235, 1),
                  Color.fromRGBO(213, 213, 213, 1),
                ],
                stops: [value, value],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          );
        },
      ),
      SizedBox(
        width: screenWidthUnit * 4,
      ),
      Image.asset("assets/images/img_monkeymoney_52.png",
          height: screenHeightUnit * 36),
      SizedBox(
        width: screenWidthUnit * 1,
      ),
      Text("$bananas",
          style: GoogleFonts.roboto(
              fontSize: screenWidthUnit * 5.5, color: Colors.black)),
    ],
  );
}
