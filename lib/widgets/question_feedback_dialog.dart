import 'package:flutter/material.dart';

class QuestionFeedbackDialog extends StatelessWidget {
  final bool isCorrect;

  const QuestionFeedbackDialog({required this.isCorrect, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  color: isCorrect ? const Color(0xFF85DC40) : const Color(0xFFFF0000), 
                  size: 32,
                ),
                const SizedBox(width: 10),
                Text(
                  isCorrect ? 'Correct' : 'Incorrect',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isCorrect ? const Color(0xFF85DC40) : const Color(0xFFFF0000),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              isCorrect
                  ? "You're right! Coins have been used since around 600 B.C., making them the oldest form of money still in use."
                  : "Correct Answer: Coins have been used since around 600 B.C., making them the oldest form of money still in use.",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15), 
                backgroundColor: isCorrect ? const Color(0xFF85DC40) : const Color(0xFFFF0000), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
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
