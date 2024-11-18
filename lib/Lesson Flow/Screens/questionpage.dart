import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Lesson Flow/Widgets/image_grid.dart';
import 'package:money_monkey/Lesson Flow/Widgets/optionList.dart';
import 'package:money_monkey/Lesson Flow/controller/controller.dart';
import 'package:money_monkey/Lesson%20Flow/Widgets/continue_button.dart';
import 'package:money_monkey/Lesson%20Flow/Widgets/custom_app_bar.dart';

class QuestionPage extends StatelessWidget {
  final ProgressController progressController = Get.put(ProgressController());

  QuestionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Fetch quiz data for the current lesson
    progressController.fetchQuizData(
        'lesson${progressController.currentLessonIndex.value + 1}');

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: CustomAppBar(progressController: progressController),
        body: Obx(() {
          if (progressController.quizOptions.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // Conditionally render the quiz question UI based on the question index
          Widget questionWidget;
          if (progressController.currentQuestionIndex.value >= 2) {
            // For questions 3 and 4, use the ImageGrid format
            questionWidget = ImageGrid();
          } else {
            // For questions 1 and 2, use the regular options list
            questionWidget = OptionsList();
          }

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenWidth * 0.3,
                    child: Image.asset(
                      'assets/images/quizMonkey.png',
                      height: screenHeight * 0.2,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/images/speech_bubble.png',
                          width: screenWidth * 0.62,
                          fit: BoxFit.contain,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            progressController.quizQuestion.value,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Baloo 2",
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              questionWidget,
            ],
          );
        }),
        bottomNavigationBar: const ContinueButtonSection(),
      ),
    );
  }
}
