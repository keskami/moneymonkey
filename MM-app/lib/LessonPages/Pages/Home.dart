import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  List<String> imageLinks = [
    "assets/lessonFlow/bulb.png",
    "assets/lessonFlow/brain.png",
    "assets/lessonFlow/book_flip.png",
    "assets/lessonFlow/briefcase.png",
    "assets/lessonFlow/recycle.png",
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
        child: Expanded(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.3,
                    ),
                    ...lessonTypes.map(
                      (type) => CustomPolygon(
                        index: type,
                        isActivated: type < 2,
                        width: polygonWidth,
                        imageLinks: imageLinks,
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: screenWidth * 0.15),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                    vertical: screenHeight * 0.02,
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.05,
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
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.ac_unit_sharp,
                              size: 100,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
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
  });
  final double width;
  final int index;
  final bool isActivated;
  final List<String> imageLinks;

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
      case 6:
        mainAxisAlignment = MainAxisAlignment.center;
        break;
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
        PolygonAvatar(
          size: width,
          backgroundColor: Colors.grey.shade400,
          icon: isActivated
              ? PolygonAvatar(
                  size: width * 0.9,
                  backgroundColor: Colors.blue.shade300,
                  icon: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.transparent,
                    child: Image.asset(imageLinks[index]),
                  ),
                )
              : Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
        ),
      ],
    );
  }
}
