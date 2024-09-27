import 'package:flutter/material.dart';

import 'package:moneymonkey/widgets/question_feedback_dialog.dart';

class ImageGrid extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/images/banknote.png',
    'assets/images/coin.png',
    'assets/images/creditcard.png',
    'assets/images/mobile.png',
  ];

  final List<String> titles = ['Banknotes', 'Coins', 'Debit Cards', 'Mobile'];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Handle selection logic
              if (titles[index] == 'Coins') {
                _showCorrectDialog(context);
              } else {
                _showIncorrectDialog(context);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.transparent,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Image.asset(imagePaths[index], height: 120, width: 120),
                  const SizedBox(height: 10),
                  Text(
                    titles[index],
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showCorrectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const QuestionFeedbackDialog(isCorrect: true);
      },
    );
  }

  void _showIncorrectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const QuestionFeedbackDialog(isCorrect: false);
      },
    );
  }
}
