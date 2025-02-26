// LessonsHomeUnit.dart
import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/LessonPages/Pages/ConceptOneTwo.dart';
import 'package:money_monkey/LessonPages/Pages/LoadingScreen/loading_wrapper.dart';
import 'package:money_monkey/LessonPages/Pages/PeerReflection.dart';
import 'package:money_monkey/LessonPages/Pages/PeerReflectionQuiz.dart';
import 'package:money_monkey/LessonPages/Pages/Scenario.dart';
import 'package:money_monkey/LessonPages/Pages/Story.dart';
import 'package:money_monkey/LessonPages/Pages/Toolkit.dart';
import 'package:money_monkey/LessonPages/Widgets/PolygonAvatar.dart';
import 'package:money_monkey/GlobalWidgets/Scoreboard.dart';
import 'package:money_monkey/Resources/Resources.dart';
import 'package:money_monkey/themes/color_themes.dart';

class LessonsHomeUnit extends StatefulWidget {
  final List<Lesson> lessons;

  const LessonsHomeUnit({
    Key? key,
    required this.lessons,
  }) : super(key: key);

  @override
  State<LessonsHomeUnit> createState() => _LessonsHomeUnitState();
}

class _LessonsHomeUnitState extends State<LessonsHomeUnit> {
  double polygonWidth = 0.0;
  double screenHeight = 0.0;
  double screenWidth = 0.0;

  // We used "lessonTypes" to build 6 polygons. Adjust as needed:
  final List<int> lessonTypes = [0, 1, 2, 3, 4, 5];

  // Example "pagesLink" from your snippet:
  List<Widget> getPages(List<String> componentIds) {
    final List<Widget> pagesLink = [];
    for (int i = 0; i < componentIds.length; i++) {
      if (i == 0) {
        pagesLink.add(LoadingPageWrapper(destinationPage: LessonOne(), componentId: componentIds[i]));
      }
      else if (i == 1) {
        pagesLink.add(LoadingPageWrapper(destinationPage: LessonOne(), componentId: componentIds[i]));
      }
      else if (i == 2) {
        pagesLink.add(LoadingPageWrapper(destinationPage: StoryPage(), componentId: componentIds[i]));
      }
      else if (i == 3) {
        pagesLink.add(LoadingPageWrapper(destinationPage: Scenario(), componentId: componentIds[i]));
      }
      else if (i == 4) {
        pagesLink.add(LoadingPageWrapper(destinationPage: PeerReflection(), componentId: componentIds[i]));
      }
      else if (i == 5) {
        pagesLink.add(LoadingPageWrapper(destinationPage: PeerReflectionQuiz(), componentId: componentIds[i]));
      }
    }
    return pagesLink;
  }

  List<String> imageLinks = [
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%20Icons%2Fbulb.png?alt=media&token=f5d89615-3c3a-48fe-9b30-2aa31a1bf293",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%20Icons%2Fbrain.png?alt=media&token=69ff0773-b9d8-49e3-97a0-4cb5dd7fc54a",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%20Icons%2Fbook_flip.png?alt=media&token=3f656860-1051-4dce-9b16-f7d4a82424ef",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%20Icons%2Frecycle.png?alt=media&token=5de6e03b-2372-4e64-9635-4cff8d3839e2",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%20Icons%2Fpeer-to-peer.png?alt=media&token=1a8e499b-0e9c-4f30-89d5-8b73969b77da",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%20Icons%2Fcircle_question.png?alt=media&token=b89a30a9-cc6a-4710-aea6-105ece4ee36c",
  ];

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    polygonWidth = screenWidth * 0.07;

    // Decide layout based on aspect ratio:
    return screenWidth > screenHeight ? _webDisplay() : _mobileDisplay();
  }

  /// WEB layout: a row with left side (lessons) + right side scoreboard
  Widget _webDisplay() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LEFT side: multiple lessons in a vertical column
        SizedBox(
          width: screenWidth * 0.5,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.05),
              child: Column(
                children: widget.lessons.map((lesson) {
                  return Container(
                    child: _buildLessonSection(lesson),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        // 3) NEW scoreboard pinned top-right
        SizedBox(width: screenWidth * 0.3),
      ],
    );
  }

  /// MOBILE layout: a simple Scaffold with an AppBar & a Column for the lessons
  Widget _mobileDisplay() {
    return Scaffold(
      appBar: AppBar(title: const Text('Lessons')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: widget.lessons.map((lesson) {
            return Container(
              margin: const EdgeInsets.only(bottom: 250),
              child: _buildLessonSection(lesson),
            );
          }).toList(),
        ),
      ),
    );
  }

  /// Builds one "lesson" section: heading + polygons + lines
  Widget _buildLessonSection(Lesson lesson) {
    final List<String> componentIds= lesson.components;

    final List<Widget> pagesLink = getPages(componentIds);
    // The chain of lines
    final slantLinesColumn = Column(
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

    // The chain of polygons
    final polygonLessonColumn = Column(
      children: [
        SizedBox(height: screenHeight * 0.1),
        for (int i = 0; i < lessonTypes.length; i++)
          CustomPolygonRow(
            index: i,
            isActivated: true,
            width: polygonWidth,
            imageLinks: imageLinks,
            pagesLink: pagesLink,
          ),
      ],
    );

    // We can give each lesson block a fixed size or let it size naturally.
    // For demonstration, we use a SizedBox for ~80% of screenHeight
    return Transform.scale(
      scale: 0.85,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize
            .min, // Allows the Column to be only as tall as its children
        children: [
          Stack(
            children: [
              slantLinesColumn,
              polygonLessonColumn,
            ],
          ).marginSymmetric(horizontal: screenWidth * 0.08),
        ],
      ),
    );
  }
}

