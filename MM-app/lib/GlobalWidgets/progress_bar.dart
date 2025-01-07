import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Controllers/Component1_2Controller.dart';
import 'package:money_monkey/LessonPages/Controllers/ScenarioController.dart';
import 'package:money_monkey/LessonPages/Controllers/StoryController.dart';
import 'package:money_monkey/LessonPages/Controllers/PeerReflectionController.dart';
import 'package:money_monkey/LessonPages/Controllers/PeerReflectionQuizController.dart';
import 'package:money_monkey/themes/color_themes.dart';

class CustomProgressBar extends StatelessWidget {
  CustomProgressBar({
    super.key,
    required this.pageName,
    this.width,
    this.pageNum = 0,
  });
  final String pageName;
  final double? width;
  final double pageNum;
  double getProgress() {
    double progress = 0;
    switch (pageName) {
      case 'ConceptOne':
        final ComponentOneTwoController educationPagesController = Get.find();
        progress = educationPagesController.pageIndex.value / 8;
        break;
      case 'PeerReflection':
        final PeerReflectioncontroller peerReflectionController = Get.find();
        progress = peerReflectionController.pageIndex.value / 8;
        break;
      case 'PeerReflectionQuiz':
        final PeerReflectionQuizcontroller peerReflectionQuizcontroller =
            Get.find();
        progress = peerReflectionQuizcontroller.pageIndex.value / 5;
        break;
      case 'StoryPage':
        final StoryController storyController = Get.find();
        progress = storyController.pageIndex.value / 5;
        break;
      case 'ScenarioPage':
        final ScenarioController scenarioController = Get.find();
        progress = scenarioController.pageIndex.value / 4;
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
