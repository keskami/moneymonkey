import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';

class ImagesIntroPage extends StatefulWidget {
  final String title;
  final String subTitle;
  final List<List<String>> characters; 
  // e.g. [ [mariaName, mariaRole], [jasonName, jasonRole], [avaName, avaRole] ]
  final String button;

  const ImagesIntroPage({
    super.key,
    required this.title,
    required this.subTitle,
    required this.characters,
    required this.button,
  });

  @override
  _ImagesIntroPageState createState() => _ImagesIntroPageState();
}

class _ImagesIntroPageState extends State<ImagesIntroPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;

  final BaseLessonController baseLessonController = Get.find();

  bool delay = false;    // controls the button enabling after 6s
  bool loading = true;   // for any local loading state if needed

  @override
  void initState() {
    super.initState();
    // Kick off a 6 second delay for the button
    _sixSecondDelay();
    // If you need to do more initialization, do it here
    setState(() {
      loading = false;
    });
  }

  Future<void> _sixSecondDelay() async {
    await Future.delayed(Duration(seconds: 6));
    setState(() {
      delay = true;
    });
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
        SizedBox(height: screenHeight * 0.08),
        
        // Title
        Text(
          widget.title,
          style: GoogleFonts.baloo2(
            fontSize: 28,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        
        SizedBox(height: screenHeight * 0.03),
        
        // Subtitle
        Text(
          widget.subTitle,
          style: GoogleFonts.baloo2(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        
        SizedBox(height: screenHeight * 0.05),
        
        // Three character containers in a row
        Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // First character
              newMonkey(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                monkeyImage: 'assets/images/newMonkeys/Maria.png',
                name: widget.characters[0][0],
                description: widget.characters[0][1],
              ),
              
              SizedBox(width: screenWidth * 0.03),
              
              // Second character
              newMonkey(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                monkeyImage: 'assets/images/newMonkeys/Jason.png',
                name: widget.characters[1][0],
                description: widget.characters[1][1],
              ),
              
              SizedBox(width: screenWidth * 0.03),
              
              // Third character
              newMonkey(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                monkeyImage: 'assets/images/newMonkeys/Ava.png',
                name: widget.characters[2][0],
                description: widget.characters[2][1],
              ),
            ],
          ),
        ),
        
        SizedBox(height: screenHeight * 0.08),
        
        // Continue button
        GestureDetector(
          onTap: !delay
              ? () {
                  // If not yet 6s, do nothing or show a message
                }
              : () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  baseLessonController.pageIndex.value += 1;
                },
          child: Container(
            height: 58,
            width: 240,
            decoration: BoxDecoration(
              color: !delay
                  ? const Color.fromRGBO(224, 227, 231, 1)
                  : const Color.fromRGBO(137, 220, 142, 1),
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
                widget.button,
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
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          
          // Title
          Text(
            widget.title,
            style: GoogleFonts.baloo2(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: 16),
          
          // Subtitle
          Text(
            widget.subTitle,
            style: GoogleFonts.baloo2(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: 24),
          
          // Three character containers in a column for mobile
          Column(
            children: [
              // First character
              newMonkeyMobile(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                monkeyImage: 'assets/images/newMonkeys/Maria.png',
                name: widget.characters[0][0],
                description: widget.characters[0][1],
              ),
              
              SizedBox(height: 20),
              
              // Second character
              newMonkeyMobile(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                monkeyImage: 'assets/images/newMonkeys/Jason.png',
                name: widget.characters[1][0],
                description: widget.characters[1][1],
              ),
              
              SizedBox(height: 20),
              
              // Third character
              newMonkeyMobile(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                monkeyImage: 'assets/images/newMonkeys/Ava.png',
                name: widget.characters[2][0],
                description: widget.characters[2][1],
              ),
            ],
          ),
          
          SizedBox(height: 30),
          
          // Continue button
          GestureDetector(
            onTap: !delay
                ? () {
                    // If not yet 6s, do nothing or show a message
                  }
                : () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    baseLessonController.pageIndex.value += 1;
                  },
            child: Container(
              height: 50,
              width: 160,
              decoration: BoxDecoration(
                color: !delay
                    ? const Color.fromRGBO(224, 227, 231, 1)
                    : const Color.fromRGBO(137, 220, 142, 1),
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
                  widget.button,
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

// Redesigned for web layout
Widget newMonkey({
  required double screenWidth,
  required double screenHeight,
  required String monkeyImage,
  required String name,
  required String description,
}) {
  return Container(
    width: screenWidth * 0.12, // Width that fits well within the container
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          monkeyImage,
          height: screenHeight * 0.15,
          fit: BoxFit.contain,
        ),
        SizedBox(height: 8),
        Text(
          name,
          style: GoogleFonts.baloo2(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: GoogleFonts.baloo2(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

// Mobile version with a different layout
Widget newMonkeyMobile({
  required double screenWidth,
  required double screenHeight,
  required String monkeyImage,
  required String name,
  required String description,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      // Image on the left
      Image.asset(
        monkeyImage,
        height: screenHeight * 0.1,
        fit: BoxFit.contain,
      ),
      SizedBox(width: 16),
      // Text on the right
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: GoogleFonts.baloo2(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4),
            Text(
              description,
              style: GoogleFonts.baloo2(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}