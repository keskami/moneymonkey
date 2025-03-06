// scenario_controller.dart

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Models/SubComponentModel.dart';
import 'package:money_monkey/Backend/Services/academics_service.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';
import 'package:money_monkey/LessonPages/Services/lesson_services.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/GraphicalResultPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/MonkeyMCQPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/TapToRevealPictorialPage.dart';

class ScenarioController extends BaseLessonController {
  final LocalAcademicService localAcademicService = LocalAcademicService();
  final String componentId;

  ScenarioController({required this.componentId});

  RxInt pageIndex = 0.obs;
  RxInt responsibilityScore = 0.obs;
  RxBool isLoading = true.obs;

  RxList<SubComponent> pageData = <SubComponent>[].obs;
  var controllerData = <int, dynamic>{}.obs;

  // Data needed for question logic
  List<List<String>> options = [];
  String question = "";
  Map<String, String> correctMessages = {};
  Map<String, int> scores = {};

  // UI pages
  List<Widget> pages = [];
  List<Widget> mcqPages = [];

  @override
  void onInit() {
    super.onInit();
    loadScenarioData();
  }

  Future<void> loadScenarioData() async {
    try {
      final Component data =
          await localAcademicService.getComponent(componentId);
      for (int i = 0; i < data.questionData.length; i++) {
        pageData.add(data.questionData[i]);

        if (pageData[i].type == SubComponentType.scenarioquestion) {
          for (int k = 0; k < pageData[i].data.length; k++) {
            ScenarioQuestion data = pageData[i].data[k];
            question = data.questionText;
            String title1 = data.options[0].title;
            String title2 = data.options[1].title;
            String title3 = data.options[2].title;
            options = [
              [title1, data.options[0].iconUrl],
              [title2, data.options[1].iconUrl],
              [title3, data.options[2].iconUrl]
            ];
            correctMessages = {
              title1: data.feedback[title1] ?? "",
              title2: data.feedback[title2] ?? "",
              title3: data.feedback[title3] ?? ""
            };
            scores = {
              title1: data.options[0].score,
              title2: data.options[1].score,
              title3: data.options[2].score
            };
            mcqPages.add(MonkeyMCQPage(
                question: question,
                options: options,
                correctMessages: correctMessages,
                scores: scores));
          }
        }
      }

      // add data to pages
      pages.add(TapToRevealPictorialPage());
      pages.addAll(mcqPages);
      pages.add(GraphicalResultPage());
    } catch (e) {
      print("Error fetching scenario data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
