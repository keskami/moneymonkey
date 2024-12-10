import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Lesson Flow/controller/controller.dart';

class ImageGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProgressController progressController =
        Get.find<ProgressController>();

    return ValueListenableBuilder<int>(
      valueListenable: progressController.selectedOptionIndex,
      builder: (context, selectedIndex, child) {
        if (progressController.quizOptions.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

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
              itemCount: progressController.quizOptions.length,
              itemBuilder: (context, index) {
                final bool isSelected = selectedIndex == index;
                final String imagePath =
                    'assets/images/${progressController.quizOptions[index]}';
                final String title =
                    _formatTitle(progressController.quizOptions[index]);

                return GestureDetector(
                  onTap: () {
                    progressController.setSelectedOptionIndex(index);
                    bool isCorrect = progressController.quizOptions[index] ==
                        progressController.correctAnswer.value;
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
                        const SizedBox(height: 10),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
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

  // Helper method to format the title from the image filename
  String _formatTitle(String filename) {
    // Remove the file extension (.svg)
    String nameWithoutExtension = filename.replaceAll('.svg', '');
    // Replace hyphens with spaces and capitalize each word
    List<String> words = nameWithoutExtension
        .split('-')
        .map((word) => _capitalize(word))
        .toList();
    // Join the words with a space
    return words.join(' ');
  }

  // Helper method to capitalize the first letter of each word
  String _capitalize(String word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1);
  }
}
