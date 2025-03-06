import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Models/SubComponentModel.dart';
import 'package:money_monkey/Backend/Services/academics_service.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/ComponentImapctPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/ComponentProblemPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/ComponentSolutionsPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/MonkeyLandingPage.dart';

class StoryController extends BaseLessonController {
  final LocalAcademicService localAcademicService = LocalAcademicService();
  final String componentId;

  StoryController({required this.componentId});

  RxInt pageIndex = 0.obs;
  RxBool toSolution = false.obs;
  RxBool toImpact = false.obs;
  RxBool isLoading = true.obs;

  String introText = "";
  String imageURL = "";

  // UI pages
  RxList pages = [].obs;

  RxList<SubComponent> pageData = <SubComponent>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadStoryData();
  }

  Future<void> loadStoryData() async {
    try {
      print("ComponentID" + componentId);
      final Component data =
          await localAcademicService.getComponent(componentId);
      for (int i = 0; i < data.questionData.length; i++) {
        pageData.add(data.questionData[i]);
      }

      // add pages
      pages.add(MonkeyLandingPage(
          introText: pageData[0].data.mintyText,
          imageURL: pageData[0].data.imageUrl,
          title: pageData[0].data.title));
      pages.add(ComponentProblemPage());
      pages.add(ComponentSolutionsPage());
      pages.add(ComponentImpactPage());
    } catch (e) {
      print("Error fetching story data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
