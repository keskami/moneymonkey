import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymonkey/controller/controller.dart';

class OptionsList extends StatelessWidget {
  final List<String> options = [
    "To use it as a distraction",
    "To exchange it for things we want or need",
    "To hide it away from others",
    "To keep it only in banks",
    "I don’t know"
  ];

  @override
  Widget build(BuildContext context) {
    final ProgressController progressController = Get.find<ProgressController>();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: options.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            progressController.setSelectedOptionIndex(index);
            bool isCorrect = options[index] == "To exchange it for things we want or need";
            progressController.setCorrectSelection(isCorrect);
          },
          child: Obx(() => Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: progressController.selectedOptionIndex.value == index
                      ? Colors.blue[50]
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: progressController.selectedOptionIndex.value == index
                        ? Colors.blue
                        : Colors.black26,
                    width: 2,
                  ),
                ),
                child: Text(
                  options[index],
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
  }
}
