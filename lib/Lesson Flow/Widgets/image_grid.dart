import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Lesson Flow/controller/controller.dart';

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
    final ProgressController progressController =
        Get.find<ProgressController>();

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
              // Set selected option and determine if it’s correct
              progressController.setSelectedOptionIndex(
                  index); // Update selected option index
              bool isCorrect =
                  titles[index] == 'Coins'; // Replace with correct answer logic
              progressController.setCorrectSelection(isCorrect);
            },
            child: Obx(() => Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: progressController.selectedOptionIndex.value == index
                        ? Colors.blue[100] // Highlight if selected
                        : Colors.grey[200], // Default color if not selected
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:
                          progressController.selectedOptionIndex.value == index
                              ? Colors.blue // Border color if selected
                              : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Image.asset(imagePaths[index], height: 120, width: 120),
                      const SizedBox(height: 10),
                      Text(
                        titles[index],
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}
