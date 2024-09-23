import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Frontend/controller/sign_up_controller.dart';
import 'package:money_monkey/GettingStarted/Frontend/controller/start_fresh_controller.dart';
import 'package:money_monkey/themes/color_themes.dart';

class CustomProgressBar extends StatelessWidget {
  const CustomProgressBar({
    super.key,
    required this.page,
  });
  final int page;
  double getProgress() {
    double progress = 0;
    if (page == 0) {
      final StartFreshController startFreshController =
          Get.find<StartFreshController>();
      progress = startFreshController.pageIndex.value / 6;
    } else if (page == 1) {
      final SignUpController signUpController = Get.find<SignUpController>();
      progress = signUpController.pageIndex.value / 3;
    }
    return progress;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        // Dynamically calculate progress based on page index (assuming 7 pages)
        double progress = getProgress();

        return Container(
          width: double.infinity,
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
              // Progress section (blue)
              FractionallySizedBox(
                widthFactor: progress, // Based on page index / total pages
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: LightTheme().primaryBlue,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
