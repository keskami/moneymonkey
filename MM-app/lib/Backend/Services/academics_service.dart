import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Base collections
  CollectionReference get _difficulties =>
      _firestore.collection('difficulties');
  CollectionReference get _classrooms => _firestore.collection('classrooms');

  // Nested collection references
  CollectionReference _unitsCollection(String difficultyId) =>
      _difficulties.doc(difficultyId).collection('units');

  CollectionReference _lessonsCollection(String difficultyId, String unitId) =>
      _difficulties
          .doc(difficultyId)
          .collection('units')
          .doc(unitId)
          .collection('lessons');

  CollectionReference _componentsCollection(
          String difficultyId, String unitId, String lessonId) =>
      _difficulties
          .doc(difficultyId)
          .collection('units')
          .doc(unitId)
          .collection('lessons')
          .doc(lessonId)
          .collection('components');

  CollectionReference _lessonResourcesCollection(
          String difficultyId, String unitId, String lessonId) =>
      _difficulties
          .doc(difficultyId)
          .collection('units')
          .doc(unitId)
          .collection('lessons')
          .doc(lessonId)
          .collection('lessonResources');

  // Difficulty methods
  Future<List<String>> getDifficulties() async {
    try {
      QuerySnapshot snapshot = await _difficulties.get();
      return snapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      print('Error fetching difficulties: $e');
      rethrow;
    }
  }

  // Unit methods
  Future<List<Unit>> getUnits(String difficultyId) async {
    try {
      QuerySnapshot snapshot = await _unitsCollection(difficultyId).get();
      return snapshot.docs
          .map((doc) =>
              Unit.fromFirestore(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print('Error fetching units: $e');
      rethrow;
    }
  }

  Future<Unit?> getUnit(String difficultyId, String unitId) async {
    try {
      DocumentSnapshot doc =
          await _unitsCollection(difficultyId).doc(unitId).get();
      if (!doc.exists) return null;
      return Unit.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
    } catch (e) {
      print('Error fetching unit: $e');
      rethrow;
    }
  }

  Future<void> createUnit(String difficultyId, Unit unit) async {
    try {
      await _unitsCollection(difficultyId)
          .doc(unit.unitId)
          .set(unit.toFirestore());
    } catch (e) {
      print('Error creating unit: $e');
      rethrow;
    }
  }

  Future<void> updateUnit(String difficultyId, Unit unit) async {
    try {
      await _unitsCollection(difficultyId)
          .doc(unit.unitId)
          .update(unit.toFirestore());
    } catch (e) {
      print('Error updating unit: $e');
      rethrow;
    }
  }

  Future<void> deleteUnit(String difficultyId, String unitId) async {
    try {
      await _unitsCollection(difficultyId).doc(unitId).delete();
    } catch (e) {
      print('Error deleting unit: $e');
      rethrow;
    }
  }

  // Lesson methods
  Future<List<Lesson>> getLessons(String difficultyId, String unitId) async {
    try {
      QuerySnapshot snapshot =
          await _lessonsCollection(difficultyId, unitId).get();
      return snapshot.docs
          .map((doc) =>
              Lesson.fromFirestore(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print('Error fetching lessons: $e');
      rethrow;
    }
  }

  Future<Lesson?> getLesson(
      String difficultyId, String unitId, String lessonId) async {
    try {
      DocumentSnapshot doc =
          await _lessonsCollection(difficultyId, unitId).doc(lessonId).get();
      if (!doc.exists) return null;
      return Lesson.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
    } catch (e) {
      print('Error fetching lesson: $e');
      rethrow;
    }
  }

  Future<void> createLesson(
      String difficultyId, String unitId, Lesson lesson) async {
    try {
      await _lessonsCollection(difficultyId, unitId)
          .doc(lesson.lessonId)
          .set(lesson.toFirestore());
    } catch (e) {
      print('Error creating lesson: $e');
      rethrow;
    }
  }

  Future<void> updateLesson(
      String difficultyId, String unitId, Lesson lesson) async {
    try {
      await _lessonsCollection(difficultyId, unitId)
          .doc(lesson.lessonId)
          .update(lesson.toFirestore());
    } catch (e) {
      print('Error updating lesson: $e');
      rethrow;
    }
  }

  Future<void> deleteLesson(
      String difficultyId, String unitId, String lessonId) async {
    try {
      await _lessonsCollection(difficultyId, unitId).doc(lessonId).delete();
    } catch (e) {
      print('Error deleting lesson: $e');
      rethrow;
    }
  }

  // Component methods
  Future<List<Component>> getComponents(
      String difficultyId, String unitId, String lessonId) async {
    try {
      QuerySnapshot snapshot =
          await _componentsCollection(difficultyId, unitId, lessonId).get();
      return snapshot.docs
          .map((doc) => Component.fromFirestore(
              doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print('Error fetching components: $e');
      rethrow;
    }
  }

  Future<Component?> getComponent(String difficultyId, String unitId,
      String lessonId, String componentId) async {
    try {
      DocumentSnapshot doc =
          await _componentsCollection(difficultyId, unitId, lessonId)
              .doc(componentId)
              .get();
      if (!doc.exists) return null;
      return Component.fromFirestore(
          doc.data() as Map<String, dynamic>, doc.id);
    } catch (e) {
      print('Error fetching component: $e');
      rethrow;
    }
  }

  Future<void> createComponent(String difficultyId, String unitId,
      String lessonId, Component component) async {
    try {
      await _componentsCollection(difficultyId, unitId, lessonId)
          .doc(component.componentId)
          .set(component.toFirestore());
    } catch (e) {
      print('Error creating component: $e');
      rethrow;
    }
  }

  Future<void> updateComponent(String difficultyId, String unitId,
      String lessonId, Component component) async {
    try {
      await _componentsCollection(difficultyId, unitId, lessonId)
          .doc(component.componentId)
          .update(component.toFirestore());
    } catch (e) {
      print('Error updating component: $e');
      rethrow;
    }
  }

  Future<void> deleteComponent(String difficultyId, String unitId,
      String lessonId, String componentId) async {
    try {
      await _componentsCollection(difficultyId, unitId, lessonId)
          .doc(componentId)
          .delete();
    } catch (e) {
      print('Error deleting component: $e');
      rethrow;
    }
  }

  // Classroom methods (remaining at root level)
  Future<List<Classroom>> getClassrooms() async {
    try {
      QuerySnapshot snapshot = await _classrooms.get();
      return snapshot.docs
          .map((doc) => Classroom.fromFirestore(
              doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print('Error fetching classrooms: $e');
      rethrow;
    }
  }

  Future<Classroom?> getClassroom(String classId) async {
    try {
      DocumentSnapshot doc = await _classrooms.doc(classId).get();
      if (!doc.exists) return null;
      return Classroom.fromFirestore(
          doc.data() as Map<String, dynamic>, doc.id);
    } catch (e) {
      print('Error fetching classroom: $e');
      rethrow;
    }
  }

  Future<void> createClassroom(Classroom classroom) async {
    try {
      await _classrooms.doc(classroom.classId).set(classroom.toFirestore());
    } catch (e) {
      print('Error creating classroom: $e');
      rethrow;
    }
  }

  Future<void> updateClassroom(Classroom classroom) async {
    try {
      await _classrooms.doc(classroom.classId).update(classroom.toFirestore());
    } catch (e) {
      print('Error updating classroom: $e');
      rethrow;
    }
  }

  Future<void> deleteClassroom(String classId) async {
    try {
      await _classrooms.doc(classId).delete();
    } catch (e) {
      print('Error deleting classroom: $e');
      rethrow;
    }
  }

  // Utility methods
  Future<void> updateLessonStatus(String difficultyId, String unitId,
      String lessonId, Status newStatus) async {
    try {
      await _lessonsCollection(difficultyId, unitId)
          .doc(lessonId)
          .update({'LessonStatus': statusToFirestore(newStatus)});
    } catch (e) {
      print('Error updating lesson status: $e');
      rethrow;
    }
  }

  Future<void> updateComponentStatus(String difficultyId, String unitId,
      String lessonId, String componentId, Status newStatus) async {
    try {
      await _componentsCollection(difficultyId, unitId, lessonId)
          .doc(componentId)
          .update({'ComponentStatus': statusToFirestore(newStatus)});
    } catch (e) {
      print('Error updating component status: $e');
      rethrow;
    }
  }

  // Helper method to get lesson with all components
  Future<Map<String, dynamic>> getLessonWithComponents(
      String difficultyId, String unitId, String lessonId) async {
    try {
      final lesson = await getLesson(difficultyId, unitId, lessonId);
      if (lesson == null) throw Exception('Lesson not found');

      final components = await getComponents(difficultyId, unitId, lessonId);

      return {
        'lesson': lesson,
        'components': components,
      };
    } catch (e) {
      print('Error fetching lesson with components: $e');
      rethrow;
    }
  }
}
