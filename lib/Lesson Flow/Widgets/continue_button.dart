import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Lesson Flow/controller/controller.dart';
import 'package:money_monkey/Lesson Flow/widgets/question_feedback_dialog.dart';
import 'package:money_monkey/Lesson%20Flow/Screens/lessoncomplete.dart';

class ContinueButtonSection extends StatelessWidget {
  const ContinueButtonSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProgressController progressController =
        Get.find<ProgressController>();

    return Obx(() {
      bool isOptionSelected = progressController.isOptionSelected.value;
      bool isCorrectSelected = progressController.isCorrectSelected.value;
      bool isDialogShown = progressController.isDialogShown.value;

      // Update button text based on current state
      String buttonText =
          isCorrectSelected && isDialogShown ? "Continue" : "Check";

      return Container(
        height: 50,
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.maxFinite,
              height: 38,
              margin: const EdgeInsets.only(bottom: 12),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isOptionSelected ? const Color(0XFF87CEEB) : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: isOptionSelected
                    ? () {
                        if (isCorrectSelected && !isDialogShown) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const QuestionFeedbackDialog(
                                  isCorrect: true);
                            },
                          ).then((_) {
                            // Update dialog shown state
                            progressController.setDialogShown(true);
                          });
                        } else if (isCorrectSelected && isDialogShown) {
                          // Move to the next question if "Continue" is clicked
                          if (progressController.currentQuestionIndex.value <
                              progressController.quizQuestions.length - 1) {
                            // Load the next question and reset state
                            progressController.nextQuestion();
                            progressController.incrementProgress();
                          } else {
                            // Mark quiz as completed
                            progressController.setQuizCompleted();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LessonCompleteScreen(),
                              ),
                            );
                            // Get.toNamed("/lessonCompletePageRoute");
                            // Award bananas and move to the next lesson
                            // progressController.awardBananas().then((_) {
                            //   progressController.moveToNextLesson();
                            // });
                          }
                        } else {
                          // Show incorrect answer dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const QuestionFeedbackDialog(
                                  isCorrect: false);
                            },
                          ).then((_) {
                            // Reset option selection for retry
                            progressController.resetSelection();
                          });
                        }
                      }
                    : null,
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    color: Color(0XFFFFFFFF),
                    fontSize: 20,
                    fontFamily: 'Baloo 2',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
