import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymonkey/controller/controller.dart';

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
    ProgressController progressController = Get.find<ProgressController>();

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
              // Set option as selected and determine if it’s correct
              progressController.setOptionSelected(true);
              bool isCorrect = titles[index] == 'Coins'; // Replace with the correct answer logic
              progressController.setCorrectSelection(isCorrect);
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
}
