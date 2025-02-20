// peer_reflection_controller.dart

import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/PeerReflection/page4.dart';
import 'package:money_monkey/LessonPages/Services/lesson_services.dart';

class PeerReflectioncontroller extends GetxController {
  final int lessonNumber;
  final int unitNumber;

  PeerReflectioncontroller({required this.unitNumber, required this.lessonNumber});

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
      for (int i = 1; i <= 5; i++) {
        final data = await lessonServices.loadSinglePageData(
          levelName: "Advanced",
          unitNumber: unitNumber,
          lessonNumber: lessonNumber,
          componentType: "PeerReflection",
          pageNumber: i,
        );
        pageData[i] = data;
      }
    } catch (e) {
      print("Error fetching peerReflection data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
