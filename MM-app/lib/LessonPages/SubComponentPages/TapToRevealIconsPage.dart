import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GlobalWidgets/CustomSnackBars.dart';
import 'package:money_monkey/LessonPages/Controllers/Component1_2Controller.dart';
import 'package:money_monkey/LessonPages/Models/Models.dart';
import 'package:money_monkey/LessonPages/Widgets/NextButton.dart';
import 'package:money_monkey/themes/color_themes.dart';

class TapToRevealIconsPage extends StatefulWidget {
  final String componentId;
  const TapToRevealIconsPage({super.key, required this.componentId});

  @override
  State<TapToRevealIconsPage> createState() => _TapToRevealIconsPageState();
}

class _TapToRevealIconsPageState extends State<TapToRevealIconsPage> {
  List<bool> showIcon = [
    false,
    false,
    false,
    false,
  ];
  List<String> iconLinks = [];
  List<String> iconContents = [];
  bool isNextEnabled = false;
  ComponentOneTwoController componentOneTwoController =
      Get.find<ComponentOneTwoController>();
  String title = '';
  String wrong = '';
  bool loading = true;

  Future<void> setData(Question data) async {
    setState(() {
      wrong = "Please click all the icons before moving on";
      title = data.data.title;
      iconContents =
          List<String>.from(data.data.contents.map((item) => item.toString()));
      iconLinks =
          List<String>.from(data.data.iconLinks.map((item) => item.toString()));
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).clearSnackBars();
    });
    if (componentOneTwoController.pageData.isNotEmpty) {
      setData(componentOneTwoController.pageData[2]);
    }
    if (title == '') {
      setData(componentOneTwoController.pageData[2]);
    }
  }

  void makeIconVisible(String iconLink) {
    int index = iconLinks.indexOf(iconLink);
    if (index == 0) {
      setState(() {
        showIcon[index] = true;
      });
    }
    for (int i = 0; i < index; i++) {
      if (showIcon[i] == false) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          WrongAnswerSnackBar(message: wrong),
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
        Duration(seconds: 8),
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
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.043),
          child: Text(
            title,
            softWrap: true,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27,
            ),
          ).marginSymmetric(
            vertical: screenHeight * 0.025,
            horizontal: screenWidth * 0.015,
          ),
        ),

        //Icon Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...iconLinks
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
        backgroundColor: showIcon[iconLinks.indexOf(e)]
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
        vertical: screenHeight * 0.04,
      ),
      child: isVisible
          ? Text(
              e,
              softWrap: true,
              overflow: TextOverflow.visible,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.5,
              ),
              textAlign: TextAlign.center,
            )
          : null,
    );
  }

  mobileDisplay() {}
}
