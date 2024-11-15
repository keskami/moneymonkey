import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymonkey/controller/controller.dart';

class OptionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProgressController progressController = Get.find<ProgressController>();

    return ValueListenableBuilder<int>(
      valueListenable: progressController.selectedOptionIndex,
      builder: (context, selectedIndex, child) {
        if (progressController.quizOptions.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: progressController.quizOptions.length,
          itemBuilder: (context, index) {
            final optionText = progressController.quizOptions[index];
            final bool isSelected = selectedIndex == index;

            return GestureDetector(
              onTap: () {
                progressController.setSelectedOptionIndex(index);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue[100] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.black26,
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
              ),
            );
          },
        );
      },
    );
  }
}
