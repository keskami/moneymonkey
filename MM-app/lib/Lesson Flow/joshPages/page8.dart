import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:money_monkey/Lesson%20Flow/joshPages/page5.dart';
import 'package:money_monkey/home.dart';
import 'package:google_fonts/google_fonts.dart';

class Page8 extends StatefulWidget {
  @override
  _Page8State createState() => _Page8State();
}

class _Page8State extends State<Page8> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;
  bool isLoading = true;
  int? balance;
  int totalBanans = 0;
  bool mariaClicked = false;
  bool jasonClicked = false;
  bool avaClicked = false;
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(133, 220, 64, 1),
        statusBarIconBrightness: Brightness.light,
      ),
    );
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    if (userID != null) {
      try {
        DocumentSnapshot profileSnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .doc(userID)
            .get();

        if (profileSnapshot.exists) {
          setState(() {
            final data = profileSnapshot.data() as Map<String, dynamic>?;

            var portfolioData = data?['Portfolio'] as Map<String, dynamic>?;

            if (portfolioData != null) {
              balance = portfolioData['Balance'] ?? 0;
              totalBanans = portfolioData['Total Bananas'] ?? 0;
            }

            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidthUnit = screenWidth / 390;
    double screenHeightUnit = screenHeight / 880;
    double WebscreenWidthUnit = screenWidth / 1920;
    double WebscreenHeightUnit = screenHeight / 1080;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(height: screenHeight * .05),
            topOfLesson(
              screenWidthUnit: screenWidthUnit,
              screenHeightUnit: screenHeightUnit,
              pageNumber: 8,
              totalPages: 8,
              context: context,
              bananas: totalBanans,
            ),
            SizedBox(height: WebscreenHeightUnit * 115),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding:
                      EdgeInsets.fromLTRB(WebscreenWidthUnit * 475, 0, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Challenge: Plan and Save!",
                        style: GoogleFonts.baloo2(
                            fontSize: screenWidthUnit * 6,
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: WebscreenHeightUnit * 70),
                      Goal(
                          image: "assets/images/lfwLessonPage5/check.png",
                          text:
                              "Step 1: Identify one short-term financial goal",
                          WebscreenHeightUnit: WebscreenHeightUnit,
                          WebscreenWidthUnit: WebscreenWidthUnit),
                      SizedBox(height: WebscreenHeightUnit * 35),
                      Goal(
                          image: "assets/images/lfwLessonPage5/check.png",
                          text:
                              "Step 2: Break it down into smaller steps using the planner",
                          WebscreenHeightUnit: WebscreenHeightUnit,
                          WebscreenWidthUnit: WebscreenWidthUnit),
                      SizedBox(height: WebscreenHeightUnit * 35),
                      Goal(
                          image: "assets/images/lfwLessonPage5/check.png",
                          text: "Step 3: Get parent approval",
                          WebscreenHeightUnit: WebscreenHeightUnit,
                          WebscreenWidthUnit: WebscreenWidthUnit),
                      SizedBox(height: WebscreenHeightUnit * 35),
                      Padding(
                        padding: EdgeInsets.only(left: WebscreenWidthUnit * 30),
                        child: Container(
                          height: WebscreenHeightUnit * 105,
                          width: WebscreenWidthUnit * 762,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(135, 206, 235, .2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: WebscreenWidthUnit * 15),
                              Image.asset(
                                  "assets/images/img_monkeymoney_52.png",
                                  height: WebscreenHeightUnit * 66),
                              SizedBox(width: WebscreenWidthUnit * 15),
                              Text(
                                "Earn 50 coins and the 'Goal Setter' badge!",
                                style: GoogleFonts.baloo2(
                                  fontSize: WebscreenWidthUnit * 25,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.fromLTRB(WebscreenWidthUnit * 200, 0, 0, WebscreenHeightUnit * 100),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  child: Container(
                    height: screenHeightUnit * 58,
                    width: WebscreenWidthUnit * 200,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(137, 220, 142, 1),
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
                        "Finish",
                        style: GoogleFonts.baloo2(
                            fontSize: screenWidthUnit * 4.2,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  )),
            )
          ],
        ));
  }
}

Widget Goal({
  required String image,
  required String text,
  required double WebscreenHeightUnit,
  required double WebscreenWidthUnit,
}) {
  return Row(
    children: [
      Image.asset(
        image,
        height: WebscreenHeightUnit * 90,
      ),
      SizedBox(width: WebscreenWidthUnit * 20),
      Text(
        text,
        style: GoogleFonts.baloo2(
            fontSize: WebscreenWidthUnit * 22,
            color: Color.fromRGBO(0, 0, 0, 1),
            fontWeight: FontWeight.w500),
      ),
    ],
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
        tween: Tween<double>(begin: (pageNumber - 1) / totalPages, end: pageNumber / totalPages),
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
