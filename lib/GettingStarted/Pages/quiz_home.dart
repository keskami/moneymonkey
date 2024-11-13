import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/controller/quiz_controller.dart';

class QuizHome extends StatefulWidget {
  const QuizHome({super.key});

  @override
  State<QuizHome> createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {
  int selectedIndex = 5;
  QuizController quizController = Get.put(QuizController());
  @override
  Widget build(BuildContext context) {
    void toNextPage() {
      int pageIndex = quizController.pageIndex.value;
      if (pageIndex == 0) {
      } else if (pageIndex == 1) {
      } else if (pageIndex == 2) {
      } else if (pageIndex == 3) {
      } else if (pageIndex == 4) {
      } else if (pageIndex == 5) {
      } else if (pageIndex == 6) {
      } else if (pageIndex == 7) {
      } else if (pageIndex == 9) {}
    }

    return Scaffold(
      body: Obx(
        () {
          if (quizController.pageIndex.value < 9) {
            return quizController.Pages[quizController.pageIndex.value];
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
