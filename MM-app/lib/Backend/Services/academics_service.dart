import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/TeacherDashboard/Backend/SampleDataFille.dart';
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

  // Get all classes mapped by their IDs and names
  Map<String, String> getAllClassrooms() => 
    Map.fromEntries(_classrooms.entries.map((entry) => MapEntry(entry.key, entry.value.name)));

  // Get methods with consistent error handling
  T _getEntityById<T>(Map<String, T> collection, String id, String entityName) {
    final entity = collection[id];
    if (entity == null) throw Exception('$entityName not found: $id');
    return entity;
  }

  Classroom getClassRoom(String classRoomId) => 
    _getEntityById(_classrooms, classRoomId, 'Classroom');

  Unit getUnit(String unitId) => 
    _getEntityById(_units, unitId, 'Unit');

  Lesson getLesson(String lessonId) => 
    _getEntityById(_lessons, lessonId, 'Lesson');

  Component getComponent(String componentId) => 
    _getEntityById(_components, componentId, 'Component');

  // Simplified name getters
  String getLessonName(String lessonId) => getLesson(lessonId).title;

  String getUnitName(String unitId) => getUnit(unitId).title;

  String getComponentName(String componentId) => getComponent(componentId).title;

  String getNextLessonId(String currentLessonId) {
    final parts = currentLessonId.split('.');
    if (parts.length != 3) throw Exception('Invalid lesson ID format');

    // Try next lesson in same unit
    final nextLessonNumber = int.parse(parts[2]) + 1;
    final nextLessonId = '${parts[0]}.${parts[1]}.$nextLessonNumber';
    if (_lessons.containsKey(nextLessonId)) {
      return nextLessonId;
    }

    // Try first lesson in next unit
    final nextUnitNumber = int.parse(parts[1]) + 1;
    final nextUnitLessonId = '${parts[0]}.$nextUnitNumber.1';
    if (_lessons.containsKey(nextUnitLessonId)) {
      return nextUnitLessonId;
    }

    throw Exception('No next lesson found');
  }

  String getActiveComponentStatus(String componentId) {
    try {
      return statusToFirestore(getComponent(componentId).componentStatus);
    } catch (_) {
      return 'inactive';
    }
  }

  // Status getters with consistent naming
  Status getComponentStatus(String componentId) => 
    getComponent(componentId).componentStatus;
    
  Status getLessonStatus(String lessonId) => 
    getLesson(lessonId).lessonStatus;

  // Collection filtering
  List<Unit> getUnitsForDifficulty(String difficulty) => 
    _units.values.where((unit) => unit.unitId.startsWith(difficulty)).toList();

  // Count getters
  int getLessonComponentCount(String lessonId) => 
    getLesson(lessonId).totalComponents;

  int getUnitLessonsCount(String unitId) => 
    getUnit(unitId).totalLessons;

  int getUnitTotalComponents(String unitId) {
    final unit = getUnit(unitId);
    return unit.lessonIds.fold<int>(0, (total, lessonId) => 
      total + getLesson(lessonId).totalComponents);
  }

  List<String> getLessonComponents(String lessonId) {
    try {
      return getLesson(lessonId).components;
    } catch (e) {
      return [];
    }
  }

  Map<String, List<String>> getComponentDiscussionQuestionsForLesson(String lessonId) {
    try {
      final lesson = getLesson(lessonId);
      final Map<String, List<String>> questionsMap = {};

      for (final componentId in lesson.components) {
        try {
          final component = getComponent(componentId);
          if (component.discussionQuestions != null) {
            questionsMap[componentId] = component.discussionQuestions!;
          }
        } catch (e) {
          // Skip components with errors
        }
      }
      
      return questionsMap;
    } catch (_) {
      return {};
    }
  }
}