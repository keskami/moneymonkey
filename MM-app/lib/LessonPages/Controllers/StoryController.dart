// story_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Services/lesson_services.dart';
import 'package:money_monkey/LessonPages/Pages_Story/ImpactPage.dart';
import 'package:money_monkey/LessonPages/Pages_Story/IntroPage.dart';
import 'package:money_monkey/LessonPages/Pages_Story/ProblemPage.dart';
import 'package:money_monkey/LessonPages/Pages_Story/SolutionPage.dart';
import 'package:money_monkey/LessonPages/Pages_Story/newlanding.dart';

class StoryController extends GetxController {
  final int lessonNumber;
  final int unitNumber;

  StoryController({required this.unitNumber, required this.lessonNumber});

  final LessonServices lessonServices = Get.find<LessonServices>();

  RxInt pageIndex = 0.obs;
  RxBool toSolution = false.obs;
  RxBool toImpact = false.obs;
  RxBool isLoading = true.obs;

  // UI pages
  final pages = <Widget>[
    NewStoryLanding(),
    IntroPage(),
    ProblemPage(),
    SolutionPage(),
    ImpactPage(),
  ];

  var pageData = <int, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadStoryData();
  }

  Future<void> loadStoryData() async {
    try {
      // For pages 1..5
      for (int i = 1; i <= 5; i++) {
        final data = await lessonServices.loadSinglePageData(
          levelName: "Advanced",
          unitNumber: unitNumber,
          lessonNumber: lessonNumber,
          componentType: "Story",
          pageNumber: i,
        );
        pageData[i] = (data is Map<String, dynamic>) ? data : {};
      }
    } catch (e) {
      print("Error fetching story data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
