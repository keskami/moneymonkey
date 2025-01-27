import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Services/lessonData.dart';
import 'package:money_monkey/LessonPages/ScenarioPages/IntroductionPage.dart';
import 'package:money_monkey/LessonPages/ScenarioPages/QuestionPage.dart';
import 'package:money_monkey/LessonPages/ScenarioPages/ResultPage.dart';

class ScenarioController extends GetxController {
  RxInt pageIndex = 0.obs;
  RxDouble responsibilityScore = 0.0.obs;
  var pageData = <int, dynamic>{}.obs;
  var controllerData = <int, dynamic>{}.obs;
  final LessonData lessonData = LessonData();
  RxBool isLoading = true.obs;
  RxBool isControllerLoading = true.obs;
  List<String> answers = [];
  List<String> options1= [];
  List<String> options2= [];
  List<String> options3= [];
  
  List<String> questions = [];
  List<String> correctMessages = [];
  List<Widget> pages = [];
  Future<void> getControllerData() async {
    try {
      var data = await lessonData.getPageInfoFromFirestore(
        levelName: "Advanced",
        UnitNumber: 1,
        LessonNumber: 1,
        TypeOfLesson: "Scenario",
        PageNumber: 0,
      );
      print(data);

      if (data != null && data is Map<String, dynamic>) {
        answers = List<String>.from(data["correctAnswers"]);
        questions = List<String>.from(data["questions"] );
        options1 = List<String>.from(data["options1"] );
        options2 = List<String>.from(data["options2"] );
        options3 = List<String>.from(data["options3"] );
        questions = List<String>.from(data["questions"] );
        correctMessages = List<String>.from(data["correctMessages"] );
      } else {
        print("Data format is unexpected or null.");
      }
    } catch (e) {
      print("Error fetching page data: $e");
    } finally {
      
    }
  }

  Future<void> fetchPageData() async {
    try {
      for (int i = 1; i <= 4; i++) {
        var data = await lessonData.getPageInfoFromFirestore(
          levelName: "Advanced",
          UnitNumber: 1,
          LessonNumber: 1,
          TypeOfLesson: "Scenario",
          PageNumber: i,
        );

        pageData[i] = data;
      }
    } catch (e) {
      print("Error fetching page data: $e");
    } finally {
      isLoading.value = false;
      
    }
  }

  void initializePages() {
    pages = [
      IntroductionPage(),
      QuestionPage(
        question:  questions[0] ,
        correctAns:  answers[0] ,
        options: [
          [options1[0], options1[1]],
          [options1[2], options1[3]],
          [options1[4], options1[5]],
        ],
        correctMessage: correctMessages[0]
            ,
      ),
      QuestionPage(
        question:  questions[1] ,
        correctAns:  answers[1] ,
        options: [
          [options2[0], options2[1]],
          [options2[2], options2[3]],
          [options2[4], options2[5]],
        ],
        correctMessage: correctMessages[1]
            ,
      ),
      QuestionPage(
        question:  questions[2] ,
        correctAns:  answers[2] ,
        options: [
          [options3[0], options3[1]],
          [options3[2], options3[3]],
          [options3[4], options3[5]],
        ],
        correctMessage: correctMessages[2]
            ,
      ),
      ResultPage(),
    ];
    isControllerLoading.value = false;
  }

  @override
  void onInit() async {
    super.onInit();
    await fetchPageData(); 
    await getControllerData(); 
    initializePages();
    
  }

  
}

