import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LessonPages/Controllers/PeerReflectionController.dart';
import 'package:money_monkey/LessonPages/Pages/PeerReflection.dart';
import 'package:money_monkey/LessonPages/PeerReflection/page3.dart';
import 'package:money_monkey/home.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;
  bool isLoading = true;
  int? balance;
  int totalBanans = 0;
  bool mariaClicked = false;
  bool jasonClicked = false;
  bool avaClicked = false;
  PeerReflectioncontroller peerReflectionController = Get.find();

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
    return Column(children: [
      topOfLesson(
          screenWidthUnit: screenWidthUnit,
          screenHeightUnit: screenHeightUnit,
          pageNumber: 2,
          totalPages: 8,
          context: context,
          bananas: totalBanans),
      SizedBox(height: WebscreenHeightUnit * 95),
      Padding(
        padding: EdgeInsets.only(right: WebscreenWidthUnit * 758),
        child: Text(
          "Peer Stories",
          style: GoogleFonts.baloo2(
              fontSize: screenWidthUnit * 5,
              color: Colors.black,
              fontWeight: FontWeight.w700),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
            left: WebscreenWidthUnit * 17.5, top: WebscreenHeightUnit * 31),
        child: Container(
            height: WebscreenHeightUnit * 550,
            child: Column(children: [
              lessonTab(
                image: "assets/images/newMonkeys/Maria.png",
                name: "Maria: The Planner",
                discription:
                    "Maria started saving as a teen to buy her first car. Now in her 20s,\nshe's saving for grad school while setting aside money for retirement.",
                isClicked: mariaClicked,
                onClick: () {
                  setState(() {
                    mariaClicked = true;
                  });
                },
                context: context,
                WebscreenHeightUnit: WebscreenHeightUnit,
                WebscreenWidthUnit: WebscreenWidthUnit,
              ),
              SizedBox(height: WebscreenHeightUnit * 29),
              lessonTab(
                image: "assets/images/newMonkeys/Jason.png",
                name: "Jason: The Family Provider",
                discription:
                    "Jason is a dad with two kids. He prioritizes housing, groceries, and school expenses\nbut still sets aside money for emergencies and his kids' future education.",
                isClicked: jasonClicked,
                onClick: () {
                  setState(() {
                    jasonClicked = true;
                  });
                },
                context: context,
                WebscreenHeightUnit: WebscreenHeightUnit,
                WebscreenWidthUnit: WebscreenWidthUnit,
              ),
              SizedBox(height: WebscreenHeightUnit * 29),
              lessonTab(
                image: "assets/images/newMonkeys/Ava.png",
                name: "Ava: The Single Saver",
                discription:
                    "Ava, in her early 30s, focuses on saving for travel and investing in her future.\nWithout dependents, she can prioritize her personal goals.",
                isClicked: avaClicked,
                onClick: () {
                  setState(() {
                    avaClicked = true;
                  });
                },
                context: context,
                WebscreenHeightUnit: WebscreenHeightUnit,
                WebscreenWidthUnit: WebscreenWidthUnit,
              ),
            ])),
      ),
      SizedBox(height: WebscreenHeightUnit * 82),
      Positioned(
        bottom: WebscreenHeightUnit * 0,
        child: GestureDetector(
            onTap: () {
              if (avaClicked && jasonClicked && mariaClicked) {
                print(peerReflectionController.pageIndex.value);
                peerReflectionController.pageIndex.value += 1;
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Please read all the stories to continue'),
                  duration: Duration(seconds: 2),
                ));
              }
            },
            child: Container(
              height: screenHeightUnit * 58,
              width: screenWidthUnit * 61,
              decoration: BoxDecoration(
                color: (avaClicked && jasonClicked && mariaClicked)
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
                  "Continue to Activity",
                  style: GoogleFonts.baloo2(
                      fontSize: screenWidthUnit * 4.2,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
              ),
            )),
      ),
    ]);
  }
}

Widget lessonTab({
  required String image,
  required String name,
  required String discription,
  required bool isClicked,
  required Function onClick,
  required BuildContext context,
  required double WebscreenHeightUnit,
  required double WebscreenWidthUnit,
}) {
  return !isClicked
      ? GestureDetector(
          onTap: () {
            onClick();
          },
          child: Container(
            height: WebscreenHeightUnit * 106,
            width: WebscreenWidthUnit * 907,
            decoration: BoxDecoration(
              color: Colors.white,
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: WebscreenWidthUnit * 25,
                ),
                Image.asset(
                  image,
                  height: WebscreenHeightUnit * 73,
                ),
                SizedBox(
                  width: WebscreenWidthUnit * 14,
                ),
                Text(name,
                    style: GoogleFonts.baloo2(
                        fontSize: WebscreenWidthUnit * 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        )
      : Container(
          height: WebscreenHeightUnit * 157,
          width: WebscreenWidthUnit * 907,
          decoration: BoxDecoration(
            color: Colors.white,
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: WebscreenWidthUnit * 25,
              ),
              Image.asset(
                image,
                height: WebscreenHeightUnit * 145,
              ),
              SizedBox(
                width: WebscreenWidthUnit * 14,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: GoogleFonts.baloo2(
                          fontSize: WebscreenWidthUnit * 25,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                  SizedBox(height: WebscreenHeightUnit * 5),
                  Text(discription,
                      style: GoogleFonts.baloo2(
                          fontSize: WebscreenWidthUnit * 16.67,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                ],
              )
            ],
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
  return Container();
}
