// scenario_controller.dart

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:money_monkey/LessonPages/Services/lesson_services.dart';

class ScenarioController extends GetxController {
  final int lessonNumber;
  final int unitNumber;

  ScenarioController({required this.unitNumber, required this.lessonNumber});

  final LessonServices lessonServices = Get.find<LessonServices>();

  RxInt pageIndex = 0.obs;
  RxDouble responsibilityScore = 0.0.obs;
  RxBool isLoading = true.obs;
  RxBool isControllerLoading = true.obs;

  var pageData = <int, dynamic>{}.obs;
  var controllerData = <int, dynamic>{}.obs;

  // Data needed for question logic
  List<String> answers = [];
  List<String> options1= [];
  List<String> options2= [];
  List<String> options3= [];
  List<String> questions = [];
  List<String> correctMessages = [];

  // UI pages
  List<Widget> pages = [];

  @override
  void onInit() {
    super.onInit();
    loadScenarioData();
  }

  Future<void> loadScenarioData() async {
    try {
      // 1) fetch the "controllerData" from pageNumber = 0, if that's how you store it
      final cData = await lessonServices.loadSinglePageData(
        levelName: "Advanced",
        unitNumber: unitNumber,
        lessonNumber: lessonNumber,
        componentType: "Scenario",
        pageNumber: 0,
      );

      if (cData.isNotEmpty) {
        answers = List<String>.from(cData["correctAnswers"] ?? []);
        options1 = List<String>.from(cData["options1"] ?? []);
        options2 = List<String>.from(cData["options2"] ?? []);
        options3 = List<String>.from(cData["options3"] ?? []);
        questions = List<String>.from(cData["questions"] ?? []);
        correctMessages = List<String>.from(cData["correctMessages"] ?? []);
      }

      // 2) fetch normal pages 1..4
      for (int i = 1; i <= 4; i++) {
        final data = await lessonServices.loadSinglePageData(
          levelName: "Advanced",
          unitNumber: unitNumber,
          lessonNumber: lessonNumber,
          componentType: "Scenario",
          pageNumber: i,
        );
        pageData[i] = data;
      }
      // 3) build UI pages
      initializePages();
    } catch (e) {
      print("Error in loadScenarioData: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void initializePages() {
    pages = [
      // etc. Then pass the loaded question data
      // QuestionPage(
      //   question: questions.isNotEmpty ? questions[0] : "",
      //   correctAns: answers.isNotEmpty ? answers[0] : "",
      //   options: [
      //     [options1.isNotEmpty ? options1[0] : "", options1.length>1 ? options1[1] : ""],
      //     [options1.length>2 ? options1[2] : "", options1.length>3 ? options1[3] : ""],
      //     [options1.length>4 ? options1[4] : "", options1.length>5 ? options1[5] : ""],
      //   ],
      //   correctMessage: correctMessages.isNotEmpty ? correctMessages[0] : "",
      // ),
      // // ...
      // // Build out the other question pages similarly
      // ResultPage(),
    ];
    isControllerLoading.value = false;
  }
}