// --------------------------------------------------------------------
// Below are your same custom classes (no changes to the design).
// Just copy them from your original file.
// If you keep them in the same file, remove the duplicates from the old code.
// --------------------------------------------------------------------

// The line painter
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
      canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
    } else {
      canvas.drawLine(Offset(0, 0), Offset(size.width, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(SlantLinePainter oldDelegate) => false;
}

// The row of polygons (the clickable ones)
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
        lessonPolygonStack.marginSymmetric(
          horizontal: width * 0.5,
        ),
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
                  style: TextStyle(
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
                        MaterialPageRoute(
                          builder: (context) => pagesLink[index],
                        ),
                      );
                    },
                    child: Text(
                      "Start",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            10,
                          ),
                        ),
                      ),
                      backgroundColor: LightTheme().primaryBlue,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Rewards:",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    //Monkey Question Mark
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: width * 0.25,
                      backgroundImage: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2Fmonkey_question.png?alt=media&token=248dc316-1996-4305-a98a-ece166e7cb27",
                      ),
                    ),
                    const Spacer(),
                    //LessonBananaWorth Image
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: width * 0.3,
                      backgroundImage: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLessonBananaReward.png?alt=media&token=9ff7a738-ad66-4f7b-a9e2-7a6c451284a6",
                      ),
                      child: Text(
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
            icon: Icon(
              Icons.lock,
            ),
            isActivated: isActivated,
            width: width,
            index: index,
            imageLinks: imageLinks,
          ),
        ),
        // GestureDetector(
        //   onTap: () {
        //     showAlignedDialog(
        //       context: context,
        //       builder: (context) => CustomPopup(
        //         content: Column(
        //           mainAxisSize: MainAxisSize.min,
        //           children: List.generate(5, (index) => Text('menu$index')),
        //         ),
        //         child: const Icon(Icons.add_circle_outline),
        //       ),
        //     ); // Navigator.push(
        //     //   context,
        //     //   MaterialPageRoute(
        //     //     builder: (context) {
        //     //       return pagesLink[index];
        //     //     },
        //     //   ),
        //     // );
        //   },
        // ),
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
                  style: TextStyle(
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
                        MaterialPageRoute(
                          builder: (context) => pagesLink[index],
                        ),
                      );
                    },
                    child: Text(
                      "Start",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            10,
                          ),
                        ),
                      ),
                      backgroundColor: LightTheme().primaryBlue,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Rewards:",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    //Monkey Question Mark
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: width * 0.25,
                      backgroundImage: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2Fmonkey_question.png?alt=media&token=248dc316-1996-4305-a98a-ece166e7cb27",
                      ),
                    ),
                    const Spacer(),
                    //LessonBananaWorth Image
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: width * 0.3,
                      backgroundImage: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLessonBananaReward.png?alt=media&token=9ff7a738-ad66-4f7b-a9e2-7a6c451284a6",
                      ),
                      child: Text(
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
            icon: Icon(
              Icons.lock,
            ),
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
                  style: TextStyle(
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
                        MaterialPageRoute(
                          builder: (context) => pagesLink[index],
                        ),
                      );
                    },
                    child: Text(
                      "Start",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            10,
                          ),
                        ),
                      ),
                      backgroundColor: LightTheme().primaryBlue,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Rewards:",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    //Monkey Question Mark
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: width * 0.25,
                      backgroundImage: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2Fmonkey_question.png?alt=media&token=248dc316-1996-4305-a98a-ece166e7cb27",
                      ),
                    ),
                    const Spacer(),
                    //LessonBananaWorth Image
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: width * 0.3,
                      backgroundImage: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLessonBananaReward.png?alt=media&token=9ff7a738-ad66-4f7b-a9e2-7a6c451284a6",
                      ),
                      child: Text(
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
            icon: Icon(
              Icons.lock,
            ),
            isActivated: isActivated,
            width: width,
            index: index,
            imageLinks: imageLinks,
          ),
        ),
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
          offset: Offset(
            -width * 0.8,
            width * 0.5,
          ),
          child: Container(
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
                ? Offset(
                    width * 0.8,
                    width * 0.7,
                  )
                : Offset(
                    -width * 0.8,
                    width * 0.7,
                  ),
            child: Container(
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
            offset: Offset(
              width * 0.5,
              width * 0.5,
            ),
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
          offset: Offset(
            -width * 0.8,
            width * 0.7,
          ),
          child: Container(
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