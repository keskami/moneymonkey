import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LessonPages/Controllers/LessonsHomeController.dart';
import 'package:money_monkey/LessonPages/Pages/ConceptOneTwo.dart';
import 'package:money_monkey/LessonPages/Pages/PeerReflection.dart';
import 'package:money_monkey/LessonPages/Pages/PeerReflectionQuiz.dart';
import 'package:money_monkey/LessonPages/Pages/SampleZigZagPage.dart';
import 'package:money_monkey/LessonPages/Pages/Scenario.dart';
import 'package:money_monkey/LessonPages/Pages/Story.dart';
import 'package:money_monkey/LessonPages/Pages/Toolkit.dart';
import 'package:money_monkey/LessonPages/Pages/LoadingScreen/loading_wrapper.dart';

import 'package:money_monkey/LessonPages/Widgets/PolygonAvatar.dart';
import 'package:money_monkey/Resources/Resources.dart';
import 'package:money_monkey/themes/color_themes.dart';

/// Painter for the slant lines behind hexagons
class SlantLinePainter extends CustomPainter {
  final bool RightToLeft;
  final bool isActivated;

  SlantLinePainter({
    required this.RightToLeft,
    required this.isActivated,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isActivated ? Colors.blue : Colors.grey.shade300
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    if (RightToLeft) {
      // from right to left
      canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
    } else {
      // from left to right
      canvas.drawLine(Offset(0, 0), Offset(size.width, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(SlantLinePainter oldDelegate) => false;
}

class LessonsHome extends StatefulWidget {
  const LessonsHome({super.key});

  @override
  State<LessonsHome> createState() => _LessonsHomeState();
}

class _LessonsHomeState extends State<LessonsHome> {
  /// For demonstration, focusing on: Levels -> Advanced -> Units -> Unit_1 -> Lessons
  late final LessonsHomeController controller;
  final String levelDoc = "Advanced";
  final String unitDoc = "Unit_1";

  final List<int> lessonTypes = [0, 1, 2, 3, 4, 5, 6];
  final GlobalKey _containerKey = GlobalKey();

  double polygonWidth = 0.0;
  double screenHeight = 0.0;
  double screenWidth = 0.0;

  /// This “unitNum” is used in your heading text “Unit $unitNum”.
  /// If your Firestore data changes units, you can adjust it.
  int unitNum = 1;

  /// Example images for each hexagon
  List<String> imageLinks = [
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%20Icons%2Fbulb.png?alt=media&token=f5d89615-3c3a-48fe-9b30-2aa31a1bf293",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%20Icons%2Fbrain.png?alt=media&token=69ff0773-b9d8-49e3-97a0-4cb5dd7fc54a",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%20Icons%2Fbook_flip.png?alt=media&token=3f656860-1051-4dce-9b16-f7d4a82424ef",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%20Icons%2Frecycle.png?alt=media&token=5de6e03b-2372-4e64-9635-4cff8d3839e2",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%20Icons%2Fpeer-to-peer.png?alt=media&token=1a8e499b-0e9c-4f30-89d5-8b73969b77da",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%20Icons%2Fbriefcase.png?alt=media&token=7d494c7c-0536-461c-aec9-b5dfb24547d3",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%20Icons%2Fcircle_question.png?alt=media&token=b89a30a9-cc6a-4710-aea6-105ece4ee36c",
  ];

  @override
  void initState() {
    super.initState();
    // Put our controller: "Advanced", unitNumber=1
    controller = Get.put(LessonsHomeController(
      levelName: levelDoc,
      unitNumber: unitNum,
    ));
  }

  /// Build the 7 pages for a given lessonNumber
  List<Widget> buildPagesLink(int lessonNumber) {
    return [
      LoadingPageWrapper(
        destinationPage: LessonOne(),
        pageType: 'concept',
        lessonNumber: lessonNumber,
        unitNumber: unitNum,
      ),
      LoadingPageWrapper(
        destinationPage: LessonOne(),
        pageType: 'concept2',
        lessonNumber: lessonNumber,
        unitNumber: unitNum,
      ),
      LoadingPageWrapper(
        destinationPage: StoryPage(),
        pageType: 'story',
        lessonNumber: lessonNumber,
        unitNumber: unitNum,
      ),
      LoadingPageWrapper(
        destinationPage: Scenario(),
        pageType: 'scenario',
        lessonNumber: lessonNumber,
        unitNumber: unitNum,
      ),
      LoadingPageWrapper(
        destinationPage: PeerReflection(),
        pageType: 'peer_reflection',
        lessonNumber: lessonNumber,
        unitNumber: unitNum,
      ),
      LoadingPageWrapper(
        destinationPage: Toolkit(),
        pageType: 'toolkit',
        lessonNumber: lessonNumber,
        unitNumber: unitNum,
      ),
      LoadingPageWrapper(
        destinationPage: PeerReflectionQuiz(),
        pageType: 'peer_reflection_quiz',
        lessonNumber: lessonNumber,
        unitNumber: unitNum,
      ),
    ];
  }

  /// Build the chain of hexagons (PolygonLessonColumn + SlantLineColumn)
  /// EXACTLY as in your original code, but we pass in the dynamic `pagesLink`.
  Widget buildHexagonChain(List<Widget> pagesLink) {
    // Build the SlantLineColumn
    final slantLineColumn = Column(
      children: [
        SizedBox(height: screenHeight * 0.1),
        for (int i = 0; i < lessonTypes.length; i++)
          CustomPolygonLinesRow(
            index: lessonTypes[i],
            isActivated: false,
            width: polygonWidth,
          ),
      ],
    );

    // Build the PolygonLessonColumn
    final polygonLessonColumn = Column(
      children: [
        SizedBox(height: screenHeight * 0.1),
        for (int i = 0; i < lessonTypes.length; i++)
          CustomPolygonRow(
            index: lessonTypes[i],
            isActivated: true,
            width: polygonWidth,
            imageLinks: imageLinks,
            pagesLink: pagesLink,
          ),
      ],
    );

    // Return them stacked on top of each other
    return Stack(
      children: [
        slantLineColumn,
        polygonLessonColumn,
      ],
    );
  }

  /// Build one single lesson section (the heading + chain)
  Widget buildLessonSection({
    required String lessonName,
    required int lessonNumber,
  }) {
    // Build the pages link for the 7 polygons
    final pagesLink = buildPagesLink(lessonNumber);

    return Stack(
      children: [
        // The chain of lines + polygons
        SingleChildScrollView(
          child: buildHexagonChain(pagesLink).marginSymmetric(
            vertical: screenHeight * 0.2,
            horizontal: screenWidth * 0.08,
          ),
        ),
        // The heading bar with the lesson title
        Positioned(
          top: screenHeight * 0.05,
          left: screenWidth * 0.05,
          right: screenWidth * 0.05,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.03,
              vertical: screenHeight * 0.02,
            ),
            height: screenHeight * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: LightTheme().primaryBlue,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // e.g. "Unit 1" just like your original
                      Text(
                        "Unit $unitNum".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          lessonName, // from Firestore
                          style: GoogleFonts.baloo2(
                            fontSize: 35,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.network(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FUnit1%2FbookLogo.png?alt=media&token=5292ff86-afa7-49a3-bb62-a14f9c8b48f8",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// WEB DISPLAY (unchanged scoreboard, but we show multiple lessons)
  Scaffold webDisplay() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // LEFT side: each lesson repeated dynamically
          // LEFT side: Obx => wait for the lessons to load from the controller
          Obx(() {
            if (controller.isLoading.value) {
              return SizedBox(
                width: screenWidth * 0.5,
                child: const Center(child: CircularProgressIndicator()),
              );
            }

            final lessons = controller.lessons;
            if (lessons.isEmpty) {
              return SizedBox(
                width: screenWidth * 0.5,
                child: const Center(child: Text('No lessons found in Unit_1.')),
              );
            }

            // We combine them into one big column
            return SizedBox(
              width: screenWidth * 0.5,
              child: SingleChildScrollView(
                child: Column(
                  children: lessons.map((lessonMap) {
                    final lessonName =
                        lessonMap['lessonName'] ?? 'Untitled Lesson';
                    final lessonNumber = lessonMap['lessonNumber'] ?? 1;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 40),
                      child: buildLessonSection(
                        lessonName: lessonName,
                        lessonNumber: lessonNumber,
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          }),

          // RIGHT side scoreboard panel
          SizedBox(
            width: screenWidth * 0.3,
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.05),
                Row(
                  children: [
                    // Diamond
                    Image.network(
                      AppResources.mmLogoLink,
                      height: screenHeight * 0.1,
                    ),
                    const Spacer(),
                    const Text("10"),
                    Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMM_Silhouette.png?alt=media&token=3bf54556-da0d-446e-94c6-5a5ca59e9ce5",
                      height: screenHeight * 0.1,
                    ),
                    const Spacer(),
                    const Text("10"),
                    Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FDiamond.png?alt=media&token=c71fbaad-8ae7-4790-9bdd-2a17a77b3837",
                      height: screenHeight * 0.1,
                    ),
                    const Spacer(),
                    const Text("10"),
                    Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FBanana.png?alt=media&token=2b2a1a4a-9196-44e5-913c-23445802edb4",
                      height: screenHeight * 0.1,
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// MOBILE DISPLAY (unchanged from your snippet)
  Scaffold mobileDisplay() {
    return Scaffold(
      appBar: AppBar(title: const Text('Lessons')),
      body: SizedBox(
        key: _containerKey,
        width: screenWidth * 0.5,
        child: Stack(
          children: [
            // You could also do a FutureBuilder here if you wanted
            // to display multiple lessons on mobile. For brevity,
            // the example focuses on web. Adjust if you want dynamic
            // lessons on mobile as well.
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 50).add(
                EdgeInsets.symmetric(horizontal: screenWidth * 0.15),
              ),
              child: Column(
                children: [
                  // If you want to replicate the same approach for mobile,
                  // do so here with your FutureBuilder or
                  // buildLessonSection(...) calls.
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    polygonWidth = screenWidth * 0.07;

    // Return web or mobile
    return screenWidth > screenHeight ? webDisplay() : mobileDisplay();
  }
}

// EXACT COPIES of your existing polygon & lines row classes below,
// with no layout changes, so the design stays identical.
// ----------------------------------------------------------------

class CustomPolygonRow extends StatelessWidget {
  const CustomPolygonRow({
    super.key,
    required this.index,
    required this.isActivated,
    required this.width,
    required this.imageLinks,
    required this.pagesLink,
  });

  final double width;
  final int index;
  final bool isActivated;
  final List<String> imageLinks;
  final List<Widget> pagesLink;

  @override
  Widget build(BuildContext context) {
    if (index == 1 || index == 2 || index == 5 || index == 6) {}
    Widget lessonPolygonStack = Stack();
    switch (index) {
      case 0:
        lessonPolygonStack = middleRow(context);
        break;
      case 1:
        lessonPolygonStack = leftRow(context);
        break;
      case 2:
        lessonPolygonStack = middleRow(context);
        break;
      case 3:
        lessonPolygonStack = rightRow(context);
        break;
      case 4:
        lessonPolygonStack = middleRow(context);
        break;
      case 5:
        lessonPolygonStack = leftRow(context);
        break;
      case 6:
        lessonPolygonStack = middleRow(context);
        break;
      case 7:
        lessonPolygonStack = rightRow(context);
        break;
      default:
        lessonPolygonStack = middleRow(context);
    }

    return Stack(
      children: [
        lessonPolygonStack.marginSymmetric(horizontal: width * 0.5),
      ],
    );
  }

  Widget leftRow(BuildContext context) {
    return Row(
      children: [
        CustomPopup(
          content: Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.1,
              vertical: width * 0.05,
            ),
            width: width * 4,
            height: width * 2,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Money and Currencies",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Lesson ${index + 1} of 7",
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => pagesLink[index]),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LightTheme().primaryBlue,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: const Text(
                      "Start",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      "Rewards:",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    // Monkey Question Mark
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: width * 0.25,
                      backgroundImage: const NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2Fmonkey_question.png?alt=media&token=248dc316-1996-4305-a98a-ece166e7cb27",
                      ),
                    ),
                    const Spacer(),
                    // LessonBananaWorth Image
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: width * 0.3,
                      backgroundImage: const NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLessonBananaReward.png?alt=media&token=9ff7a738-ad66-4f7b-a9e2-7a6c451284a6",
                      ),
                      child: const Text(
                        "10",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                )
              ],
            ),
          ),
          child: LessonPolygon(
            backgroundColor: Colors.grey.shade400,
            icon: const Icon(Icons.lock),
            isActivated: isActivated,
            width: width,
            index: index,
            imageLinks: imageLinks,
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget rightRow(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        CustomPopup(
          content: Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.1,
              vertical: width * 0.05,
            ),
            width: width * 4,
            height: width * 2,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Money and Currencies",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Lesson ${index + 1} of 7",
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => pagesLink[index]),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LightTheme().primaryBlue,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: const Text(
                      "Start",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      "Rewards:",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: width * 0.25,
                      backgroundImage: const NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2Fmonkey_question.png?alt=media&token=248dc316-1996-4305-a98a-ece166e7cb27",
                      ),
                    ),
                    const Spacer(),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: width * 0.3,
                      backgroundImage: const NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLessonBananaReward.png?alt=media&token=9ff7a738-ad66-4f7b-a9e2-7a6c451284a6",
                      ),
                      child: const Text(
                        "10",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                )
              ],
            ),
          ),
          child: LessonPolygon(
            backgroundColor: Colors.grey.shade400,
            icon: const Icon(Icons.lock),
            isActivated: isActivated,
            width: width,
            index: index,
            imageLinks: imageLinks,
          ),
        ),
      ],
    );
  }

  Widget middleRow(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        CustomPopup(
          content: Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.1,
              vertical: width * 0.05,
            ),
            width: width * 4,
            height: width * 2,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Money and Currencies",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Lesson ${index + 1} of 7",
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => pagesLink[index]),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LightTheme().primaryBlue,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: const Text(
                      "Start",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      "Rewards:",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: width * 0.25,
                      backgroundImage: const NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2Fmonkey_question.png?alt=media&token=248dc316-1996-4305-a98a-ece166e7cb27",
                      ),
                    ),
                    const Spacer(),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: width * 0.3,
                      backgroundImage: const NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLessonBananaReward.png?alt=media&token=9ff7a738-ad66-4f7b-a9e2-7a6c451284a6",
                      ),
                      child: const Text(
                        "10",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                )
              ],
            ),
          ),
          child: LessonPolygon(
            backgroundColor: Colors.grey.shade400,
            icon: const Icon(Icons.lock),
            isActivated: isActivated,
            width: width,
            index: index,
            imageLinks: imageLinks,
          ),
        ),
        // The treasure polygon if index == 6
        if (index == 6) SizedBox(width: width * 0.5),
        if (index == 6) TreaureWidget(width: width, isActivated: isActivated),
        if (index != 6) const Spacer(),
      ],
    );
  }
}

class CustomPolygonLinesRow extends StatelessWidget {
  const CustomPolygonLinesRow({
    super.key,
    required this.index,
    required this.isActivated,
    required this.width,
  });

