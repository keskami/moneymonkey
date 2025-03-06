import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Models/SubComponentModel.dart';
import 'package:money_monkey/Backend/Services/academics_service.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/ComponentTakeawaysPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/LearningCheckPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/MCQPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/ScenarioPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/TapToRevealIconsPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/TapToRevealPage.dart';

class ComponentOneTwoController extends BaseLessonController {
  final LocalAcademicService localAcademicService = LocalAcademicService();
  final String componentId;

  ComponentOneTwoController({required this.componentId});

  // Pages:
  RxInt pageIndex = 0.obs;

  RxList<SubComponent> pageData = <SubComponent>[].obs;

  // The UI pages to show in order
  List<Widget> pages = [
  ];

  List<Widget> scenarioPages = [];

  @override
  void onInit() {
    super.onInit();
    loadConceptData();
  }

  Future<void> loadConceptData() async {
    try {
      final Component data =
          await localAcademicService.getComponent(componentId);
      for (int i = 0; i < data.questionData.length; i++) {
        pageData.add(data.questionData[i]);
        if (pageData[i].type == SubComponentType.scenario) {
          for (int j = 0; j < pageData[i].data.questions.length; j++) {
            MultipleChoice question = pageData[i].data.questions[j];

            scenarioPages.add(ScenarioPage(
                title: pageData[i].data.title,
                subTitle: pageData[i].data.scenarioExplanation,
                wrong: question.prompts.incorrect,
                correct: question.prompts.correct,
                containerHeading: question.questionHeading,
                containerSubHeading: question.question,
                options: question.options,
                correctAnswer: question.correctAnswers[0],
                componentId: componentId));
          }
        }
      }

      pages.add(MCQPage(componentId: componentId));
      pages.add(TapToRevealPage(componentId: componentId));
      pages.add(TapToRevealIconsPage(componentId: componentId));
      pages.addAll(scenarioPages);
      pages.add(LearningCheckPage(componentId: componentId));
      pages.add(ComponentTakeawaysPage(componentId: componentId));

    } catch (e) {
      print("Error loading concept data: $e");
    } finally {
      isLoading.value = false; // using the inherited property
    }
  }
}
