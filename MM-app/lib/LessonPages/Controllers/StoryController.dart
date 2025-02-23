// story_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Services/academics_service.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';
import 'package:money_monkey/LessonPages/Models/Models.dart';
import 'package:money_monkey/LessonPages/Services/lesson_services.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/ComponentImapctPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/ComponentProblemPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/ComponentSolutionsPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/MonkeyIntroPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/MonkeyLandingPage.dart';

class StoryController extends BaseLessonController {
  final LocalAcademicService localAcademicService = LocalAcademicService();
  final String componentId;

  StoryController({required this.componentId});

  final LessonServices lessonServices = Get.find<LessonServices>();

  RxInt pageIndex = 0.obs;
  RxBool toSolution = false.obs;
  RxBool toImpact = false.obs;
  RxBool isLoading = true.obs;

  // UI pages
  final pages = <Widget>[
    MonkeyLandingPage(),
    MonkeyIntroPage(),
    ComponentProblemPage(),
    ComponentSolutionsPage(),
    ComponentImapctPage(),
  ];

  RxList<Question> pageData = <Question>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadStoryData();
  }

  Future<void> loadStoryData() async {
    try {
      final Component data =
          await localAcademicService.getComponent(componentId);
      for (int i = 0; i < data.questionData.length; i++) {
        pageData[i] = data.questionData[i];
      }
    } catch (e) {
      print("Error fetching story data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
