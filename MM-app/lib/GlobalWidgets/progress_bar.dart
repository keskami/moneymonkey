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
      case ComponentType.kickoff:
        progress = controller.pageIndex.value / 8;
        break;
      case ComponentType.learnIt:
        progress = controller.pageIndex.value / 4;
        break;
      case ComponentType.tryIt:
        progress = controller.pageIndex.value / 4;
        break;
      case ComponentType.exitCheck:
        progress = controller.pageIndex.value / 6;
        break;
      case ComponentType.recap:
        progress = controller.pageIndex.value / 4;
        break;
      default:
        progress = pageNum / 8;
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
