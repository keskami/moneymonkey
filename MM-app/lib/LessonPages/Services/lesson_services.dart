// lesson_services.dart

import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/LessonModel.dart';
import 'package:money_monkey/LessonPages/Repositories/lesson_repository.dart';

class LessonServices extends GetxService {
  final LessonRepository lessonRepository = LessonRepository();

  Future<List<Map<String, dynamic>>> loadLessonsForUnit({
    required String levelName,
    required int unitNumber,
  }) async {
    return lessonRepository.fetchLessonsForUnit(
      levelName: levelName,
      unitNumber: unitNumber,
    );
  }

  /// Example: load a single page from a component
  Future<Map<String, dynamic>> loadSinglePageData({
    required String levelName,
    required int unitNumber,
    required int lessonNumber,
    required String componentType,
    required int pageNumber,
  }) async {
    // get the entire component doc as a map
    final pagesMap = await lessonRepository.fetchComponentPages(
      levelName: levelName,
      unitNumber: unitNumber,
      lessonNumber: lessonNumber,
      componentType: componentType,
    );
    // Return the requested page
    return pagesMap[pageNumber] ?? {};
  }

  /// Example: load an entire LessonModel (including all components)
  Future<LessonModel> loadFullLesson({
    required String levelName,
    required int unitNumber,
    required int lessonNumber,
  }) async {
    return lessonRepository.getFullLessonModel(
      levelName: levelName,
      unitNumber: unitNumber,
      lessonNumber: lessonNumber,
    );
  }

  /// If you want separate helpers for "Concept" pages vs. "Story", do so:
  Future<Map<int, dynamic>> loadConceptPages({
    required String levelName,
    required int unitNumber,
    required int lessonNumber,
  }) async {
    return lessonRepository.fetchComponentPages(
      levelName: levelName,
      unitNumber: unitNumber,
      lessonNumber: lessonNumber,
      componentType: 'Concept',
    );
  }

  // ... Similarly for Story, Scenario, etc.
}
