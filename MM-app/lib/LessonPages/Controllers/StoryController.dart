import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Services/lessonData.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/ComponentImapctPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/MonkeyIntroPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/ComponentProblemPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/ComponentSolutionsPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/MonkeyLandingPage.dart';

class StoryController extends GetxController {

  RxInt pageIndex = 0.obs;
  RxBool toSolution = false.obs;
  RxBool toImpact = false.obs;

  var pages = <Widget>[
    MonkeyLandingPage(),
    MonkeyIntroPage(),
    ComponentProblemPage(),
    ComponentSolutionsPage(),
    ComponentImapctPage(),
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

      pageData[i] = data;
        }
  } catch (e) {
    print("Error fetching page data: $e");
  } finally {
    isLoading.value = false;
    print(pageData);
  }
}

}
