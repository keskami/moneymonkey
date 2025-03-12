import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';

class TapToExpandPage extends StatefulWidget {
  final String title;
  final List<List<String>> characters;
  // each element: [ "name: role", "storyText" ]
  final String button;

  const TapToExpandPage({
    super.key,
    required this.title,
    required this.characters,
    required this.button,
  });

  @override
  State<TapToExpandPage> createState() => _TapToExpandPageState();
}

class _TapToExpandPageState extends State<TapToExpandPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;
  final BaseLessonController baseLessonController = Get.find();

  bool mariaClicked = false;
  bool jasonClicked = false;
  bool avaClicked = false;
  bool delay = false; // controls enabling the button after 6s

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  Future<void> _startDelay() async {
    await Future.delayed(Duration(seconds: 6));
    setState(() => delay = true);
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
    // Use SingleChildScrollView for the entire content to ensure everything is accessible
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.03),
          
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
          
          // Stories container - NO FIXED HEIGHT
          Column(
            children: [
              // Maria's story
              lessonTab(
                image: "assets/images/newMonkeys/Maria.png",
                name: widget.characters[0][0], // "Maria: role"
                discription: widget.characters[0][1], // the story
                isClicked: mariaClicked,
                onClick: () {
                  setState(() {
                    mariaClicked = true;
                  });
                },
                context: context,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              
              SizedBox(height: 16),
              
              // Jason's story
              lessonTab(
                image: "assets/images/newMonkeys/Jason.png",
                name: widget.characters[1][0],
                discription: widget.characters[1][1],
                isClicked: jasonClicked,
                onClick: () {
                  setState(() {
                    jasonClicked = true;
                  });
                },
                context: context,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              
              SizedBox(height: 16),
              
              // Ava's story
              lessonTab(
                image: "assets/images/newMonkeys/Ava.png",
                name: widget.characters[2][0],
                discription: widget.characters[2][1],
                isClicked: avaClicked,
                onClick: () {
                  setState(() {
                    avaClicked = true;
                  });
                },
                context: context,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
            ],
          ),
          
          SizedBox(height: screenHeight * 0.05),
          
          // Continue button
          Center(
            child: GestureDetector(
              onTap: () {
                // Only proceed if user clicked all 3 stories and we waited 6s
                if (avaClicked && jasonClicked && mariaClicked && delay) {
                  baseLessonController.pageIndex.value += 1;
                } else if (!delay) {
                  // still in initial 6s lock
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please read all the stories to continue'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: Container(
                height: 56,
                width: 200,
                decoration: BoxDecoration(
                  color: (avaClicked && jasonClicked && mariaClicked && delay)
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
          ),
          
          SizedBox(height: screenHeight * 0.03),
        ],
      ).paddingSymmetric(horizontal: screenWidth * 0.25), // Key for proper alignment
    );
  }

  Widget mobileDisplay(double screenWidth, double screenHeight) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          
          // Title
          Text(
            widget.title,
            style: GoogleFonts.baloo2(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          
          SizedBox(height: 16),
          
          // Stories in a column - NO FIXED HEIGHT
          Column(
            children: [
              // Maria's story
              lessonTabMobile(
                image: "assets/images/newMonkeys/Maria.png",
                name: widget.characters[0][0],
                discription: widget.characters[0][1],
                isClicked: mariaClicked,
                onClick: () {
                  setState(() {
                    mariaClicked = true;
                  });
                },
                context: context,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              
              SizedBox(height: 12),
              
              // Jason's story
              lessonTabMobile(
                image: "assets/images/newMonkeys/Jason.png",
                name: widget.characters[1][0],
                discription: widget.characters[1][1],
                isClicked: jasonClicked,
                onClick: () {
                  setState(() {
                    jasonClicked = true;
                  });
                },
                context: context,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              
              SizedBox(height: 12),
              
              // Ava's story
              lessonTabMobile(
                image: "assets/images/newMonkeys/Ava.png",
                name: widget.characters[2][0],
                discription: widget.characters[2][1],
                isClicked: avaClicked,
                onClick: () {
                  setState(() {
                    avaClicked = true;
                  });
                },
                context: context,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
            ],
          ),
          
          SizedBox(height: 24),
          
          // Continue button
          Center(
            child: GestureDetector(
              onTap: () {
                if (avaClicked && jasonClicked && mariaClicked && delay) {
                  baseLessonController.pageIndex.value += 1;
                } else if (!delay) {
                  // still in initial 6s lock
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please read all the stories to continue'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: Container(
                height: 50,
                width: 160,
                decoration: BoxDecoration(
                  color: (avaClicked && jasonClicked && mariaClicked && delay)
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
          ),
          
          SizedBox(height: 16),
        ],
      ).paddingSymmetric(horizontal: 16), // Mobile padding
    );
  }
}

/// Redesigned lessonTab for web layout
Widget lessonTab({
  required String image,
  required String name,
  required String discription,
  required bool isClicked,
  required Function onClick,
  required BuildContext context,
  required double screenWidth,
  required double screenHeight,
}) {
  return GestureDetector(
    onTap: !isClicked ? () => onClick() : null,
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: EdgeInsets.all(16),
      child: !isClicked
          // Collapsed view (not clicked)
          ? Row(
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
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )
          // Expanded view (clicked)
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  image,
                  height: 60,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.baloo2(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        discription,
                        style: GoogleFonts.baloo2(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        softWrap: true,
                      ),
                    ],
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
  required String discription,
  required bool isClicked,
  required Function onClick,
  required BuildContext context,
  required double screenWidth,
  required double screenHeight,
}) {
  return GestureDetector(
    onTap: !isClicked ? () => onClick() : null,
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: EdgeInsets.all(12),
      child: !isClicked
          // Collapsed view (not clicked)
          ? Row(
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
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )
          // Expanded view (clicked)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    discription,
                    style: GoogleFonts.baloo2(
                      fontSize: 14,
                      color: Colors.black,
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