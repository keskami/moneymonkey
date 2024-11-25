import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Lesson Flow/controller/controller.dart';

class QuestionFeedbackDialog extends StatelessWidget {
  final bool isCorrect;

  const QuestionFeedbackDialog({required this.isCorrect, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProgressController progressController =
        Get.find<ProgressController>();

    final String correctMessage = progressController
                .quizQuestions[progressController.currentQuestionIndex.value]
            ['correctMessage'] ??
        "Well done!";
    final String incorrectMessage = progressController
                .quizQuestions[progressController.currentQuestionIndex.value]
            ['incorrectMessage'] ??
        "Better luck next time!";

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(
                  isCorrect ? Icons.check_circle : Icons.cancel,
                  color: isCorrect
                      ? const Color(0xFF85DC40)
                      : const Color(0xFFFF0000),
                  size: 32,
                ),
                const SizedBox(width: 10),
                Text(
                  isCorrect ? 'Correct' : 'Incorrect',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isCorrect
                        ? const Color(0xFF85DC40)
                        : const Color(0xFFFF0000),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              isCorrect ? correctMessage : incorrectMessage,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                backgroundColor: isCorrect
                    ? const Color(0xFF85DC40)
                    : const Color(0xFFFF0000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                if (!isCorrect) {
                  progressController.resetSelection();
                }
              },
              child: const Text(
                'Got it',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
