import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GlobalWidgets/CustomSnackBars.dart';
import 'package:money_monkey/LessonPages/Controllers/Component1_2Controller.dart';
import 'package:money_monkey/LessonPages/Widgets/NextButton.dart';
import 'package:money_monkey/themes/color_themes.dart';

class IconRevealPage extends StatefulWidget {
  const IconRevealPage({super.key});

  @override
  State<IconRevealPage> createState() => _IconRevealPageState();
}

class _IconRevealPageState extends State<IconRevealPage> {
  List<bool> showIcon = [
    false,
    false,
    false,
    false,
  ];
  List<String> iconsLinks = [
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fcard.png?alt=media&token=d9ad44a7-c607-4a88-9c8b-64d49e47a245",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fgraduation-cap.png?alt=media&token=53e1203d-816d-4512-b570-db886d53d904",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fbriefcase-bag.png?alt=media&token=987a2538-9376-46ef-965e-502cf493d798",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fsunset.png?alt=media&token=2ebd97df-6903-4254-bd15-3a59c404825b",
  ];
  List<String> iconContents = [
    "Even small allowances or part-time earnings can be budgeted. Learning to save a portion of every dollar sets a foundation for bigger goals later.",
    "This might be your first real job or college experience. Start building credit responsibly and budget for regular bills—rent, utilities, groceries.",
    "You might buy a home or consider long-term investments. Having an emergency fund, managing debt wisely, and planning for retirement become crucial.",
    "You live off savings, pensions, or investments made earlier. Continued budgeting helps ensure your money lasts and you maintain your desired lifestyle.",
  ];
  bool isNextEnabled = false;
  ComponentOneTwoController componentOneTwoController = Get.find();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).clearSnackBars();
    });
  }

  void makeIconVisible(String iconLink) {
    int index = iconsLinks.indexOf(iconLink);
    if (index == 0) {
      setState(() {
        showIcon[index] = true;
      });
    }
    for (int i = 0; i < index; i++) {
      if (showIcon[i] == false) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          WrongAnswerSnackBar(
              message: "Kindly go in order from Left to Right."),
        );
        return;
      }
    }
    setState(() {
      showIcon[index] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    //For enabling the Next Button
    if (showIcon[3]) {
      Future.delayed(
        Duration(seconds: 2),
        () {
          setState(() {
            isNextEnabled = true;
          });
        },
      );
    }
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > screenHeight
        ? webDisplay(screenWidth, screenHeight)
        : mobileDisplay();
  }

  Widget webDisplay(double screenWidth, double screenHeight) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: screenWidth * 0.02),
        Text(
          "Definition: Financial Responsibility Over a Lifetime",
          softWrap: true,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 27,
          ),
        ).marginSymmetric(
          vertical: screenHeight * 0.025,
          horizontal: screenWidth * 0.015,
        ),
        //Icon Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...iconsLinks
                .map(
                  (e) {
                    return TapToViewCircleAvatar(e, screenWidth);
                  },
                )
                .expand((widget) => [
                      widget,
                      SizedBox(
                        width: screenWidth * 0.11,
                        height: 3,
                        child: Container(
                          color: Colors.grey.shade400,
                        ),
                      )
                    ])
                .toList()
              ..removeLast()
          ],
        ),
        SizedBox(
          height: screenHeight * 0.05,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...iconContents
                .map(
                  (e) => CustomInfoContainer(screenWidth, screenHeight, e,
                      showIcon[iconContents.indexOf(e)]),
                )
                .expand((widget) => [
                      widget,
                      const Spacer(),
                    ])
                .toList()
              ..removeLast()
          ],
        ),
        SizedBox(
          height: screenHeight * 0.05,
        ),
        //Next Button Row
        Row(
          children: [
            const Spacer(),
            CustomNextButton(
              nextPage: () {
                componentOneTwoController.pageIndex.value += 1;
              },
              isEnabled: isNextEnabled,
            ),
            SizedBox(
              width: screenWidth * 0.02,
            ),
          ],
        )
      ],
    ).paddingSymmetric(horizontal: screenWidth * 0.2);
  }

  GestureDetector TapToViewCircleAvatar(String e, double screenWidth) {
    return GestureDetector(
      onTap: () {
        makeIconVisible(e);
      },
      child: CircleAvatar(
        radius: screenWidth * 0.02,
        backgroundColor: showIcon[iconsLinks.indexOf(e)]
            ? LightTheme().primaryBlue
            : Colors.grey,
        child: Image.network(
          e,
          width: screenWidth * 0.025,
        ),
      ),
    );
  }

  Container CustomInfoContainer(
      double screenWidth, double screenHeight, String e, bool isVisible) {
    return Container(
      width: screenWidth * 0.12,
      height: screenHeight * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: isVisible
            ? [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 2,
                  offset: Offset(0, 2),
                ),
              ]
            : null,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.01,
        vertical: screenHeight * 0.05,
      ),
      child: isVisible
          ? Text(
              e,
              softWrap: true,
              overflow: TextOverflow.visible,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            )
          : null,
    );
  }

  mobileDisplay() {}
}
