import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GlobalWidgets/CustomSnackBars.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';
import 'package:money_monkey/LessonPages/Widgets/NextButton.dart';
import 'package:money_monkey/themes/color_themes.dart';

class TapToRevealIconsPage extends StatefulWidget {
  final String title;
  final String wrongMessage;
  final List<String> iconLinks;
  final List<String> iconContents;

  const TapToRevealIconsPage({
    super.key,
    required this.title,
    required this.wrongMessage,
    required this.iconLinks,
    required this.iconContents,
  });

  @override
  State<TapToRevealIconsPage> createState() => _TapToRevealIconsPageState();
}

class _TapToRevealIconsPageState extends State<TapToRevealIconsPage> {
  // Local states
  List<bool> showIcon = [false, false, false, false];
  bool isNextEnabled = false;

  // If you still need the controller for pageIndex navigation, keep it
  final BaseLessonController baseLessonController =
      Get.find<BaseLessonController>();

  @override
  Widget build(BuildContext context) {
    // For enabling the Next Button
    // (If the last icon is visible, schedule enabling the button in 8s)
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
        : mobileDisplay(screenWidth, screenHeight);
  }

  /// Called when user taps an icon
  void makeIconVisible(String iconLink) {
    int index = widget.iconLinks.indexOf(iconLink);
    // Check if the user has tapped all previous icons
    for (int i = 0; i < index; i++) {
      if (!showIcon[i]) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          WrongAnswerSnackBar(message: widget.wrongMessage),
        );
        return;
      }
    }
    // Make current icon visible
    setState(() {
      showIcon[index] = true;
    });
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
            widget.title,
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
        // Icon Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...widget.iconLinks
                .map((iconLink) {
                  return TapToViewCircleAvatar(iconLink, screenWidth);
                })
                .expand((iconWidget) => [
                      iconWidget,
                      SizedBox(
                        width: screenWidth * 0.11,
                        height: 3,
                        child: Container(color: Colors.grey.shade400),
                      )
                    ])
                .toList()
              ..removeLast() // remove the trailing space after last icon
          ],
        ),
        SizedBox(height: screenHeight * 0.05),
        // Info containers below each icon
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...widget.iconContents
                .asMap()
                .entries
                .map((entry) => CustomInfoContainer(
                      screenWidth,
                      screenHeight,
                      entry.value,            // the actual content text
                      showIcon[entry.key],    // visibility depends on tapped icon
                    ))
                .expand((infoWidget) => [
                      infoWidget,
                      const Spacer(),
                    ])
                .toList()
              ..removeLast() // remove trailing spacer
          ],
        ),
        SizedBox(height: screenHeight * 0.05),
        // Next Button Row
        Row(
          children: [
            const Spacer(),
            CustomNextButton(
              nextPage: () {
                baseLessonController.pageIndex.value += 1;
              },
              isEnabled: isNextEnabled,
            ),
            SizedBox(width: screenWidth * 0.02),
          ],
        )
      ],
    ).paddingSymmetric(horizontal: screenWidth * 0.2);
  }

  Widget TapToViewCircleAvatar(String iconLink, double screenWidth) {
    int index = widget.iconLinks.indexOf(iconLink);
    return GestureDetector(
      onTap: () {
        makeIconVisible(iconLink);
      },
      child: CircleAvatar(
        radius: screenWidth * 0.02,
        backgroundColor: showIcon[index] ? LightTheme().primaryBlue : Colors.grey,
        child: Image.network(
          iconLink,
          width: screenWidth * 0.025,
        ),
      ),
    );
  }

  Container CustomInfoContainer(
    double screenWidth,
    double screenHeight,
    String content,
    bool isVisible,
  ) {
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
              content,
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

  /// Stub for the mobile layout
  Widget mobileDisplay(double screenWidth, double screenHeight) {
    // You can adapt the same logic in webDisplay for mobile,
    // or create a separate arrangement.
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Title
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            // icons row, content below, etc. ...
            // Then Next button
            Row(
              children: [
                Spacer(),
                CustomNextButton(
                  nextPage: () {
                    baseLessonController.pageIndex.value += 1;
                  },
                  isEnabled: isNextEnabled,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
