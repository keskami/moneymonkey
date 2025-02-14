// component_one_two_controller.dart

import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Models/Question_Model.dart';
import 'package:money_monkey/LessonPages/Pages_ConceptOneTwo/1MCQPage.dart';
import 'package:money_monkey/LessonPages/Pages_ConceptOneTwo/2RevealPage.dart';
import 'package:money_monkey/LessonPages/Pages_ConceptOneTwo/3IconRevealPage.dart';
import 'package:money_monkey/LessonPages/Pages_ConceptOneTwo/4ScenarioPage.dart';
import 'package:money_monkey/LessonPages/Pages_ConceptOneTwo/Page5.dart';
import 'package:money_monkey/LessonPages/Pages_ConceptOneTwo/Page6.dart';
import 'package:money_monkey/LessonPages/Pages_ConceptOneTwo/5QuizkCheckPage.dart';
import 'package:money_monkey/LessonPages/Pages_ConceptOneTwo/6TakeawayPage.dart';
import 'package:money_monkey/LessonPages/Pages_ConceptOneTwo/Page7.dart';

import 'package:money_monkey/LessonPages/Models/lesson_model.dart';
import 'package:money_monkey/LessonPages/Services/lesson_services.dart';

class ComponentOneTwoController extends GetxController {
  final int lessonNumber;
  final int unitNumber;
  final int conceptNumber; // 1 => "Concept", 2 => "Concept2" perhaps

  ComponentOneTwoController({
    required this.lessonNumber,
    required this.unitNumber,
    required this.conceptNumber,
  });

  // Pages:
  RxInt pageIndex = 0.obs;
  RxBool isLoading = true.obs;

  // If you want to store the page data
  var pageData = <int, dynamic>{}.obs;

  // Optional: store fetched questions in a list
  RxList<Question> questions = <Question>[].obs;

  // The UI pages to show in order
  final pages = [
    MCQPage(),
    RevealPage(),
    IconRevealPage(),
    ScenarioPage(),
    L1Page5(),
    L1Page6(),
    L1Page7(),
    QuickCheckPage(),
    TakeawayPage(),
  ];

  final LessonServices lessonServices = Get.find<LessonServices>();

  @override
  void onInit() {
    super.onInit();
    loadConceptData();
  }

  Future<void> loadConceptData() async {
    try {
      // For each page i in [1..9], fetch from "Concept" or "Concept2"
      final String componentType = (conceptNumber == 1) ? 'Concept' : 'Concept2';

      for (int i = 1; i <= 9; i++) {
        final data = await lessonServices.loadSinglePageData(
          levelName: "Advanced",
          unitNumber: unitNumber,
          lessonNumber: lessonNumber,
          componentType: componentType,
          pageNumber: i,
        );
        pageData[i] = data;
      }
    } catch (e) {
      print("Error loading concept data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
