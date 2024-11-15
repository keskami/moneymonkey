import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymonkey/controller/controller.dart';

class OptionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProgressController progressController = Get.find<ProgressController>();

    return Obx(() {
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
              progressController.setSelectedOptionIndex(index);
            },
            child: Obx(() => Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: progressController.isOptionSelected.value &&
                            progressController.quizOptions[index] ==
                                progressController.correctAnswer.value
                        ? Colors.blue[150]
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.black26,
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
