// lessons_home_controller.dart

import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Services/lesson_services.dart';

class LessonsHomeController extends GetxController {
  final String levelName;
  final int unitNumber;

  LessonsHomeController({required this.levelName, required this.unitNumber});

  final LessonServices lessonServices = Get.find<LessonServices>();

  // We'll store the list of lessons as a list of Maps:
  // Each map = {'lessonName': '...', 'lessonNumber': ...}
  RxList<Map<String, dynamic>> lessons = <Map<String, dynamic>>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadLessons();
  }

  Future<void> loadLessons() async {
    try {
      isLoading.value = true;
      final results = await lessonServices.loadLessonsForUnit(
        levelName: levelName,
        unitNumber: unitNumber,
      );
      lessons.assignAll(results); // update our RxList
    } catch (e) {
      print("Error loading lessons: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
