// lesson_repositories.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_monkey/Backend/Models/lesson_model.dart';

class LessonRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Example: fetch entire "Concept" (or "Story", etc.) doc,
  /// then parse out its pages into a map<int, dynamic>.

  Future<List<Map<String, dynamic>>> fetchLessonsForUnit({
    required String levelName,
    required int unitNumber,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection('Levels')
          .doc(levelName)
          .collection('Units')
          .doc('Unit_$unitNumber')
          .collection('Lessons')
          .orderBy('lessonNumber')
          .get();

      // Convert each doc to a map with doc fields
      List<Map<String, dynamic>> lessons = [];
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        // e.g. data contains {'lessonName':..., 'lessonNumber':...}
        lessons.add(data);
      }
      return lessons;
    } catch (e) {
      print("Error in fetchLessonsForUnit: $e");
      return [];
    }
  }

  Future<Map<int, dynamic>> fetchComponentPages({
    required String levelName,
    required int unitNumber,
    required int lessonNumber,
    required String componentType,
  }) async {
    try {
      // e.g. "Advanced" -> "Unit_1" -> "Lesson_1" -> "Components" -> "Concept"
      final docRef = _firestore
          .collection('Levels')
          .doc(levelName)
          .collection('Units')
          .doc('Unit_$unitNumber')
          .collection('Lessons')
          .doc('Lesson_$lessonNumber')
          .collection('Components')
          .doc(componentType);

      final docSnapshot = await docRef.get();
      if (!docSnapshot.exists) {
        return {};
      }

      final data = docSnapshot.data() as Map<String, dynamic>;
      // For example, concept doc might have 'conceptPage_1', 'conceptPage_2', ...
      // We'll create a map of pageNumber -> pageData
      Map<int, dynamic> pagesMap = {};

      // Iterate over each key in the doc (like "conceptPage_1"), parse the integer index.
      data.forEach((key, value) {
        // key might be "conceptPage_1" -> we parse out "1"
        final parts = key.split('_'); // ["conceptPage", "1"]
        if (parts.length >= 2) {
          final pageNum = int.tryParse(parts[1]) ?? 0;
          pagesMap[pageNum] = value;
        }
      });

      return pagesMap;
    } catch (e) {
      print("Error in fetchComponentPages($componentType): $e");
      return {};
    }
  }

  /// Optionally, fetch the top-level lesson doc to get "lessonName", "lessonNumber"...
  Future<Map<String, dynamic>> fetchLessonDoc({
    required String levelName,
    required int unitNumber,
    required int lessonNumber,
  }) async {
    try {
      final docRef = _firestore
          .collection('Levels')
          .doc(levelName)
          .collection('Units')
          .doc('Unit_$unitNumber')
          .collection('Lessons')
          .doc('Lesson_$lessonNumber');

      final snapshot = await docRef.get();
      if (!snapshot.exists) {
        return {};
      }
      return snapshot.data() ?? {};
    } catch (e) {
      print("Error in fetchLessonDoc: $e");
      return {};
    }
  }

  /// Example: Create a "LessonModel" from Firestore data
  Future<LessonModel> getFullLessonModel({
    required String levelName,
    required int unitNumber,
    required int lessonNumber,
  }) async {
    // 1) fetch top-level lesson doc
    final lessonData = await fetchLessonDoc(
      levelName: levelName,
      unitNumber: unitNumber,
      lessonNumber: lessonNumber,
    );
    final lessonName = lessonData['lessonName'] ?? 'Untitled Lesson';
    final ln = lessonData['lessonNumber'] ?? lessonNumber;

    // 2) fetch all major components
    final conceptMap = await fetchComponentPages(
      levelName: levelName,
      unitNumber: unitNumber,
      lessonNumber: lessonNumber,
      componentType: 'Concept',
    );
    final concept2Map = await fetchComponentPages(
      levelName: levelName,
      unitNumber: unitNumber,
      lessonNumber: lessonNumber,
      componentType: 'Concept2',
    );
    final storyMap = await fetchComponentPages(
      levelName: levelName,
      unitNumber: unitNumber,
      lessonNumber: lessonNumber,
      componentType: 'Story',
    );
    final scenarioMap = await fetchComponentPages(
      levelName: levelName,
      unitNumber: unitNumber,
      lessonNumber: lessonNumber,
      componentType: 'Scenario',
    );
    final peerReflectionMap = await fetchComponentPages(
      levelName: levelName,
      unitNumber: unitNumber,
      lessonNumber: lessonNumber,
      componentType: 'PeerReflection',
    );
    final quizMap = await fetchComponentPages(
      levelName: levelName,
      unitNumber: unitNumber,
      lessonNumber: lessonNumber,
      componentType: 'Quiz',
    );

    // 3) Build and return the LessonModel
    return LessonModel(
      lessonName: lessonName,
      lessonNumber: ln,
      conceptPages: conceptMap,
      concept2Pages: concept2Map,
      storyPages: storyMap,
      scenarioPages: scenarioMap,
      peerReflectionPages: peerReflectionMap,
      quizPages: quizMap,
    );
  }
}
