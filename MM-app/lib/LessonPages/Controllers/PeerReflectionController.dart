// peer_reflection_controller.dart

import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Services/academics_service.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';
import 'package:money_monkey/LessonPages/Models/Models.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/DragNDropQuestionPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/page4.dart';
import 'package:money_monkey/LessonPages/Services/lesson_services.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/ImagesIntroPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/TapToExpandPage.dart';

class PeerReflectioncontroller extends BaseLessonController {
  final LocalAcademicService localAcademicService = LocalAcademicService();
  final String componentId;

  PeerReflectioncontroller({required this.componentId});

  RxInt pageIndex = 0.obs;
  RxBool isLoading = true.obs;

  RxList<Question> pageData = <Question>[].obs;

  // UI pages
  final pages = [
    ImagesIntroPage(),
    TapToExpandPage(),
    DragNDropQuestionPage(),
    Page4()
  ];

  @override
  void onInit() {
    super.onInit();
    loadPeerReflectionData();
  }

  Future<void> loadPeerReflectionData() async {
    try {
      final Component data = await localAcademicService.getComponent(componentId);
      for (int i = 0; i < data.questionData.length; i++) {
        pageData.add(data.questionData[i]);
      }
    } catch (e) {
      print("Error fetching peerReflection data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
