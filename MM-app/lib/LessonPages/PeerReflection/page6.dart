import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LessonPages/PeerReflection/page7.dart';
import 'package:money_monkey/home.dart';

class Page6 extends StatefulWidget {
  @override
  _Page6State createState() => _Page6State();
}

class _Page6State extends State<Page6> {
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
            pageNumber: 6,
            totalPages: 8,
            context: context,
            bananas: totalBanans,
          ),
          SizedBox(height: WebscreenHeightUnit * 95),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text(
                "Lifelong Financial Well-Being",
                style: GoogleFonts.baloo2(
                  fontSize: screenWidthUnit * 7,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          SizedBox(height: WebscreenHeightUnit * 65),
          Image.asset(
            "assets/images/lfwLessonPage5/bubble.png",
            width: WebscreenWidthUnit * 700,
          ),
          SizedBox(height: WebscreenHeightUnit * 12),
          Image.asset("assets/images/monkeyNoText.png",
              height: WebscreenHeightUnit * 250),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: WebscreenHeightUnit * 103),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Page7()),
                  );
                },
                child: Container(
                  height: screenHeightUnit * 58,
                  width: WebscreenWidthUnit * 291,
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
                      "Continue",
                      style: GoogleFonts.baloo2(
                          fontSize: screenWidthUnit * 4.2,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                )),
          )
        ],
      ),
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
