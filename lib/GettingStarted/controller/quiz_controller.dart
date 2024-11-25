// quiz_controller.dart

import 'package:get/get.dart';

import '../Models and Questions/question_data.dart';

class QuizController extends GetxController {
  RxInt pageIndex = 0.obs;
  RxInt result = 0.obs;
  List<List<String>> answers = List.generate(questions.length, (_) => []);

  // Method to calculate the score
  int calculateScore() {
    int score = 0;
    for (int i = 0; i < questions.length; i++) {
      final userAnswers = answers[i];
      final correctAnswers = questions[i].correctAnswers;

      if (userAnswers.toSet().containsAll(correctAnswers) &&
          correctAnswers.toSet().containsAll(userAnswers)) {
        score += 1;
      }
    }
    return score;
  }
}
