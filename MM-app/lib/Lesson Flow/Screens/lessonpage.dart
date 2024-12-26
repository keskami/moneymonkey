import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Lesson Flow/Widgets/lesson_card.dart';
import 'package:money_monkey/Lesson Flow/controller/controller.dart';
import 'package:money_monkey/Lesson Flow/Widgets/custom_app_bar.dart';

class LessonPage extends StatelessWidget {
  final ProgressController progressController = Get.put(ProgressController());

  LessonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    double verticalPadding =
        screenSize.height * 0.05; // 5% of screen height as padding

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0XFFFFFFFF),
        //appBar: CustomAppBar(
            //progressController: progressController), // Custom app bar
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical:
                    verticalPadding), // Dynamic padding based on screen height
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width *
                            0.1), // 10% of screen width for padding
                    child: const LessonCard(), // Use the LessonCard widget
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
