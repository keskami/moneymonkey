import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymonkey/controller/controller.dart';
import 'package:moneymonkey/widgets/question_feedback_dialog.dart';

class ContinueButtonSection extends StatelessWidget {
  const ContinueButtonSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProgressController progressController = Get.find<ProgressController>();

    return Obx(() {
      bool isOptionSelected = progressController.isOptionSelected.value;
      bool isCorrectSelected = progressController.isCorrectSelected.value;
      bool isDialogShown = progressController.isDialogShown.value;

      // Update button text based on current state
      String buttonText = isCorrectSelected && isDialogShown ? "Continue" : "Check";

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
                  backgroundColor: isOptionSelected
                      ? const Color(0XFF87CEEB)
                      : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: isOptionSelected
                    ? () {
                        if (isCorrectSelected && !isDialogShown) {
                          // Show correct answer dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const QuestionFeedbackDialog(isCorrect: true);
                            },
                          ).then((_) {
                            // After showing the dialog, update dialog shown state
                            progressController.setDialogShown(true);
                            // Mark quiz as completed
                            progressController.setQuizCompleted();
                          });
                        } else if (isCorrectSelected && isDialogShown) {
                          // Navigate to the next page if "Continue" is clicked
                          Get.toNamed("/lessonCompletePageRoute");
                        } else {
                          // Show incorrect answer dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const QuestionFeedbackDialog(isCorrect: false);
                            },
                          ).then((_) {
                            // Reset option selection for retry
                            progressController.setOptionSelected(false);
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
            )
          ],
        ),
      );
    });
  }
}
