import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';
import 'package:money_monkey/LessonPages/Widgets/NextButton.dart';
import 'package:money_monkey/themes/color_themes.dart';

class GraphicalResultPage extends StatefulWidget {
  final String title;
  final String subTitle;
  final String button;

  const GraphicalResultPage({
    super.key,
    required this.title,
    required this.subTitle,
    required this.button,
  });

  @override
  _GraphicalResultPageState createState() => _GraphicalResultPageState();
}

class _GraphicalResultPageState extends State<GraphicalResultPage> {
  // We still need the baseLessonController to get the user’s final score
  final BaseLessonController baseLessonController = Get.find();

  /// We'll compute the "message" based on the `responsibilityScore`
  String get message {
    int score = baseLessonController.responsibilityScore.value;
    if (score == 100) {
      return "Amazing! You're in an incredible spot for financial growth, continue being financially responsible!";
    } else if (score < 50) {
      return "You got quite a lot to learn!";
    } else {
      return "There's still room for improvement in your abilities to be financially responsible!";
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: screenWidth * 0.06),
        Container(
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Centered title
              Text(
                widget.title, // e.g. "Your Financial Summary"
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        // Graphic Image
        Image.network(
          "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2Ftemp.png?alt=media&token=7e4f0270-18cb-4d10-86ba-30bb2ccfb68d",
          width: screenWidth * 0.3,
          height: screenHeight * 0.25,
        ),
        const SizedBox(height: 40),
        // Score Container
        Container(
          width: screenWidth * 0.4,
          height: screenHeight * 0.15,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.02,
            vertical: screenHeight * 0.02,
          ),
          decoration: BoxDecoration(
            color: LightTheme().primaryBlue.withAlpha(70),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // e.g. "Financial Responsibility Score 72"
              Text(
                "${widget.subTitle} ${baseLessonController.responsibilityScore.value.toStringAsFixed(2)}",
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                message, // from our getter
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomNextButton(
              nextPage: () {
                if (Get.isRegistered<BaseLessonController>()) {
                  Get.delete<BaseLessonController>();
                }
                // Reset score & page index
                baseLessonController.pageIndex.value = 0;
                baseLessonController.responsibilityScore.value = 0;
                baseLessonController.dispose();

                // Then pop out of the lesson
                Navigator.pop(context);
              },
              isEnabled: true,
              text: widget.button, // e.g. "Finish"
            ),
          ],
        ).marginOnly(top: 45),
      ],
    );
  }
}
