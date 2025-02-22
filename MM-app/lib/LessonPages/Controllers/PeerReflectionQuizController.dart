// peer_reflection_quiz_controller.dart

import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Services/academics_service.dart';
import 'package:money_monkey/LessonPages/Services/lesson_services.dart';
import 'package:money_monkey/LessonPages/PeerReflection/QuizPages/page1.dart';
import 'package:money_monkey/LessonPages/PeerReflection/QuizPages/page2.dart';
import 'package:money_monkey/LessonPages/PeerReflection/QuizPages/page3.dart';
import 'package:money_monkey/LessonPages/PeerReflection/QuizPages/page4.dart';
import 'package:money_monkey/LessonPages/PeerReflection/QuizPages/page5.dart';

class PeerReflectionQuizcontroller extends GetxController {
  final LocalAcademicService localAcademicService = LocalAcademicService();
  final String componentId;

  PeerReflectionQuizcontroller({required this.componentId});

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
      final Component data = await localAcademicService.getComponent(componentId);
      for (int i = 0; i < data.questionData.length; i++) {
        pageData[i] = data.questionData[i];
      }
    } catch (e) {
      print("Error fetching quiz data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
