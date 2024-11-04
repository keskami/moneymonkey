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
      String buttonText = isCorrectSelected && progressController.isDialogShown.value
          ? "Continue"
          : "Check";

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
                      ? const Color(0XFF87CEEB) // Light blue when enabled
                      : Colors.grey,            // Grey when disabled
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: isOptionSelected
                    ? () {
                        if (!isCorrectSelected) {
                          // Show feedback dialog on "Check" button press for incorrect answer
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return QuestionFeedbackDialog(
                                isCorrect: false,
                              );
                            },
                          ).then((_) {
                            // Reset selection to allow retry with "Check" button
                            progressController.setOptionSelected(false);
                          });
                        } else if (!progressController.isDialogShown.value) {
                          // Show correct answer dialog on "Check" button press for correct answer
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const QuestionFeedbackDialog(
                                isCorrect: true,
                              );
                            },
                          ).then((_) {
                            // After showing the dialog, change "Check" to "Continue"
                            progressController.setDialogShown(true);
                          });
                        } else {
                          // Navigate to the next screen when "Continue" is pressed
                          Get.toNamed("/lessonCompletePageRoute");
                        }
                      }
                    : null, // Disable button if no option is selected
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
