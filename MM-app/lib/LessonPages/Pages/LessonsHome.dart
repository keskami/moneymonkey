import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Pages/ConceptOneTwo.dart';
import 'package:money_monkey/LessonPages/Pages/PeerReflection.dart';
import 'package:money_monkey/LessonPages/Pages/PeerReflectionQuiz.dart';
import 'package:money_monkey/LessonPages/Pages/Scenario.dart';
import 'package:money_monkey/LessonPages/Pages/Story.dart';
import 'package:money_monkey/LessonPages/Widgets/PolygonAvatar.dart';
import 'package:money_monkey/themes/color_themes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> lessonTypes = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
  ];
  double polygonWidth = 0.0;
  double screenHeight = 0.0;
  double screenWidth = 0.0;
  int unitNum = 1;
  List<Widget> pagesLink = [
    LessonOne(),
    LessonOne(),
    StoryPage(),
    Scenario(),
    PeerReflection(),
    Scenario(),
    PeerReflectionQuiz(),
  ];
  List<String> imageLinks = [
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%20Icons%2Fbulb.png?alt=media&token=f5d89615-3c3a-48fe-9b30-2aa31a1bf293",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%20Icons%2Fbrain.png?alt=media&token=69ff0773-b9d8-49e3-97a0-4cb5dd7fc54a",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%20Icons%2Fbook_flip.png?alt=media&token=3f656860-1051-4dce-9b16-f7d4a82424ef",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%20Icons%2Frecycle.png?alt=media&token=5de6e03b-2372-4e64-9635-4cff8d3839e2",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%20Icons%2Fpeer-to-peer.png?alt=media&token=1a8e499b-0e9c-4f30-89d5-8b73969b77da",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%20Icons%2Fbriefcase.png?alt=media&token=7d494c7c-0536-461c-aec9-b5dfb24547d3",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%20Icons%2Fcircle_question.png?alt=media&token=b89a30a9-cc6a-4710-aea6-105ece4ee36c",
  ];
  List<String> unitTitles = [
    "Costs and Benefits of Financial Responsibility",
  ];
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    polygonWidth = screenWidth * 0.07;
    return screenWidth > screenHeight ? webDisplay() : mobileDisplay();
  }

  Scaffold webDisplay() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: screenWidth * 0.5,
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(
                  top: screenHeight *
                      0.25), // Add padding to avoid overlap with the floating container
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  ...lessonTypes.map(
                    (type) => CustomPolygon(
                      index: type,
                      isActivated: true,
                      width: polygonWidth,
                      imageLinks: imageLinks,
                      pagesLink: pagesLink,
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: screenWidth * 0.15),
            ),
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Unit $unitNum".toUpperCase(),
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              unitTitles[unitNum - 1],
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
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
                            border: Border.all(
                              color: Colors.blue,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FUnit1%2FbookLogo.png?alt=media&token=5292ff86-afa7-49a3-bb62-a14f9c8b48f8",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  mobileDisplay() {}
}

class CustomPolygon extends StatelessWidget {
  const CustomPolygon({
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
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center;
    switch (index) {
      case 1:
      case 5:
        mainAxisAlignment = MainAxisAlignment.start;
        break;
      case 2:
      case 4:
        mainAxisAlignment = MainAxisAlignment.center;
        break;
      case 6:
      case 3:
      case 7:
        mainAxisAlignment = MainAxisAlignment.end;
        break;
      default:
        mainAxisAlignment = MainAxisAlignment.center;
    }
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return pagesLink[index];
              },
            ));
          },
          child: PolygonAvatar(
            size: width,
            isActivated: isActivated,
            backgroundColor: Colors.grey.shade400,
            icon: isActivated
                ? PolygonAvatar(
                    size: width * 0.9,
                    isActivated: !isActivated,
                    backgroundColor: Colors.blue.shade600,
                    icon: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.transparent,
                      child: Image.network(
                        imageLinks[index],
                      ),
                    ),
                  )
                : Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
          ),
        ),
        if (index == 6)
          CircleAvatar(
            radius: 45,
            backgroundColor: Colors.transparent,
            child: Image.network(
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%20Icons%2FTreasure%20Chest.png?alt=media&token=e2acbcb2-17d4-4b1a-89df-6d6296467c03"),
          ).marginOnly(left: 45),
      ],
    );
  }
}
