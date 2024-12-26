import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/home.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;
  bool isLoading = true;
  int? balance;
  int totalBanans = 0;

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
              balance = portfolioData?['Balance'] ?? 0;
              totalBanans = portfolioData?['Total Bananas'] ?? 0;
              int netGain = portfolioData?['Weekly net gain'] ?? 0;
              int lastWeek = balance! - netGain;
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

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0XFFFFFFFF),
        body: Column(children: [
          SizedBox(
            height: screenHeight * .05,
          ),
          topOfLesson(
              screenWidthUnit: screenWidthUnit,
              screenHeightUnit: screenHeightUnit,
              pageNumber: 5,
              totalPages: 10,
              context: context,
              bananas: totalBanans!),
          SizedBox(height: screenHeightUnit * 82),
          Text(
            "Taking Responsibility for Personal Financial Decisions",
            style: GoogleFonts.baloo2(
                fontSize: screenWidthUnit * 7,
                color: Colors.black,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(height: screenHeightUnit * 42),
          Text(
            "Taking responsibility for your finances helps you plan for\nevery stage of life, whether you're managing just for\n yourself or for others who depend on you.",
            style: GoogleFonts.baloo2(
                fontSize: screenWidthUnit * 4.5,
                color: Colors.black,
                fontWeight: FontWeight.w500,
                height: ((5 / 3) * screenWidthUnit) / 3.5),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenHeightUnit * 42),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              newMonkey(
                  screenWidthUnit: screenWidthUnit,
                  screenHeightUnit: screenHeightUnit,
                  monkeyImage: 'assets/images/newMonkeys/Maria.png',
                  name: "Maria",
                  description: "The Planner"),
              newMonkey(
                  screenWidthUnit: screenWidthUnit,
                  screenHeightUnit: screenHeightUnit,
                  monkeyImage: 'assets/images/newMonkeys/Jason.png',
                  name: "Jason",
                  description: "Family Provider"),
              newMonkey(
                  screenWidthUnit: screenWidthUnit,
                  screenHeightUnit: screenHeightUnit,
                  monkeyImage: 'assets/images/newMonkeys/Ava.png',
                  name: "Ava",
                  description: "The Single Saver"),
            ],
          ),
          Text("here"),
        ]),
      ),
    );
  }
}

Widget newMonkey({
  required double screenWidthUnit,
  required double screenHeightUnit,
  required String monkeyImage,
  required String name,
  required String description,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    child: Image.asset(monkeyImage),
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
      Container(
        height: screenHeightUnit * 25,
        width: screenWidthUnit * 202,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(135, 206, 235, 1),
              Color.fromRGBO(213, 213, 213, 1),
            ],
            stops: [pageNumber / totalPages, pageNumber / totalPages],
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
