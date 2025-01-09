import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LessonPages/Controllers/PeerReflectionController.dart';
import 'package:money_monkey/LessonPages/Controllers/ToolkitController.dart';
<<<<<<< HEAD:MM-app/lib/LessonPages/PeerReflection/page5.dart
import 'package:money_monkey/LessonPages/PeerReflection/page6.dart';
=======
import 'package:money_monkey/LessonPages/Toolkit/page6.dart';
>>>>>>> development:MM-app/lib/LessonPages/Toolkit/page5.dart
import 'package:money_monkey/home.dart';

class Page5 extends StatefulWidget {
  @override
  _Page5State createState() => _Page5State();
}

class _Page5State extends State<Page5> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;
  bool isLoading = true;
  int? balance;
  int totalBanans = 0;
  bool mariaClicked = false;
  bool jasonClicked = false;
  bool avaClicked = false;
  Toolkitcontroller peerReflectionController = Get.find();
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
    return  Column(
        children: [
          SizedBox(height: screenHeight * .07),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(WebscreenWidthUnit * 455, 0, 0, 0),
              child: Text(
                "Welcome to your Toolkit for Lifelong\nFinancial Wellbeing!",
                style: GoogleFonts.baloo2(
                  fontSize: screenWidthUnit * 7,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          SizedBox(height: WebscreenHeightUnit * 20),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(WebscreenWidthUnit * 455, 0, 0, 0),
              child: Text(
                "Get ready to plan ahead, save smart, and take responsibility for your finances.",
                style: GoogleFonts.baloo2(
                  fontSize: screenWidthUnit * 4.75,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          SizedBox(height: WebscreenHeightUnit * 65),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/lfwLessonPage5/piggy.png",
                  height: WebscreenHeightUnit * 181),
              SizedBox(width: WebscreenWidthUnit * 104),
              Image.asset("assets/images/lfwLessonPage5/house.png",
                  height: WebscreenHeightUnit * 181),
              SizedBox(width: WebscreenWidthUnit * 104),
              Image.asset("assets/images/lfwLessonPage5/grad.png",
                  height: WebscreenHeightUnit * 181),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: WebscreenHeightUnit * 293),
            child: GestureDetector(
                onTap: () {
                  print(peerReflectionController.pageIndex.value);
                  peerReflectionController.pageIndex.value += 1;
                },
                child: Container(
                  height: screenHeightUnit * 58,
                  width: screenWidthUnit * 71,
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
                      "Start Learning ->",
                      style: GoogleFonts.baloo2(
                          fontSize: screenWidthUnit * 4.2,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                )),
          )
        ],
      
    );
  }
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