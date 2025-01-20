import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Services/lessonData.dart';
import 'package:money_monkey/LessonPages/Pages_Story/ImpactPage.dart';
import 'package:money_monkey/LessonPages/Pages_Story/IntroPage.dart';
import 'package:money_monkey/LessonPages/Pages_Story/ProblemPage.dart';
import 'package:money_monkey/LessonPages/Pages_Story/SolutionPage.dart';
import 'package:money_monkey/LessonPages/Pages_Story/newlanding.dart';

class StoryController extends GetxController {

  RxInt pageIndex = 0.obs;
  RxBool toSolution = false.obs;
  RxBool toImpact = false.obs;

  var pages = <Widget>[
    NewStoryLanding(),
    IntroPage(),
    ProblemPage(),
    SolutionPage(),
    ImpactPage(),
  ];


  var pageData = <int, dynamic>{}.obs;
  final LessonData lessonData = LessonData();
  RxBool isLoading = true.obs;
  

  @override
  void onInit() {
    super.onInit();
    fetchPageData();
  }

  Future<void> fetchPageData() async {
  try {
    for (int i = 1; i <= 5; i++) {
      var data = await lessonData.getPageInfoFromFirestore(
        levelName: "Advanced",
        UnitNumber: 1,
        LessonNumber: 1,
        TypeOfLesson: "Story",
        PageNumber: i,
      );

      if (data != null && data is Map<String, dynamic>) {
        pageData[i] = data;
      } else {
        print("Page $i data is null or invalid.");
        pageData[i] = {}; // Set a default empty map to avoid errors
      }
    }
  } catch (e) {
    print("Error fetching page data: $e");
  } finally {
    isLoading.value = false;
    print(pageData);
  }
}

}
