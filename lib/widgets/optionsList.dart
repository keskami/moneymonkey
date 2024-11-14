import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymonkey/controller/controller.dart';

class OptionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProgressController progressController = Get.find<ProgressController>();

    // Fetch quiz data when the widget is built
    progressController.fetchQuizData('lesson${progressController.currentLessonIndex.value + 1}');

    return Obx(() {
      // Check if options are still being fetched
      if (progressController.quizOptions.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: progressController.quizOptions.length,
        itemBuilder: (context, index) {
          final optionText = progressController.quizOptions[index];

          return GestureDetector(
            onTap: () {
              // Set selected option and determine if it’s correct
              progressController.setSelectedOptionIndex(index);
              bool isCorrect = optionText == progressController.correctAnswer.value;
              progressController.setCorrectSelection(isCorrect);
            },
            child: Obx(() => Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: progressController.selectedOptionIndex.value == index
                        ? Colors.blue[50]
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: progressController.selectedOptionIndex.value == index
                          ? Colors.blue
                          : Colors.black26,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    optionText,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Baloo 2",
                    ),
                  ),
                )),
          );
        },
      );
    });
  }
}
