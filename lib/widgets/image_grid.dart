import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:moneymonkey/controller/controller.dart';

class ImageGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProgressController progressController = Get.find<ProgressController>();

    return ValueListenableBuilder<int>(
      valueListenable: progressController.selectedOptionIndex,
      builder: (context, selectedIndex, child) {
        if (progressController.quizOptions.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        // Get the image options and the correct answer
        final List<String> imagePaths = [
          progressController.quizOptions[0],
          progressController.quizOptions[1],
          progressController.quizOptions[2],
          progressController.quizOptions[3],
        ];
        final String correctImage = progressController.correctAnswer.value;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: GridView.builder(
              padding: const EdgeInsets.only(top: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: imagePaths.length,
              itemBuilder: (context, index) {
                final bool isSelected = selectedIndex == index;
                final String imagePath = 'assets/images/${imagePaths[index]}';

                return GestureDetector(
                  onTap: () {
                    progressController.setSelectedOptionIndex(index);
                    bool isCorrect = imagePaths[index] == correctImage;
                    progressController.setCorrectSelection(isCorrect);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue[50] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.black12,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SvgPicture.asset(
                            imagePath,
                            height: 100,
                            width: 100,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
