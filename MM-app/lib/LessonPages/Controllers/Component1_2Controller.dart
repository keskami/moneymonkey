import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Models/QuestionsModel.dart';
import 'package:money_monkey/Backend/Services/academics_service.dart';
import 'package:money_monkey/LessonPages/Models/Models.dart';
import 'package:money_monkey/LessonPages/Pages_ConceptOneTwo/Page5.dart';
import 'package:money_monkey/LessonPages/Pages_ConceptOneTwo/Page6.dart';
import 'package:money_monkey/LessonPages/Pages_ConceptOneTwo/Page7.dart';
import 'package:money_monkey/LessonPages/Services/lesson_services.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/ComponentTakeawaysPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/LearningCheckPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/MCQPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/ScenarioPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/TapToRevealIconsPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/TapToRevealPage.dart';

class ComponentOneTwoController extends GetxController {
  final LocalAcademicService localAcademicService = LocalAcademicService();
  final String componentId;

  ComponentOneTwoController({required this.componentId});

  // Pages:
  RxInt pageIndex = 0.obs;
  RxBool isLoading = true.obs;

  List<Question> pageData = [];

  // Optional: store fetched questions in a list
  RxList<SubComponent> questions = <SubComponent>[].obs;

  // The UI pages to show in order
  final pages = [
    MCQPage(),
    TapToRevealPage(),
    TapToRevealIconsPage(),
    ScenarioPage(),
    L1Page5(),
    L1Page6(),
    L1Page7(),
    LearningCheckPage(),
    ComponentTakeawaysPage(),
  ];

  @override
  void onInit() {
    super.onInit();
    loadConceptData();
  }

  Future<void> loadConceptData() async {
    try {
      final Component data = await localAcademicService.getComponent(componentId);
      for (int i = 0; i < data.questionData.length; i++) {
        pageData.add(data.questionData[i]);
        print(pageData[i].data.toString());
      }
    } catch (e) {
      print("Error loading concept data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
