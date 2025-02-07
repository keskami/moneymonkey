import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/TeacherDashboard/Backend/SampleDataFille.dart';

class AcademicService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Classroom> getClassRoom(String classRoomId) async {
    final doc =
        await _firestore.collection('classrooms').doc(classRoomId).get();
    if (!doc.exists) throw Exception('Classroom not found: $classRoomId');
    return Classroom.fromFirestore(doc.data()!, doc.id);
  }

  Future<Unit> getUnit(String unitId) async {
    final doc = await _firestore.collection('units').doc(unitId).get();
    if (!doc.exists) throw Exception('Unit not found: $unitId');
    return Unit.fromFirestore(doc.data()!, doc.id);
  }

  Future<Lesson> getLesson(String lessonId) async {
    final doc = await _firestore.collection('lessons').doc(lessonId).get();
    if (!doc.exists) throw Exception('Lesson not found: $lessonId');
    return Lesson.fromFirestore(doc.data()!, doc.id);
  }

  Future<String> getNextLessonId(String currentLessonId) async {
    final parts = currentLessonId.split('.');
    if (parts.length != 3) throw Exception('Invalid lesson ID format');

    final nextLessonNumber = int.parse(parts[2]) + 1;
    final nextLessonId = '${parts[0]}.${parts[1]}.$nextLessonNumber';

    try {
      await getLesson(nextLessonId);
      return nextLessonId;
    } catch (e) {
      // If next lesson doesn't exist, try next unit
      final nextUnitNumber = int.parse(parts[1]) + 1;
      return '${parts[0]}.$nextUnitNumber.1';
    }
  }

  Future<Component> getComponent(String componentId) async {
    final lessonId = componentId.split('.').take(3).join('.');
    final doc = await _firestore.collection('lessons').doc(lessonId).get();
    if (!doc.exists)
      throw Exception('Lesson not found for component: $componentId');

    final lesson = Lesson.fromFirestore(doc.data()!, doc.id);
    final component = lesson.components[componentId];
    if (component == null) throw Exception('Component not found: $componentId');

    return component;
  }

  Future<String> getActiveComponentStatus(String componentId) async {
    try {
      final component = await getComponent(componentId);
      return statusToFirestore(component.componentStatus);
    } catch (e) {
      return 'inactive';
    }
  }
}

class LocalAcademicService {
  final Map<String, Classroom> _classrooms;
  final Map<String, Unit> _units;
  final Map<String, Lesson> _lessons;
  final Map<String, Component> _components;

  LocalAcademicService({
    Map<String, Classroom>? classrooms,
    Map<String, Unit>? units,
    Map<String, Lesson>? lessons,
    Map<String, Component>? components,
  })  : _classrooms = classrooms ?? sampleClassrooms,
        _units = units ?? advancedUnits,
        _lessons = lessons ?? advancedLessons,
        _components = components ?? advancedComponents;

  Classroom getClassRoom(String classRoomId) {
    final classroom = _classrooms[classRoomId];
    if (classroom == null) throw Exception('Classroom not found: $classRoomId');
    return classroom;
  }

  Unit getUnit(String unitId) {
    final unit = _units[unitId];
    if (unit == null) throw Exception('Unit not found: $unitId');
    return unit;
  }

  Lesson getLesson(String lessonId) {
    final lesson = _lessons[lessonId];
    if (lesson == null) throw Exception('Lesson not found: $lessonId');
    return lesson;
  }

  String getLessonName(String lessonId) {
    Lesson _lesson = getLesson(lessonId);
    return _lesson.title;
  }

  String getUnitName(String unitId) {
    Unit _unit = getUnit(unitId);
    return _unit.title;
  }

  String getNextLessonId(String currentLessonId) {
    final parts = currentLessonId.split('.');
    if (parts.length != 3) throw Exception('Invalid lesson ID format');

    final nextLessonNumber = int.parse(parts[2]) + 1;
    final nextLessonId = '${parts[0]}.${parts[1]}.$nextLessonNumber';

    if (_lessons.containsKey(nextLessonId)) {
      return nextLessonId;
    }

    final nextUnitNumber = int.parse(parts[1]) + 1;
    final nextUnitLessonId = '${parts[0]}.$nextUnitNumber.1';

    if (_lessons.containsKey(nextUnitLessonId)) {
      return nextUnitLessonId;
    }

    throw Exception('No next lesson found');
  }

  Component getComponent(String componentId) {
    final component = _components[componentId];
    if (component == null) throw Exception('Component not found: $componentId');
    return component;
  }

  String getActiveComponentStatus(String componentId) {
    try {
      return statusToFirestore(getComponent(componentId).componentStatus);
    } catch (e) {
      return 'inactive';
    }
  }

  List<Unit> getUnitsForDifficulty(String difficulty) {
    return _units.values
        .where((unit) => unit.unitId.startsWith(difficulty))
        .toList();
  }

  int getLessonComponentCount(String lessonId) {
    Lesson _lesson = getLesson(lessonId);
    return _lesson.totalComponents;
  }

  int getUnitLessonsCount(String unitId) {
    Unit _unit = getUnit(unitId);
    return _unit.totalLessons;
  }

  int getUnitTotalComponents(String unitId) {
    //Get current Unit
    Unit _unit = getUnit(unitId);
    int totalComponents = 0;
    //Iterate through all lessons in that particular Unit
    _unit.lessonIds.forEach((lesson) {
      //Get each lesson
      Lesson _lesson = getLesson(lesson);
      //Get total components
      totalComponents += _lesson.totalComponents;
    });
    return totalComponents;
  }
}
