// peer_reflection_controller.dart

import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Services/academics_service.dart';
import 'package:money_monkey/LessonPages/PeerReflection/page4.dart';
import 'package:money_monkey/LessonPages/Services/lesson_services.dart';

class PeerReflectioncontroller extends GetxController {
  final LocalAcademicService localAcademicService = LocalAcademicService();
  final String componentId;

  PeerReflectioncontroller({required this.componentId});

  final LessonServices lessonServices = Get.find<LessonServices>();

  RxInt pageIndex = 0.obs;
  RxBool isLoading = true.obs;

  var pageData = <int, dynamic>{}.obs;

  // UI pages
  final pages = [
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
        pageData[i] = data.questionData[i];
      }
    } catch (e) {
      print("Error fetching peerReflection data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