  final double width;
  final int index;
  final bool isActivated;

  @override
  Widget build(BuildContext context) {
    if (index == 1 || index == 2 || index == 5 || index == 6) {}
    Widget lessonPolygonStack = Stack();
    switch (index) {
      case 0:
        lessonPolygonStack = middleRow(context, false);
        break;
      case 1:
        lessonPolygonStack = leftRow(context);
        break;
      case 2:
        lessonPolygonStack = middleRow(context, true);
        break;
      case 3:
        lessonPolygonStack = rightRow(context);
        break;
      case 4:
        lessonPolygonStack = middleRow(context, false);
        break;
      case 5:
        lessonPolygonStack = leftRow(context);
        break;
      case 6:
        lessonPolygonStack = middleRow(context, true);
        break;
      case 7:
        lessonPolygonStack = rightRow(context);
        break;
      default:
        lessonPolygonStack = middleRow(context, false);
    }

    return Stack(
      children: [
        lessonPolygonStack.marginSymmetric(
          horizontal: width * 0.5,
        ),
      ],
    );
  }

  Widget leftRow(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Transform.translate(
          offset: Offset(-width * 0.8, width * 0.5),
          child: SizedBox(
            width: width,
            height: width,
            child: CustomPaint(
              painter: SlantLinePainter(
                RightToLeft: false,
                isActivated: isActivated,
              ),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget middleRow(BuildContext context, bool isLeftToRight) {
    return Row(
      children: [
        const Spacer(),
        if (index != 6)
          Transform.translate(
            offset: isLeftToRight
                ? Offset(width * 0.8, width * 0.7)
                : Offset(-width * 0.8, width * 0.7),
            child: SizedBox(
              width: width,
              height: width,
              child: CustomPaint(
                painter: SlantLinePainter(
                  RightToLeft: !isLeftToRight,
                  isActivated: isActivated,
                ),
              ),
            ),
          ),
        if (index == 6)
          Transform.translate(
            offset: Offset(width * 0.5, width * 0.5),
            child: Container(
              width: width,
              height: width * 0.07,
              color: isActivated ? Colors.blue : Colors.grey.shade300,
            ),
          ),
        const Spacer(),
      ],
    );
  }

  Widget rightRow(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Transform.translate(
          offset: Offset(-width * 0.8, width * 0.7),
          child: SizedBox(
            width: width,
            height: width,
            child: CustomPaint(
              painter: SlantLinePainter(
                RightToLeft: true,
                isActivated: isActivated,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TreaureWidget extends StatelessWidget {
  const TreaureWidget({
    super.key,
    required this.width,
    required this.isActivated,
  });

  final double width;
  final bool isActivated;

  @override
  Widget build(BuildContext context) {
    return PolygonAvatar(
      size: width,
      isActivated: false,
      backgroundColor: Colors.grey.shade400,
      icon: PolygonAvatar(
        size: width * 0.9,
        isActivated: isActivated,
        backgroundColor: Colors.yellow,
        icon: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.transparent,
          child: Image.network(
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonFlowImages%2FgoldTreasure.png?alt=media&token=2299e888-e835-414e-ac4a-0e260fa44e2a",
          ),
        ),
      ),
    );
  }
}

/// PolygonAvatar is from your code (unchanged).
/// If needed, copy the exact code from your existing file so design remains the same.
