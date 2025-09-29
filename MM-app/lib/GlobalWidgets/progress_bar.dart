import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';
import 'package:money_monkey/themes/color_themes.dart';

class CustomProgressBar extends StatelessWidget {
  CustomProgressBar({
    super.key,
    required this.pageType,
    this.width,
    this.pageNum = 0,
  });
  final ComponentType pageType;
  final double? width;
  final double pageNum;
  double getProgress() {
    double progress = 0;
    final BaseLessonController controller = Get.find();
    switch (pageType) {
      case ComponentType.concept:
        progress = controller.pageIndex.value / 9;
        break;
      case ComponentType.peerReflection:
        progress = controller.pageIndex.value / 5;
        break;
      case ComponentType.quiz:
        progress = controller.pageIndex.value / 5;
        break;
      case ComponentType.story:
        progress = controller.pageIndex.value / 5;
        break;
      case ComponentType.scenarioSimulation:
        progress = controller.pageIndex.value / 5;
        break;
      default:
        progress = pageNum / 9;
    }
    return progress;
  }

  @override
  Widget build(BuildContext context) {
    double effectiveWidth = width ?? MediaQuery.of(context).size.width;
    return Obx(
      () {
        double progress = getProgress();
        return Container(
          width: effectiveWidth,
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Stack(
            children: [
              Container(
                width: effectiveWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: LightTheme().primaryBackgroundColor,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                width: effectiveWidth * progress,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
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
