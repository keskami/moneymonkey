// peer_reflection_quiz_controller.dart

import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Services/lesson_services.dart';
import 'package:money_monkey/LessonPages/PeerReflection/QuizPages/page1.dart';
import 'package:money_monkey/LessonPages/PeerReflection/QuizPages/page2.dart';
import 'package:money_monkey/LessonPages/PeerReflection/QuizPages/page3.dart';
import 'package:money_monkey/LessonPages/PeerReflection/QuizPages/page4.dart';
import 'package:money_monkey/LessonPages/PeerReflection/QuizPages/page5.dart';

class PeerReflectionQuizcontroller extends GetxController {
  final int lessonNumber;
  final int unitNumber;

  PeerReflectionQuizcontroller({required this.unitNumber, required this.lessonNumber});

  final LessonServices lessonServices = Get.find<LessonServices>();

  RxInt pageIndex = 0.obs;
  RxBool isLoading = true.obs;

  var pageData = <int, dynamic>{}.obs;

  final pages = [
    PeerReflectionQuizPage1(),
    PeerReflectionQuizPage2(),
    PeerReflectionQuizPage3(),
    PeerReflectionQuizPage4(),
    PeerReflectionQuizPage5(),
  ];

  @override
  void onInit() {
    super.onInit();
    loadQuizData();
  }

  Future<void> loadQuizData() async {
    try {
      for (int i = 1; i <= 5; i++) {
        final data = await lessonServices.loadSinglePageData(
          levelName: "Advanced",
          unitNumber: unitNumber,
          lessonNumber: lessonNumber,
          componentType: "Quiz",
          pageNumber: i,
        );
        pageData[i] = data;
      }
    } catch (e) {
      print("QUIZ Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
