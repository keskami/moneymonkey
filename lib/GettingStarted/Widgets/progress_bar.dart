import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/controller/start_fresh_controller.dart';
import 'package:money_monkey/themes/color_themes.dart';

class CustomProgressBar extends StatelessWidget {
  final StartFreshController startFreshController =
      Get.put(StartFreshController());

  CustomProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        // Dynamically calculate progress based on page index (assuming 7 pages)
        double progress = startFreshController.pageIndex.value /
            6; // Adjust 6 based on your total pages

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
