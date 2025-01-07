import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Controllers/ScenarioController.dart';
import 'package:money_monkey/themes/color_themes.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScenarioController scenarioController = Get.find();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: screenWidth * 0.5,
          height: screenHeight * 0.3,
          decoration: BoxDecoration(
            color: LightTheme().primaryBlue.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                height: screenHeight * 0.2,
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMinty.png?alt=media&token=50e15d9a-3fc7-4fdb-9beb-ef2857b68793",
              ),
              Expanded(
                child: Text(
                  "Congratulations! You've just started your first part-time job and earned your first paycheck of \$500. You have several things you want to do with the money: buy new sneakers, save for college, and plan for weekend activities.",
                  overflow: TextOverflow.visible,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ).paddingSymmetric(
            horizontal: screenWidth * 0.02,
            vertical: screenHeight * 0.05,
          ),
        ),
        SizedBox(
          height: screenHeight * 0.3,
        ),
        GestureDetector(
            onTap: () {
              scenarioController.pageIndex.value += 1;
            },
            child: Container(
              decoration: BoxDecoration(
                color: LightTheme().pastelGreen,
                borderRadius: BorderRadius.circular(10),
              ),
              width: screenWidth * 0.18,
              height: screenHeight * 0.08,
              child: Center(
                child: Text(
                  "Start Managing Your Money",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
