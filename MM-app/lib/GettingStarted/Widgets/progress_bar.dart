import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/controller/quiz_controller.dart';
import 'package:money_monkey/GettingStarted/controller/sign_up_controller.dart';
import 'package:money_monkey/GettingStarted/controller/start_fresh_controller.dart';
import 'package:money_monkey/themes/color_themes.dart';

class CustomProgressBar extends StatelessWidget {
  CustomProgressBar({
    super.key,
    required this.page,
    this.width,
  });
  final int page;
  final double? width;

  double getProgress() {
    double progress = 0;
    if (page == 0) {
      final StartFreshController startFreshController =
          Get.find<StartFreshController>();
      progress = startFreshController.pageIndex.value / 5;
    } else if (page == 1) {
      final SignUpController signUpController = Get.find<SignUpController>();
      progress = signUpController.pageIndex.value / 5;
    } else if (page == 2) {
      final QuizController quizController = Get.find();
      progress = quizController.pageIndex.value / 9;
    }
    return progress;
  }

  @override
  Widget build(BuildContext context) {
    double effectiveWidth = width ?? MediaQuery.of(context).size.width;
    return Obx(
      () {
        // Dynamically calculate progress based on page index
        double progress = getProgress();

        return Container(
          width: effectiveWidth,
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            color: Colors.white,
          ),
          child: Stack(
            children: [
              // Background of progress bar (white)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  color: Colors.white,
                ),
              ),
              // Animated progress section
              AnimatedContainer(
                duration:
                    const Duration(milliseconds: 300), // Animation duration
                curve: Curves.easeInOut, // Smooth curve for animation
                width: effectiveWidth * progress,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  color: LightTheme().primaryBlue,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
