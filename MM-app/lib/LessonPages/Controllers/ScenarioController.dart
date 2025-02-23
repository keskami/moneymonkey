// scenario_controller.dart

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Services/academics_service.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';
import 'package:money_monkey/LessonPages/Models/Models.dart';
import 'package:money_monkey/LessonPages/Services/lesson_services.dart';

class ScenarioController extends BaseLessonController {
  final LocalAcademicService localAcademicService = LocalAcademicService();
  final String componentId;

  ScenarioController({required this.componentId});

  final LessonServices lessonServices = Get.find<LessonServices>();

  RxInt pageIndex = 0.obs;
  RxDouble responsibilityScore = 0.0.obs;
  RxBool isLoading = true.obs;

  RxList<Question> pageData = <Question>[].obs;
  var controllerData = <int, dynamic>{}.obs;

  // Data needed for question logic
  List<String> answers = [];
  List<String> options1 = [];
  List<String> options2 = [];
  List<String> options3 = [];
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
      final Component data =
          await localAcademicService.getComponent(componentId);
      for (int i = 0; i < data.questionData.length; i++) {
        pageData[i] = data.questionData[i];
      }
    } catch (e) {
      print("Error fetching scenario data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
